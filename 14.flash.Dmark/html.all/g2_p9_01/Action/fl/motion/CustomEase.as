package fl.motion
{
    import fl.motion.*;
    import flash.geom.*;

    public class CustomEase extends Object implements ITween
    {
        public var points:Array;
        private var firstNode:Point;
        private var lastNode:Point;
        private var _target:String = "";

        public function CustomEase(param1:XML = null)
        {
            this.points = [];
            this.parseXML(param1);
            this.firstNode = new Point(0, 0);
            this.lastNode = new Point(1, 1);
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

        private function parseXML(param1:XML = null) : CustomEase
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
            var _loc_6:* = [this.firstNode].concat(this.points);
            _loc_6.push(this.lastNode);
            var _loc_7:* = getYForPercent(_loc_5, _loc_6);
            return param2 + _loc_7 * param3;
        }// end function

        static function getYForPercent(param1:Number, param2:Array) : Number
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_3:* = new BezierSegment(param2[0], param2[1], param2[2], param2[3]);
            var _loc_4:* = [_loc_3];
            var _loc_5:* = 3;
            while (_loc_5 < param2.length - 3)
            {
                
                _loc_4.push(new BezierSegment(param2[_loc_5], param2[(_loc_5 + 1)], param2[_loc_5 + 2], param2[_loc_5 + 3]));
                _loc_5 = _loc_5 + 3;
            }
            var _loc_6:* = _loc_3;
            if (param2.length >= 5)
            {
                _loc_8 = 0;
                while (_loc_8 < _loc_4.length)
                {
                    
                    _loc_9 = _loc_4[_loc_8];
                    if (_loc_9.a.x <= param1 && param1 <= _loc_9.d.x)
                    {
                        _loc_6 = _loc_9;
                        break;
                    }
                    _loc_8++;
                }
            }
            var _loc_7:* = _loc_6.getYForX(param1);
            return _loc_6.getYForX(param1);
        }// end function

    }
}
