package m3a_092_093_c004_fla
{
    import flash.display.*;
    import flash.events.*;

    dynamic public class mc_2 extends MovieClip
    {
        public var afterimage_0:MovieClip;
        public var afterimage_1:MovieClip;
        public var afterimage_2:MovieClip;
        public var afterimage_3:MovieClip;
        public var afterimage_4:MovieClip;
        public var ball:MovieClip;
        public var text_0:MovieClip;
        public var text_1:MovieClip;
        public var text_2:MovieClip;
        public var text_3:MovieClip;
        public var text_4:MovieClip;
        public var frameCnt:int;

        public function mc_2()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function init() : void
        {
            try
            {
                this.frameCnt = 0;
                this.ball.x = 0;
                this.afterimage_0.visible = false;
                this.afterimage_1.visible = false;
                this.afterimage_2.visible = false;
                this.afterimage_3.visible = false;
                this.afterimage_4.visible = false;
                this.text_0.visible = false;
                this.text_1.visible = false;
                this.text_2.visible = false;
                this.text_3.visible = false;
                this.text_4.visible = false;
                dispatchEvent(new Event("animeHandler"));
            }
            catch (e:Error)
            {
                trace("init:" + e.message);
            }
            return;
        }// end function

        public function animeStart() : void
        {
            try
            {
                addEventListener(Event.ENTER_FRAME, this.animeHandler);
            }
            catch (e:Error)
            {
                trace("animeStart:" + e.message);
            }
            return;
        }// end function

        public function animeStop() : void
        {
            try
            {
                removeEventListener(Event.ENTER_FRAME, this.animeHandler);
            }
            catch (e:Error)
            {
                trace("animeStop:" + e.message);
            }
            return;
        }// end function

        public function animeFirst() : void
        {
            try
            {
                removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                this.init();
            }
            catch (e:Error)
            {
                trace("animeFirst:" + e.message);
            }
            return;
        }// end function

        public function changeAfterimage() : void
        {
            try
            {
                if (parent.chkAfter.check.visible == true)
                {
                    this.afterimage_0.visible = true;
                    this.text_0.visible = true;
                    if (this.frameCnt >= 30)
                    {
                        this.afterimage_1.visible = true;
                        this.text_1.visible = true;
                    }
                    if (this.frameCnt >= 60)
                    {
                        this.afterimage_2.visible = true;
                        this.text_2.visible = true;
                    }
                    if (this.frameCnt >= 90)
                    {
                        this.afterimage_3.visible = true;
                        this.text_3.visible = true;
                    }
                    if (this.frameCnt >= 120)
                    {
                        this.afterimage_4.visible = true;
                        this.text_4.visible = true;
                    }
                }
                else
                {
                    this.afterimage_0.visible = false;
                    this.afterimage_1.visible = false;
                    this.afterimage_2.visible = false;
                    this.afterimage_3.visible = false;
                    this.afterimage_4.visible = false;
                    this.text_0.visible = false;
                    this.text_1.visible = false;
                    this.text_2.visible = false;
                    this.text_3.visible = false;
                    this.text_4.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("changeAfterimage:" + e.message);
            }
            return;
        }// end function

        public function animeHandler(event:Event) : void
        {
            var ballX:Number;
            var event:* = event;
            try
            {
                if (this.frameCnt == 180)
                {
                    parent.btnStart.visible = false;
                    parent.btnStop.visible = false;
                    parent.btnFirst.visible = true;
                    removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                    return;
                }
                var _loc_3:* = this;
                var _loc_4:* = this.frameCnt + 1;
                _loc_3.frameCnt = _loc_4;
                ballX = 0.2 * (this.frameCnt / 30 * (this.frameCnt / 30));
                this.ball.x = ballX * 100;
                if (parent.chkAfter.check.visible == true)
                {
                    this.afterimage_0.visible = true;
                    this.text_0.visible = true;
                    if (this.frameCnt >= 30)
                    {
                        this.afterimage_1.visible = true;
                        this.text_1.visible = true;
                    }
                    if (this.frameCnt >= 60)
                    {
                        this.afterimage_2.visible = true;
                        this.text_2.visible = true;
                    }
                    if (this.frameCnt >= 90)
                    {
                        this.afterimage_3.visible = true;
                        this.text_3.visible = true;
                    }
                    if (this.frameCnt >= 120)
                    {
                        this.afterimage_4.visible = true;
                        this.text_4.visible = true;
                    }
                }
                else
                {
                    this.afterimage_0.visible = false;
                    this.afterimage_1.visible = false;
                    this.afterimage_2.visible = false;
                    this.afterimage_3.visible = false;
                    this.afterimage_4.visible = false;
                    this.text_0.visible = false;
                    this.text_1.visible = false;
                    this.text_2.visible = false;
                    this.text_3.visible = false;
                    this.text_4.visible = false;
                }
                dispatchEvent(new Event("animeHandler"));
            }
            catch (e:Error)
            {
                trace("animeHandler:" + e.message);
            }
            return;
        }// end function

        public function slideHandler(param1) : void
        {
            var ballX:Number;
            var cnt:* = param1;
            try
            {
                this.frameCnt = cnt;
                if (hasEventListener(Event.ENTER_FRAME) == true)
                {
                    removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                }
                if (this.frameCnt == 180)
                {
                    parent.btnStart.visible = false;
                    parent.btnStop.visible = false;
                    parent.btnFirst.visible = true;
                }
                ballX = 0.2 * (this.frameCnt / 30 * (this.frameCnt / 30));
                this.ball.x = ballX * 100;
                if (parent.chkAfter.check.visible == true)
                {
                    this.afterimage_0.visible = true;
                    this.text_0.visible = true;
                    if (this.frameCnt >= 30)
                    {
                        this.afterimage_1.visible = true;
                        this.text_1.visible = true;
                    }
                    else
                    {
                        this.afterimage_1.visible = false;
                        this.text_1.visible = false;
                    }
                    if (this.frameCnt >= 60)
                    {
                        this.afterimage_2.visible = true;
                        this.text_2.visible = true;
                    }
                    else
                    {
                        this.afterimage_2.visible = false;
                        this.text_2.visible = false;
                    }
                    if (this.frameCnt >= 90)
                    {
                        this.afterimage_3.visible = true;
                        this.text_3.visible = true;
                    }
                    else
                    {
                        this.afterimage_3.visible = false;
                        this.text_3.visible = false;
                    }
                    if (this.frameCnt >= 120)
                    {
                        this.afterimage_4.visible = true;
                        this.text_4.visible = true;
                    }
                    else
                    {
                        this.afterimage_4.visible = false;
                        this.text_4.visible = false;
                    }
                }
                else
                {
                    this.afterimage_0.visible = false;
                    this.afterimage_1.visible = false;
                    this.afterimage_2.visible = false;
                    this.afterimage_3.visible = false;
                    this.afterimage_4.visible = false;
                    this.text_0.visible = false;
                    this.text_1.visible = false;
                    this.text_2.visible = false;
                    this.text_3.visible = false;
                    this.text_4.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("slideHandler:" + e.message);
            }
            return;
        }// end function

        function frame1()
        {
            this.frameCnt = 0;
            this.init();
            return;
        }// end function

    }
}
