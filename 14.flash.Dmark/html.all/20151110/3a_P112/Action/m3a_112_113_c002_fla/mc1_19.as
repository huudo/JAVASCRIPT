package m3a_112_113_c002_fla
{
    import flash.display.*;
    import flash.events.*;

    dynamic public class mc1_19 extends MovieClip
    {
        public var Ins_Clock:MovieClip;
        public var car:MovieClip;
        public var chk_0:MovieClip;
        public var chk_1:MovieClip;
        public var train:MovieClip;
        public const COEFFCIENT:int = 2;
        public var frameCnt:int;
        public var trainStart:Object;

        public function mc1_19()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function init() : void
        {
            try
            {
                removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                this.car.x = 0;
                this.train.x = 200;
                this.Ins_Clock.Ins_Time2.text = "0";
                this.Ins_Clock.Ins_Time3.text = "0";
                this.frameCnt = 0;
                parent.btnStart.visible = true;
                parent.btnStop.visible = false;
                parent.btnFirst.visible = false;
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
                this.Ins_Clock.gotoAndPlay("start");
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
                this.Ins_Clock.gotoAndPlay("stop");
                removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                parent.btnStart.visible = true;
                parent.btnStop.visible = false;
            }
            catch (e:Error)
            {
                trace("animeStop:" + e.message);
            }
            return;
        }// end function

        public function animeHandler(event:Event) : void
        {
            var carX:Number;
            var tmp:Number;
            var cnt:int;
            var seconds:int;
            var trainX:Number;
            var event:* = event;
            try
            {
                var _loc_3:* = this;
                var _loc_4:* = this.frameCnt + 1;
                _loc_3.frameCnt = _loc_4;
                carX = 10 * this.frameCnt * (1 / 30);
                this.car.x = carX * this.COEFFCIENT;
                if (this.frameCnt > this.trainStart)
                {
                    trainX = (this.frameCnt - this.trainStart) * (1 / 30) * this.COEFFCIENT * ((this.frameCnt - this.trainStart) * (1 / 30) * this.COEFFCIENT) / 4;
                    this.train.x = 200 + trainX;
                }
                this.clockHandler(this.frameCnt);
                tmp = this.frameCnt % (30 / this.COEFFCIENT);
                cnt = this.frameCnt - this.trainStart;
                seconds = cnt / 30 * this.COEFFCIENT;
                if (this.frameCnt == this.trainStart && this.chk_0.check.visible == true)
                {
                    removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                    parent.btnStart.visible = true;
                    parent.btnStop.visible = false;
                }
                if (tmp == 0 && seconds == 40 && this.chk_1.check.visible == true)
                {
                    removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                    parent.btnStart.visible = true;
                    parent.btnStop.visible = false;
                }
                if (tmp == 0 && seconds == 60)
                {
                    removeEventListener(Event.ENTER_FRAME, this.animeHandler);
                    parent.btnStop.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("animeHandler:" + e.message);
            }
            return;
        }// end function

        public function clockHandler(param1:int) : void
        {
            var seconds:int;
            var str:*;
            var cnt:* = param1;
            try
            {
                if (cnt % (30 / this.COEFFCIENT) != 0)
                {
                    return;
                }
                if (cnt > this.trainStart)
                {
                    cnt = cnt - this.trainStart;
                    seconds = cnt / 30 * this.COEFFCIENT;
                    str = seconds.toString();
                    if (str.length == 1)
                    {
                        this.Ins_Clock.Ins_Time3.text = str;
                    }
                    else
                    {
                        this.Ins_Clock.Ins_Time2.text = str.substr(0, 1);
                        this.Ins_Clock.Ins_Time3.text = str.substr(1, 1);
                    }
                }
            }
            catch (e:Error)
            {
                trace("clockHandler:" + e.message);
            }
            return;
        }// end function

        function frame1()
        {
            this.frameCnt = 0;
            this.trainStart = 600 / this.COEFFCIENT;
            return;
        }// end function

    }
}
