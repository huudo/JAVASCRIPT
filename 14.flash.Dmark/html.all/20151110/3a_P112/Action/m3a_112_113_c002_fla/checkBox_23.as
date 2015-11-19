package m3a_112_113_c002_fla
{
    import flash.display.*;

    dynamic public class checkBox_23 extends MovieClip
    {
        public var btnCheckBox:btnAnsFrame01;
        public var check:MovieClip;

        public function checkBox_23()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function reset() : void
        {
            try
            {
                this.btnCheckBox.reset();
            }
            catch (e:Error)
            {
                trace("reset:" + e.message);
            }
            return;
        }// end function

        function frame1()
        {
            this.btnCheckBox.targetMC = this.check;
            this.btnCheckBox.reset();
            return;
        }// end function

    }
}
