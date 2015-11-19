package common.buttons
{
    import flash.display.*;
    import flash.events.*;

    public class btnOnOff extends buttonBase
    {
        public var btnDisable:MovieClip;
        public var btnEnable:MovieClip;
        private var _colorChange:Boolean;

        public function btnOnOff()
        {
            this._colorChange = false;
            this.btnEnable.visible = true;
            this.btnDisable.visible = false;
            addEventListener(MouseEvent.CLICK, this.mouseClick);
            return;
        }// end function

        public function get colorChange() : Boolean
        {
            return this._colorChange;
        }// end function

        public function set colorChange(param1:Boolean) : void
        {
            this._colorChange = param1;
            return;
        }// end function

        public function reset() : void
        {
            try
            {
                this.btnEnable.visible = true;
                this.btnDisable.visible = false;
                if (_targetMC != null)
                {
                    _targetMC.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("reset:" + e.message);
            }
            return;
        }// end function

        public function reverseColor() : void
        {
            try
            {
                this.btnEnable.visible = !this.btnEnable.visible;
                this.btnDisable.visible = !this.btnDisable.visible;
            }
            catch (e:Error)
            {
                trace("reverseColor:" + e.message);
            }
            return;
        }// end function

        public function enableColor() : void
        {
            try
            {
                this.btnEnable.visible = true;
                this.btnDisable.visible = false;
            }
            catch (e:Error)
            {
                trace("enableColor:" + e.message);
            }
            return;
        }// end function

        public function disableColor() : void
        {
            try
            {
                this.btnEnable.visible = false;
                this.btnDisable.visible = true;
            }
            catch (e:Error)
            {
                trace("disableColor:" + e.message);
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._colorChange)
                {
                    this.btnEnable.visible = !this.btnEnable.visible;
                    this.btnDisable.visible = !this.btnDisable.visible;
                }
            }
            catch (e:Error)
            {
                trace("mouseClick:" + e.message);
            }
            return;
        }// end function

    }
}
