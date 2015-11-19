package g1_p136_01_fla
{
    import flash.display.*;

    dynamic public class Graph_Item_2 extends MovieClip
    {
        public var Ins_Back:MovieClip;
        public var Ins_Line_Mc:MovieClip;

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
