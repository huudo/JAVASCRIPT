package phcontents
{
    import flash.display.*;
    import flash.geom.*;
    import phcomm.*;
    import phcomm.clipstage.*;
    import phcontents.comaction.*;

    public class ContentsPage1890501 extends ContentsPageTenkaizu
    {
        public var btnOtherTenkai:OtherTenkaitButton;
        public var txt円錐:MovieClip;
        public var btnSurface:SurfaceButton;
        public var btnColor5:SolidColorButtonYellow;
        public var btnLeft:SolidLeftButton;
        public var btnColor4:SolidColorButtonOrange;
        public var btnColor7:SolidColorButtonGreen;
        public var btnColor6:SolidColorButtonPurple;
        public var btnUp:SolidUpButton;
        public var txt三角柱:MovieClip;
        public var btnColor1:SolidColorButtonPink;
        public var btnKumitate:KumitateButton;
        public var btnStart:StartButton;
        public var btnColor0:SolidColorButtonRed;
        public var btnColor3:SolidColorButtonBlueGreen;
        public var btnTenkai:TenkaiButton;
        public var btnDown:SolidDownButton;
        public var txt三角錐:MovieClip;
        public var btnOtherTenkai2:OtherTenkaitButton;
        public var btnColorErase:StageColorButtonErase;
        public var btnColor2:SolidColorButtonViolet;
        public var btnReset:SolidResetButton;
        public var btnTape:SolidTapeButton;
        public var txt円柱:MovieClip;
        public var txt四角錐:MovieClip;
        public var btnWireFrame:WireFrameButton;
        public var btnOtherTenkaiReset:RestartButton;
        public var btnRight:SolidRightButton;
        public var btnCut:SolidCutButton;
        public var txt直方体:MovieClip;
        private const VIEW_SIZE:Number = 600;
        private const VIEW_X_DIFF_FIX:Number = -50;
        private const VIEW_Y_DIFF_CLOSE:Number = 0;
        private const VIEW_Y_DIFF_OPEN:Number = -120;
        private const INTERVAL_START_OPEN:int = 1000;
        private const INTERVAL_FRONT_STEP:int = 50;
        private const FRONT_MOVE_STEP_DIVIDE:int = 10;
        private var mTenkaiCount:int;
        private var mAnimateFunction:Function;
        private var mAnimateValues:Array;
        private var mNeedAngleRotY:Number;
        private var mNeedAngleRotZ:Number;
        private var mMovedAngleRotY:Number;
        private var mMovedAngleRotZ:Number;
        private var mFontMoveCount:int;

        public function ContentsPage1890501()
        {
            return;
        }// end function

        override protected function eventJump(event:StageEvent) : void
        {
            super.eventJump(event);
            switch(event.type)
            {
                case StageEvent.INITIALIZE:
                case StageEvent.BUTTON_CLICK + BUTTON_COMMON_ACTION_END:
                {
                    this.Screen1_Initialize();
                    break;
                }
                default:
                {
                    switch(this.screenNo)
                    {
                        case 1:
                        {
                            this.Screen1_Event(event);
                            break;
                        }
                        case 2:
                        {
                            this.Screen2_Event(event);
                            break;
                        }
                        case 3:
                        {
                            this.Screen3_Event(event);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function Screen1_Initialize() : void
        {
            this.stopTimerAll();
            this.screenNo = 1;
            this.setCursor(CursorOperate.SYSTEM_DEFAULT);
            this.objectClear();
            gPH3D.setVew3D(0, 0, 2000);
            this.dataLoadFromName("円錐");
            this.clear();
            this.initialize();
            this.setView(this.VIEW_SIZE, this.VIEW_SIZE, this.VIEW_X_DIFF_FIX, this.VIEW_Y_DIFF_CLOSE);
            this.moveBasis();
            this.faceBasisColorB(5154495);
            this.faceBasisColorAlpha(0.9);
            this.gS3ModelMode = 0;
            this.lineStateDefault();
            this.viewSet();
            this.display3D();
            this.buttonClear();
            this.buttonVisible("btnStart", true);
            this.buttonVisible(BUTTON_COMMON_ACTION_START2, true);
            return;
        }// end function

        private function Screen1_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.BUTTON_CLICK + "btnStart":
                {
                    this.Screen2_Initialize();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function Screen2_Initialize() : void
        {
            this.stopTimerAll();
            this.screenNo = 2;
            this.objectClear();
            this.clear();
            this.initialize();
            this.moveBasis();
            gS3GLineCut[2] = 1;
            gS3CutFlg[0] = 1;
            var _loc_1:* = 2 + int(S3_SOKUMEN / 2) - 1;
            if (_loc_1 >= S3_SOKUMEN)
            {
                _loc_1 = _loc_1 - S3_SOKUMEN;
            }
            var _loc_2:* = 0;
            while (_loc_2 < S3_SOKUMEN)
            {
                
                if (_loc_2 != _loc_1)
                {
                    gS3GLineCut[S3_SOKUMEN + _loc_2] = 1;
                }
                _loc_2++;
            }
            gS3CutFlg[1] = 1;
            this.setView(this.VIEW_SIZE, this.VIEW_SIZE, this.VIEW_X_DIFF_FIX, this.VIEW_Y_DIFF_CLOSE);
            this.viewSet();
            this.display3D();
            this.buttonClear();
            this.pause(this.INTERVAL_START_OPEN);
            return;
        }// end function

        private function Screen2_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.PAUSE_END:
                {
                    this.Screen3_Initialize();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function Screen3_Initialize() : void
        {
            this.stopTimerAll();
            this.screenNo = 3;
            this.objectClear();
            this.buttonClear();
            this.setView(this.VIEW_SIZE, this.VIEW_SIZE, this.VIEW_X_DIFF_FIX, this.VIEW_Y_DIFF_CLOSE);
            this.mTenkaiCount = 0;
            this.Screen3_TenkaiStart();
            return;
        }// end function

        private function Screen3_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.S3D_TENKAI_END:
                {
                    if (this.mAnimateFunction != null)
                    {
                        this.mAnimateFunction.call();
                    }
                    break;
                }
                case StageEvent.TIMER:
                {
                    this.Screen3_TenkaiFront();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function Screen3_TenkaiStart() : void
        {
            if (this.nowMove)
            {
                return;
            }
            if (this.mTenkaiCount == 2)
            {
                return;
            }
            this.isTenkaiMoveFront = false;
            this.mAnimateFunction = null;
            this.mAnimateValues = null;
            var _loc_1:* = int.MIN_VALUE;
            if (gS3CutFlg[1] == 1)
            {
                _loc_1 = 1;
            }
            else if (gS3CutFlg[2] == 1)
            {
                _loc_1 = 2;
            }
            else if (gS3CutFlg[0] == 1)
            {
                if (gS3SolidNo == 1 && gS3CutFlg[1] == 2 || gS3SolidNo == 2 && gS3CutFlg[1] == 2 && gS3CutFlg[2] == 2)
                {
                    _loc_1 = 0;
                }
            }
            if (_loc_1 >= 0)
            {
                this.mAnimateFunction = this.Screen3_TenkaiMove;
                this.mAnimateValues = new Array();
                this.mAnimateValues.push(_loc_1);
                this.cylinderTenkai(_loc_1);
            }
            return;
        }// end function

        private function Screen3_TenkaiMove() : void
        {
            if (gS3SolidNo == 1 && gS3CutFlg[0] == 2 && gS3CutFlg[1] == 2 || gS3SolidNo == 2 && gS3CutFlg[0] == 2 && gS3CutFlg[1] == 2 && gS3CutFlg[2] == 2)
            {
                this.mTenkaiCount = 2;
            }
            this.mAnimateFunction = null;
            this.mAnimateValues = null;
            if (this.mTenkaiCount != 2)
            {
                this.Screen3_TenkaiStart();
                return;
            }
            var _loc_1:* = this.getVectorCrossCurrentFace(0, true);
            this.mNeedAngleRotY = ComOther.roundDeg(ComOther.toDigree(Math.atan2(_loc_1.z, _loc_1.x)));
            if (Math.abs(this.mNeedAngleRotY) > 90)
            {
                if (this.mNeedAngleRotY > 0)
                {
                    this.mNeedAngleRotY = this.mNeedAngleRotY - 180;
                }
                else
                {
                    this.mNeedAngleRotY = this.mNeedAngleRotY + 180;
                }
            }
            this.mNeedAngleRotZ = ComOther.roundDeg(ComOther.toDigree(Math.atan2(_loc_1.y, _loc_1.x)));
            if (Math.abs(this.mNeedAngleRotZ) > 90)
            {
                if (this.mNeedAngleRotZ > 0)
                {
                    this.mNeedAngleRotZ = this.mNeedAngleRotZ - 180;
                }
                else
                {
                    this.mNeedAngleRotZ = this.mNeedAngleRotZ + 180;
                }
            }
            this.mMovedAngleRotY = 0;
            this.mMovedAngleRotZ = 0;
            this.mFontMoveCount = 0;
            this.stopTimerAll();
            this.startTimer(this.screenNo, this.INTERVAL_FRONT_STEP);
            return;
        }// end function

        private function Screen3_TenkaiFront() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = this;
            var _loc_4:* = this.mFontMoveCount + 1;
            _loc_3.mFontMoveCount = _loc_4;
            if (this.mFontMoveCount >= this.FRONT_MOVE_STEP_DIVIDE)
            {
                this.stopTimerAll();
            }
            if (this.mFontMoveCount < this.FRONT_MOVE_STEP_DIVIDE)
            {
                _loc_1 = this.mNeedAngleRotY / this.FRONT_MOVE_STEP_DIVIDE;
                _loc_2 = this.mNeedAngleRotZ / this.FRONT_MOVE_STEP_DIVIDE;
                this.mMovedAngleRotY = this.mMovedAngleRotY + _loc_1;
                this.mMovedAngleRotZ = this.mMovedAngleRotZ + _loc_2;
            }
            else
            {
                _loc_1 = this.mNeedAngleRotY - this.mMovedAngleRotY;
                _loc_2 = this.mNeedAngleRotZ - this.mMovedAngleRotZ;
            }
            if (Math.abs(_loc_1) >= 1e-007)
            {
                this.move(2, _loc_1);
            }
            if (Math.abs(_loc_2) >= 1e-007)
            {
                this.move(3, _loc_2);
            }
            if (this.mFontMoveCount < this.FRONT_MOVE_STEP_DIVIDE)
            {
                this.setView(this.VIEW_SIZE, this.VIEW_SIZE, this.VIEW_X_DIFF_FIX, (this.VIEW_Y_DIFF_OPEN - this.VIEW_Y_DIFF_CLOSE) * (this.mFontMoveCount / this.FRONT_MOVE_STEP_DIVIDE) + this.VIEW_Y_DIFF_CLOSE);
            }
            else
            {
                this.setView(this.VIEW_SIZE, this.VIEW_SIZE, this.VIEW_X_DIFF_FIX, this.VIEW_Y_DIFF_OPEN);
            }
            this.viewSet();
            this.display3D();
            if (this.mFontMoveCount >= this.FRONT_MOVE_STEP_DIVIDE)
            {
                this.buttonVisible(this.BUTTON_COMMON_ACTION_START, true);
                this.buttonVisible(this.BUTTON_COMMON_ACTION_END, true);
            }
            return;
        }// end function

    }
}
