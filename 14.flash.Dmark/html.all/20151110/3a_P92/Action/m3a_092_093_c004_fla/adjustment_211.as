package m3a_092_093_c004_fla
{
    import flash.display.*;
    import flash.events.*;

    dynamic public class adjustment_211 extends MovieClip
    {
        public var btnSlider:MovieClip;

        public function adjustment_211()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function startSlide(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                this.btnSlider.startDrag(false, new Rectangle(0, this.btnSlider.y, 180, 0));
                dispatchEvent(new Event("moveSlide"));
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveSlide);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.stopSlide);
            }
            catch (e:Error)
            {
                trace("startSlide:" + e.message);
            }
            return;
        }// end function

        public function moveSlide(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                dispatchEvent(new Event("moveSlide"));
            }
            catch (e:Error)
            {
                trace("moveSlide:" + e.message);
            }
            return;
        }// end function

        public function stopSlide(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                this.btnSlider.stopDrag();
                dispatchEvent(new Event("moveSlide"));
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveSlide);
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.stopSlide);
            }
            catch (e:Error)
            {
                trace("stopSlide:" + e.message);
            }
            return;
        }// end function

        function frame1()
        {
            this.btnSlider.addEventListener(MouseEvent.MOUSE_DOWN, this.startSlide);
            return;
        }// end function

    }
}
