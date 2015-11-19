package phcomm.clipstage
{
    import __AS3__.vec.*;
    import flash.ui.*;
    import phcomm.clipstage.cursor.*;

    public class CursorOperate extends Object
    {
        private const CURSOR_NAME_HEDDER:String = "PHCOMM_CURSOR_";
        private var mCurrentCode:int;
        private var mDataList:Vector.<CursorData>;
        public static const HIDE:int = -1;
        public static const ARROW:int = 0;
        public static const ERASE:int = 16;
        public static const SCISSORS:int = 18;
        public static const TAPE:int = 19;
        public static const RIGHT_FINGER:int = 20;
        public static const GRIP:int = 21;
        public static const BRUSH1:int = 22;
        public static const BRUSH2:int = 23;
        public static const ERASER1:int = 24;
        public static const PENCIL1:int = 25;
        public static const FAT_ERASER:int = 26;
        public static const SLIM_ERASER:int = 27;
        public static const ERASER2:int = 28;
        public static const RULER:int = 32;
        public static const PENCIL2:int = 33;
        public static const CRAYON:int = 34;
        public static const LEFT_FINGER:int = 35;
        public static const ERASER3:int = 36;
        public static const SYSTEM_DEFAULT:int = -2147483648;

        public function CursorOperate()
        {
            this.mCurrentCode = SYSTEM_DEFAULT;
            this.mDataList = null;
            Mouse.cursor = MouseCursor.AUTO;
            Mouse.show();
            if (Mouse.supportsNativeCursor)
            {
                this.mDataList = new Vector.<CursorData>;
                this.mDataList.push(new CursorData18(SCISSORS, this.CURSOR_NAME_HEDDER + "SCISSORS"));
                this.mDataList.push(new CursorData19(TAPE, this.CURSOR_NAME_HEDDER + "TAPE"));
                this.mDataList.push(new CursorData22(BRUSH1, this.CURSOR_NAME_HEDDER + "BRUSH1"));
                this.mDataList.push(new CursorData23(BRUSH2, this.CURSOR_NAME_HEDDER + "BRUSH2"));
                this.mDataList.push(new CursorData24(ERASER1, this.CURSOR_NAME_HEDDER + "ERASER1"));
                this.mDataList.push(new CursorData25(PENCIL1, this.CURSOR_NAME_HEDDER + "PENCIL1"));
                this.mDataList.push(new CursorData26(FAT_ERASER, this.CURSOR_NAME_HEDDER + "FAT_ERASER"));
                this.mDataList.push(new CursorData27(SLIM_ERASER, this.CURSOR_NAME_HEDDER + "SLIM_ERASER"));
                this.mDataList.push(new CursorData28(ERASER2, this.CURSOR_NAME_HEDDER + "ERASER2"));
                this.mDataList.push(new CursorData32(RULER, this.CURSOR_NAME_HEDDER + "RULER"));
                this.mDataList.push(new CursorData33(PENCIL2, this.CURSOR_NAME_HEDDER + "PENCIL2"));
                this.mDataList.push(new CursorData34(CRAYON, this.CURSOR_NAME_HEDDER + "CRAYON"));
                this.mDataList.push(new CursorData35(LEFT_FINGER, this.CURSOR_NAME_HEDDER + "LEFT_FINGER"));
                this.mDataList.push(new CursorData36(ERASER3, this.CURSOR_NAME_HEDDER + "ERASER3"));
                this.mDataList.fixed = true;
            }
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = 0;
            Mouse.cursor = MouseCursor.AUTO;
            Mouse.show();
            if (this.mDataList)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mDataList.length)
                {
                    
                    if (this.mDataList[_loc_1].code == this.mCurrentCode)
                    {
                        Mouse.unregisterCursor(this.mDataList[_loc_1].name);
                        break;
                    }
                    _loc_1++;
                }
            }
            this.mCurrentCode = SYSTEM_DEFAULT;
            if (this.mDataList)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mDataList.length)
                {
                    
                    this.mDataList[_loc_1].dispose();
                    this.mDataList[_loc_1] = null;
                    _loc_1++;
                }
                this.mDataList = null;
            }
            return;
        }// end function

        public function get current() : int
        {
            return this.mCurrentCode;
        }// end function

        public function setCursor(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 == this.mCurrentCode)
            {
                return;
            }
            Mouse.cursor = MouseCursor.AUTO;
            if (this.mDataList)
            {
                _loc_2 = 0;
                while (_loc_2 < this.mDataList.length)
                {
                    
                    if (this.mDataList[_loc_2].code == this.mCurrentCode)
                    {
                        Mouse.unregisterCursor(this.mDataList[_loc_2].name);
                        break;
                    }
                    _loc_2++;
                }
            }
            this.mCurrentCode = param1;
            if (this.mDataList)
            {
                _loc_2 = 0;
                while (_loc_2 < this.mDataList.length)
                {
                    
                    if (this.mDataList[_loc_2].code == this.mCurrentCode)
                    {
                        Mouse.registerCursor(this.mDataList[_loc_2].name, this.mDataList[_loc_2].createMouseCursorData());
                        Mouse.cursor = this.mDataList[_loc_2].name;
                        Mouse.show();
                        return;
                    }
                    _loc_2++;
                }
            }
            switch(this.mCurrentCode)
            {
                case HIDE:
                case ERASE:
                {
                    Mouse.cursor = MouseCursor.AUTO;
                    Mouse.hide();
                    return;
                }
                case ARROW:
                {
                    Mouse.cursor = MouseCursor.ARROW;
                    Mouse.show();
                    return;
                }
                case RIGHT_FINGER:
                {
                    Mouse.cursor = MouseCursor.BUTTON;
                    Mouse.show();
                    return;
                }
                case GRIP:
                {
                    Mouse.cursor = MouseCursor.HAND;
                    Mouse.show();
                    return;
                }
                default:
                {
                    break;
                }
            }
            this.mCurrentCode = SYSTEM_DEFAULT;
            Mouse.cursor = MouseCursor.AUTO;
            Mouse.show();
            return;
        }// end function

    }
}
