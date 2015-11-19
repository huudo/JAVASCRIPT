package phcontents
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import phcomm.clipstage.*;

    public class ContentsPage1910301 extends Solid3D
    {
        public var btnLeft:SolidLeftButton;
        public var clpAreaShadow:MovieClip;
        public var btnUp:SolidUpButton;
        public var btnDown:SolidDownButton;
        public var btnReset:SolidResetButton;
        public var btnRight:SolidRightButton;
        public var clpAreaEntity:MovieClip;
        private const CROSS_NUMBER_ADD:int = 1000;
        private var mCrossPoints:Vector.<Vector.<Vector.<Vector3D>>>;
        private var mCrossPointsCurrent:Vector.<Vector.<Vector.<Vector3D>>>;
        private var mViewDiffEntityX:Number;
        private var mViewDiffShadowX:Number;

        public function ContentsPage1910301()
        {
            this.mCrossPoints = null;
            this.mCrossPointsCurrent = null;
            return;
        }// end function

        override protected function eventJump(event:StageEvent) : void
        {
            super.eventJump(event);
            switch(event.type)
            {
                case StageEvent.INITIALIZE:
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
            this.screenNo = 1;
            gPH3D.setVew3D(0, 0, 2000);
            var _loc_1:* = this.objectReference("clpAreaEntity").getBounds(this);
            this.mViewDiffEntityX = _loc_1.x + _loc_1.width / 2 - this.areaWidth / 2;
            _loc_1 = this.objectReference("clpAreaShadow").getBounds(this);
            this.mViewDiffShadowX = _loc_1.x + _loc_1.width / 2 - this.areaWidth / 2;
            this.dataLoadFromName("正四面体");
            this.setCrossSurface();
            this.isUseMoveActionSnap = true;
            this.degreeStep = 5;
            this.Screen1_InitializeSolid();
            this.objectClear();
            this.objectVisible("clpAreaEntity", true);
            this.objectVisible("clpAreaShadow", true);
            this.buttonClear();
            this.buttonVisible("btnUp", true);
            this.buttonVisible("btnDown", true);
            this.buttonVisible("btnLeft", true);
            this.buttonVisible("btnRight", true);
            this.buttonVisible("btnReset", true);
            return;
        }// end function

        private function Screen1_InitializeSolid() : void
        {
            this.clear();
            this.initialize();
            this.setView(550, 550, this.mViewDiffEntityX, 10);
            this.move(3, 10);
            this.move(2, 10);
            this.gS3ModelMode = 0;
            this.faceBasisColor(216, 241, 253);
            this.faceBasisColorAlpha(0.6);
            this.lineState(5528926, 5);
            this.viewSet();
            this.display3D();
            return;
        }// end function

        private function Screen1_Event(event:StageEvent) : void
        {
            switch(event.type)
            {
                case StageEvent.BUTTON_CLICK + "btnRestart":
                {
                    this.Screen1_Initialize();
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + "btnLeft":
                {
                    this.defaultActionLeft();
                    this.startTimer(1, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + "btnRight":
                {
                    this.defaultActionRight();
                    this.startTimer(2, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + "btnUp":
                {
                    this.defaultActionUp();
                    this.startTimer(3, StageEvent.BUTTON_TIMER_INTERVAL_1);
                    break;
                }
                case StageEvent.BUTTON_MOUSE_DOWN + "btnDown":
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
                case StageEvent.BUTTON_MOUSE_UP + "btnLeft":
                case StageEvent.BUTTON_MOUSE_UP + "btnRight":
                case StageEvent.BUTTON_MOUSE_UP + "btnUp":
                case StageEvent.BUTTON_MOUSE_UP + "btnDown":
                {
                    this.stopTimerAll();
                    break;
                }
                case StageEvent.BUTTON_CLICK + "btnReset":
                {
                    this.Screen1_Initialize();
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function initialize() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            super.initialize();
            if (!this.mCrossPointsCurrent)
            {
                this.mCrossPointsCurrent = new Vector.<Vector.<Vector.<Vector3D>>>(this.mCrossPoints.length, true);
            }
            var _loc_1:* = 0;
            while (_loc_1 < this.mCrossPoints.length)
            {
                
                if (!this.mCrossPointsCurrent[_loc_1])
                {
                    this.mCrossPointsCurrent[_loc_1] = new Vector.<Vector.<Vector3D>>(this.mCrossPoints[_loc_1].length, true);
                }
                _loc_2 = 0;
                while (_loc_2 < this.mCrossPoints[_loc_1].length)
                {
                    
                    if (!this.mCrossPointsCurrent[_loc_1][_loc_2])
                    {
                        this.mCrossPointsCurrent[_loc_1][_loc_2] = new Vector.<Vector3D>(this.mCrossPoints[_loc_1][_loc_2].length, true);
                    }
                    _loc_3 = 0;
                    while (_loc_3 < this.mCrossPoints[_loc_1][_loc_2].length)
                    {
                        
                        if (!this.mCrossPointsCurrent[_loc_1][_loc_2][_loc_3])
                        {
                            this.mCrossPointsCurrent[_loc_1][_loc_2][_loc_3] = new Vector3D();
                        }
                        this.mCrossPointsCurrent[_loc_1][_loc_2][_loc_3].x = this.mCrossPoints[_loc_1][_loc_2][_loc_3].x;
                        this.mCrossPointsCurrent[_loc_1][_loc_2][_loc_3].y = this.mCrossPoints[_loc_1][_loc_2][_loc_3].y;
                        this.mCrossPointsCurrent[_loc_1][_loc_2][_loc_3].z = this.mCrossPoints[_loc_1][_loc_2][_loc_3].z;
                        _loc_3++;
                    }
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        override protected function move(param1:int, param2:Number) : void
        {
            var _loc_4:* = 0;
            super.move(param1, param2);
            var _loc_3:* = 0;
            while (_loc_3 < this.mCrossPointsCurrent.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this.mCrossPointsCurrent[_loc_3].length)
                {
                    
                    this.actionMove3D(param1, param2, this.mCrossPointsCurrent[_loc_3][_loc_4], this.mCrossPointsCurrent[_loc_3][_loc_4].length);
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        override protected function moveActionSnap() : int
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_1:* = super.moveActionSnap();
            if (_loc_1 == int.MIN_VALUE)
            {
                _loc_2 = false;
                _loc_3 = 0;
                while (_loc_3 < this.mCrossPointsCurrent.length)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < this.mCrossPointsCurrent[_loc_3].length)
                    {
                        
                        _loc_5 = this.CROSS_NUMBER_ADD + _loc_3 * 100 + _loc_4;
                        _loc_6 = this.getVectorCross3D(this.mCrossPointsCurrent[_loc_3][_loc_4][0], this.mCrossPointsCurrent[_loc_3][_loc_4][1], this.mCrossPointsCurrent[_loc_3][_loc_4][2], true);
                        _loc_7 = gLastMoveSnapFaceNo != _loc_5;
                        if (this.snapSurface(_loc_6, _loc_7, 0.15))
                        {
                            _loc_2 = true;
                            _loc_1 = _loc_5;
                            if (_loc_7)
                            {
                                gLastMoveSnapFaceNo = _loc_5;
                            }
                            else
                            {
                                gLastMoveSnapFaceNo = int.MIN_VALUE;
                            }
                            break;
                        }
                        _loc_4++;
                    }
                    if (_loc_2)
                    {
                        break;
                    }
                    _loc_3++;
                }
            }
            return _loc_1;
        }// end function

        override protected function display3D2(param1:int = -1) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.objectVisible("clpAreaEntity", true);
            this.objectVisible("clpAreaShadow", true);
            var _loc_2:* = this.mViewDiffShadowX - this.mViewDiffEntityX;
            var _loc_3:* = 2;
            if (dLineWid >= 0)
            {
                _loc_3 = Math.max(dLineWid, 1);
            }
            var _loc_4:* = 0;
            while (_loc_4 < gS3SFaceCnt)
            {
                
                _loc_5 = gS3SFace[_loc_4][0];
                _loc_6 = new Vector.<Number>(_loc_5, true);
                _loc_7 = new Vector.<Number>(_loc_5, true);
                _loc_8 = 0;
                while (_loc_8 < _loc_5)
                {
                    
                    _loc_9 = gS3SFace[_loc_4][(_loc_8 + 1)];
                    gPH3D.cv3d3d(gS3GPoint[_loc_9][0], gS3GPoint[_loc_9][1], gS3GPoint[_loc_9][2]);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_6[_loc_8] = this.VewWinX + _loc_2;
                    _loc_7[_loc_8] = this.VewWinY;
                    _loc_8++;
                }
                this.canvasGraphics.lineStyle(_loc_3, 6710886);
                this.canvasGraphics.beginFill(6710886);
                this.canvasGraphics.moveTo(_loc_6[0], _loc_7[0]);
                _loc_8 = 1;
                while (_loc_8 < _loc_5)
                {
                    
                    this.canvasGraphics.lineTo(_loc_6[_loc_8], _loc_7[_loc_8]);
                    _loc_8++;
                }
                this.canvasGraphics.lineTo(_loc_6[0], _loc_7[0]);
                this.canvasGraphics.endFill();
                _loc_4++;
            }
            super.display3D2(param1);
            this.drawMark(_loc_2);
            return;
        }// end function

        private function setCrossSurface() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = false;
            this.mCrossPoints = new Vector.<Vector.<Vector.<Vector3D>>>(4, true);
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                _loc_4 = gS3SFace[_loc_1][1];
                _loc_5 = gS3SFace[_loc_1][2];
                _loc_6 = gS3SFace[_loc_1][3];
                _loc_7 = null;
                _loc_2 = 0;
                while (_loc_2 < gS3SPointCnt)
                {
                    
                    _loc_8 = _loc_4 == _loc_2 || _loc_5 == _loc_2 || _loc_6 == _loc_2;
                    if (!_loc_8)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < gS3SPointCom[_loc_4][0])
                        {
                            
                            _loc_8 = gS3SPointCom[_loc_4][(_loc_3 + 1)] == _loc_2;
                            if (_loc_8)
                            {
                                break;
                            }
                            _loc_3++;
                        }
                        _loc_3 = 0;
                        while (_loc_3 < gS3SPointCom[_loc_5][0])
                        {
                            
                            _loc_8 = gS3SPointCom[_loc_5][(_loc_3 + 1)] == _loc_2;
                            if (_loc_8)
                            {
                                break;
                            }
                            _loc_3++;
                        }
                        _loc_3 = 0;
                        while (_loc_3 < gS3SPointCom[_loc_6][0])
                        {
                            
                            _loc_8 = gS3SPointCom[_loc_6][(_loc_3 + 1)] == _loc_2;
                            if (_loc_8)
                            {
                                break;
                            }
                            _loc_3++;
                        }
                    }
                    if (!_loc_8)
                    {
                        _loc_7 = new Vector3D(gS3SPoint[_loc_2][0], gS3SPoint[_loc_2][1], gS3SPoint[_loc_2][2]);
                        break;
                    }
                    _loc_2++;
                }
                this.mCrossPoints[_loc_1] = new Vector.<Vector.<Vector3D>>(3, true);
                this.mCrossPoints[_loc_1][0] = new Vector.<Vector3D>(3, true);
                this.mCrossPoints[_loc_1][0][0] = _loc_7.clone();
                this.mCrossPoints[_loc_1][0][1] = new Vector3D();
                this.mCrossPoints[_loc_1][0][1].x = (gS3SPoint[_loc_6][0] - gS3SPoint[_loc_4][0]) / 3 + gS3SPoint[_loc_4][0];
                this.mCrossPoints[_loc_1][0][1].y = (gS3SPoint[_loc_6][1] - gS3SPoint[_loc_4][1]) / 3 + gS3SPoint[_loc_4][1];
                this.mCrossPoints[_loc_1][0][1].z = (gS3SPoint[_loc_6][2] - gS3SPoint[_loc_4][2]) / 3 + gS3SPoint[_loc_4][2];
                this.mCrossPoints[_loc_1][0][2] = new Vector3D();
                this.mCrossPoints[_loc_1][0][2].x = (gS3SPoint[_loc_6][0] - gS3SPoint[_loc_5][0]) / 3 + gS3SPoint[_loc_5][0];
                this.mCrossPoints[_loc_1][0][2].y = (gS3SPoint[_loc_6][1] - gS3SPoint[_loc_5][1]) / 3 + gS3SPoint[_loc_5][1];
                this.mCrossPoints[_loc_1][0][2].z = (gS3SPoint[_loc_6][2] - gS3SPoint[_loc_5][2]) / 3 + gS3SPoint[_loc_5][2];
                this.mCrossPoints[_loc_1][1] = new Vector.<Vector3D>(3, true);
                this.mCrossPoints[_loc_1][1][0] = _loc_7.clone();
                this.mCrossPoints[_loc_1][1][1] = new Vector3D();
                this.mCrossPoints[_loc_1][1][1].x = (gS3SPoint[_loc_4][0] - gS3SPoint[_loc_5][0]) / 3 + gS3SPoint[_loc_5][0];
                this.mCrossPoints[_loc_1][1][1].y = (gS3SPoint[_loc_4][1] - gS3SPoint[_loc_5][1]) / 3 + gS3SPoint[_loc_5][1];
                this.mCrossPoints[_loc_1][1][1].z = (gS3SPoint[_loc_4][2] - gS3SPoint[_loc_5][2]) / 3 + gS3SPoint[_loc_5][2];
                this.mCrossPoints[_loc_1][1][2] = new Vector3D();
                this.mCrossPoints[_loc_1][1][2].x = (gS3SPoint[_loc_4][0] - gS3SPoint[_loc_6][0]) / 3 + gS3SPoint[_loc_6][0];
                this.mCrossPoints[_loc_1][1][2].y = (gS3SPoint[_loc_4][1] - gS3SPoint[_loc_6][1]) / 3 + gS3SPoint[_loc_6][1];
                this.mCrossPoints[_loc_1][1][2].z = (gS3SPoint[_loc_4][2] - gS3SPoint[_loc_6][2]) / 3 + gS3SPoint[_loc_6][2];
                this.mCrossPoints[_loc_1][2] = new Vector.<Vector3D>(3, true);
                this.mCrossPoints[_loc_1][2][0] = _loc_7.clone();
                this.mCrossPoints[_loc_1][2][1] = new Vector3D();
                this.mCrossPoints[_loc_1][2][1].x = (gS3SPoint[_loc_5][0] - gS3SPoint[_loc_6][0]) / 3 + gS3SPoint[_loc_6][0];
                this.mCrossPoints[_loc_1][2][1].y = (gS3SPoint[_loc_5][1] - gS3SPoint[_loc_6][1]) / 3 + gS3SPoint[_loc_6][1];
                this.mCrossPoints[_loc_1][2][1].z = (gS3SPoint[_loc_5][2] - gS3SPoint[_loc_6][2]) / 3 + gS3SPoint[_loc_6][2];
                this.mCrossPoints[_loc_1][2][2] = new Vector3D();
                this.mCrossPoints[_loc_1][2][2].x = (gS3SPoint[_loc_5][0] - gS3SPoint[_loc_4][0]) / 3 + gS3SPoint[_loc_4][0];
                this.mCrossPoints[_loc_1][2][2].y = (gS3SPoint[_loc_5][1] - gS3SPoint[_loc_4][1]) / 3 + gS3SPoint[_loc_4][1];
                this.mCrossPoints[_loc_1][2][2].z = (gS3SPoint[_loc_5][2] - gS3SPoint[_loc_4][2]) / 3 + gS3SPoint[_loc_4][2];
                _loc_1++;
            }
            return;
        }// end function

        private function drawMark(param1:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_2:* = new Vector.<int>(0, true);
            _loc_3 = 0;
            while (_loc_3 < gS3SFaceCnt)
            {
                
                _loc_7 = new Vector.<int>;
                _loc_5 = 0;
                while (_loc_5 < gS3SFace[_loc_3][0])
                {
                    
                    _loc_4 = gS3SFace[_loc_3][_loc_5 + 7];
                    _loc_9 = Math.abs(gS3GPoint[gS3SLine[_loc_4][0]][0] - gS3GPoint[gS3SLine[_loc_4][1]][0]) < 1e-005;
                    if (_loc_9)
                    {
                        _loc_6 = 0;
                        while (_loc_6 < _loc_2.length)
                        {
                            
                            if (_loc_2[_loc_6] == _loc_4 || _loc_2[_loc_6] == gS3SLine[_loc_4][2])
                            {
                                _loc_9 = false;
                                break;
                            }
                            _loc_6++;
                        }
                    }
                    if (_loc_9)
                    {
                        _loc_7.push(_loc_4);
                    }
                    _loc_5++;
                }
                _loc_7.fixed = true;
                _loc_8 = null;
                if (_loc_7.length > 0)
                {
                    _loc_8 = this.getVectorCross(gS3GPoint[gS3SFace[_loc_3][1]], gS3GPoint[gS3SFace[_loc_3][2]], gS3GPoint[gS3SFace[_loc_3][3]], true);
                }
                _loc_2.fixed = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_7.length)
                {
                    
                    _loc_4 = _loc_7[_loc_5];
                    if (_loc_8.x > 0)
                    {
                        _loc_10 = gS3SLine[_loc_4][0];
                        _loc_11 = gS3SLine[_loc_4][1];
                    }
                    else
                    {
                        _loc_10 = gS3SLine[_loc_4][1];
                        _loc_11 = gS3SLine[_loc_4][0];
                    }
                    _loc_12 = new Vector.<Point>(2, true);
                    gPH3D.cv3d3d(gS3GPoint[_loc_10][0], gS3GPoint[_loc_10][1], gS3GPoint[_loc_10][2]);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_12[0] = new Point(this.VewWinX, this.VewWinY);
                    gPH3D.cv3d3d(gS3GPoint[_loc_11][0], gS3GPoint[_loc_11][1], gS3GPoint[_loc_11][2]);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_12[1] = new Point(this.VewWinX, this.VewWinY);
                    _loc_13 = Point.distance(_loc_12[0], _loc_12[1]);
                    _loc_14 = Math.atan2(_loc_12[1].y - _loc_12[0].y, _loc_12[1].x - _loc_12[0].x);
                    _loc_15 = _loc_13 / 20;
                    _loc_16 = new Vector.<Point>;
                    _loc_16.push(_loc_12[0].clone());
                    _loc_16.push(Point.interpolate(_loc_12[1], _loc_12[0], 0.1).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.9)));
                    _loc_16.push(Point.interpolate(_loc_12[1], _loc_12[0], 0.15).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.8)));
                    _loc_16.push(Point.interpolate(_loc_12[1], _loc_12[0], 0.2).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.7)));
                    _loc_16.push(Point.interpolate(_loc_12[1], _loc_12[0], 0.25).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.6)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.3).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.5)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.3).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.5)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.25).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.4)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.2).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.3)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.15).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.2)));
                    _loc_16.push(Point.interpolate(_loc_12[0], _loc_12[1], 0.1).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.1)));
                    _loc_16.push(_loc_12[1].clone());
                    _loc_16.fixed = true;
                    this.canvasGraphics.lineStyle(2, 1184274);
                    this.drawDotLine(this.canvasGraphics, _loc_16, _loc_16.length, 8, 4, false);
                    _loc_6 = 0;
                    while (_loc_6 < _loc_16.length)
                    {
                        
                        _loc_16[_loc_6].x = _loc_16[_loc_6].x + param1;
                        _loc_6++;
                    }
                    this.drawDotLine(this.canvasGraphics, _loc_16, _loc_16.length, 8, 4, false);
                    _loc_17 = Point.interpolate(_loc_12[1], _loc_12[0], 0.5).add(Point.polar(_loc_15, _loc_14 + Math.PI * 0.5));
                    _loc_18 = _loc_17.add(Point.polar(_loc_15 * 0.5, _loc_14 + Math.PI * 0.5));
                    _loc_19 = _loc_17.add(Point.polar(_loc_15 * 0.5, _loc_14 + Math.PI * -0.5));
                    this.canvasGraphics.lineStyle(2, 1184274);
                    this.canvasGraphics.moveTo(_loc_18.x, _loc_18.y);
                    this.canvasGraphics.lineTo(_loc_19.x, _loc_19.y);
                    this.canvasGraphics.moveTo(_loc_18.x + param1, _loc_18.y);
                    this.canvasGraphics.lineTo(_loc_19.x + param1, _loc_19.y);
                    _loc_2.push(_loc_4);
                    _loc_2.push(gS3SLine[_loc_4][2]);
                    _loc_5++;
                }
                _loc_2.fixed = true;
                _loc_7 = null;
                _loc_3++;
            }
            _loc_2 = null;
            return;
        }// end function

    }
}
