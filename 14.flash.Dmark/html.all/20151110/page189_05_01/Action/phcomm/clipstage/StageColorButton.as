package phcomm.clipstage
{
    import flash.display.*;
    import flash.geom.*;

    public class StageColorButton extends StageButton
    {
        protected var mColor:uint;

        public function StageColorButton()
        {
            this.setColor();
            return;
        }// end function

        public function get color() : uint
        {
            return this.mColor;
        }// end function

        protected function setColor() : void
        {
            var _loc_1:* = this.getBounds(this);
            var _loc_2:* = new BitmapData(_loc_1.width, _loc_1.height, false);
            _loc_2.draw(this, new Matrix(1, 0, 0, 1, -_loc_1.x, -_loc_1.y));
            this.mColor = _loc_2.getPixel(int(_loc_1.width / 2), int(_loc_1.height / 2));
            _loc_2.dispose();
            _loc_2 = null;
            return;
        }// end function

    }
}
