package m1a_158_159_c008_fla
{
    import flash.display.*;

    dynamic public class animation_3 extends MovieClip
    {
        public var C:MovieClip;
        public var D:MovieClip;
        public var E:MovieClip;
        public var line:MovieClip;
        public var num_1:MovieClip;
        public var num_2:MovieClip;
        public var num_3:MovieClip;

        public function animation_3()
        {
            addFrameScript(0, this.frame1, 59, this.frame60, 169, this.frame170, 199, this.frame200);
            return;
        }// end function

        function frame1()
        {
            stop();
            this.num_1.visible = false;
            this.num_2.visible = false;
            this.num_3.visible = false;
            this.C.visible = false;
            this.D.visible = false;
            this.E.visible = false;
            root.nextBtn.visible = true;
            root.backBtn.visible = false;
            root.resetBtn.visible = false;
            return;
        }// end function

        function frame60()
        {
            stop();
            this.num_1.visible = true;
            this.num_2.visible = false;
            this.C.visible = true;
            this.D.visible = true;
            this.E.visible = false;
            root.nextBtn.visible = true;
            root.backBtn.visible = true;
            root.resetBtn.visible = true;
            return;
        }// end function

        function frame170()
        {
            stop();
            this.num_2.visible = true;
            this.num_3.visible = false;
            this.E.visible = true;
            root.nextBtn.visible = true;
            root.backBtn.visible = true;
            root.resetBtn.visible = true;
            return;
        }// end function

        function frame200()
        {
            stop();
            root.backBtn.visible = true;
            root.resetBtn.visible = true;
            return;
        }// end function

    }
}
