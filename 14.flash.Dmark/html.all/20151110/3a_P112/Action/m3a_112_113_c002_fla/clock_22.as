package m3a_112_113_c002_fla
{
    import flash.display.*;
    import flash.text.*;

    dynamic public class clock_22 extends MovieClip
    {
        public var Ins_Time1:TextField;
        public var Ins_Time2:TextField;
        public var Ins_Time3:TextField;

        public function clock_22()
        {
            addFrameScript(0, this.frame1, 7, this.frame8, 11, this.frame12);
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

        function frame8()
        {
            gotoAndStop("off");
            return;
        }// end function

        function frame12()
        {
            gotoAndStop("off");
            return;
        }// end function

    }
}
