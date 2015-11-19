package phcomm.clipstage
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MovieClipStage extends MovieClip
    {
        private const AREA_WIDTH_MIN:int = 10;
        private const AREA_HEIGHT_MIN:int = 10;
        private const BACKGROUND_COLOR_DEFAULT:uint = 16777215;
        private const BACKGROUND_ALPHA_DEFAULT:Number = 1;
        protected var screenNo:int;
        private var mAreaCanvas:Shape;
        private var mAreaBackground:Shape;
        private var mAreaWidth:int;
        private var mAreaHeight:int;
        private var mAreaBackColor:uint;
        private var mAreaBackAlpha:Number;
        private var mPutObjects:Vector.<DisplayObject>;
        private var mButtons:Vector.<InteractiveObject>;
        private var mIsNoticeEvent:Boolean;
        private var mIsNoticedMouseDown:Boolean;
        private var mTimer:Vector.<StageTimer>;
        private var mTimerPause:Timer;
        private var mCursor:CursorOperate;

        public function MovieClipStage(param1:Boolean = true)
        {
            var _loc_3:* = null;
            this.stop();
            this.mIsNoticeEvent = false;
            this.mIsNoticedMouseDown = false;
            this.screenNo = -1;
            this.mTimer = new Vector.<StageTimer>;
            this.mTimerPause = null;
            this.mCursor = new CursorOperate();
            this.mAreaWidth = Math.max(Math.round(this.width * this.scaleX), this.AREA_WIDTH_MIN);
            this.mAreaHeight = Math.max(Math.round(this.height * this.scaleY), this.AREA_HEIGHT_MIN);
            this.mAreaBackColor = this.BACKGROUND_COLOR_DEFAULT;
            this.mAreaBackAlpha = this.BACKGROUND_ALPHA_DEFAULT;
            this.mAreaBackground = null;
            if (param1)
            {
                this.mAreaBackground = new Shape();
                this.mAreaBackground.x = 0;
                this.mAreaBackground.y = 0;
                this.drawBackground();
            }
            this.mAreaCanvas = null;
            if (param1)
            {
                this.mAreaCanvas = new Shape();
                this.mAreaCanvas.x = 0;
                this.mAreaCanvas.y = 0;
            }
            this.mPutObjects = new Vector.<DisplayObject>;
            this.mButtons = new Vector.<InteractiveObject>;
            var _loc_2:* = 0;
            while (_loc_2 < this.numChildren)
            {
                
                _loc_3 = this.getChildAt(_loc_2);
                this.mPutObjects.push(_loc_3);
                if (_loc_3 is SimpleButton || _loc_3 is StageButton)
                {
                    this.mButtons.push(InteractiveObject(_loc_3));
                }
                else if (_loc_3 is MovieClip)
                {
                    MovieClip(_loc_3).gotoAndStop(1);
                }
                _loc_2++;
            }
            this.mPutObjects.fixed = true;
            this.mButtons.fixed = true;
            this.buttonClear();
            this.objectClear();
            this.stageClear();
            this.addEventListener(Event.ENTER_FRAME, this.onWaitStageLoading);
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = 0;
            this.mIsNoticeEvent = false;
            if (this.hasEventListener(Event.ENTER_FRAME))
            {
                this.removeEventListener(Event.ENTER_FRAME, this.onWaitStageLoading);
            }
            if (this.mTimer != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mTimer.length)
                {
                    
                    if (this.mTimer[_loc_1] != null)
                    {
                        if (this.mTimer[_loc_1].hasEventListener(TimerEvent.TIMER))
                        {
                            this.mTimer[_loc_1].removeEventListener(TimerEvent.TIMER, this.onTimerEventAction);
                        }
                        this.mTimer[_loc_1] = null;
                    }
                    _loc_1++;
                }
                this.mTimer = null;
            }
            if (this.mTimerPause != null)
            {
                this.mTimerPause.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onPauseEnd);
                this.mTimerPause = null;
            }
            if (this.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
                this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDown);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
                this.removeEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_UP))
            {
                this.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                this.removeEventListener(MouseEvent.MOUSE_OVER, this.onStageMouseOver);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_OUT))
            {
                this.removeEventListener(MouseEvent.MOUSE_OUT, this.onStageMouseOut);
            }
            if (this.hasEventListener(MouseEvent.CLICK))
            {
                this.removeEventListener(MouseEvent.CLICK, this.onStageClick);
            }
            if (this.mButtons)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mButtons.length)
                {
                    
                    if (this.mButtons[_loc_1])
                    {
                        this.setButtonEvent(this.mButtons[_loc_1], false);
                        if (this.mButtons[_loc_1] is StageButton)
                        {
                            StageButton(this.mButtons[_loc_1]).dispose();
                        }
                        this.mButtons[_loc_1] = null;
                    }
                    _loc_1++;
                }
                this.mButtons = null;
            }
            if (this.mCursor)
            {
                this.mCursor.dispose();
                this.mCursor = null;
            }
            if (this.mAreaBackground)
            {
                if (this.mAreaBackground.parent)
                {
                    this.removeChild(this.mAreaBackground);
                }
                this.mAreaBackground = null;
            }
            if (this.mAreaCanvas)
            {
                if (this.mAreaCanvas.parent)
                {
                    this.removeChild(this.mAreaCanvas);
                }
                this.mAreaCanvas = null;
            }
            return;
        }// end function

        final protected function get areaCanvas() : Shape
        {
            if (this.mAreaCanvas)
            {
                return this.mAreaCanvas;
            }
            return Shape(this);
        }// end function

        protected function get areaWidth() : int
        {
            return this.mAreaWidth;
        }// end function

        protected function set areaWidth(param1:int) : void
        {
            if (this.mAreaWidth != param1)
            {
                this.mAreaWidth = Math.max(param1, this.AREA_WIDTH_MIN);
                this.drawBackground();
            }
            return;
        }// end function

        protected function get areaHeight() : int
        {
            return this.mAreaHeight;
        }// end function

        protected function set areaHeight(param1:int) : void
        {
            if (this.mAreaHeight != param1)
            {
                this.mAreaHeight = Math.max(param1, this.AREA_HEIGHT_MIN);
                this.drawBackground();
            }
            return;
        }// end function

        protected function get areaBackColor() : uint
        {
            return this.mAreaBackColor;
        }// end function

        protected function set areaBackColor(param1:uint) : void
        {
            if (this.mAreaBackColor != param1)
            {
                this.mAreaBackColor = param1;
                this.drawBackground();
            }
            return;
        }// end function

        protected function get areaBackAlpha() : Number
        {
            return this.mAreaBackAlpha;
        }// end function

        protected function set areaBackAlpha(param1:Number) : void
        {
            if (this.mAreaBackAlpha != param1)
            {
                this.mAreaBackAlpha = param1;
                this.drawBackground();
            }
            return;
        }// end function

        final protected function get canvasGraphics() : Graphics
        {
            if (this.mAreaCanvas)
            {
                return this.mAreaCanvas.graphics;
            }
            return this.graphics;
        }// end function

        protected function eventJump(event:StageEvent) : void
        {
            return;
        }// end function

        final protected function buttonClear() : void
        {
            var _loc_1:* = 0;
            if (this.mButtons)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mButtons.length)
                {
                    
                    if (this.mButtons is SimpleButton)
                    {
                        SimpleButton(this.mButtons[_loc_1]).enabled = true;
                    }
                    else
                    {
                        StageButton(this.mButtons[_loc_1]).unlock();
                        StageButton(this.mButtons[_loc_1]).enabled = true;
                        StageButton(this.mButtons[_loc_1]).selected = false;
                    }
                    this.mButtons[_loc_1].mouseEnabled = true;
                    this.mButtons[_loc_1].visible = false;
                    this.setButtonEvent(this.mButtons[_loc_1], false);
                    _loc_1++;
                }
            }
            return;
        }// end function

        final protected function buttonEnabled(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            if (this.mButtons)
            {
                _loc_3 = 0;
                while (_loc_3 < this.mButtons.length)
                {
                    
                    if (this.mButtons[_loc_3].name == param1)
                    {
                        if (this.mButtons is SimpleButton)
                        {
                            SimpleButton(this.mButtons[_loc_3]).enabled = param2;
                        }
                        else
                        {
                            StageButton(this.mButtons[_loc_3]).unlock();
                            StageButton(this.mButtons[_loc_3]).enabled = param2;
                        }
                        this.mButtons[_loc_3].mouseEnabled = param2;
                        this.setButtonEvent(this.mButtons[_loc_3], param2 && this.mButtons[_loc_3].visible);
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        final protected function buttonLock(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = false;
            if (this.mButtons)
            {
                _loc_3 = !param1;
                _loc_2 = 0;
                while (_loc_2 < this.mButtons.length)
                {
                    
                    if (this.mButtons is SimpleButton)
                    {
                        SimpleButton(this.mButtons[_loc_2]).enabled = _loc_3;
                        this.mButtons[_loc_2].mouseEnabled = _loc_3;
                    }
                    else if (_loc_3)
                    {
                        StageButton(this.mButtons[_loc_2]).unlock();
                    }
                    else
                    {
                        StageButton(this.mButtons[_loc_2]).lock();
                    }
                    this.setButtonEvent(this.mButtons[_loc_2], _loc_3 && this.mButtons[_loc_2].visible);
                    _loc_2++;
                }
            }
            return;
        }// end function

        final protected function buttonReference(param1:String) : InteractiveObject
        {
            var _loc_2:* = 0;
            if (this.mButtons)
            {
                _loc_2 = 0;
                while (_loc_2 < this.mButtons.length)
                {
                    
                    if (this.mButtons[_loc_2].name == param1)
                    {
                        return this.mButtons[_loc_2];
                    }
                    _loc_2++;
                }
            }
            return null;
        }// end function

        final protected function buttonSelected(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            if (this.mButtons)
            {
                _loc_3 = 0;
                while (_loc_3 < this.mButtons.length)
                {
                    
                    if (this.mButtons[_loc_3].name == param1)
                    {
                        if (this.mButtons is SimpleButton)
                        {
                        }
                        else
                        {
                            StageButton(this.mButtons[_loc_3]).selected = param2;
                        }
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        final protected function buttonVisible(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            if (this.mButtons)
            {
                _loc_3 = 0;
                while (_loc_3 < this.mButtons.length)
                {
                    
                    if (this.mButtons[_loc_3].name == param1)
                    {
                        if (this.mButtons is StageButton)
                        {
                            if (param2 && this.mButtons[_loc_3].visible != param2)
                            {
                                StageButton(this.mButtons[_loc_3]).setMouseView();
                            }
                        }
                        this.mButtons[_loc_3].visible = param2;
                        this.setButtonEvent(this.mButtons[_loc_3], param2 && this.mButtons[_loc_3].mouseEnabled);
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        final protected function changeTimerInterval(param1:int, param2:int) : void
        {
            if (!this.mTimer)
            {
                trace("[MovieClipStage.changeTimerInterval] mTimer is null");
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.mTimer.length)
            {
                
                if (this.mTimer[_loc_3].timerID == param1)
                {
                    this.mTimer[_loc_3].delay = param2;
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        final protected function drawDotLine(param1:Graphics, param2:Vector.<Point>, param3:int, param4:uint, param5:uint, param6:Boolean = true, param7:Point = null, param8:Point = null) : void
        {
            var _loc_16:* = 0;
            var _loc_17:* = false;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null;
            if (!param1 || !param2)
            {
                return;
            }
            if (param2.length < 2 || param3 < 2 || param4 <= 0)
            {
                return;
            }
            var _loc_9:* = new Vector.<int>;
            var _loc_10:* = new Vector.<Number>;
            var _loc_11:* = !param7 || !param8;
            _loc_9.push(GraphicsPathCommand.MOVE_TO);
            if (_loc_11)
            {
                _loc_10.push(param2[0].x);
                _loc_10.push(param2[0].y);
            }
            var _loc_12:* = 0;
            var _loc_13:* = true;
            var _loc_14:* = Math.min(param3, param2.length);
            var _loc_15:* = 0;
            while (_loc_15 < _loc_14)
            {
                
                if (++_loc_15 >= _loc_14)
                {
                    if (param6 && _loc_14 > 2)
                    {
                        _loc_16 = ++_loc_15 - _loc_14;
                    }
                    else
                    {
                        break;
                    }
                }
                _loc_17 = _loc_11;
                if (!_loc_17)
                {
                    _loc_23 = 1e-006;
                    _loc_17 = Point.distance(param2[_loc_15], param7) < _loc_23 && Point.distance(param2[_loc_16], param8) < _loc_23;
                    if (!_loc_17)
                    {
                        _loc_17 = Point.distance(param2[_loc_16], param7) < _loc_23 && Point.distance(param2[_loc_15], param8) < _loc_23;
                    }
                    if (_loc_17)
                    {
                        _loc_10.push(param2[_loc_15].x);
                        _loc_10.push(param2[_loc_15].y);
                    }
                }
                _loc_18 = Point.distance(param2[_loc_15], param2[_loc_16]);
                _loc_19 = param4 / _loc_18;
                _loc_20 = param5 / _loc_18;
                _loc_21 = _loc_12 / _loc_18;
                _loc_22 = 0;
                while (_loc_22 < _loc_18)
                {
                    
                    if (_loc_12 > 0)
                    {
                        _loc_22 = _loc_22 + _loc_12;
                    }
                    else if (_loc_13)
                    {
                        _loc_22 = _loc_22 + param4;
                    }
                    else
                    {
                        _loc_22 = _loc_22 + param5;
                    }
                    if (_loc_22 < _loc_18)
                    {
                        _loc_24 = Point.interpolate(param2[_loc_16], param2[_loc_15], _loc_22 / _loc_18);
                    }
                    else
                    {
                        _loc_24 = param2[_loc_16];
                    }
                    if (_loc_17)
                    {
                        if (_loc_13)
                        {
                            _loc_9.push(GraphicsPathCommand.LINE_TO);
                            _loc_10.push(_loc_24.x);
                            _loc_10.push(_loc_24.y);
                        }
                        else
                        {
                            _loc_9.push(GraphicsPathCommand.MOVE_TO);
                            _loc_10.push(_loc_24.x);
                            _loc_10.push(_loc_24.y);
                        }
                    }
                    if (_loc_22 > _loc_18)
                    {
                        _loc_12 = _loc_22 - _loc_18;
                        continue;
                    }
                    _loc_12 = 0;
                    _loc_13 = !_loc_13;
                }
                _loc_15++;
            }
            param1.drawPath(_loc_9, _loc_10);
            return;
        }// end function

        final protected function isTimer() : Boolean
        {
            if (this.mTimer != null)
            {
                return this.mTimer.length > 0;
            }
            return false;
        }// end function

        final protected function objectClear() : void
        {
            var _loc_1:* = 0;
            if (this.mPutObjects)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mPutObjects.length)
                {
                    
                    if (!(this.mPutObjects[_loc_1] is SimpleButton) && !(this.mPutObjects[_loc_1] is StageButton))
                    {
                        this.mPutObjects[_loc_1].visible = false;
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        final protected function objectReference(param1:String) : DisplayObject
        {
            var _loc_2:* = 0;
            if (this.mPutObjects)
            {
                _loc_2 = 0;
                while (_loc_2 < this.mPutObjects.length)
                {
                    
                    if (this.mPutObjects[_loc_2].name == param1)
                    {
                        return this.mPutObjects[_loc_2];
                    }
                    _loc_2++;
                }
            }
            return null;
        }// end function

        final protected function objectVisible(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            if (this.mPutObjects)
            {
                _loc_3 = 0;
                while (_loc_3 < this.mPutObjects.length)
                {
                    
                    if (!(this.mPutObjects[_loc_3] is SimpleButton) && !(this.mPutObjects[_loc_3] is StageButton))
                    {
                        if (this.mPutObjects[_loc_3].name == param1)
                        {
                            this.mPutObjects[_loc_3].visible = param2;
                        }
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        final protected function pauseTimer(param1:int) : void
        {
            if (!this.mTimer)
            {
                trace("[MovieClipStage.pauseTimer] mTimer is null");
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.mTimer.length)
            {
                
                if (this.mTimer[_loc_2].timerID == param1)
                {
                    if (this.mTimer[_loc_2].running)
                    {
                        this.mTimer[_loc_2].stop();
                    }
                    else
                    {
                        this.mTimer[_loc_2].start();
                    }
                    break;
                }
                _loc_2++;
            }
            return;
        }// end function

        final protected function pause(param1:int) : void
        {
            if (this.mTimerPause != null)
            {
                this.mTimerPause.reset();
                this.mTimerPause.delay = param1;
                this.mTimerPause.repeatCount = 1;
            }
            else
            {
                this.mTimerPause = new Timer(param1, 1);
                this.mTimerPause.addEventListener(TimerEvent.TIMER_COMPLETE, this.onPauseEnd);
            }
            this.mIsNoticeEvent = false;
            this.mTimerPause.start();
            return;
        }// end function

        protected function setCursor(param1:int) : void
        {
            if (this.mCursor)
            {
                this.mCursor.setCursor(param1);
            }
            return;
        }// end function

        final protected function setDotLineStyle(param1:Graphics, param2:int, param3:uint, param4:Number) : void
        {
            param1.lineStyle(param2, param3, param4, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.BEVEL);
            return;
        }// end function

        protected function stageClear() : void
        {
            var _loc_1:* = 0;
            this.graphics.clear();
            if (this.mAreaCanvas)
            {
                this.mAreaCanvas.graphics.clear();
            }
            while (this.numChildren > 0)
            {
                
                this.removeChildAt((this.numChildren - 1));
            }
            if (this.mAreaBackground)
            {
                this.addChild(this.mAreaBackground);
            }
            if (this.mAreaCanvas)
            {
                this.addChild(this.mAreaCanvas);
            }
            if (this.mPutObjects)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mPutObjects.length)
                {
                    
                    this.addChild(this.mPutObjects[_loc_1]);
                    _loc_1++;
                }
            }
            return;
        }// end function

        final protected function startTimer(param1:int, param2:int) : void
        {
            if (!this.mTimer)
            {
                trace("[MovieClipStage.startTimer] mTimer is null");
                return;
            }
            if (param1 <= 0)
            {
                trace("[MovieClipStage.startTimer] pTimerID <= 0");
                return;
            }
            if (param2 < 1)
            {
                trace("[MovieClipStage.startTimer] pDelay < 1");
                return;
            }
            var _loc_3:* = new StageTimer(param1, param2, 0);
            _loc_3.addEventListener(TimerEvent.TIMER, this.onTimerEventAction);
            _loc_3.start();
            this.mTimer.push(_loc_3);
            return;
        }// end function

        final protected function stopTimerAll() : void
        {
            this.stopTimer(0);
            return;
        }// end function

        final protected function stopTimer(param1:int) : void
        {
            var _loc_3:* = null;
            if (!this.mTimer)
            {
                trace("[MovieClipStage.stopTimer] mTimer is null");
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.mTimer.length)
            {
                
                if (this.mTimer[_loc_2].timerID == param1 || param1 == 0)
                {
                    _loc_3 = this.mTimer.splice(_loc_2, 1)[0];
                    _loc_3.reset();
                    _loc_3.removeEventListener(TimerEvent.TIMER, this.onTimerEventAction);
                    _loc_3 = null;
                    if (param1 != 0)
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function onButtonClick(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                this.eventJump(StageEvent.createButtonEvent(StageEvent.BUTTON_CLICK, DisplayObject(event.currentTarget).name, false));
            }
            return;
        }// end function

        private function onButtonMouseDown(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (event.type == MouseEvent.MOUSE_DOWN || event.buttonDown)
                {
                    this.eventJump(StageEvent.createButtonEvent(StageEvent.BUTTON_MOUSE_DOWN, DisplayObject(event.currentTarget).name, false));
                }
            }
            return;
        }// end function

        private function onButtonMouseUp(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (event.type == MouseEvent.MOUSE_UP || event.buttonDown)
                {
                    this.eventJump(StageEvent.createButtonEvent(StageEvent.BUTTON_MOUSE_UP, DisplayObject(event.currentTarget).name, false));
                }
            }
            return;
        }// end function

        private function onPauseEnd(event:TimerEvent) : void
        {
            if (this.mTimerPause != null)
            {
                this.mTimerPause.stop();
            }
            this.mIsNoticeEvent = true;
            this.eventJump(new StageEvent(StageEvent.PAUSE_END));
            return;
        }// end function

        private function onStageClick(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (this.isMouseInnerArea())
                {
                    this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_CLICK, this.mouseX, this.mouseY, false));
                }
            }
            return;
        }// end function

        private function onStageMouseDown(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (this.isMouseInnerArea())
                {
                    this.mIsNoticedMouseDown = true;
                    this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_DOWN, this.mouseX, this.mouseY, true));
                }
            }
            return;
        }// end function

        private function onStageMouseMove(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (this.isMouseInnerArea())
                {
                    if (!this.mIsNoticedMouseDown && event.buttonDown)
                    {
                        this.mIsNoticedMouseDown = true;
                        this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_DOWN, this.mouseX, this.mouseY, true));
                    }
                    else
                    {
                        this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_MOVE, this.mouseX, this.mouseY, event.buttonDown));
                    }
                }
                else if (this.mIsNoticedMouseDown)
                {
                    this.mIsNoticedMouseDown = false;
                    this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_UP, this.mouseX, this.mouseY, false));
                }
            }
            return;
        }// end function

        private function onStageMouseOut(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (this.mIsNoticedMouseDown)
                {
                    this.mIsNoticedMouseDown = false;
                    this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_UP, this.mouseX, this.mouseY, false));
                }
            }
            return;
        }// end function

        private function onStageMouseOver(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                if (!this.mIsNoticedMouseDown && event.buttonDown)
                {
                    this.mIsNoticedMouseDown = true;
                    this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_DOWN, this.mouseX, this.mouseY, true));
                }
            }
            return;
        }// end function

        private function onStageMouseUp(event:MouseEvent) : void
        {
            if (this.mIsNoticeEvent)
            {
                this.mIsNoticedMouseDown = false;
                this.eventJump(StageEvent.createMouseEvent(StageEvent.STAGE_MOUSE_UP, this.mouseX, this.mouseY, false));
            }
            return;
        }// end function

        private function onTimerEventAction(event:TimerEvent) : void
        {
            if (!this.mIsNoticeEvent)
            {
                return;
            }
            var _loc_2:* = 0;
            if (event.target is StageTimer)
            {
                _loc_2 = StageTimer(event.target).timerID;
            }
            else if (event.currentTarget is StageTimer)
            {
                _loc_2 = StageTimer(event.currentTarget).timerID;
            }
            else
            {
                trace("[MovieClipStage.onTimerEventAction] target can\'t be acquired");
                return;
            }
            this.eventJump(StageEvent.createTimerEvent(StageEvent.TIMER, _loc_2));
            return;
        }// end function

        private function onWaitStageLoading(event:Event) : void
        {
            if (this.loaderInfo.bytesLoaded >= this.loaderInfo.bytesTotal)
            {
                this.removeEventListener(Event.ENTER_FRAME, this.onWaitStageLoading);
                this.mIsNoticeEvent = true;
                this.eventJump(new StageEvent(StageEvent.INITIALIZE));
                if (this.mAreaBackground)
                {
                    this.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageMouseDown);
                    this.addEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
                    this.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
                    this.addEventListener(MouseEvent.MOUSE_OVER, this.onStageMouseOver);
                    this.addEventListener(MouseEvent.MOUSE_OUT, this.onStageMouseOut);
                    this.addEventListener(MouseEvent.CLICK, this.onStageClick);
                }
            }
            return;
        }// end function

        private function drawBackground() : void
        {
            if (this.mAreaBackground)
            {
                this.mAreaBackground.graphics.clear();
                this.mAreaBackground.graphics.lineStyle();
                this.mAreaBackground.graphics.beginFill(this.mAreaBackColor, this.mAreaBackAlpha);
                this.mAreaBackground.graphics.drawRect(0, 0, this.mAreaWidth, this.mAreaHeight);
                this.mAreaBackground.graphics.endFill();
            }
            return;
        }// end function

        private function isMouseInnerArea() : Boolean
        {
            return this.mouseX >= 0 && this.mouseY >= 0 && this.mouseX < this.mAreaWidth || this.mouseY < this.mAreaHeight;
        }// end function

        private function setButtonEvent(param1:InteractiveObject, param2:Boolean) : void
        {
            if (param1)
            {
                if (param2)
                {
                    if (!param1.hasEventListener(MouseEvent.CLICK))
                    {
                        param1.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                        param1.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
                        param1.addEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
                        param1.addEventListener(MouseEvent.ROLL_OUT, this.onButtonMouseUp);
                    }
                }
                else
                {
                    if (param1.hasEventListener(MouseEvent.CLICK))
                    {
                        param1.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
                    }
                    if (param1.hasEventListener(MouseEvent.MOUSE_DOWN))
                    {
                        param1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
                    }
                    if (param1.hasEventListener(MouseEvent.MOUSE_UP))
                    {
                        param1.removeEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
                    }
                    if (param1.hasEventListener(MouseEvent.ROLL_OUT))
                    {
                        param1.removeEventListener(MouseEvent.ROLL_OUT, this.onButtonMouseUp);
                    }
                }
            }
            return;
        }// end function

    }
}
