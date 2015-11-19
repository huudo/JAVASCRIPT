package fl.motion
{
    import flash.geom.*;

    public class BezierSegment extends Object
    {
        public var a:Point;
        public var b:Point;
        public var c:Point;
        public var d:Point;

        public function BezierSegment(param1:Point, param2:Point, param3:Point, param4:Point)
        {
            this.a = param1;
            this.b = param2;
            this.c = param3;
            this.d = param4;
            return;
        }// end function

        public function getValue(param1:Number) : Point
        {
            var _loc_2:* = this.a.x;
            var _loc_3:* = (param1 * param1 * (this.d.x - _loc_2) + 3 * (1 - param1) * (param1 * (this.c.x - _loc_2) + (1 - param1) * (this.b.x - _loc_2))) * param1 + _loc_2;
            var _loc_4:* = this.a.y;
            var _loc_5:* = (param1 * param1 * (this.d.y - _loc_4) + 3 * (1 - param1) * (param1 * (this.c.y - _loc_4) + (1 - param1) * (this.b.y - _loc_4))) * param1 + _loc_4;
            return new Point(_loc_3, _loc_5);
        }// end function

        public function getYForX(param1:Number, param2:Array = null) : Number
        {
            var _loc_6:* = NaN;
            if (this.a.x < this.d.x)
            {
                if (param1 <= this.a.x + 1e-016)
                {
                    return this.a.y;
                }
                if (param1 >= this.d.x - 1e-016)
                {
                    return this.d.y;
                }
            }
            else
            {
                if (param1 >= this.a.x + 1e-016)
                {
                    return this.a.y;
                }
                if (param1 <= this.d.x - 1e-016)
                {
                    return this.d.y;
                }
            }
            if (!param2)
            {
                param2 = getCubicCoefficients(this.a.x, this.b.x, this.c.x, this.d.x);
            }
            var _loc_3:* = getCubicRoots(param2[0], param2[1], param2[2], param2[3] - param1);
            var _loc_4:* = NaN;
            if (_loc_3.length == 0)
            {
                _loc_4 = 0;
            }
            else if (_loc_3.length == 1)
            {
                _loc_4 = _loc_3[0];
            }
            else
            {
                for each (_loc_6 in _loc_3)
                {
                    
                    if (_loc_6 >= 0 && _loc_6 <= 1)
                    {
                        _loc_4 = _loc_6;
                        break;
                    }
                }
            }
            if (isNaN(_loc_4))
            {
                return NaN;
            }
            var _loc_5:* = getSingleValue(_loc_4, this.a.y, this.b.y, this.c.y, this.d.y);
            return getSingleValue(_loc_4, this.a.y, this.b.y, this.c.y, this.d.y);
        }// end function

        public static function getSingleValue(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0) : Number
        {
            return (param1 * param1 * (param5 - param2) + 3 * (1 - param1) * (param1 * (param4 - param2) + (1 - param1) * (param3 - param2))) * param1 + param2;
        }// end function

        public static function getCubicCoefficients(param1:Number, param2:Number, param3:Number, param4:Number) : Array
        {
            return [-param1 + 3 * param2 - 3 * param3 + param4, 3 * param1 - 6 * param2 + 3 * param3, -3 * param1 + 3 * param2, param1];
        }// end function

        public static function getCubicRoots(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : Array
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = 0;
            var _loc_16:* = NaN;
            if (!param1)
            {
                return BezierSegment.getQuadraticRoots(param2, param3, param4);
            }
            if (param1 != 1)
            {
                param2 = param2 / param1;
                param3 = param3 / param1;
                param4 = param4 / param1;
            }
            var _loc_5:* = (param2 * param2 - 3 * param3) / 9;
            var _loc_6:* = (param2 * param2 - 3 * param3) / 9 * ((param2 * param2 - 3 * param3) / 9) * _loc_5;
            var _loc_7:* = (2 * param2 * param2 * param2 - 9 * param2 * param3 + 27 * param4) / 54;
            var _loc_8:* = _loc_6 - _loc_7 * _loc_7;
            if (_loc_6 - _loc_7 * _loc_7 >= 0)
            {
                if (!_loc_5)
                {
                    return [0];
                }
                _loc_9 = Math.acos(_loc_7 / Math.sqrt(_loc_6));
                _loc_10 = Math.sqrt(_loc_5);
                _loc_11 = -2 * _loc_10 * Math.cos(_loc_9 / 3) - param2 / 3;
                _loc_12 = -2 * _loc_10 * Math.cos((_loc_9 + 2 * Math.PI) / 3) - param2 / 3;
                _loc_13 = -2 * _loc_10 * Math.cos((_loc_9 + 4 * Math.PI) / 3) - param2 / 3;
                return [_loc_11, _loc_12, _loc_13];
            }
            else
            {
                _loc_14 = Math.pow(Math.sqrt(-_loc_8) + Math.abs(_loc_7), 1 / 3);
                _loc_15 = _loc_7 > 0 ? (1) : (_loc_7 < 0 ? (-1) : (0));
                _loc_16 = (-_loc_15) * (_loc_14 + _loc_5 / _loc_14) - param2 / 3;
                return [_loc_16];
            }
        }// end function

        public static function getQuadraticRoots(param1:Number, param2:Number, param3:Number) : Array
        {
            var _loc_7:* = NaN;
            var _loc_4:* = [];
            if (!param1)
            {
                if (!param2)
                {
                    return [];
                }
                _loc_4[0] = (-param3) / param2;
                return _loc_4;
            }
            var _loc_5:* = param2 * param2 - 4 * param1 * param3;
            var _loc_6:* = param2 * param2 - 4 * param1 * param3 > 0 ? (1) : (_loc_5 < 0 ? (-1) : (0));
            if ((param2 * param2 - 4 * param1 * param3 > 0 ? (1) : (_loc_5 < 0 ? (-1) : (0))) < 0)
            {
                return [];
            }
            if (!_loc_6)
            {
                _loc_4[0] = (-param2) / (2 * param1);
            }
            else
            {
                var _loc_8:* = (-param2) / (2 * param1);
                _loc_4[1] = (-param2) / (2 * param1);
                _loc_4[0] = _loc_8;
                _loc_7 = Math.sqrt(_loc_5) / (2 * param1);
                _loc_4[0] = _loc_4[0] - _loc_7;
                _loc_4[1] = _loc_4[1] + _loc_7;
            }
            return _loc_4;
        }// end function

    }
}
