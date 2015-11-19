package fl.motion
{
    import fl.motion.*;
    import flash.utils.*;

    public class FunctionEase extends Object implements ITween
    {
        private var _functionName:String = "";
        public var easingFunction:Function = null;
        public var parameters:Array = null;
        private var _target:String = "";

        public function FunctionEase(param1:XML = null)
        {
            this.parseXML(param1);
            return;
        }// end function

        public function get functionName() : String
        {
            return this._functionName;
        }// end function

        public function set functionName(param1:String) : void
        {
            var _loc_2:* = param1.split(".");
            var _loc_3:* = _loc_2.pop();
            var _loc_4:* = _loc_2.join(".");
            var _loc_5:* = getDefinitionByName(_loc_4) as Class;
            if ((_loc_5)[_loc_3] is Function)
            {
                this.easingFunction = _loc_5[_loc_3];
                this._functionName = param1;
            }
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

        private function parseXML(param1:XML = null) : FunctionEase
        {
            if (!param1)
            {
                return this;
            }
            if (param1.@functionName.length())
            {
                this.functionName = param1.@functionName;
            }
            if (param1.@target.length())
            {
                this.target = param1.@target;
            }
            return this;
        }// end function

        public function getValue(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = null;
            if (this.parameters is Array)
            {
                _loc_5 = [param1, param2, param3, param4].concat(this.parameters);
                return this.easingFunction.apply(null, _loc_5);
            }
            return this.easingFunction(param1, param2, param3, param4);
        }// end function

    }
}
