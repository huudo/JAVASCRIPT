package phcomm.clipstage.cursor
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;

    public class CursorData extends BitmapData
    {
        private var mCode:int;
        private var mName:String;

        public function CursorData(param1:int, param2:String)
        {
            super(32, 32, true);
            this.mCode = param1;
            this.mName = param2;
            var _loc_3:* = new Vector.<uint>;
            this.setVectorData(_loc_3);
            this.setVector(new Rectangle(0, 0, this.width, this.height), _loc_3);
            return;
        }// end function

        final public function get code() : int
        {
            return this.mCode;
        }// end function

        final public function get name() : String
        {
            return this.mName;
        }// end function

        public function get hotSpotX() : Number
        {
            return 0;
        }// end function

        public function get hotSpotY() : Number
        {
            return 0;
        }// end function

        final public function createMouseCursorData() : MouseCursorData
        {
            var _loc_1:* = new MouseCursorData();
            _loc_1.hotSpot = new Point(this.hotSpotX, this.hotSpotY);
            new Vector.<BitmapData>(1)[0] = BitmapData(this);
            _loc_1.data = new Vector.<BitmapData>(1);
            return _loc_1;
        }// end function

        protected function setVectorData(param1:Vector.<uint>) : void
        {
            return;
        }// end function

    }
}
