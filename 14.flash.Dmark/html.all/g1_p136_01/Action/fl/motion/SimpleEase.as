package fl.motion
{
    import fl.motion.*;

    public class SimpleEase extends Object implements ITween
    {
        private var _ease:Number = 0;
        private var _target:String = "";

        public function SimpleEase(param1:XML = null)
        {
            this.parseXML(param1);
            return;
        }// end function

        public function get ease() : Number
        {
            return this._ease;
        }// end function

        public function set ease(param1:Number) : void
        {
            this._ease = param1 > 1 ? (1) : (param1 < -1 ? (-1) : (isNaN(param1) ? (0) : (param1)));
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

        private function parseXML(param1:XML = null) : SimpleEase
        {
            if (param1)
            {
                if (param1.@ease.length())
                {
                    this.ease = Number(param1.@ease);
                }
                if (param1.@target.length())
                {
                    this.target = param1.@target;
                }
            }
            return this;
        }// end function

        public function getValue(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return easeQuadPercent(param1, param2, param3, param4, this.ease);
        }// end function

        public static function easeQuadPercent(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
        {
            if (param4 <= 0)
            {
                return NaN;
            }
            if (param1 <= 0)
            {
                return param2;
            }
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_6 >= 1)
            {
                return param2 + param3;
            }
            if (!param5)
            {
                return param3 * param1 + param2;
            }
            if (param5 > 1)
            {
                param5 = 1;
            }
            else if (param5 < -1)
            {
                param5 = -1;
            }
            if (param5 < 0)
            {
                return param3 * param1 * (param1 * (-param5) + (1 + param5)) + param2;
            }
            return param3 * param1 * ((2 - param1) * param5 + (1 - param5)) + param2;
        }// end function

        public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            if (param4 <= 0)
            {
                return NaN;
            }
            if (param1 <= 0)
            {
                return param2;
            }
            if (param1 >= param4)
            {
                return param2 + param3;
            }
            return param3 * param1 / param4 + param2;
        }// end function

    }
}
