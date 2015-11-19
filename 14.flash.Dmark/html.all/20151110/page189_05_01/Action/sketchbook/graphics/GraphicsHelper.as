package sketchbook.graphics
{
    import flash.display.*;
    import flash.geom.*;

    public class GraphicsHelper extends Object
    {
        protected var _target:Graphics;

        public function GraphicsHelper(param1:Graphics)
        {
            this._target = param1;
            return;
        }// end function

        public function set target(param1:Graphics) : void
        {
            this._target = param1;
            return;
        }// end function

        public function get target() : Graphics
        {
            return this._target;
        }// end function

        public function drawLines(param1:Array, param2:Boolean = false) : void
        {
            var _loc_3:* = this._target;
            var _loc_4:* = param1.length;
            _loc_3.moveTo(param1[0].x, param1[0].y);
            var _loc_5:* = 1;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3.lineTo(param1[_loc_5].x, param1[_loc_5].y);
                _loc_5 = _loc_5 + 1;
            }
            if (param2)
            {
                _loc_3.lineTo(param1[0].x, param1[0].y);
            }
            return;
        }// end function

        public function drawQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
        {
            var _loc_9:* = this.getQuadPoints(param1, param2, param3, param4, param5, param6, param7, param8);
            this.drawLines(_loc_9, true);
            return;
        }// end function

        public function getQuadPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Array
        {
            return [new Point(param1, param2), new Point(param3, param4), new Point(param5, param6), new Point(param7, param8)];
        }// end function

        public function drawPolygon(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            this.drawLines([new Point(param1, param2), new Point(param3, param4), new Point(param5, param6)], true);
            return;
        }// end function

        public function drawArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 36) : void
        {
            var _loc_7:* = getArcPoints(param1, param2, param3, param4, param5, param6);
            this.drawLines(_loc_7, false);
            return;
        }// end function

        public function drawRing(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 360, param6:Number = 0, param7:Number = 36) : void
        {
            var _loc_8:* = this.getRingPoints(param1, param2, param3, param4, param5, param6, param7);
            this.drawLines(_loc_8, true);
            return;
        }// end function

        public function getRingPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 360, param6:Number = 0, param7:Number = 36) : Array
        {
            var _loc_10:* = null;
            var _loc_12:* = NaN;
            var _loc_8:* = param6 * Math.PI / 180;
            var _loc_9:* = param5 * Math.PI / 180 / param7;
            var _loc_11:* = param7 + 1;
            var _loc_13:* = new Array();
            var _loc_14:* = 0;
            while (_loc_14 < _loc_11)
            {
                
                _loc_10 = new Point();
                _loc_12 = _loc_8 + _loc_9 * _loc_14;
                _loc_10.x = Math.cos(_loc_12) * param3 + param1;
                _loc_10.y = Math.sin(_loc_12) * param3 + param2;
                _loc_13.push(_loc_10);
                _loc_14++;
            }
            var _loc_15:* = [];
            _loc_14 = 0;
            while (_loc_14 < _loc_11)
            {
                
                _loc_10 = new Point();
                _loc_12 = _loc_8 + _loc_9 * _loc_14;
                _loc_10.x = Math.cos(_loc_12) * param4 + param1;
                _loc_10.y = Math.sin(_loc_12) * param4 + param2;
                _loc_15.push(_loc_10);
                _loc_14++;
            }
            _loc_15.reverse();
            _loc_13 = _loc_13.concat(_loc_15);
            return _loc_13;
        }// end function

        public function drawPie(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 36) : void
        {
            var _loc_7:* = getPiePoints(param1, param2, param3, param4, param5, param6);
            this.drawLines(_loc_7, true);
            return;
        }// end function

        public function drawStar(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void
        {
            var _loc_7:* = getStarPoints(param1, param2, param3, param4, param5, param6);
            this.drawLines(_loc_7, true);
            return;
        }// end function

        public function beginFill(param1:uint, param2:Number = 1) : void
        {
            this._target.beginFill(param1, param2);
            return;
        }// end function

        public function clear() : void
        {
            this._target.clear();
            return;
        }// end function

        public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this._target.curveTo(param1, param2, param3, param4);
            return;
        }// end function

        public function drawRect(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this._target.drawRect(param1, param2, param3, param4);
            return;
        }// end function

        public function drawCircle(param1:Number, param2:Number, param3:Number) : void
        {
            this._target.drawCircle(param1, param2, param3);
            return;
        }// end function

        public function drawEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this._target.drawEllipse(param1, param2, param3, param4);
            return;
        }// end function

        public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            this._target.drawRoundRect(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

        public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
        {
            this._target.drawRoundRectComplex(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public function endFill() : void
        {
            this._target.endFill();
            return;
        }// end function

        public function moveTo(param1:Number, param2:Number) : void
        {
            this._target.moveTo(param1, param2);
            return;
        }// end function

        public function lineTo(param1:Number, param2:Number) : void
        {
            this._target.lineTo(param1, param2);
            return;
        }// end function

        public function lineStyle(param1:Number = 0, param2:uint = 0, param3:Number = 1, param4:Boolean = false, param5:String = "normal", param6:String = null, param7:String = null, param8:Number = 3) : void
        {
            this._target.lineStyle(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public function beginBitmapFill(param1:BitmapData, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : void
        {
            this._target.beginBitmapFill(param1, param2, param3, param4);
            return;
        }// end function

        public function beginGradientFill(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void
        {
            this._target.beginGradientFill(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public function lineGradientStyle(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void
        {
            this._target.lineGradientStyle(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public static function getArcPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 36) : Array
        {
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_7:* = new Array();
            var _loc_8:* = param5 * Math.PI / 180;
            var _loc_9:* = param4 * Math.PI / 180 / param6;
            var _loc_10:* = param6 + 1;
            var _loc_11:* = 0;
            while (_loc_11 < _loc_10)
            {
                
                _loc_12 = new Point();
                _loc_13 = _loc_8 + _loc_9 * _loc_11;
                _loc_12.x = Math.cos(_loc_13) * param3 + param1;
                _loc_12.y = Math.sin(_loc_13) * param3 + param2;
                _loc_7.push(_loc_12);
                _loc_11++;
            }
            return _loc_7;
        }// end function

        public static function getPiePoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 36) : Array
        {
            var _loc_8:* = null;
            var _loc_7:* = getArcPoints(param1, param2, param3, param4, param5, param6);
            _loc_7.unshift(new Point(param1, param2));
            return _loc_7;
        }// end function

        public static function getStarPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : Array
        {
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null;
            var _loc_7:* = new Array();
            var _loc_8:* = Math.PI * 2 / param5;
            var _loc_9:* = param1;
            var _loc_10:* = param2;
            var _loc_11:* = param6 * Math.PI / 180;
            var _loc_12:* = param5;
            var _loc_13:* = 0;
            while (_loc_13 < _loc_12)
            {
                
                _loc_14 = Math.PI * 2 * _loc_13 / param5 + _loc_11;
                _loc_15 = Math.PI * 2 * (_loc_13 + 0.5) / param5 + _loc_11;
                _loc_16 = new Point();
                _loc_16.x = Math.cos(_loc_14) * param3 + _loc_9;
                _loc_16.y = Math.sin(_loc_14) * param3 + _loc_10;
                _loc_7.push(_loc_16);
                _loc_16 = new Point();
                _loc_16.x = Math.cos(_loc_15) * param4 + _loc_9;
                _loc_16.y = Math.sin(_loc_15) * param4 + _loc_10;
                _loc_7.push(_loc_16);
                _loc_13 = _loc_13 + 1;
            }
            return _loc_7;
        }// end function

    }
}
