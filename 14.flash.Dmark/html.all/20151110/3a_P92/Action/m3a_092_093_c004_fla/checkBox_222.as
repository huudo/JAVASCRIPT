package m3a_092_093_c004_fla
{
    import flash.display.*;

    dynamic public class checkBox_222 extends MovieClip
    {
        public var btnCheckBox:btnAnsFrame01;
        public var check:MovieClip;

        public function checkBox_222()
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
