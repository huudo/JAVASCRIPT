package phcomm
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;

    public class PolygonObject extends ShapeObject
    {
        private var dPoints:Vector.<Point>;
        private var dRect:Rectangle;
        private var dArea:Shape;
        private var dAreaData:BitmapData;
        private var dDrawSize:int;
        private var dDrawClose:Boolean;
        public static const SOLID:int = 1;
        public static const DOT:int = 2;
        public static const DASH:int = 3;
        public static const DASHDOT:int = 4;
        public static const DASHDOTDOT:int = 5;
        public static const FINEDOT:int = 6;
        public static const JOIN_MITER:String = "miter";
        public static const JOIN_ROUND:String = "round";
        public static const JOIN_BEVEL:String = "bevel";

        public function PolygonObject(param1:Object = null, param2:int = 0) : void
        {
            this.dPoints = new Vector.<Point>;
            this.dPoints.fixed = false;
            this.dRect = new Rectangle();
            this.dArea = null;
            this.dAreaData = null;
            this.dDrawSize = 0;
            this.dDrawClose = true;
            this.lineJoints = JOIN_MITER;
            if (param1 != null)
            {
                this.add(param1, param2);
            }
            return;
        }// end function

        public function add(param1:Object, param2:int, param3:int = 0) : void
        {
            var _loc_8:* = 0;
            this.clear();
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = int.MIN_VALUE;
            if (param1 != null)
            {
                if (param1 is Vector.<Point>)
                {
                    _loc_4 = this.Vector.<Point>(param1);
                    _loc_6 = _loc_4.length;
                }
                else if (param1 is Array)
                {
                    _loc_5 = param1 as Array;
                    _loc_6 = _loc_5.length;
                }
            }
            if (_loc_4 == null && _loc_5 == null)
            {
                return;
            }
            if (param3 < 0)
            {
                return;
            }
            if (param3 >= _loc_6)
            {
                return;
            }
            if (param2 <= 0)
            {
                return;
            }
            var _loc_7:* = param2 + param3;
            if (param2 + param3 > _loc_6)
            {
                _loc_7 = _loc_6;
            }
            _loc_8 = param3;
            while (_loc_8 < _loc_7)
            {
                
                if (_loc_4 != null)
                {
                    this.dPoints.push(_loc_4[_loc_8].clone());
                }
                else
                {
                    this.dPoints.push(Point(_loc_5[_loc_8]).clone());
                }
                _loc_8++;
            }
            if (this.dPoints.length > 0)
            {
                this.setRect();
            }
            return;
        }// end function

        public function addPoint(param1, param2:Number = NaN) : void
        {
            var _loc_4:* = NaN;
            var _loc_3:* = null;
            if (param1 is Point)
            {
                _loc_3 = Point(param1).clone();
            }
            else
            {
                _loc_4 = Number(param1);
                if (!isNaN(_loc_4) && !isNaN(param2))
                {
                    _loc_3 = new Point(_loc_4, param2);
                }
            }
            if (_loc_3 == null)
            {
                return;
            }
            this.dPoints.push(_loc_3);
            this.setRect();
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            if (this.dPoints.length > 0)
            {
                _loc_1 = 0;
                while (_loc_1 < this.dPoints.length)
                {
                    
                    this.dPoints[_loc_1] = null;
                    _loc_1++;
                }
                this.dPoints = new Vector.<Point>;
                this.dPoints.fixed = false;
            }
            this.dRect.setEmpty();
            this.dArea = null;
            if (this.dAreaData != null)
            {
                this.dAreaData.dispose();
                this.dAreaData = null;
            }
            return;
        }// end function

        public function contains(param1:Number, param2:Number) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this.dPoints.length < 3)
            {
                return false;
            }
            if (!this.dRect.contains(param1, param2))
            {
                return false;
            }
            if (this.dArea == null)
            {
                this.dArea = new Shape();
                this.dArea.x = 0;
                this.dArea.y = 0;
                _loc_4 = this.dArea.graphics;
                _loc_4.clear();
                _loc_4.lineStyle(1, 16777215);
                _loc_4.beginFill(16777215);
                _loc_4.moveTo(this.dPoints[0].x - this.dRect.x, this.dPoints[0].y - this.dRect.y);
                _loc_5 = 1;
                while (_loc_5 < this.dPoints.length)
                {
                    
                    _loc_4.lineTo(this.dPoints[_loc_5].x - this.dRect.x, this.dPoints[_loc_5].y - this.dRect.y);
                    _loc_5++;
                }
                _loc_4.lineTo(this.dPoints[0].x - this.dRect.x, this.dPoints[0].y - this.dRect.y);
                _loc_4.endFill();
            }
            var _loc_3:* = false;
            if (this.parent != null)
            {
                this.parent.addChild(this.dArea);
                _loc_6 = this.parent.localToGlobal(new Point(param1, param2));
                _loc_3 = this.dArea.hitTestPoint(_loc_6.x, _loc_6.y);
                this.parent.removeChild(this.dArea);
            }
            else
            {
                _loc_7 = int(Math.round(param1 - this.dRect.x));
                _loc_8 = int(Math.round(param2 - this.dRect.y));
                if (this.dAreaData == null)
                {
                    this.dAreaData = new BitmapData(this.dArea.width, this.dArea.height, false, 0);
                    this.dAreaData.draw(this.dArea);
                }
                if (_loc_7 >= 0 && _loc_7 < this.dAreaData.width)
                {
                    if (_loc_8 >= 0 && _loc_8 < this.dAreaData.height)
                    {
                        _loc_3 = this.dAreaData.getPixel(_loc_7, _loc_8) != 0;
                    }
                }
            }
            return _loc_3;
        }// end function

        public function createPath(param1:Boolean = true) : GraphicsPath
        {
            var _loc_2:* = new GraphicsPath();
            var _loc_3:* = 0;
            while (_loc_3 < this.dPoints.length)
            {
                
                _loc_2.lineTo(this.dPoints[_loc_3].x, this.dPoints[_loc_3].y);
                _loc_3++;
            }
            if (param1)
            {
                _loc_2.lineTo(this.dPoints[0].x, this.dPoints[0].y);
            }
            return _loc_2;
        }// end function

        public function draw(param1:Graphics, param2:Boolean = true, param3:int = -1) : void
        {
            this.dDrawSize = param3;
            if (this.dDrawSize < 0)
            {
                this.dDrawSize = this.dPoints.length;
            }
            if (this.dDrawSize < 2 || this.dDrawSize > this.dPoints.length)
            {
                return;
            }
            this.dDrawClose = param2;
            this.drawAction(param1, false);
            return;
        }// end function

        public function fill(param1:Graphics) : void
        {
            this.dDrawSize = this.dPoints.length;
            this.dDrawClose = true;
            this.drawAction(param1, true);
            return;
        }// end function

        public function getPoint(param1:int) : Point
        {
            if (param1 >= 0 && param1 < this.dPoints.length)
            {
                return this.dPoints[param1].clone();
            }
            return new Point(Number.NaN, Number.NaN);
        }// end function

        public function getSize() : int
        {
            return this.dPoints.length;
        }// end function

        public function remove(param1:int) : void
        {
            if (param1 >= 0 && param1 < this.dPoints.length)
            {
                this.dPoints.splice(param1, 1);
                this.setRect();
            }
            return;
        }// end function

        public function setElementAt(... args) : void
        {
            var _loc_5:* = null;
            args = Number.NaN;
            var _loc_3:* = Number.NaN;
            var _loc_4:* = int.MIN_VALUE;
            if (args.length >= 2)
            {
                if (args[0] is Point && args[1] is int)
                {
                    _loc_5 = Point(args[0]);
                    args = _loc_5.x;
                    _loc_3 = _loc_5.y;
                    _loc_4 = int(args[1]);
                }
            }
            if (_loc_4 == int.MIN_VALUE)
            {
                if (args.length >= 3)
                {
                    args = Number(args[0]);
                    _loc_3 = Number(args[1]);
                    _loc_4 = int(args[2]);
                }
            }
            if (!isNaN(args) && !isNaN(_loc_3) && _loc_3 >= 0 && _loc_3 < this.dPoints.length)
            {
                this.dPoints[_loc_4].x = args;
                this.dPoints[_loc_4].y = _loc_3;
                this.setRect();
            }
            return;
        }// end function

        public function scalePoints(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this.dPoints.length)
            {
                
                this.dPoints[_loc_3].x = this.dPoints[_loc_3].x * param1;
                this.dPoints[_loc_3].y = this.dPoints[_loc_3].y * param2;
                _loc_3++;
            }
            var _loc_4:* = this.dRect.x;
            var _loc_5:* = this.dRect.x + this.dRect.width;
            var _loc_6:* = this.dRect.y;
            var _loc_7:* = this.dRect.y + this.dRect.height;
            _loc_4 = _loc_4 * param1;
            _loc_5 = _loc_5 * param1;
            _loc_6 = _loc_6 * param2;
            _loc_7 = _loc_7 * param2;
            this.dRect.x = _loc_4;
            this.dRect.y = _loc_6;
            this.dRect.width = _loc_5 - _loc_4;
            this.dRect.height = _loc_7 - _loc_6;
            this.dArea = null;
            if (this.dAreaData != null)
            {
                this.dAreaData.dispose();
                this.dAreaData = null;
            }
            return;
        }// end function

        public function translatePoints(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this.dPoints.length)
            {
                
                this.dPoints[_loc_3].x = this.dPoints[_loc_3].x + param1;
                this.dPoints[_loc_3].y = this.dPoints[_loc_3].y + param2;
                _loc_3++;
            }
            this.dRect.x = this.dRect.x + param1;
            this.dRect.y = this.dRect.y + param2;
            return;
        }// end function

        override protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            if (this.dDrawSize < 2)
            {
                return;
            }
            param1.moveTo(this.dPoints[0].x, this.dPoints[0].y);
            var _loc_4:* = 1;
            while (_loc_4 < this.dDrawSize)
            {
                
                param1.lineTo(this.dPoints[_loc_4].x, this.dPoints[_loc_4].y);
                _loc_4++;
            }
            if (this.dDrawClose)
            {
                param1.lineTo(this.dPoints[0].x, this.dPoints[0].y);
            }
            return;
        }// end function

        override protected function getShapePath() : Array
        {
            var _loc_1:* = new Array();
            if (this.dDrawSize < 2)
            {
                return _loc_1;
            }
            var _loc_2:* = 1;
            while (_loc_2 < this.dDrawSize)
            {
                
                this.setShapePointStraight(this.dPoints[(_loc_2 - 1)], this.dPoints[_loc_2], _loc_1);
                _loc_2++;
            }
            if (this.dDrawClose)
            {
                this.setShapePointStraight(this.dPoints[(this.dDrawSize - 1)], this.dPoints[0], _loc_1);
            }
            return _loc_1;
        }// end function

        private function setRect() : void
        {
            var _loc_1:* = 0;
            this.dRect.setEmpty();
            if (this.dPoints.length > 0)
            {
                this.dRect.x = this.dPoints[0].x;
                this.dRect.y = this.dPoints[0].y;
                this.dRect.width = this.dPoints[0].x;
                this.dRect.height = this.dPoints[0].y;
                _loc_1 = 1;
                while (_loc_1 < this.dPoints.length)
                {
                    
                    if (this.dRect.x > this.dPoints[_loc_1].x)
                    {
                        this.dRect.x = this.dPoints[_loc_1].x;
                    }
                    if (this.dRect.width < this.dPoints[_loc_1].x)
                    {
                        this.dRect.width = this.dPoints[_loc_1].x;
                    }
                    if (this.dRect.y > this.dPoints[_loc_1].y)
                    {
                        this.dRect.y = this.dPoints[_loc_1].y;
                    }
                    if (this.dRect.height < this.dPoints[_loc_1].y)
                    {
                        this.dRect.height = this.dPoints[_loc_1].y;
                    }
                    _loc_1++;
                }
                this.dRect.width = this.dRect.width - this.dRect.x;
                this.dRect.height = this.dRect.height - this.dRect.y;
            }
            this.dArea = null;
            if (this.dAreaData != null)
            {
                this.dAreaData.dispose();
                this.dAreaData = null;
            }
            return;
        }// end function

    }
}
