package phcomm.clipstage
{
    import flash.geom.*;

    public class StageEvent extends Object
    {
        private var mType:String;
        private var mMouseX:Number;
        private var mMouseY:Number;
        private var mIsButtonDown:Boolean;
        private var mTimerID:int;
        public static const INITIALIZE:String = "MovieClipStageEvent_Initialize";
        public static const BUTTON_CLICK:String = "MovieClipStageEvent_ButtonClick_";
        public static const BUTTON_MOUSE_DOWN:String = "MovieClipStageEvent_ButtonMouseDown_";
        public static const BUTTON_MOUSE_UP:String = "MovieClipStageEvent_ButtonMouseUp_";
        public static const STAGE_CLICK:String = "MovieClipStageEvent_StageClick";
        public static const STAGE_MOUSE_DOWN:String = "MovieClipStageEvent_StageMouseDown";
        public static const STAGE_MOUSE_MOVE:String = "MovieClipStageEvent_StageMouseMove";
        public static const STAGE_MOUSE_UP:String = "MovieClipStageEvent_StageMouseUp";
        public static const TIMER:String = "MovieClipStageEvent_TimerTimer";
        public static const PAUSE_END:String = "MovieClipStageEvent_PauseEnd";
        public static const SLOW_LINE_END:String = "MovieClipStageEvent_Line_SlowLineEnd";
        public static const S3D_DRAW_PLANE_END:String = "MovieClipStageEvent_S3D_DrwPlnEnd";
        public static const S3D_TENKAI_END:String = "MovieClipStageEvent_S3D_TenkaiEnd";
        public static const S3D_KUMITATE_END:String = "MovieClipStageEvent_S3D_KumitateEnd";
        public static const S3D_IDO1_END:String = "MovieClipStageEvent_S3D_Ido1End";
        public static const S3D_IDO2_END:String = "MovieClipStageEvent_S3D_Ido2End";
        public static const C3D_TENKAI_END:String = "MovieClipStageEvent_S3D_TenkaiEnd";
        public static const C3D_KUMITATE_END:String = "MovieClipStageEvent_S3D_KumitateEnd";
        public static const C3D_IDO1_END:String = "MovieClipStageEvent_S3D_Ido1End";
        public static const C3D_IDO2_END:String = "MovieClipStageEvent_S3D_Ido2End";
        public static const BUTTON_TIMER_INTERVAL_1:int = 500;
        public static const BUTTON_TIMER_INTERVAL_2:int = 100;

        public function StageEvent(param1:String)
        {
            this.mType = param1;
            this.mMouseX = Number.NaN;
            this.mMouseY = Number.NaN;
            this.mIsButtonDown = false;
            this.mTimerID = 0;
            return;
        }// end function

        public function get type() : String
        {
            return this.mType;
        }// end function

        public function set type(param1:String) : void
        {
            this.mType = param1;
            return;
        }// end function

        public function get mousePoint() : Point
        {
            return new Point(this.mMouseX, this.mMouseY);
        }// end function

        public function get mouseX() : Number
        {
            return this.mMouseX;
        }// end function

        public function set mouseX(param1:Number) : void
        {
            this.mMouseX = param1;
            return;
        }// end function

        public function get mouseY() : Number
        {
            return this.mMouseY;
        }// end function

        public function set mouseY(param1:Number) : void
        {
            this.mMouseY = param1;
            return;
        }// end function

        public function get isMouseButtonDown() : Boolean
        {
            return this.mIsButtonDown;
        }// end function

        public function set isMouseButtonDown(param1:Boolean) : void
        {
            this.mIsButtonDown = param1;
            return;
        }// end function

        public function get timerID() : int
        {
            return this.mTimerID;
        }// end function

        public function set timerID(param1:int) : void
        {
            this.mTimerID = param1;
            return;
        }// end function

        public static function createButtonEvent(param1:String, param2:String, param3:Boolean) : StageEvent
        {
            var _loc_4:* = new StageEvent(param1 + param2);
            _loc_4.isMouseButtonDown = param3;
            return _loc_4;
        }// end function

        public static function createMouseEvent(param1:String, param2:Number, param3:Number, param4:Boolean) : StageEvent
        {
            var _loc_5:* = new StageEvent(param1);
            _loc_5.mouseX = param2;
            _loc_5.mouseY = param3;
            _loc_5.isMouseButtonDown = param4;
            return _loc_5;
        }// end function

        public static function createTimerEvent(param1:String, param2:int) : StageEvent
        {
            var _loc_3:* = new StageEvent(param1);
            _loc_3.timerID = param2;
            return _loc_3;
        }// end function

    }
}
