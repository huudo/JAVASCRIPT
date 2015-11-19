package phcomm
{
    import __AS3__.vec.*;

    public class PH3D extends Object
    {
        public var _xs:Number;
        public var _ys:Number;
        public var _zs:Number;
        public var _ash:Number;
        public var _asv:Number;
        public var _cosh:Number;
        public var _sinh:Number;
        public var _cosv:Number;
        public var _sinv:Number;
        public var dX:Number;
        public var dY:Number;
        public var dZ:Number;
        private const VEC_RANGE_VAL:Number = 1.0201;

        public function PH3D()
        {
            this._xs = Number.NaN;
            this._ys = Number.NaN;
            this._zs = Number.NaN;
            this._ash = Number.NaN;
            this._asv = Number.NaN;
            this._cosh = Number.NaN;
            this._sinh = Number.NaN;
            this._cosv = Number.NaN;
            this._sinv = Number.NaN;
            this.dX = Number.NaN;
            this.dY = Number.NaN;
            this.dZ = Number.NaN;
            return;
        }// end function

        public function setVew3D(param1:Number, param2:Number, param3:Number) : void
        {
            this._ash = Math.PI * param1 / 180;
            this._asv = Math.PI * param2 / 180;
            this._cosh = Math.cos(this._ash);
            this._sinh = Math.sin(this._ash);
            this._cosv = Math.cos(this._asv);
            this._sinv = Math.sin(this._asv);
            this._xs = param3 * this._cosv * this._cosh;
            this._ys = param3 * this._cosv * this._sinh;
            this._zs = param3 * this._sinv;
            return;
        }// end function

        public function xRevolv3D(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = param1;
            var _loc_6:* = param2;
            var _loc_7:* = param3;
            var _loc_8:* = param4 / 180 * Math.PI;
            var _loc_9:* = Math.cos(_loc_8);
            var _loc_10:* = Math.sin(_loc_8);
            this.dX = _loc_5;
            this.dY = _loc_6 * _loc_9 + _loc_7 * _loc_10;
            this.dZ = -1 * _loc_6 * _loc_10 + _loc_7 * _loc_9;
            return;
        }// end function

        public function yRevolv3D(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = param1;
            var _loc_6:* = param2;
            var _loc_7:* = param3;
            var _loc_8:* = param4 / 180 * Math.PI;
            var _loc_9:* = Math.cos(_loc_8);
            var _loc_10:* = Math.sin(_loc_8);
            this.dX = _loc_5 * _loc_9 + _loc_7 * _loc_10;
            this.dY = _loc_6;
            this.dZ = -1 * _loc_5 * _loc_10 + _loc_7 * _loc_9;
            return;
        }// end function

        public function zRevolv3D(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = param1;
            var _loc_6:* = param2;
            var _loc_7:* = param3;
            var _loc_8:* = param4 / 180 * Math.PI;
            var _loc_9:* = Math.cos(_loc_8);
            var _loc_10:* = Math.sin(_loc_8);
            this.dX = _loc_5 * _loc_9 + _loc_6 * _loc_10;
            this.dY = -1 * _loc_5 * _loc_10 + _loc_6 * _loc_9;
            this.dZ = _loc_7;
            return;
        }// end function

        public function cv3d3d(param1:Number, param2:Number, param3:Number) : void
        {
            var _loc_4:* = (param1 - this._xs) * this._cosh + (param2 - this._ys) * this._sinh;
            var _loc_5:* = ((param1 - this._xs) * this._cosh + (param2 - this._ys) * this._sinh) * this._cosv + (param3 - this._zs) * this._sinv;
            var _loc_6:* = -1 * (param1 - this._xs) * this._sinh + (param2 - this._ys) * this._cosh;
            var _loc_7:* = -1 * _loc_4 * this._sinv + (param3 - this._zs) * this._cosv;
            this.dX = _loc_5;
            this.dY = _loc_6;
            this.dZ = _loc_7;
            return;
        }// end function

        public function getDist(param1:int, param2:Vector.<Number>, param3:Vector.<Number>, param4:Vector.<Number>) : Number
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_7 = 0;
            _loc_6 = _loc_9;
            _loc_5 = _loc_9;
            _loc_8 = 0;
            while (_loc_8 < param1)
            {
                
                _loc_5 = _loc_5 + param2[_loc_8];
                _loc_6 = _loc_6 + param3[_loc_8];
                _loc_7 = _loc_7 + param4[_loc_8];
                _loc_8++;
            }
            _loc_5 = _loc_5 / param1;
            _loc_6 = _loc_6 / param1;
            _loc_7 = _loc_7 / param1;
            this.cv3d3d(_loc_5, _loc_6, _loc_7);
            return Math.sqrt(this.dX * this.dX);
        }// end function

        public function getVec(param1:int, param2:Vector.<Number>, param3:Vector.<Number>, param4:Vector.<Number>) : void
        {
            var _loc_8:* = 0;
            var _loc_5:* = new Vector.<Number>(3, true);
            var _loc_6:* = new Vector.<Number>(3, true);
            var _loc_7:* = new Vector.<Number>(3, true);
            _loc_8 = 0;
            while (_loc_8 < 3)
            {
                
                _loc_5[2 - _loc_8] = param2[_loc_8];
                _loc_6[2 - _loc_8] = param3[_loc_8];
                _loc_7[2 - _loc_8] = param4[_loc_8];
                _loc_8++;
            }
            var _loc_9:* = _loc_6[0] * (_loc_7[1] - _loc_7[2]);
            _loc_9 = _loc_6[0] * (_loc_7[1] - _loc_7[2]) + _loc_6[1] * (_loc_7[2] - _loc_7[0]);
            _loc_9 = _loc_9 + _loc_6[2] * (_loc_7[0] - _loc_7[1]);
            var _loc_10:* = _loc_7[0] * (_loc_5[1] - _loc_5[2]);
            _loc_10 = _loc_7[0] * (_loc_5[1] - _loc_5[2]) + _loc_7[1] * (_loc_5[2] - _loc_5[0]);
            _loc_10 = _loc_10 + _loc_7[2] * (_loc_5[0] - _loc_5[1]);
            var _loc_11:* = _loc_5[0] * (_loc_6[1] - _loc_6[2]);
            _loc_11 = _loc_5[0] * (_loc_6[1] - _loc_6[2]) + _loc_5[1] * (_loc_6[2] - _loc_6[0]);
            _loc_11 = _loc_11 + _loc_5[2] * (_loc_6[0] - _loc_6[1]);
            var _loc_12:* = _loc_9 * _loc_9 + _loc_10 * _loc_10 + _loc_11 * _loc_11;
            _loc_12 = Math.sqrt(_loc_12);
            _loc_9 = _loc_9 / _loc_12;
            _loc_10 = _loc_10 / _loc_12;
            _loc_11 = _loc_11 / _loc_12;
            var _loc_13:* = _loc_9;
            var _loc_14:* = _loc_10;
            var _loc_15:* = _loc_11;
            _loc_9 = -this._xs;
            _loc_10 = -this._ys;
            _loc_11 = -this._zs;
            _loc_12 = _loc_9 * _loc_9 + _loc_10 * _loc_10 + _loc_11 * _loc_11;
            _loc_12 = Math.sqrt(_loc_12);
            _loc_9 = _loc_9 / _loc_12;
            _loc_10 = _loc_10 / _loc_12;
            _loc_11 = _loc_11 / _loc_12;
            this.dX = _loc_9 * _loc_13 + _loc_10 * _loc_14 + _loc_11 * _loc_15;
            _loc_9 = -40;
            _loc_10 = -50;
            _loc_11 = -160;
            _loc_12 = _loc_9 * _loc_9 + _loc_10 * _loc_10 + _loc_11 * _loc_11;
            _loc_12 = Math.sqrt(_loc_12);
            _loc_9 = _loc_9 / _loc_12;
            _loc_10 = _loc_10 / _loc_12;
            _loc_11 = _loc_11 / _loc_12;
            this.dY = _loc_9 * _loc_13 + _loc_10 * _loc_14 + _loc_11 * _loc_15;
            return;
        }// end function

        public function drwplColor(param1:uint, param2:Number, param3:Number) : uint
        {
            return this.getDrwplColor(param1, param2, param3, -80, -50, 0.64);
        }// end function

        public function drwplColorToBall(param1:uint, param2:Number, param3:Number) : uint
        {
            return this.getDrwplColor(param1, param2, param3, -60, -60, 1.14);
        }// end function

        private function getDrwplColor(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : uint
        {
            var _loc_7:* = NaN;
            if (param2 * param2 > this.VEC_RANGE_VAL || param3 * param3 > this.VEC_RANGE_VAL)
            {
                return 0;
            }
            var _loc_8:* = int(Math.floor(param1 / 65536));
            var _loc_9:* = int(Math.floor(param1 % 65536 / 256));
            var _loc_10:* = param1 % 256;
            if (param2 < 0)
            {
                _loc_7 = (-(2 * Math.acos(param3) - Math.PI)) / Math.PI;
                _loc_8 = int(_loc_8 + _loc_7 * param4);
                _loc_9 = int(_loc_9 + _loc_7 * param4);
                _loc_10 = int(_loc_10 + _loc_7 * param4);
            }
            else
            {
                _loc_7 = (-(2 * Math.acos(param3 * -1) - Math.PI)) / Math.PI;
                _loc_8 = int(_loc_8 * param6 + _loc_7 * param5);
                _loc_9 = int(_loc_9 * param6 + _loc_7 * param5);
                _loc_10 = int(_loc_10 * param6 + _loc_7 * param5);
            }
            _loc_8 = Math.min(_loc_8, 255);
            _loc_8 = Math.max(_loc_8, 0);
            _loc_9 = Math.min(_loc_9, 255);
            _loc_9 = Math.max(_loc_9, 0);
            _loc_10 = Math.min(_loc_10, 255);
            _loc_10 = Math.max(_loc_10, 0);
            return _loc_8 * 65536 + _loc_9 * 256 + _loc_10;
        }// end function

        public function vrtVec(param1:int, param2:Vector.<Number>, param3:Vector.<Number>, param4:Vector.<Number>) : void
        {
            var _loc_8:* = 0;
            var _loc_5:* = new Vector.<Number>(3, true);
            var _loc_6:* = new Vector.<Number>(3, true);
            var _loc_7:* = new Vector.<Number>(3, true);
            _loc_8 = 0;
            while (_loc_8 < 3)
            {
                
                _loc_5[2 - _loc_8] = param2[_loc_8];
                _loc_6[2 - _loc_8] = param3[_loc_8];
                _loc_7[2 - _loc_8] = param4[_loc_8];
                _loc_8++;
            }
            var _loc_9:* = _loc_6[0] * (_loc_7[1] - _loc_7[2]);
            _loc_9 = _loc_6[0] * (_loc_7[1] - _loc_7[2]) + _loc_6[1] * (_loc_7[2] - _loc_7[0]);
            _loc_9 = _loc_9 + _loc_6[2] * (_loc_7[0] - _loc_7[1]);
            var _loc_10:* = _loc_7[0] * (_loc_5[1] - _loc_5[2]);
            _loc_10 = _loc_7[0] * (_loc_5[1] - _loc_5[2]) + _loc_7[1] * (_loc_5[2] - _loc_5[0]);
            _loc_10 = _loc_10 + _loc_7[2] * (_loc_5[0] - _loc_5[1]);
            var _loc_11:* = _loc_5[0] * (_loc_6[1] - _loc_6[2]);
            _loc_11 = _loc_5[0] * (_loc_6[1] - _loc_6[2]) + _loc_5[1] * (_loc_6[2] - _loc_6[0]);
            _loc_11 = _loc_11 + _loc_5[2] * (_loc_6[0] - _loc_6[1]);
            var _loc_12:* = _loc_9 * _loc_9 + _loc_10 * _loc_10 + _loc_11 * _loc_11;
            _loc_12 = Math.sqrt(_loc_12);
            _loc_9 = _loc_9 / _loc_12;
            _loc_10 = _loc_10 / _loc_12;
            _loc_11 = _loc_11 / _loc_12;
            this.dX = _loc_9;
            this.dY = _loc_10;
            this.dZ = _loc_11;
            return;
        }// end function

        public function drwplColor2(param1:uint, param2:Number, param3:Number) : uint
        {
            var _loc_4:* = NaN;
            if (param2 * param2 > this.VEC_RANGE_VAL || param3 * param3 > this.VEC_RANGE_VAL)
            {
                return 0;
            }
            var _loc_5:* = int(Math.floor(param1 / 65536));
            var _loc_6:* = int(Math.floor(param1 % 65536 / 256));
            var _loc_7:* = param1 % 256;
            if (param2 < 0)
            {
                _loc_4 = param3;
                _loc_5 = int(_loc_5 + _loc_4 * -80);
                _loc_6 = int(_loc_6 + _loc_4 * -80);
                _loc_7 = int(_loc_7 + _loc_4 * -80);
            }
            else
            {
                _loc_4 = param3 * -1;
                _loc_5 = int(_loc_5 * 0.64 + _loc_4 * -50);
                _loc_6 = int(_loc_6 * 0.64 + _loc_4 * -50);
                _loc_7 = int(_loc_7 * 0.64 + _loc_4 * -50);
            }
            _loc_5 = Math.min(_loc_5, 255);
            _loc_5 = Math.max(_loc_5, 0);
            _loc_6 = Math.min(_loc_6, 255);
            _loc_6 = Math.max(_loc_6, 0);
            _loc_7 = Math.min(_loc_7, 255);
            _loc_7 = Math.max(_loc_7, 0);
            return _loc_5 * 65536 + _loc_6 * 256 + _loc_7;
        }// end function

    }
}
