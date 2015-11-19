package g1_p29_01_fla
{
    import flash.display.*;

    dynamic public class Explain_Item_2 extends MovieClip
    {
        public var Ins_After:MovieClip;
        public var Ins_Befoer:MovieClip;
        public var Ins_Exp_Man:MovieClip;
        public var Ins_Exp_Move1:MovieClip;
        public var Ins_Exp_Move2:MovieClip;
        public var Ins_Man:MovieClip;
        public var Ins_Now:MovieClip;
        public var Ins_PerKm1:MovieClip;
        public var Ins_PerKm2:MovieClip;

        public function Explain_Item_2()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

    }
}
