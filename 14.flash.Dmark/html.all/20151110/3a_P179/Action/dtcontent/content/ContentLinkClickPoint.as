package dtcontent.content
{
    import flash.display.*;
    import flash.events.*;

    public class ContentLinkClickPoint extends MovieClip
    {
        private var _root:MovieClip;
        private var _prohibited:Boolean = false;
        public static var cpAlpha:Number = 0;
        public static const cpAlphaStyle:Number = 0.3;

        public function ContentLinkClickPoint()
        {
            this.gotoAndStop(0);
            this.mouseChildren = false;
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onCPMouseDown);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onCPMouseUp);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onCPRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onCPRollOut);
            this.addEventListener(MouseEvent.CLICK, this.onCPClick);
            this.addEventListener(Event.ADDED, this.onAdded);
            return;
        }// end function

        public function onAdded(event:Event) : void
        {
            this.removeEventListener(Event.ADDED, this.onAdded);
            this._root = MovieClip(this["root"]);
            this._root.lcpList.push(this);
            this.alpha = cpAlpha;
            return;
        }// end function

        private function onCPMouseDown(event:MouseEvent) : void
        {
            if (this._prohibited)
            {
                return;
            }
            this.alpha = 1;
            return;
        }// end function

        private function onCPMouseUp(event:MouseEvent) : void
        {
            if (this._prohibited)
            {
                return;
            }
            this.alpha = cpAlpha;
            return;
        }// end function

        private function onCPRollOver(event:MouseEvent) : void
        {
            if (this._prohibited)
            {
                return;
            }
            this.alpha = (1 - cpAlpha) / 2 + cpAlpha;
            return;
        }// end function

        private function onCPRollOut(event:MouseEvent) : void
        {
            if (this._prohibited)
            {
                return;
            }
            this.alpha = cpAlpha;
            return;
        }// end function

        private function onCPClick(event:MouseEvent) : void
        {
            if (this._prohibited)
            {
                return;
            }
            this.alpha = cpAlpha;
            var _loc_2:* = this.name.substr(-3, 3);
            this._root.contentToFrame(ConnectConst.LINK, _loc_2);
            trace("ConnectConst.LINK", _loc_2);
            return;
        }// end function

        public function set prohibited(param1:Boolean) : void
        {
            this._prohibited = param1;
            this.visible = !param1;
            this.mouseEnabled = !param1;
            this.mouseChildren = !param1;
            if (param1)
            {
                this.alpha = 0;
            }
            else
            {
                this.alpha = cpAlpha;
            }
            return;
        }// end function

        public function get prohibited() : Boolean
        {
            return this._prohibited;
        }// end function

    }
}
