package phcomm.clipstage
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;

    public class StageButton extends MovieClip
    {
        private const SELECTED_FILTER:GlowFilter;
        private const ENABLED_COLOR:ColorTransform;
        private const DISABLED_COLOR:ColorTransform;
        private var mIsSelected:Boolean;
        private var mIsLocked:Boolean;
        private var mSaveEnabled:Boolean;

        public function StageButton()
        {
            this.SELECTED_FILTER = new GlowFilter(16737792, 1, 5, 5, 2, BitmapFilterQuality.LOW, true, false);
            this.ENABLED_COLOR = new ColorTransform();
            this.DISABLED_COLOR = new ColorTransform(0.5, 0.5, 0.5, 1, 100, 100, 100, 0);
            this.gotoAndStop(1);
            this.buttonMode = true;
            this.useHandCursor = true;
            this.mouseChildren = false;
            this.mIsSelected = false;
            this.mIsLocked = false;
            this.mSaveEnabled = this.enabled;
            if (this.totalFrames > 1)
            {
                this.addEventListener(MouseEvent.ROLL_OVER, this.onButtonRollOver);
                this.addEventListener(MouseEvent.ROLL_OUT, this.onButtonRollOut);
                if (this.totalFrames > 2)
                {
                    this.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
                    this.addEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
                }
            }
            return;
        }// end function

        override public function get enabled() : Boolean
        {
            return super.enabled;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.setStateView();
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this.mIsSelected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (this.mIsSelected != param1)
            {
                this.mIsSelected = param1;
                this.setStateView();
            }
            return;
        }// end function

        public function dispose() : void
        {
            if (this.hasEventListener(MouseEvent.ROLL_OVER))
            {
                this.removeEventListener(MouseEvent.ROLL_OVER, this.onButtonRollOver);
            }
            if (this.hasEventListener(MouseEvent.ROLL_OUT))
            {
                this.removeEventListener(MouseEvent.ROLL_OUT, this.onButtonRollOut);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
                this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
            }
            if (this.hasEventListener(MouseEvent.MOUSE_UP))
            {
                this.removeEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
            }
            return;
        }// end function

        public function lock() : void
        {
            this.mSaveEnabled = this.enabled;
            this.enabled = false;
            this.mouseEnabled = false;
            this.mIsLocked = true;
            return;
        }// end function

        public function reset() : void
        {
            this.gotoAndStop(1);
            return;
        }// end function

        public function setMouseView() : void
        {
            var _loc_1:* = null;
            if (this.totalFrames > 1 && this.mouseEnabled && this.enabled)
            {
                _loc_1 = this.localToGlobal(new Point(this.mouseX, this.mouseY));
                if (this.hitTestPoint(_loc_1.x, _loc_1.y, true))
                {
                    this.gotoAndStop(2);
                    return;
                }
            }
            this.gotoAndStop(1);
            return;
        }// end function

        public function unlock() : void
        {
            if (this.mIsLocked)
            {
                this.enabled = this.mSaveEnabled;
                this.mouseEnabled = this.mSaveEnabled;
            }
            this.mIsLocked = false;
            return;
        }// end function

        private function onButtonMouseDown(event:MouseEvent) : void
        {
            if (this.totalFrames > 2)
            {
                this.gotoAndStop(3);
            }
            return;
        }// end function

        private function onButtonMouseUp(event:MouseEvent) : void
        {
            if (this.totalFrames > 1)
            {
                this.gotoAndStop(2);
            }
            return;
        }// end function

        private function onButtonRollOut(event:MouseEvent) : void
        {
            this.gotoAndStop(1);
            return;
        }// end function

        private function onButtonRollOver(event:MouseEvent) : void
        {
            if (this.totalFrames > 1)
            {
                this.gotoAndStop(2);
            }
            return;
        }// end function

        private function setStateView() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.enabled)
            {
                this.transform.colorTransform = this.ENABLED_COLOR;
                this.setMouseView();
                _loc_1 = this.filters;
                _loc_2 = int.MIN_VALUE;
                if (_loc_1)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_1.length)
                    {
                        
                        if (_loc_1[_loc_3] is GlowFilter)
                        {
                            if (GlowFilter(_loc_1[_loc_3]).color == this.SELECTED_FILTER.color)
                            {
                                _loc_2 = _loc_3;
                                break;
                            }
                        }
                        _loc_3++;
                    }
                }
                if (this.mIsSelected)
                {
                    if (_loc_2 < 0)
                    {
                        _loc_1.push(this.SELECTED_FILTER);
                    }
                }
                else if (_loc_2 >= 0)
                {
                    _loc_1.splice(_loc_2, 1);
                }
                this.filters = _loc_1;
            }
            else
            {
                this.transform.colorTransform = this.DISABLED_COLOR;
                this.gotoAndStop(1);
            }
            return;
        }// end function

    }
}
