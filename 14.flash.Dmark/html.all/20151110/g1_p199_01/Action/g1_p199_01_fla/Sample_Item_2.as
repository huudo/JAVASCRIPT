package g1_p199_01_fla
{
    import flash.display.*;

    dynamic public class Sample_Item_2 extends MovieClip
    {
        public var Ins_Circle_B1:MovieClip;
        public var Ins_Circle_B2:MovieClip;
        public var Ins_Circle_B3:MovieClip;
        public var Ins_Circle_B4:MovieClip;
        public var Ins_Circle_Back:MovieClip;
        public var Ins_Circle_R1:MovieClip;
        public var Ins_Circle_R2:MovieClip;
        public var Ins_Circle_R3:MovieClip;
        public var Ins_Circle_R4:MovieClip;
        public var Ins_Exp_l1:MovieClip;
        public var Ins_Exp_r1:MovieClip;

        public function Sample_Item_2()
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
