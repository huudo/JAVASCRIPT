package phcomm
{

    public class ComOther extends Object
    {

        public function ComOther()
        {
            return;
        }// end function

        public static function dComp(param1:Number, param2:Number, param3:int) : int
        {
            if (param3 < 0 || param3 > 15)
            {
                return 0;
            }
            var _loc_4:* = param1.toFixed((param3 + 1));
            var _loc_5:* = param2.toFixed((param3 + 1));
            _loc_4 = _loc_4.substr(0, param3);
            _loc_5 = _loc_5.substr(0, param3);
            var _loc_6:* = parseFloat(_loc_4);
            if (_loc_6.valueOf() == 0)
            {
                _loc_6 = 0;
            }
            var _loc_7:* = parseFloat(_loc_5);
            if (_loc_7.valueOf() == 0)
            {
                _loc_7 = 0;
            }
            if (_loc_4 == _loc_5 || _loc_6 == _loc_7)
            {
                return 0;
            }
            if (_loc_6 > _loc_7)
            {
                return -1;
            }
            return 1;
        }// end function

        public static function doubleFormat(param1:Number, param2:int) : String
        {
            return param1.toFixed(param2);
        }// end function

        public static function roundDeg(param1:Number) : Number
        {
            var _loc_2:* = param1;
            if (_loc_2 > 180)
            {
                while (_loc_2 > 180)
                {
                    
                    _loc_2 = _loc_2 - 360;
                }
            }
            if (_loc_2 < -180)
            {
                while (_loc_2 < -180)
                {
                    
                    _loc_2 = _loc_2 + 360;
                }
            }
            if (_loc_2 == -0)
            {
                _loc_2 = 0;
                return _loc_2;
            }
            if (_loc_2 == -180)
            {
                _loc_2 = 180;
                return _loc_2;
            }
            return _loc_2;
        }// end function

        public static function roundRad(param1:Number) : Number
        {
            var _loc_2:* = param1;
            if (_loc_2 > Math.PI)
            {
                while (_loc_2 > Math.PI)
                {
                    
                    _loc_2 = _loc_2 - Math.PI * 2;
                }
            }
            if (_loc_2 < -Math.PI)
            {
                while (_loc_2 < -Math.PI)
                {
                    
                    _loc_2 = _loc_2 + Math.PI * 2;
                }
            }
            if (_loc_2 == toRadian(-0))
            {
                return toRadian(0);
            }
            if (_loc_2 == -Math.PI)
            {
                return Math.PI;
            }
            return _loc_2;
        }// end function

        public static function toDigree(param1:Number) : Number
        {
            var _loc_2:* = param1 * 180 / Math.PI;
            return _loc_2;
        }// end function

        public static function toRadian(param1:Number) : Number
        {
            var _loc_2:* = param1 * Math.PI / 180;
            return _loc_2;
        }// end function

    }
}
