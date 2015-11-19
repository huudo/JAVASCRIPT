package g1_p29_01_fla
{
    import flash.display.*;

    dynamic public class exp_man_s_12 extends MovieClip
    {

        public function exp_man_s_12()
        {
            addFrameScript(0, this.frame1, 35, this.frame36, 67, this.frame68);
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

        function frame36()
        {
            gotoAndPlay("walk");
            return;
        }// end function

        function frame68()
        {
            gotoAndPlay("back");
            return;
        }// end function

    }
}
