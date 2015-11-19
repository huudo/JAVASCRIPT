package g2_p9_01_fla
{
    import fl.motion.*;
    import flash.display.*;
    import flash.geom.*;

    dynamic public class course_anime_3 extends MovieClip
    {
        public var Ins_Line:MovieClip;
        public var Ins_lane_l:MovieClip;
        public var Ins_lane_r:MovieClip;
        public var __motion_Ins_Course_l:MotionBase;
        public var Ins_Course_l:AnimatorFactory;

        public function course_anime_3()
        {
            addFrameScript(0, this.frame1, 10, this.frame11, 30, this.frame31, 104, this.frame105, 134, this.frame135);
            if (this.__motion_Ins_Course_l == null)
            {
                this.__motion_Ins_Course_l = new Motion();
                this.__motion_Ins_Course_l.duration = 30;
                this.__motion_Ins_Course_l.overrideTargetTransform();
                this.__motion_Ins_Course_l.addPropertyArray("x", [0, 6.06207, 12.1241, 18.1862, 24.2483, 30.3103, 36.3724, 42.4345, 48.4966, 54.5586, 60.6207, 66.6828, 72.7448, 78.8069, 84.869, 90.931, 96.9931, 103.055, 109.117, 115.179, 121.241, 127.303, 133.366, 139.428, 145.49, 151.546, 157.614, 163.676, 169.738, 175.8]);
                this.__motion_Ins_Course_l.addPropertyArray("y", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
                this.__motion_Ins_Course_l.addPropertyArray("scaleX", [1]);
                this.__motion_Ins_Course_l.addPropertyArray("scaleY", [1]);
                this.__motion_Ins_Course_l.addPropertyArray("skewX", [0]);
                this.__motion_Ins_Course_l.addPropertyArray("skewY", [0]);
                this.__motion_Ins_Course_l.addPropertyArray("rotationConcat", [0]);
                this.__motion_Ins_Course_l.addPropertyArray("blendMode", ["normal"]);
                this.__motion_Ins_Course_l.addPropertyArray("cacheAsBitmap", [false]);
                this.__motion_Ins_Course_l.addPropertyArray("opaqueBackground", [null]);
                this.__motion_Ins_Course_l.addPropertyArray("visible", [true]);
                this.Ins_Course_l = new AnimatorFactory(this.__motion_Ins_Course_l);
                this.Ins_Course_l.transformationPoint = new Point(0.953704, 0.500926);
            }
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

        function frame11()
        {
            stop();
            return;
        }// end function

        function frame31()
        {
            stop();
            return;
        }// end function

        function frame105()
        {
            stop();
            return;
        }// end function

        function frame135()
        {
            stop();
            return;
        }// end function

    }
}
