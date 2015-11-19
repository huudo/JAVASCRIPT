package phcomm.clipstage
{
    import flash.utils.*;

    public class StageTimer extends Timer
    {
        private var mTimerID:int;

        public function StageTimer(param1:int, param2:Number, param3:int = 0)
        {
            super(param2, param3);
            this.mTimerID = param1;
            return;
        }// end function

        public function get timerID() : int
        {
            return this.mTimerID;
        }// end function

    }
}
