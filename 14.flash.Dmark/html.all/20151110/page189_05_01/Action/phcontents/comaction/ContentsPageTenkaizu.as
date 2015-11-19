package phcontents.comaction
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import phcomm.clipstage.*;

    public class ContentsPageTenkaizu extends Cylinder3D
    {
        protected const BUTTON_COMMON_ACTION_START:String = "btnOtherTenkai";
        protected const BUTTON_COMMON_ACTION_START2:String = "btnOtherTenkai2";
        protected const BUTTON_COMMON_ACTION_END:String = "btnOtherTenkaiReset";
        protected const BUTTON_TENKAI:String = "btnTenkai";
        protected const BUTTON_KUMITATE:String = "btnKumitate";
        protected const BUTTON_WIREFRAME:String = "btnWireFrame";
        protected const BUTTON_SURFACE:String = "btnSurface";
        protected const BUTTON_CUT:String = "btnCut";
        protected const BUTTON_TAPE:String = "btnTape";
        protected const BUTTON_UP:String = "btnUp";
        protected const BUTTON_DOWN:String = "btnDown";
        protected const BUTTON_LEFT:String = "btnLeft";
        protected const BUTTON_RIGHT:String = "btnRight";
        protected const BUTTON_RESET:String = "btnReset";
        protected const BUTTON_COLOR:Vector.<String>;
        protected const COMMON_ACTION_SCREEN_NO_BASE:int = 10000;
        private const SOLID_NAME_OBJECT:Vector.<String>;
        private const SOLID_DATA_NUMBER:Vector.<int>;
        private const SOLID_VIEW_SIZE:Vector.<Number>;
        protected var dSolidNo:int;
        protected var dMouseIcon:int;
        protected var dAutoFlag:int;
        protected var dMenuItemArea:Vector.<Rectangle>;
        private var dAnimateFunction:Function;
        private var dAnimateValues:Array;

        public function ContentsPageTenkaizu()
        {
            this.BUTTON_COLOR = this.Vector.<String>(["btnColor0", "btnColor1", "btnColor2", "btnColor3", "btnColor4", "btnColor5", "btnColor6", "btnColor7", "btnColorErase"]);
            this.SOLID_NAME_OBJECT = this.Vector.<String>(["txt三角柱", "txt三角錐", "txt直方体", "txt四角錐", "txt円柱", "txt円錐"]);
            this.SOLID_DATA_NUMBER = this.Vector.<int>([4, 3, 6, 5, 2, 1]);
            this.SOLID_VIEW_SIZE = this.Vector.<Number>([450, 520, 450, 480, 450, 500]);
            return;
        }// end function

        override protected function eventJump(event:StageEvent) : void
        {
            super.eventJump(event);
            switch(event.type)
            {
                case StageEvent.BUTTON_CLICK + this.BUTTON_COMMON_ACTION_START:
                case StageEvent.BUTTON_CLICK + this.BUTTON_COMMON_ACTION_START2:
                {
                    this.TenkaiScreen1_Initialize();
                    break;
                }
                default:
                {
                    switch(this.screenNo)
                    {
                        case (this.COMMON_ACTION_SCREEN_NO_BASE + 1):
                        {
                            this.TenkaiScreen1_Event(event);
                            break;
                        }
                        case this.COMMON_ACTION_SCREEN_NO_BASE + 2:
                        {
                            this.TenkaiScreen2_Event(event);
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

        protected function selectFlagSet(param1:int, param2:uint = 0) : void
        {
            if (gS3StFlg == param1 && param2 == this.getDrawColor())
            {
                param1 = SELECT_NONE;
            }
            gS3StFlg = param1;
            switch(gS3StFlg)
            {
                case SELECT_COLOR:
                {
                    this.setDrawColor(param2);
                    break;
                }
                default:
                {
                    this.setDrawColor(0);
                    break;
                    break;
                }
            }
            this.buttonSelected(this.BUTTON_CUT, gS3StFlg == SELECT_CUT);
            this.buttonSelected(this.BUTTON_TAPE, gS3StFlg == SELECT_TAPE);
            var _loc_3:* = 0;
            while (_loc_3 < this.BUTTON_COLOR.length)
            {
                
                this.buttonSelected(this.BUTTON_COLOR[_loc_3], gS3StFlg == SELECT_COLOR && StageColorButton(this.buttonReference(this.BUTTON_COLOR[_loc_3])).color == param2);
                _loc_3++;
            }
            return;
        }// end function

        protected function TenkaiScreen1_Initialize() : void
        {
            var _loc_1:* = 0;
            if (!this.dMenuItemArea)
            {
                this.dMenuItemArea = new Vector.<Rectangle>(this.SOLID_DATA_NUMBER.length, true);
                _loc_1 = 0;
                while (_loc_1 < this.dMenuItemArea.length)
                {
                    
                    this.dMenuItemArea[_loc_1] = new Rectangle();
                    _loc_1++;
                }
            }
            this.stopTimerAll();
            this.screenNo = this.COMMON_ACTION_SCREEN_NO_BASE + 1;
            gS3StFlg = SELECT_NONE;
            this.buttonClear();
            this.buttonVisible(this.BUTTON_COMMON_ACTION_END, true);
            this.TenkaiScreen1_Draw();
            return;
        }// end function

        protected function TenkaiScreen1_Draw() : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            this.stageClear();
            this.objectClear();
            this.dSolidNo = 0;
            this.dMouseIcon = 0;
            gPH3D.setVew3D(0, 0, 2000);
            this.gS3ModelMode = 0;
            this.lineStateDefault();
            var _loc_1:* = this.objectReference(this.BUTTON_COMMON_ACTION_START).x;
            var _loc_2:* = this.areaHeight;
            var _loc_3:* = Math.min(_loc_1 / 3, (_loc_2 - 100) / 2);
            var _loc_4:* = 0;
            while (_loc_4 < this.SOLID_DATA_NUMBER.length)
            {
                
                this.dataLoad(-1, this.SOLID_DATA_NUMBER[_loc_4]);
                this.clear();
                this.initialize();
                _loc_5 = _loc_1 / 2;
                switch(_loc_4 % 3)
                {
                    case 0:
                    {
                        _loc_5 = _loc_5 - _loc_3;
                        break;
                    }
                    case 2:
                    {
                        _loc_5 = _loc_5 + _loc_3;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (int(_loc_4 / 3) < 1)
                {
                    _loc_6 = _loc_2 / 3;
                }
                else
                {
                    _loc_6 = _loc_2 / 4 * 3;
                }
                _loc_6 = _loc_6 - 50;
                _loc_7 = _loc_5 - _loc_1 / 2 - (this.areaWidth - _loc_1) / 2;
                _loc_8 = _loc_6 - _loc_2 / 2 - (this.areaHeight - _loc_2) / 2;
                this.setView(_loc_3 * 1.2, _loc_3 * 1.2, _loc_7, _loc_8);
                this.moveBasis();
                this.display3D2();
                this.deleteRegion();
                this.dMenuItemArea[_loc_4].width = _loc_3 * 0.7;
                this.dMenuItemArea[_loc_4].height = _loc_3 * 0.9;
                this.dMenuItemArea[_loc_4].x = _loc_5 - this.dMenuItemArea[_loc_4].width / 2;
                this.dMenuItemArea[_loc_4].y = _loc_6 - this.dMenuItemArea[_loc_4].height / 2 + 30;
                _loc_9 = MovieClip(this.objectReference(this.SOLID_NAME_OBJECT[_loc_4]));
                _loc_9.x = this.dMenuItemArea[_loc_4].x + this.dMenuItemArea[_loc_4].width / 2 - _loc_9.width / 2;
                _loc_9.y = this.dMenuItemArea[_loc_4].y + this.dMenuItemArea[_loc_4].height - _loc_9.height;
                _loc_9.enabled = false;
                _loc_9.mouseEnabled = false;
                _loc_9.mouseChildren = false;
                _loc_9.visible = true;
                _loc_4++;
            }
            return;
        }// end function

        private function TenkaiScreen1_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.STAGE_MOUSE_DOWN:
                {
                    this.TenkaiScreen1_StageMouseDown(event);
                    break;
                }
                case StageEvent.STAGE_MOUSE_MOVE:
                {
                    this.TenkaiScreen1_StageMouseMove(event);
                    break;
                }
                case StageEvent.STAGE_MOUSE_UP:
                {
                    this.TenkaiScreen1_StageMouseUp(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function TenkaiScreen1_StageMouseDown(event:StageEvent) : void
        {
            if (!event.isMouseButtonDown)
            {
                return;
            }
            this.dSolidNo = this.TenkaiScreen1_SolidNo(event);
            return;
        }// end function

        private function TenkaiScreen1_StageMouseMove(event:StageEvent) : void
        {
            if (event.isMouseButtonDown)
            {
                return;
            }
            if (this.TenkaiScreen1_SolidNo(event) > 0)
            {
                if (this.dMouseIcon != CursorOperate.RIGHT_FINGER)
                {
                    this.dMouseIcon = CursorOperate.RIGHT_FINGER;
                    this.setCursor(this.dMouseIcon);
                }
            }
            else if (this.dMouseIcon != CursorOperate.SYSTEM_DEFAULT)
            {
                this.setCursor(CursorOperate.SYSTEM_DEFAULT);
                this.dMouseIcon = CursorOperate.SYSTEM_DEFAULT;
            }
            return;
        }// end function

        private function TenkaiScreen1_StageMouseUp(event:StageEvent) : void
        {
            var _loc_2:* = this.TenkaiScreen1_SolidNo(event);
            if (this.dSolidNo != 0 && _loc_2 == this.dSolidNo)
            {
                this.TenkaiScreen2_Initialize();
            }
            return;
        }// end function

        protected function TenkaiScreen1_SolidNo(event:StageEvent) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.dMenuItemArea.length)
            {
                
                if (this.dMenuItemArea[_loc_2].contains(event.mouseX, event.mouseY))
                {
                    return this.SOLID_DATA_NUMBER[_loc_2];
                }
                _loc_2++;
            }
            return 0;
        }// end function

        protected function TenkaiScreen2_Initialize() : void
        {
            this.stopTimerAll();
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            this.screenNo = this.COMMON_ACTION_SCREEN_NO_BASE + 2;
            gS3StFlg = SELECT_NONE;
            this.setDrawColor(0);
            this.dMouseIcon = CursorOperate.SYSTEM_DEFAULT;
            this.setCursor(CursorOperate.SYSTEM_DEFAULT);
            gPH3D.setVew3D(0, 0, 2000);
            this.dataLoad(-1, this.dSolidNo);
            this.isUseMoveActionSnap = true;
            this.objectClear();
            this.buttonClear();
            this.buttonVisible(this.BUTTON_COMMON_ACTION_START, true);
            this.buttonVisible(this.BUTTON_COMMON_ACTION_END, true);
            this.buttonVisible(this.BUTTON_TENKAI, true);
            this.buttonVisible(this.BUTTON_KUMITATE, true);
            this.buttonVisible(this.BUTTON_WIREFRAME, true);
            this.buttonVisible(this.BUTTON_SURFACE, false);
            this.buttonVisible(this.BUTTON_CUT, true);
            this.buttonVisible(this.BUTTON_TAPE, true);
            this.buttonVisible(this.BUTTON_UP, true);
            this.buttonVisible(this.BUTTON_DOWN, true);
            this.buttonVisible(this.BUTTON_LEFT, true);
            this.buttonVisible(this.BUTTON_RIGHT, true);
            this.buttonVisible(this.BUTTON_RESET, true);
            var _loc_1:* = 0;
            while (_loc_1 < this.BUTTON_COLOR.length)
            {
                
                this.buttonVisible(this.BUTTON_COLOR[_loc_1], true);
                _loc_1++;
            }
            this.TenkaiScreen2_InitializeSolid();
            return;
        }// end function

        protected function TenkaiScreen2_InitializeSolid() : void
        {
            this.clear();
            this.initialize();
            var _loc_1:* = DEFAULT_VIEW_SIZE;
            var _loc_2:* = 0;
            while (_loc_2 < this.SOLID_DATA_NUMBER.length)
            {
                
                if (this.dSolidNo == this.SOLID_DATA_NUMBER[_loc_2])
                {
                    _loc_1 = this.SOLID_VIEW_SIZE[_loc_2];
                    break;
                }
                _loc_2++;
            }
            var _loc_3:* = this.objectReference(this.BUTTON_LEFT).x;
            this.setView(_loc_1, _loc_1, (-(this.areaWidth - _loc_3)) / 2, 0);
            this.moveBasis();
            this.viewSet();
            this.gS3ModelMode = 0;
            this.lineStateDefault();
            this.display3D();
            return;
        }// end function

        private function TenkaiScreen2_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.BUTTON_CLICK + this.BUTTON_CUT:
                {
                    this.selectFlagSet(SELECT_CUT);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_TAPE:
                {
                    this.selectFlagSet(SELECT_TAPE);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_TENKAI:
                {
                    this.dAutoFlag = 0;
                    this.TenkaiScreen2_AutoTenkai();
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_KUMITATE:
                {
                    this.dAutoFlag = 0;
                    this.TenkaiScreen2_AutoKumitate();
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_SURFACE:
                case StageEvent.BUTTON_CLICK + this.BUTTON_WIREFRAME:
                {
                    this.TenkaiScreen2_ModelChange();
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[0]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[0])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[1]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[1])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[2]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[2])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[3]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[3])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[4]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[4])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[5]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[5])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[6]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[6])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[7]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[7])).color);
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_COLOR[8]:
                {
                    this.selectFlagSet(SELECT_COLOR, StageColorButton(this.buttonReference(this.BUTTON_COLOR[8])).color);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + this.BUTTON_LEFT:
                {
                    this.defaultActionLeft();
                    this.startTimer(1, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + this.BUTTON_RIGHT:
                {
                    this.defaultActionRight();
                    this.startTimer(2, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + this.BUTTON_UP:
                {
                    this.defaultActionUp();
                    this.startTimer(3, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + this.BUTTON_DOWN:
                {
                    this.defaultActionDown();
                    this.startTimer(4, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.TIMER:
                {
                    switch(event.timerID)
                    {
                        case 1:
                        case 11:
                        {
                            this.defaultActionLeft();
                            break;
                        }
                        case 2:
                        case 12:
                        {
                            this.defaultActionRight();
                            break;
                        }
                        case 3:
                        case 13:
                        {
                            this.defaultActionUp();
                            break;
                        }
                        case 4:
                        case 14:
                        {
                            this.defaultActionDown();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (event.timerID < 10)
                    {
                        this.stopTimerAll();
                        this.startTimer(event.timerID + 10, StageEvent.BUTTON_TIMER_INTERVAL_2);
                    }
                    break;
                }
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_LEFT:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_RIGHT:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_UP:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_DOWN:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_RESET:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_CUT:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_TAPE:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_TENKAI:
                case StageEvent.BUTTON_MOUSE_UP + this.BUTTON_KUMITATE:
                {
                    this.stopTimerAll();
                    break;
                }
                case StageEvent.BUTTON_CLICK + this.BUTTON_RESET:
                {
                    this.motonoichi();
                    break;
                }
                case StageEvent.STAGE_MOUSE_DOWN:
                {
                    this.defaultActionStageMouseDown(event);
                    break;
                }
                case StageEvent.STAGE_MOUSE_MOVE:
                {
                    this.defaultActionStageMouseMove(event, false);
                    break;
                }
                case StageEvent.STAGE_MOUSE_UP:
                {
                    this.defaultActionStageMouseUp(event);
                    break;
                }
                case StageEvent.S3D_TENKAI_END:
                case StageEvent.S3D_KUMITATE_END:
                {
                    if (this.dAnimateFunction != null)
                    {
                        this.dAnimateFunction.call();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function TenkaiScreen2_ModelChange() : void
        {
            var _loc_1:* = this.modelChange();
            this.lineStateDefault();
            if (_loc_1 != 0)
            {
                this.lineStateWidth(3);
                this.lineStateRevDot(7, 4);
            }
            this.display3D();
            this.buttonVisible(this.BUTTON_WIREFRAME, _loc_1 == 0);
            this.buttonVisible(this.BUTTON_SURFACE, _loc_1 != 0);
            return;
        }// end function

        private function TenkaiScreen2_AutoTenkai() : void
        {
            if (this.nowMove)
            {
                return;
            }
            if (this.dAutoFlag == 2)
            {
                return;
            }
            this.selectFlagSet(SELECT_NONE);
            this.isTenkaiMoveFront = false;
            if (gS3SolidNo < 3)
            {
                this.TenkaiScreen2_AutoTenkaiCylinder();
            }
            else
            {
                this.TenkaiScreen2_AutoTenkaiSolid();
            }
            return;
        }// end function

        private function TenkaiScreen2_AutoTenkaiCylinder() : void
        {
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
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
                this.buttonLock(true);
                this.dAnimateFunction = this.TenkaiScreen2_AutoTenkaiCylinder_MoveEnd;
                this.dAnimateValues = new Array();
                this.dAnimateValues.push(_loc_1);
                this.cylinderTenkai(_loc_1);
            }
            return;
        }// end function

        private function TenkaiScreen2_AutoTenkaiCylinder_MoveEnd()
        {
            if (gS3SolidNo == 1 && gS3CutFlg[0] == 2 && gS3CutFlg[1] == 2 || gS3SolidNo == 2 && gS3CutFlg[0] == 2 && gS3CutFlg[1] == 2 && gS3CutFlg[2] == 2)
            {
                this.dAutoFlag = 2;
            }
            this.buttonLock(false);
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            return;
        }// end function

        private function TenkaiScreen2_AutoTenkaiSolid() : void
        {
            var _loc_2:* = 0;
            this.buttonLock(true);
            this.dAnimateFunction = this.TenkaiScreen2_AutoTenkaiSolid_MoveEnd;
            this.dAnimateValues = new Array();
            var _loc_1:* = gS3SLineCnt;
            this.dAnimateValues.push(_loc_1);
            var _loc_3:* = 0;
            while (_loc_3 < gS3SLineCnt)
            {
                
                if (gS3GLineCut[_loc_3] == 0)
                {
                    _loc_2 = this.tenkai(_loc_3);
                }
                if (_loc_2 != 0)
                {
                    _loc_1 = _loc_3;
                    this.dAnimateValues[0] = _loc_1;
                    return;
                }
                _loc_3++;
            }
            this.dAnimateFunction.call();
            return;
        }// end function

        private function TenkaiScreen2_AutoTenkaiSolid_MoveEnd() : void
        {
            var _loc_1:* = int(this.dAnimateValues[0]);
            if (_loc_1 != gS3SLineCnt)
            {
                this.dAutoFlag = 1;
            }
            else if (this.dAutoFlag == 1)
            {
                this.dAutoFlag = 2;
            }
            this.buttonLock(false);
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            return;
        }// end function

        private function TenkaiScreen2_AutoKumitate() : void
        {
            if (this.nowMove)
            {
                return;
            }
            if (this.dAutoFlag == 2)
            {
                return;
            }
            this.selectFlagSet(SELECT_NONE);
            if (gS3SolidNo < 3)
            {
                this.TenkaiScreen2_AutoKumitateCylinder();
            }
            else
            {
                this.TenkaiScreen2_AutoKumitateSolid();
            }
            return;
        }// end function

        private function TenkaiScreen2_AutoKumitateCylinder() : void
        {
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            var _loc_1:* = int.MIN_VALUE;
            if (gS3CutFlg[0] == 2)
            {
                _loc_1 = 0;
            }
            else if (gS3CutFlg[1] == 2)
            {
                _loc_1 = 1;
            }
            else if (gS3CutFlg[2] == 2)
            {
                _loc_1 = 2;
            }
            if (_loc_1 >= 0)
            {
                this.buttonLock(true);
                this.dAnimateFunction = this.TenkaiScreen2_AutoKumitateCylinder_MoveEnd;
                this.cylinderKumitate(_loc_1);
            }
            return;
        }// end function

        private function TenkaiScreen2_AutoKumitateCylinder_MoveEnd() : void
        {
            this.buttonLock(false);
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            return;
        }// end function

        private function TenkaiScreen2_AutoKumitateSolid() : void
        {
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            var _loc_1:* = gS3SLineCnt;
            var _loc_2:* = 0;
            while (_loc_2 < gS3SLineCnt)
            {
                
                if (gS3GLineCut[_loc_2] == 3)
                {
                    _loc_1 = _loc_2;
                    break;
                }
                _loc_2++;
            }
            if (_loc_1 != gS3SLineCnt)
            {
                this.dAutoFlag = 1;
                this.dAnimateFunction = this.TenkaiScreen2_AutoKumitateSolid_MoveEnd;
                this.buttonLock(true);
                this.kumitate(_loc_1);
            }
            else if (this.dAutoFlag == 1)
            {
                this.dAutoFlag = 2;
            }
            return;
        }// end function

        private function TenkaiScreen2_AutoKumitateSolid_MoveEnd() : void
        {
            this.buttonLock(false);
            this.dAnimateFunction = null;
            this.dAnimateValues = null;
            return;
        }// end function

    }
}
