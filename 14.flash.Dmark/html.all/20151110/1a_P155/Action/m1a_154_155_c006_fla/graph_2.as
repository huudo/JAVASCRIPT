package m1a_154_155_c006_fla
{
    import flash.display.*;

    dynamic public class graph_2 extends MovieClip
    {
        public var compass:MovieClip;

        public function graph_2()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 4, this.frame5, 64, this.frame65, 65, this.frame66, 69, this.frame70, 115, this.frame116, 175, this.frame176, 209, this.frame210);
            return;
        }// end function

        function frame1()
        {
            stop();
            MovieClip(parent).btnNext.visible = true;
            return;
        }// end function

        function frame2()
        {
            this.compass.gotoAndStop(26);
            return;
        }// end function

        function frame5()
        {
            stop();
            this.compass.gotoAndPlay(26);
            return;
        }// end function

        function frame65()
        {
            stop();
            MovieClip(parent).btnNext.visible = true;
            MovieClip(parent).btnBack.visible = true;
            MovieClip(parent).btnReset.visible = true;
            return;
        }// end function

        function frame66()
        {
            this.compass.gotoAndStop(61);
            return;
        }// end function

        function frame70()
        {
            stop();
            this.compass.gotoAndPlay(61);
            return;
        }// end function

        function frame116()
        {
            this.compass.gotoAndStop(61);
            return;
        }// end function

        function frame176()
        {
            stop();
            MovieClip(parent).btnNext.visible = true;
            MovieClip(parent).btnBack.visible = true;
            MovieClip(parent).btnReset.visible = true;
            return;
        }// end function

        function frame210()
        {
            stop();
            MovieClip(parent).btnBack.visible = true;
            MovieClip(parent).btnReset.visible = true;
            return;
        }// end function

    }
}
