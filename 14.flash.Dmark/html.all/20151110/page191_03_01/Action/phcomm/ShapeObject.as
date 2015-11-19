package phcomm
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import sketchbook.graphics.*;

    public class ShapeObject extends Shape
    {
        protected const RANGE_SMALL_LIMIT:Number = 3;
        protected const PATH_NOTCHI_STRAIGHT:Number = 1.5;
        protected const PATH_NOTCHI_ARC:Number = 4;
        public var lineWidth:int;
        public var lineStyle:int;
        public var lineColor:uint;
        public var lineAlpha:Number;
        public var fillColor:uint;
        public var fillAlpha:Number;
        public var lineRange:Number;
        public var linePixelHinting:Boolean;
        public var lineCaps:String;
        public var lineJoints:String;
        protected var useDrawHelper:Boolean;
        public static const SOLID:int = 1;
        public static const DOT:int = 2;
        public static const DASH:int = 3;
        public static const DASHDOT:int = 4;
        public static const DASHDOTDOT:int = 5;
        public static const FINEDOT:int = 6;
        public static const JOIN_MITER:String = "miter";
        public static const JOIN_ROUND:String = "round";
        public static const JOIN_BEVEL:String = "bevel";
        public static const CAP_BUTT:String = "none";
        public static const CAP_ROUND:String = "round";
        public static const CAP_SQUARE:String = "square";

        public function ShapeObject() : void
        {
            this.lineWidth = 1;
            this.lineStyle = SOLID;
            this.lineColor = 0;
            this.lineAlpha = 1;
            this.fillColor = 0;
            this.fillAlpha = 1;
            this.lineRange = this.RANGE_SMALL_LIMIT;
            this.linePixelHinting = false;
            this.lineCaps = CapsStyle.ROUND;
            this.lineJoints = JointStyle.ROUND;
            this.useDrawHelper = false;
            return;
        }// end function

        public function getAlpha() : Number
        {
            return this.lineAlpha;
        }// end function

        public function getCap() : String
        {
            return this.lineCaps;
        }// end function

        public function getColor() : uint
        {
            return this.lineColor;
        }// end function

        public function getFillAlpha() : Number
        {
            return this.fillAlpha;
        }// end function

        public function getFillColor() : uint
        {
            return this.fillColor;
        }// end function

        public function getJoin() : String
        {
            return this.lineJoints;
        }// end function

        public function getRange() : Number
        {
            return this.lineRange;
        }// end function

        public function getStyle() : int
        {
            return this.lineStyle;
        }// end function

        public function getWidth() : int
        {
            return this.lineWidth;
        }// end function

        public function setAlpha(param1:Number) : void
        {
            this.lineAlpha = param1;
            return;
        }// end function

        public function setCap(param1:String) : void
        {
            this.lineCaps = param1;
            return;
        }// end function

        public function setColor(param1:uint) : void
        {
            this.lineColor = param1;
            return;
        }// end function

        public function setFillAlpha(param1:Number) : void
        {
            this.fillAlpha = param1;
            return;
        }// end function

        public function setFillColor(param1:uint) : void
        {
            this.fillColor = param1;
            return;
        }// end function

        public function SetJoin(param1:String) : void
        {
            this.lineJoints = param1;
            return;
        }// end function

        public function setRange(param1:Number) : void
        {
            this.lineRange = param1;
            if (this.lineRange < this.RANGE_SMALL_LIMIT)
            {
                this.lineRange = param1;
            }
            return;
        }// end function

        public function setStyle(param1:int) : void
        {
            this.lineStyle = param1;
            return;
        }// end function

        public function setWidth(param1:int) : void
        {
            this.lineWidth = param1;
            return;
        }// end function

        protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            return;
        }// end function

        protected function drawShapeSolidHelper(param1:GraphicsHelper, param2:Boolean, param3:Boolean) : void
        {
            return;
        }// end function

        protected function getShapePath() : Array
        {
            return null;
        }// end function

        final protected function getArcNotch(param1:Number, param2:Number) : Number
        {
            return param1 * this.PATH_NOTCHI_ARC * (Math.abs(param2) / 360);
        }// end function

        final protected function dashedLineStyle(param1:Graphics) : void
        {
            param1.lineStyle(this.lineWidth, this.lineColor, this.lineAlpha, this.linePixelHinting, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.BEVEL);
            return;
        }// end function

        final protected function drawAction(param1:Graphics, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = true;
            switch(this.lineStyle)
            {
                case DOT:
                case DASH:
                case DASHDOT:
                case DASHDOTDOT:
                case FINEDOT:
                {
                    _loc_3 = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 != null)
            {
                _loc_4 = param1;
            }
            else
            {
                _loc_4 = this.graphics;
                _loc_4.clear();
            }
            var _loc_5:* = null;
            if (this.useDrawHelper)
            {
                _loc_5 = new GraphicsHelper(_loc_4);
            }
            if (this.useDrawHelper)
            {
                _loc_5.endFill();
                _loc_5.lineStyle(Number.NaN);
            }
            _loc_4.endFill();
            _loc_4.lineStyle(Number.NaN);
            if (param2 || _loc_3)
            {
                if (_loc_3)
                {
                    if (this.useDrawHelper)
                    {
                        this.solidLineStyleHelper(_loc_5);
                    }
                    else
                    {
                        this.solidLineStyle(_loc_4);
                    }
                }
                if (param2)
                {
                    if (this.useDrawHelper)
                    {
                        _loc_5.beginFill(this.fillColor, this.fillAlpha);
                    }
                    else
                    {
                        _loc_4.beginFill(this.fillColor, this.fillAlpha);
                    }
                }
                if (this.useDrawHelper)
                {
                    this.drawShapeSolidHelper(_loc_5, param2, _loc_3);
                    _loc_5.endFill();
                }
                else
                {
                    this.drawShapeSolid(_loc_4, param2, _loc_3);
                    _loc_4.endFill();
                }
                _loc_4.endFill();
            }
            if (!_loc_3 && this.lineWidth >= 0)
            {
                _loc_6 = this.getShapePath();
                _loc_7 = this.dashedLines(_loc_6, this.lineStyle);
                _loc_8 = _loc_7[1].valueOf();
                _loc_9 = _loc_7[0].valueOf();
                this.dashedLineStyle(_loc_4);
                _loc_4.drawPath(_loc_9, _loc_8);
            }
            _loc_4.lineStyle(Number.NaN);
            return;
        }// end function

        final protected function setShapePointArc(param1:Point, param2:Number, param3:Number, param4:Number, param5:Array) : void
        {
            if (param5 == null)
            {
                param5 = new Array();
            }
            var _loc_6:* = this.getArcNotch(param2, param4);
            var _loc_7:* = GraphicsHelper.getArcPoints(param1.x, param1.y, param2, param4, param3, _loc_6);
            var _loc_8:* = false;
            if (param5.length > 0)
            {
                if (_loc_7.length > 0)
                {
                    _loc_8 = Point(param5[(param5.length - 1)]).equals(Point(_loc_7[0]));
                }
            }
            var _loc_9:* = 0;
            while (_loc_9 < _loc_7.length)
            {
                
                if (!_loc_8 || _loc_9 > 0)
                {
                    param5.push(Point(_loc_7[_loc_9]).clone());
                }
                _loc_9++;
            }
            return;
        }// end function

        final protected function setShapePointStraight(param1:Point, param2:Point, param3:Array) : void
        {
            if (param3 == null)
            {
                param3 = new Array();
            }
            var _loc_4:* = false;
            if (param3.length > 0)
            {
                _loc_4 = Point(param3[(param3.length - 1)]).equals(param1);
            }
            var _loc_5:* = Point.distance(param1, param2);
            if (Point.distance(param1, param2) < this.PATH_NOTCHI_STRAIGHT)
            {
                if (!_loc_4)
                {
                    param3.push(param1.clone());
                }
                if (!param1.equals(param2))
                {
                    param3.push(param2.clone());
                }
                return;
            }
            var _loc_6:* = this.PATH_NOTCHI_STRAIGHT / _loc_5;
            var _loc_7:* = 1;
            while (_loc_7 > 0)
            {
                
                if (!_loc_4 || _loc_7 < 1)
                {
                    param3.push(Point.interpolate(param1, param2, _loc_7));
                }
                _loc_7 = _loc_7 - _loc_6;
            }
            var _loc_8:* = false;
            if (param3.length > 0)
            {
                _loc_8 = Point(param3[(param3.length - 1)]).equals(param2);
            }
            if (!_loc_8)
            {
                param3.push(param2.clone());
            }
            return;
        }// end function

        final protected function solidLineStyle(param1:Graphics) : void
        {
            var _loc_2:* = this.lineWidth;
            if (this.lineWidth < 0)
            {
                _loc_2 = Number.NaN;
            }
            param1.lineStyle(_loc_2, this.lineColor, this.lineAlpha, this.linePixelHinting, LineScaleMode.NORMAL, this.lineCaps, this.lineJoints);
            return;
        }// end function

        final protected function solidLineStyleHelper(param1:GraphicsHelper) : void
        {
            var _loc_2:* = this.lineWidth;
            if (this.lineWidth < 0)
            {
                _loc_2 = Number.NaN;
            }
            param1.lineStyle(_loc_2, this.lineColor, this.lineAlpha, this.linePixelHinting, LineScaleMode.NORMAL, this.lineCaps, this.lineJoints);
            return;
        }// end function

        private function dashedLines(param1:Array, param2:int) : Array
        {
            var _loc_3:* = new Array(2);
            var _loc_4:* = new Vector.<Number>;
            var _loc_5:* = new Vector.<int>;
            var _loc_6:* = 0;
            while (_loc_6 < param1.length)
            {
                
                _loc_4.push(this.Point(param1[_loc_6]).x.valueOf(), this.Point(param1[_loc_6]).y.valueOf());
                switch(param2)
                {
                    case DOT:
                    {
                        if (_loc_6 % 8 == 0 || _loc_6 % 8 >= 5)
                        {
                            _loc_5.push(1);
                        }
                        else
                        {
                            _loc_5.push(2);
                        }
                        break;
                    }
                    case DASH:
                    {
                        if (_loc_6 % 16 == 0 || _loc_6 % 16 >= 13)
                        {
                            _loc_5.push(1);
                        }
                        else
                        {
                            _loc_5.push(2);
                        }
                        break;
                    }
                    case DASHDOT:
                    {
                        if (_loc_6 % 16 == 0 || _loc_6 % 16 >= 13 || _loc_6 % 16 >= 7 && _loc_6 % 16 <= 10)
                        {
                            _loc_5.push(1);
                        }
                        else
                        {
                            _loc_5.push(2);
                        }
                        break;
                    }
                    case DASHDOTDOT:
                    {
                        if (_loc_6 % 16 == 0 || _loc_6 % 16 == 15 || _loc_6 % 16 >= 7 && _loc_6 % 16 <= 9 || _loc_6 % 16 >= 11 && _loc_6 % 16 <= 13)
                        {
                            _loc_5.push(1);
                        }
                        else
                        {
                            _loc_5.push(2);
                        }
                        break;
                    }
                    case FINEDOT:
                    {
                        if (_loc_6 % 4 == 0 || _loc_6 % 4 == 3)
                        {
                            _loc_5.push(1);
                        }
                        else
                        {
                            _loc_5.push(2);
                        }
                        break;
                    }
                    default:
                    {
                        _loc_5.push(2);
                        break;
                        break;
                    }
                }
                _loc_6++;
            }
            _loc_3[0] = _loc_5;
            _loc_3[1] = _loc_4;
            return _loc_3;
        }// end function

    }
}
