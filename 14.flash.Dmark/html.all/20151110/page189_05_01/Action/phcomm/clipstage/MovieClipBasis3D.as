package phcomm.clipstage
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import phcomm.*;

    public class MovieClipBasis3D extends MovieClipStage
    {
        protected var VewWinX:Number;
        protected var VewWinY:Number;
        protected var gPH3D:PH3D;
        protected var isUseMoveActionSnap:Boolean;
        protected var gLastMoveSnapFaceNo:int;
        private var dLeftV:Number;
        private var dTopV:Number;
        private var dWidthV:Number;
        private var dHeightV:Number;
        private var dDeltaX:Number;
        private var dDeltaY:Number;
        private var dWinX1:Number;
        private var dWinY1:Number;
        private var dWinX2:Number;
        private var dWinY2:Number;
        private var dVPWX:Number;
        private var dVPWY:Number;
        private var dMouseX:int;
        private var dMouseY:int;
        private var dDegreeStep:int;
        public static const DEFAULT_DEGREE_STEP:int = 10;

        public function MovieClipBasis3D(param1:Boolean = true)
        {
            super(param1);
            this.VewWinX = Number.NaN;
            this.VewWinY = Number.NaN;
            this.gPH3D = new PH3D();
            this.isUseMoveActionSnap = false;
            this.gLastMoveSnapFaceNo = int.MIN_VALUE;
            this.dLeftV = Number.NaN;
            this.dTopV = Number.NaN;
            this.dWidthV = Number.NaN;
            this.dHeightV = Number.NaN;
            this.dDeltaX = Number.NaN;
            this.dDeltaY = Number.NaN;
            this.dWinX1 = Number.NaN;
            this.dWinY1 = Number.NaN;
            this.dWinX2 = Number.NaN;
            this.dWinY2 = Number.NaN;
            this.dVPWX = Number.NaN;
            this.dVPWY = Number.NaN;
            this.dMouseX = int.MIN_VALUE;
            this.dMouseY = int.MIN_VALUE;
            this.dDegreeStep = DEFAULT_DEGREE_STEP;
            return;
        }// end function

        protected function get isSelectedObject() : Boolean
        {
            return false;
        }// end function

        protected function display3D() : void
        {
            return;
        }// end function

        protected function move(param1:int, param2:Number) : void
        {
            return;
        }// end function

        protected function moveActionSnap() : int
        {
            return int.MIN_VALUE;
        }// end function

        protected function set degreeStep(param1:int) : void
        {
            this.dDegreeStep = param1;
            return;
        }// end function

        protected function defaultActionUp() : void
        {
            this.move(2, -this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function defaultActionDown() : void
        {
            this.move(2, this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function defaultActionLeft() : void
        {
            this.move(3, this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function defaultActionRight() : void
        {
            this.move(3, -this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function defaultActionLeftRev() : void
        {
            this.move(1, -this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function defaultActionRightRev() : void
        {
            this.move(1, this.dDegreeStep);
            if (this.isUseMoveActionSnap)
            {
                this.moveActionSnap();
            }
            this.display3D();
            return;
        }// end function

        protected function actionLarge(param1:Number, param2:Number) : Boolean
        {
            this.dWidthV = this.dWidthV + param1;
            this.dHeightV = this.dHeightV + param1;
            this.viewSet();
            this.display3D();
            return this.dWidthV < param2;
        }// end function

        protected function actionSmall(param1:Number, param2:Number) : Boolean
        {
            this.dWidthV = this.dWidthV - param1;
            this.dHeightV = this.dHeightV - param1;
            this.viewSet();
            this.display3D();
            return this.dWidthV > param2;
        }// end function

        protected function defaultActionIdou(event:StageEvent) : void
        {
            this.dDeltaX = this.dDeltaX - (this.dMouseX - event.mouseX);
            this.dDeltaY = this.dDeltaY - (this.dMouseY - event.mouseY);
            this.viewSet();
            this.dMouseX = event.mouseX;
            this.dMouseY = event.mouseY;
            this.display3D();
            return;
        }// end function

        protected function defaultActionKaiten(event:StageEvent) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = int((this.dMouseX - event.mouseX) / 10);
            var _loc_4:* = int((this.dMouseY - event.mouseY) / 10) * -1;
            if (_loc_3 != 0)
            {
                _loc_2 = true;
                this.dMouseX = event.mouseX;
                this.move(3, 5 * _loc_3);
            }
            if (_loc_4 != 0)
            {
                _loc_2 = true;
                this.dMouseY = event.mouseY;
                this.move(2, 5 * _loc_4);
            }
            if (_loc_2)
            {
                if (this.isUseMoveActionSnap)
                {
                    this.moveActionSnap();
                }
            }
            if (_loc_2)
            {
                this.display3D();
            }
            return;
        }// end function

        protected function actionStageMouseDown(event:StageEvent) : void
        {
            this.dMouseX = event.mouseX;
            this.dMouseY = event.mouseY;
            return;
        }// end function

        protected function actionStageMouseMove(event:StageEvent, param2:Boolean) : Boolean
        {
            if (event.isMouseButtonDown && !param2)
            {
                this.defaultActionKaiten(event);
                return true;
            }
            if (event.isMouseButtonDown && param2 && this.isSelectedObject)
            {
                this.defaultActionIdou(event);
                return true;
            }
            return false;
        }// end function

        protected function actionStageMouseUp(event:StageEvent) : void
        {
            this.dMouseX = Number.NaN;
            this.dMouseY = Number.NaN;
            return;
        }// end function

        protected function viewSet() : void
        {
            this.dLeftV = (this.areaWidth + this.dDeltaX * 2 - this.dWidthV) / 2;
            this.dTopV = (this.areaHeight + this.dDeltaY * 2 - this.dHeightV) / 2;
            this.dWinX1 = -240;
            this.dWinY1 = -240;
            this.dWinX2 = 240;
            this.dWinY2 = 240;
            this.dVPWX = this.dWidthV / (this.dWinX2 - this.dWinX1);
            this.dVPWY = this.dHeightV / (this.dWinY2 - this.dWinY1);
            return;
        }// end function

        protected function setView(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.dWidthV = param1;
            this.dHeightV = param2;
            this.dDeltaX = param3;
            this.dDeltaY = param4;
            this.viewSet();
            return;
        }// end function

        protected function getView() : Vector.<Number>
        {
            var _loc_1:* = new Vector.<Number>(4, true);
            _loc_1[0] = this.dWidthV;
            _loc_1[1] = this.dHeightV;
            _loc_1[2] = this.dDeltaX;
            _loc_1[3] = this.dDeltaY;
            return _loc_1;
        }// end function

        protected function changeViewWindow(param1:Number, param2:Number) : void
        {
            var _loc_3:* = this.dLeftV + this.dVPWX * (param1 - this.dWinX1);
            var _loc_4:* = this.dTopV + this.dHeightV - 1 - this.dVPWY * (param2 - this.dWinY1);
            this.VewWinX = _loc_3;
            this.VewWinY = _loc_4;
            return;
        }// end function

        final protected function rgb(param1:int, param2:int, param3:int) : uint
        {
            param1 = Math.max(param1, 0);
            param1 = Math.min(param1, 255);
            param2 = Math.max(param2, 0);
            param2 = Math.min(param2, 255);
            param3 = Math.max(param3, 0);
            param3 = Math.min(param3, 255);
            return param1 * 65536 + param2 * 256 + param3;
        }// end function

        protected function actionMove(param1:int, param2:Number, param3:Vector.<Vector.<Number>>, param4:int) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_5:* = 0;
            while (_loc_5 < param4)
            {
                
                _loc_6 = param3[_loc_5][0];
                _loc_7 = param3[_loc_5][1];
                _loc_8 = param3[_loc_5][2];
                switch(param1)
                {
                    case 1:
                    {
                        this.gPH3D.xRevolv3D(_loc_6, _loc_7, _loc_8, param2);
                        break;
                    }
                    case 2:
                    {
                        this.gPH3D.yRevolv3D(_loc_6, _loc_7, _loc_8, param2);
                        break;
                    }
                    default:
                    {
                        this.gPH3D.zRevolv3D(_loc_6, _loc_7, _loc_8, param2);
                        break;
                        break;
                    }
                }
                param3[_loc_5][0] = this.gPH3D.dX;
                param3[_loc_5][1] = this.gPH3D.dY;
                param3[_loc_5][2] = this.gPH3D.dZ;
                _loc_5++;
            }
            return;
        }// end function

        protected function actionMove3D(param1:int, param2:Number, param3:Vector.<Vector3D>, param4:int) : void
        {
            var _loc_5:* = 0;
            while (_loc_5 < param4)
            {
                
                switch(param1)
                {
                    case 1:
                    {
                        this.gPH3D.xRevolv3D(param3[_loc_5].x, param3[_loc_5].y, param3[_loc_5].z, param2);
                        break;
                    }
                    case 2:
                    {
                        this.gPH3D.yRevolv3D(param3[_loc_5].x, param3[_loc_5].y, param3[_loc_5].z, param2);
                        break;
                    }
                    default:
                    {
                        this.gPH3D.zRevolv3D(param3[_loc_5].x, param3[_loc_5].y, param3[_loc_5].z, param2);
                        break;
                        break;
                    }
                }
                param3[_loc_5].x = this.gPH3D.dX;
                param3[_loc_5].y = this.gPH3D.dY;
                param3[_loc_5].z = this.gPH3D.dZ;
                _loc_5++;
            }
            return;
        }// end function

        protected function getAveragPoint3D(param1:Vector.<Vector3D>, param2:int) : Vector3D
        {
            var _loc_3:* = Math.min(param2, param1.length);
            var _loc_4:* = new Vector3D(0, 0, 0);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4.x = _loc_4.x + param1[_loc_5].x;
                _loc_4.y = _loc_4.y + param1[_loc_5].y;
                _loc_4.z = _loc_4.z + param1[_loc_5].z;
                _loc_5++;
            }
            _loc_4.x = _loc_4.x / param2;
            _loc_4.y = _loc_4.y / param2;
            _loc_4.z = _loc_4.z / param2;
            return _loc_4;
        }// end function

        protected function getVectorCross(param1:Vector.<Number>, param2:Vector.<Number>, param3:Vector.<Number>, param4:Boolean = true) : Vector3D
        {
            var _loc_5:* = new Vector3D(param1[0], param1[1], param1[2]);
            var _loc_6:* = new Vector3D(param2[0] - _loc_5.x, param2[1] - _loc_5.y, param2[2] - _loc_5.z);
            var _loc_7:* = new Vector3D(param3[0] - _loc_5.x, param3[1] - _loc_5.y, param3[2] - _loc_5.z);
            var _loc_8:* = _loc_6.crossProduct(_loc_7);
            if (param4)
            {
                _loc_8.normalize();
            }
            return _loc_8;
        }// end function

        protected function getVectorCross3D(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Boolean = true) : Vector3D
        {
            var _loc_5:* = param2.subtract(param1).crossProduct(param3.subtract(param1));
            if (param4)
            {
                _loc_5.normalize();
            }
            return _loc_5;
        }// end function

        protected function lineTurn(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : Vector3D
        {
            var _loc_15:* = NaN;
            if (param1 == param7 && param2 == param8 && param3 == param9)
            {
                return null;
            }
            if (param4 == param7 && param5 == param8 && param6 == param9)
            {
                return null;
            }
            var _loc_11:* = param4 - param1;
            var _loc_12:* = param5 - param2;
            var _loc_13:* = param6 - param3;
            if (_loc_11 == 0 && _loc_12 == 0 && _loc_13 == 0)
            {
                return null;
            }
            var _loc_14:* = Math.sqrt(_loc_11 * _loc_11 + _loc_12 * _loc_12);
            if (Math.sqrt(_loc_11 * _loc_11 + _loc_12 * _loc_12) == 0)
            {
                _loc_15 = 0;
            }
            else
            {
                _loc_15 = Math.acos((param4 - param1) / _loc_14);
                if (_loc_12 < 0)
                {
                    _loc_15 = 2 * Math.PI - _loc_15;
                }
            }
            var _loc_16:* = Math.sqrt(_loc_11 * _loc_11 + _loc_12 * _loc_12 + _loc_13 * _loc_13);
            var _loc_17:* = Math.acos(_loc_14 / _loc_16);
            if (_loc_13 < 0)
            {
                _loc_17 = 2 * Math.PI - _loc_17;
            }
            var _loc_18:* = Math.cos(_loc_15);
            var _loc_19:* = Math.sin(_loc_15);
            var _loc_20:* = Math.cos(_loc_17);
            var _loc_21:* = Math.sin(_loc_17);
            var _loc_22:* = Math.cos(param10);
            var _loc_23:* = Math.sin(param10);
            var _loc_24:* = ((param7 - param1) * _loc_18 + (param8 - param2) * _loc_19) * _loc_20 + (param9 - param3) * _loc_21;
            var _loc_25:* = (-(param7 - param1)) * _loc_19 + (param8 - param2) * _loc_18;
            var _loc_26:* = (-((param7 - param1) * _loc_18 + (param8 - param2) * _loc_19)) * _loc_21 + (param9 - param3) * _loc_20;
            var _loc_27:* = _loc_24;
            var _loc_28:* = _loc_25 * _loc_22 - _loc_26 * _loc_23;
            var _loc_29:* = _loc_25 * _loc_23 + _loc_26 * _loc_22;
            var _loc_30:* = new Vector3D();
            _loc_30.x = (_loc_27 * _loc_20 - _loc_29 * _loc_21) * _loc_18 - _loc_28 * _loc_19 + param1;
            _loc_30.y = (_loc_27 * _loc_20 - _loc_29 * _loc_21) * _loc_19 + _loc_28 * _loc_18 + param2;
            _loc_30.z = _loc_27 * _loc_21 + _loc_29 * _loc_20 + param3;
            return _loc_30;
        }// end function

        protected function lineTurn3D(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector3D
        {
            var _loc_5:* = this.lineTurn(param1.x, param1.y, param1.z, param2.x, param2.y, param2.z, param3.x, param3.y, param3.z, param4);
            if (!this.lineTurn(param1.x, param1.y, param1.z, param2.x, param2.y, param2.z, param3.x, param3.y, param3.z, param4))
            {
                return param3.clone();
            }
            return _loc_5;
        }// end function

        protected function snapSurface(param1:Vector3D, param2:Boolean, param3:Number = 0.1) : Boolean
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_4:* = Math.abs(param1.y) < param3 && Math.abs(param1.z) < param3;
            if (Math.abs(param1.y) < param3 && Math.abs(param1.z) < param3)
            {
                if (param2)
                {
                    _loc_5 = ComOther.roundDeg(ComOther.toDigree(Math.atan2(param1.z, param1.x)));
                    if (Math.abs(_loc_5) > 90)
                    {
                        if (_loc_5 > 0)
                        {
                            _loc_5 = _loc_5 - 180;
                        }
                        else
                        {
                            _loc_5 = _loc_5 + 180;
                        }
                    }
                    _loc_6 = ComOther.roundDeg(ComOther.toDigree(Math.atan2(param1.y, param1.x)));
                    if (Math.abs(_loc_6) > 90)
                    {
                        if (_loc_6 > 0)
                        {
                            _loc_6 = _loc_6 - 180;
                        }
                        else
                        {
                            _loc_6 = _loc_6 + 180;
                        }
                    }
                    if (Math.abs(_loc_5) >= 1e-007)
                    {
                        this.move(2, _loc_5);
                    }
                    if (Math.abs(_loc_6) >= 1e-007)
                    {
                        this.move(3, _loc_6);
                    }
                }
            }
            return _loc_4;
        }// end function

    }
}
