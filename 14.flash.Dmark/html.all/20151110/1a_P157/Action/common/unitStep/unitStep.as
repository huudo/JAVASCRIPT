package common.unitStep
{
    import flash.display.*;
    import flash.events.*;

    public class unitStep extends MovieClip
    {
        public var btnAdvance_Disable_Unit:btnAdvanceDisableUnit;
        public var btnAdvance_Enable_Unit:btnAdvanceEnableUnit;
        public var btnAll_Disable_Unit:btnAllDisableUnit;
        public var btnAll_Enable_Unit:btnAllEnableUnit;
        public var btnReturn_Disable_Unit:btnReturnDisableUnit;
        public var btnReturn_Enable_Unit:btnReturnEnableUnit;
        public var btnStep_Disable_Unit:btnStepDisableUnit;
        public var btnStep_Enable_Unit:btnStepEnableUnit;
        private var _stepMC:MovieClip;
        private var _subMC:MovieClip;
        private var _brightnessChange:Boolean;

        public function unitStep()
        {
            this.init();
            this._brightnessChange = true;
            this.btnStep_Enable_Unit.addEventListener(MouseEvent.CLICK, this.btnStep_EnableHandler);
            this.btnStep_Disable_Unit.addEventListener(MouseEvent.CLICK, this.btnStep_DisableHandler);
            this.btnAdvance_Enable_Unit.addEventListener(MouseEvent.CLICK, this.btnAdvance_EnableHandler);
            this.btnReturn_Enable_Unit.addEventListener(MouseEvent.CLICK, this.btnReturn_EnableHandler);
            this.btnAll_Enable_Unit.addEventListener(MouseEvent.CLICK, this.btnAll_EnableHandler);
            this.btnAll_Disable_Unit.addEventListener(MouseEvent.CLICK, this.btnAll_DisableHandler);
            this.btnStep_Enable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnStep_Enable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.btnStep_Disable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnStep_Disable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.btnAdvance_Enable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnAdvance_Enable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.btnReturn_Enable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnReturn_Enable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.btnAll_Enable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnAll_Enable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.btnAll_Disable_Unit.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.btnAll_Disable_Unit.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            return;
        }// end function

        public function get stepMC() : MovieClip
        {
            return this._stepMC;
        }// end function

        public function set stepMC(param1:MovieClip) : void
        {
            this._stepMC = param1;
            this.init();
            return;
        }// end function

        public function get subMC() : MovieClip
        {
            return this._subMC;
        }// end function

        public function set subMC(param1:MovieClip) : void
        {
            this._subMC = param1;
            return;
        }// end function

        public function get brightnessChange() : Boolean
        {
            return this._brightnessChange;
        }// end function

        public function set brightnessChange(param1:Boolean) : void
        {
            this._brightnessChange = param1;
            return;
        }// end function

        public function reset() : void
        {
            try
            {
                this.init();
                if (this._stepMC != null)
                {
                    this._stepMC.gotoAndStop(0);
                }
            }
            catch (e:Error)
            {
                trace("reset:" + e.message);
            }
            return;
        }// end function

        private function init() : void
        {
            try
            {
                this.btnAll_Enable_Unit.visible = true;
                this.btnStep_Enable_Unit.visible = true;
                this.btnAdvance_Enable_Unit.visible = false;
                this.btnReturn_Enable_Unit.visible = false;
                this.btnAdvance_Disable_Unit.visible = false;
                this.btnReturn_Disable_Unit.visible = false;
                this.btnAll_Disable_Unit.visible = false;
                this.btnStep_Disable_Unit.visible = false;
            }
            catch (e:Error)
            {
                trace("init:" + e.message);
            }
            return;
        }// end function

        private function btnStep_EnableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this.btnStep_Enable_Unit.visible = false;
                this.btnStep_Disable_Unit.visible = true;
                if (this._stepMC.currentFrame == 1)
                {
                    this.btnAdvance_Enable_Unit.visible = true;
                }
                else if (this._stepMC.currentFrame == this._stepMC.totalFrames)
                {
                    this.btnReturn_Enable_Unit.visible = true;
                }
                else
                {
                    this.btnAdvance_Enable_Unit.visible = true;
                    this.btnReturn_Enable_Unit.visible = true;
                }
            }
            catch (e:Error)
            {
                trace("btnStep_EnableHandler:" + e.message);
            }
            return;
        }// end function

        private function btnStep_DisableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this._stepMC.gotoAndStop(1);
                if (this._subMC != null)
                {
                    this._subMC.gotoAndStop(1);
                }
                this.btnStep_Enable_Unit.visible = true;
                this.btnStep_Disable_Unit.visible = false;
                this.btnAdvance_Enable_Unit.visible = false;
                this.btnReturn_Enable_Unit.visible = false;
                this.btnAll_Enable_Unit.visible = true;
                this.btnAll_Disable_Unit.visible = false;
            }
            catch (e:Error)
            {
                trace("btnStep_DisableHandler:" + e.message);
            }
            return;
        }// end function

        private function btnAdvance_EnableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this._stepMC.nextFrame();
                if (this._subMC != null)
                {
                    this._subMC.nextFrame();
                }
                this.btnReturn_Enable_Unit.visible = true;
                if (this._stepMC.currentFrame == this._stepMC.totalFrames)
                {
                    this.btnAdvance_Enable_Unit.visible = false;
                    this.btnAll_Enable_Unit.visible = false;
                    this.btnAll_Disable_Unit.visible = true;
                }
            }
            catch (e:Error)
            {
                trace("btnAdvance_EnableHandler:" + e.message);
            }
            return;
        }// end function

        private function btnReturn_EnableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this._stepMC.prevFrame();
                if (this._subMC != null)
                {
                    this._subMC.prevFrame();
                }
                this.btnAdvance_Enable_Unit.visible = true;
                if (this._stepMC.currentFrame == 1)
                {
                    this.btnReturn_Enable_Unit.visible = false;
                }
                if (this._stepMC.currentFrame != this._stepMC.totalFrames)
                {
                    this.btnAll_Enable_Unit.visible = true;
                    this.btnAll_Disable_Unit.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("btnReturn_EnableHandler:" + e.message);
            }
            return;
        }// end function

        private function btnAll_EnableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this._stepMC.gotoAndStop(this._stepMC.totalFrames);
                if (this._subMC != null)
                {
                    this._subMC.gotoAndStop(this._subMC.totalFrames);
                }
                this.btnAll_Enable_Unit.visible = false;
                this.btnAll_Disable_Unit.visible = true;
                if (this.btnStep_Disable_Unit.visible == true)
                {
                    this.btnAdvance_Enable_Unit.visible = false;
                    this.btnReturn_Enable_Unit.visible = true;
                }
            }
            catch (e:Error)
            {
                trace("btnAll_EnableHandler:" + e.message);
            }
            return;
        }// end function

        private function btnAll_DisableHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._stepMC == null)
                {
                    return;
                }
                this._stepMC.gotoAndStop(1);
                if (this._subMC != null)
                {
                    this._subMC.gotoAndStop(1);
                }
                this.btnAll_Enable_Unit.visible = true;
                this.btnAll_Disable_Unit.visible = false;
                if (this.btnStep_Disable_Unit.visible == true)
                {
                    this.btnAdvance_Enable_Unit.visible = true;
                    this.btnReturn_Enable_Unit.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("btnAll_DisableHandler:" + e.message);
            }
            return;
        }// end function

        private function mouseOver(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
            }
            catch (e:Error)
            {
                trace("mouseOver:" + e.message);
            }
            return;
        }// end function

        private function mouseOut(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._brightnessChange)
                {
                }
            }
            catch (e:Error)
            {
                trace("mouseOut:" + e.message);
            }
            return;
        }// end function

    }
}
