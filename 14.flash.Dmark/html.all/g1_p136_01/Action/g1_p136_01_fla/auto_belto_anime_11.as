package g1_p136_01_fla
{
    import fl.motion.*;
    import flash.display.*;
    import flash.geom.*;

    dynamic public class auto_belto_anime_11 extends MovieClip
    {
        public var __motion_Ins_Auto:MotionBase;
        public var Ins_Auto:AnimatorFactory;

        public function auto_belto_anime_11()
        {
            if (this.__motion_Ins_Auto == null)
            {
                this.__motion_Ins_Auto = new Motion();
                this.__motion_Ins_Auto.duration = 17;
                this.__motion_Ins_Auto.overrideTargetTransform();
                this.__motion_Ins_Auto.addPropertyArray("x", [0, 2.125, 4.25, 6.375, 8.5, 10.625, 12.75, 14.875, 17, 19.125, 21.25, 23.375, 25.5, 27.625, 29.75, 31.875, 34]);
                this.__motion_Ins_Auto.addPropertyArray("y", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
                this.__motion_Ins_Auto.addPropertyArray("scaleX", [1]);
                this.__motion_Ins_Auto.addPropertyArray("scaleY", [1]);
                this.__motion_Ins_Auto.addPropertyArray("skewX", [0]);
                this.__motion_Ins_Auto.addPropertyArray("skewY", [0]);
                this.__motion_Ins_Auto.addPropertyArray("rotationConcat", [0]);
                this.__motion_Ins_Auto.addPropertyArray("blendMode", ["normal"]);
                this.__motion_Ins_Auto.addPropertyArray("cacheAsBitmap", [false]);
                this.__motion_Ins_Auto.addPropertyArray("opaqueBackground", [null]);
                this.__motion_Ins_Auto.addPropertyArray("visible", [true]);
                this.Ins_Auto = new AnimatorFactory(this.__motion_Ins_Auto);
                this.Ins_Auto.transformationPoint = new Point(0.5, 0.5);
            }
            return;
        }// end function

    }
}
