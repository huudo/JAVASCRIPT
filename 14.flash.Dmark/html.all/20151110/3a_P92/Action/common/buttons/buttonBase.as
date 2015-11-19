package common.buttons
{
    import fl.motion.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class buttonBase extends MovieClip
    {
        protected var _brightnessChange:Boolean;
        protected var _targetMC:MovieClip;

        public function buttonBase()
        {
            buttonMode = true;
            this._brightnessChange = true;
            addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            addEventListener(MouseEvent.CLICK, this.showAnsHandler);
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

        public function get targetMC() : MovieClip
        {
            return this._targetMC;
        }// end function

        public function set targetMC(param1:MovieClip) : void
        {
            this._targetMC = param1;
            return;
        }// end function

        private function mouseOver(event:MouseEvent) : void
        {
            var colorMatrix:ColorMatrix;
            var filter:ColorMatrixFilter;
            var filterMatrix:Array;
            var event:* = event;
            try
            {
                if (this._brightnessChange)
                {
                    colorMatrix = new ColorMatrix();
                    colorMatrix.SetBrightnessMatrix(15);
                    filter = new ColorMatrixFilter();
                    filterMatrix = colorMatrix.GetFlatArray();
                    filter.matrix = filterMatrix;
                    filters = [filter];
                }
            }
            catch (e:Error)
            {
                trace("mouseOver:" + e.message);
            }
            return;
        }// end function

        private function mouseOut(event:MouseEvent) : void
        {
            var colorMatrix:ColorMatrix;
            var filter:ColorMatrixFilter;
            var filterMatrix:Array;
            var event:* = event;
            try
            {
                if (this._brightnessChange)
                {
                    colorMatrix = new ColorMatrix();
                    colorMatrix.SetBrightnessMatrix(0);
                    filter = new ColorMatrixFilter();
                    filterMatrix = colorMatrix.GetFlatArray();
                    filter.matrix = filterMatrix;
                    filters = [filter];
                }
            }
            catch (e:Error)
            {
                trace("mouseOut:" + e.message);
            }
            return;
        }// end function

        private function showAnsHandler(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                if (this._targetMC == null)
                {
                    return;
                }
                this._targetMC.visible = !this._targetMC.visible;
            }
            catch (e:Error)
            {
                trace("btnStep_EnableHandler:" + e.message);
            }
            return;
        }// end function

    }
}
