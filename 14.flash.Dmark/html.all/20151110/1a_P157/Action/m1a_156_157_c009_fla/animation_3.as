package m1a_156_157_c009_fla
{
    import flash.display.*;

    dynamic public class animation_3 extends MovieClip
    {
        public var compass:MovieClip;

        public function animation_3()
        {
            addFrameScript(0, this.frame1, 220, this.frame221, 260, this.frame261);
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

        function frame221()
        {
            stop();
            root.nextBtn.visible = true;
            root.backBtn.visible = true;
            root.resetBtn.visible = true;
            return;
        }// end function

        function frame261()
        {
            stop();
            root.backBtn.visible = true;
            root.resetBtn.visible = true;
            return;
        }// end function

    }
}
