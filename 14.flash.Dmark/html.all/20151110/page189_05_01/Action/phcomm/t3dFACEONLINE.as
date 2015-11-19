package phcomm
{
    import __AS3__.vec.*;

    public class t3dFACEONLINE extends Object
    {
        public var FaceNo:int;
        public var LinePos:Vector.<int>;
        public var PosRate:Vector.<Number>;

        public function t3dFACEONLINE(param1:int = 0)
        {
            this.FaceNo = param1;
            this.LinePos = new Vector.<int>(2);
            this.PosRate = new Vector.<Number>(2);
            return;
        }// end function

    }
}
