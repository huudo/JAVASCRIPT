package g2_p63_01_fla
{
    import flash.display.*;

    dynamic public class Graph_Item_2 extends MovieClip
    {
        public var Ins_Back:MovieClip;
        public var Ins_Line_Mc:MovieClip;
        public var Ins_Mode:MovieClip;
        public var Ins_No1:MovieClip;
        public var Ins_No2:MovieClip;
        public var Ins_No3:MovieClip;
        public var Ins_No4:MovieClip;
        public var Ins_Save_Mc:MovieClip;

        public function Graph_Item_2()
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
