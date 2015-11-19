package phcomm
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;

    public class CircleObject extends ShapeObject
    {
        private var dCenterP:Point;
        private var dRadius:Number;
        private var dFill:Boolean;
        public static const SOLID:int = 1;
        public static const DOT:int = 2;
        public static const DASH:int = 3;
        public static const DASHDOT:int = 4;
        public static const DASHDOTDOT:int = 5;
        public static const FINEDOT:int = 6;

        public function CircleObject(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this.dCenterP = new Point(param1, param2);
            this.dRadius = param3;
            return;
        }// end function

        public function contains(param1:Number, param2:Number) : Boolean
        {
            return this.containsPoint(new Point(param1, param2));
        }// end function

        public function containsPoint(param1:Point) : Boolean
        {
            var _loc_2:* = Point.distance(param1, this.dCenterP);
            return _loc_2 <= this.dRadius;
        }// end function

        public function containsOnLine(param1:Number, param2:Number) : Boolean
        {
            return this.containsOnLinePoint(new Point(param1, param2));
        }// end function

        public function containsOnLinePoint(param1:Point) : Boolean
        {
            var _loc_2:* = Point.distance(param1, this.dCenterP);
            return Math.abs(_loc_2 - this.dRadius) <= this.lineRange;
        }// end function

        public function getLocation() : Point
        {
            return this.dCenterP.clone();
        }// end function

        public function getCross(param1:Number, param2:Number, param3:Number) : Vector.<Point>
        {
            return this.getCrossPoint(new Point(param1, param2), param3);
        }// end function

        public function getCrossPoint(param1:Point, param2:Number) : Vector.<Point>
        {
            var _loc_8:* = NaN;
            var _loc_3:* = new Vector.<Point>(1, true);
            _loc_3[0] = new Point(Number.NaN, Number.NaN);
            var _loc_4:* = Point.distance(param1, this.dCenterP);
            if (Point.distance(param1, this.dCenterP) > this.dRadius + param2)
            {
                return _loc_3;
            }
            if (_loc_4 + this.dRadius < param2 || _loc_4 + param2 < this.dRadius)
            {
                return _loc_3;
            }
            var _loc_5:* = new Vector.<Point>(2, false);
            var _loc_6:* = new PointObject();
            _loc_6.setLocationPoint(this.dCenterP);
            var _loc_7:* = _loc_4 * _loc_4 + this.dRadius * this.dRadius - param2 * param2;
            _loc_7 = (_loc_4 * _loc_4 + this.dRadius * this.dRadius - param2 * param2) / (2 * _loc_4 * this.dRadius);
            if (_loc_7 == -1)
            {
                _loc_8 = Math.PI;
            }
            else if (_loc_7 == 1)
            {
                _loc_8 = 0;
            }
            else
            {
                _loc_8 = Math.acos(_loc_7);
            }
            _loc_5[0] = _loc_6.calcPoint(this.dRadius, _loc_6.getAnglePoint(param1) + _loc_8);
            _loc_5[1] = _loc_6.calcPoint(this.dRadius, _loc_6.getAnglePoint(param1) - _loc_8);
            if (_loc_5[0].x == _loc_5[1].x && _loc_5[0].y == _loc_5[1].y)
            {
                _loc_5.pop();
            }
            _loc_5.fixed = true;
            return _loc_5;
        }// end function

        public function getCrossCircle(param1:CircleObject) : Vector.<Point>
        {
            return this.getCrossPoint(param1.getLocation(), param1.getRadius());
        }// end function

        public function getRadius() : Number
        {
            return this.dRadius;
        }// end function

        public function draw(param1:Graphics = null) : void
        {
            this.drawAction(param1, this.dFill);
            return;
        }// end function

        public function setFill(param1:Boolean) : void
        {
            this.dFill = param1;
            return;
        }// end function

        public function setLocation(param1:Number, param2:Number) : void
        {
            this.dCenterP.x = param1;
            this.dCenterP.y = param2;
            return;
        }// end function

        public function setLocationPoint(param1:Point) : void
        {
            this.dCenterP.x = param1.x;
            this.dCenterP.y = param1.y;
            return;
        }// end function

        public function setRect(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.dRadius = (param3 - param1) / 2;
            this.dCenterP.x = param1 + this.dRadius;
            this.dCenterP.y = param2 + this.dRadius;
            return;
        }// end function

        public function setRadius(param1:Number) : void
        {
            this.dRadius = param1;
            return;
        }// end function

        override protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            if (this.dRadius <= 0)
            {
                return;
            }
            param1.drawCircle(this.dCenterP.x, this.dCenterP.y, this.dRadius);
            return;
        }// end function

        override protected function getShapePath() : Array
        {
            if (this.dRadius <= 0)
            {
                return new Array();
            }
            var _loc_1:* = new Array();
            this.setShapePointArc(this.dCenterP, this.dRadius, 0, 360, _loc_1);
            return _loc_1;
        }// end function

    }
}
