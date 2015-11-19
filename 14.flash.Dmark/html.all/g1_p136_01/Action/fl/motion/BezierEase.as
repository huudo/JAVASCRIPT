package fl.motion
{
    import fl.motion.*;
    import flash.geom.*;

    public class BezierEase extends Object implements ITween
    {
        public var points:Array;
        private var firstNode:Point;
        private var lastNode:Point;
        private var _target:String = "";

        public function BezierEase(param1:XML = null)
        {
            this.points = [];
            this.parseXML(param1);
            return;
        }// end function

        public function get target() : String
        {
            return this._target;
        }// end function

        public function set target(param1:String) : void
        {
            this._target = param1;
            return;
        }// end function

        private function parseXML(param1:XML = null) : BezierEase
        {
            var _loc_3:* = null;
            if (!param1)
            {
                return this;
            }
            if (param1.@target.length())
            {
                this.target = param1.@target;
            }
            var _loc_2:* = param1.elements();
            for each (_loc_3 in _loc_2)
            {
                
                this.points.push(new Point(Number(_loc_3.@x), Number(_loc_3.@y)));
            }
            return this;
        }// end function

        public function getValue(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param4 <= 0)
            {
                return NaN;
            }
            var _loc_5:* = param1 / param4;
            if (param1 / param4 <= 0)
            {
                return param2;
            }
            if (_loc_5 >= 1)
            {
                return param2 + param3;
            }
            this.firstNode = new Point(0, param2);
            this.lastNode = new Point(1, param2 + param3);
            var _loc_6:* = [this.firstNode].concat(this.points);
            _loc_6.push(this.lastNode);
            var _loc_7:* = CustomEase.getYForPercent(_loc_5, _loc_6);
            return CustomEase.getYForPercent(_loc_5, _loc_6);
        }// end function

    }
}
