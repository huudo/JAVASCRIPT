package phcomm
{
    import flash.display.*;
    import flash.geom.*;

    public class PointObject extends ShapeObject
    {
        private var dPt:Point;
        private var dSize:int;
        public static const SIZE_01:int = 1;
        public static const SIZE_03:int = 2;
        public static const SIZE_05:int = 3;
        public static const SIZE_07:int = 4;
        public static const SIZE_09:int = 5;
        public static const SIZE_11:int = 6;
        public static const SIZE_13:int = 7;

        public function PointObject(... args) : void
        {
            this.dPt = null;
            if (args.length >= 1)
            {
                if (args[0] is Point)
                {
                    this.dPt = Point(args[0]).clone();
                }
                else if (args.length >= 2)
                {
                    this.dPt = new Point(Number(args[0]), Number(args[1]));
                }
            }
            else
            {
                this.dPt = new Point(0, 0);
            }
            if (this.dPt == null)
            {
                throw new ArgumentError("パラメータの指定が正しくありません. PointObject.PointObject");
            }
            this.dSize = SIZE_01;
            return;
        }// end function

        public function calcPoint(param1:Number, param2:Number, param3:Number = NaN, param4:Number = NaN, param5:Point = null) : Point
        {
            var _loc_6:* = new Point();
            var _loc_7:* = new Point();
            if (param5 != null)
            {
                _loc_7 = param5.clone();
            }
            else if (!isNaN(param3) && !isNaN(param4))
            {
                _loc_7 = new Point(param3, param4);
            }
            else
            {
                _loc_7 = this.dPt.clone();
            }
            if (param2 > Math.PI || param2 < -Math.PI)
            {
                param2 = ComOther.roundRad(param2);
            }
            _loc_6 = _loc_7.add(Point.polar(param1, param2));
            return _loc_6;
        }// end function

        public function contain(param1:Number, param2:Number) : Boolean
        {
            return this.containPoint(new Point(param1, param2));
        }// end function

        public function containPoint(param1:Point) : Boolean
        {
            var _loc_2:* = this.getPointRadius();
            if (_loc_2 < 3.5)
            {
                _loc_2 = 3.5;
            }
            return Point.distance(this.dPt, param1) <= _loc_2;
        }// end function

        public function draw(param1:Graphics) : void
        {
            this.lineWidth = int.MIN_VALUE;
            this.lineStyle = ShapeObject.SOLID;
            this.fillColor = this.lineColor;
            this.fillAlpha = this.lineAlpha;
            this.drawAction(param1, true);
            return;
        }// end function

        public function getAngle(param1:Number, param2:Number, param3:Number = NaN, param4:Number = NaN) : Number
        {
            var _loc_5:* = new Point(param1, param2);
            var _loc_6:* = null;
            if (!isNaN(param3) && !isNaN(param4))
            {
                _loc_6 = new Point(param3, param4);
            }
            return this.getAnglePoint(_loc_5, _loc_6);
        }// end function

        public function getAnglePoint(param1:Point, param2:Point = null) : Number
        {
            var _loc_3:* = 0;
            if (param2 == null)
            {
                param2 = this.dPt;
            }
            var _loc_4:* = param1.subtract(param2);
            if (Math.abs(_loc_4.x) < 1 && Math.abs(_loc_4.y) < 1)
            {
                return _loc_3;
            }
            _loc_3 = Math.atan2(_loc_4.y, _loc_4.x);
            return _loc_3;
        }// end function

        public function getAngleBetweenLines(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = NaN, param6:Number = NaN) : Number
        {
            var _loc_7:* = null;
            if (!isNaN(param5) && !isNaN(param6))
            {
                _loc_7 = new Point(param5, param6);
            }
            return this.getAngleBetweenLinesPoint(new Point(param1, param2), new Point(param3, param4), _loc_7);
        }// end function

        public function getAngleBetweenLinesPoint(param1:Point, param2:Point, param3:Point = null) : Number
        {
            var _loc_4:* = this.getAnglePoint(param1, param3);
            var _loc_5:* = this.getAnglePoint(param2, param3);
            var _loc_6:* = Math.abs(_loc_4 - _loc_5);
            if (Math.abs(_loc_4 - _loc_5) > Math.PI)
            {
                _loc_6 = 2 * Math.PI - _loc_6;
            }
            return _loc_6;
        }// end function

        public function getDistance(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = Point.distance(this.dPt, new Point(param1, param2));
            return _loc_3;
        }// end function

        public function getDistancePoint(param1:Point) : Number
        {
            var _loc_2:* = Point.distance(this.dPt, param1);
            return _loc_2;
        }// end function

        public function getIntercept(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = 0;
            var _loc_4:* = this.getSlope(param1, param2);
            if (!isFinite(_loc_4))
            {
                return 0;
            }
            _loc_3 = this.dPt.y - _loc_4 * this.dPt.x;
            return _loc_3;
        }// end function

        public function getInterceptPoint(param1:Point) : Number
        {
            return this.getIntercept(param1.x, param1.y);
        }// end function

        public function getLocation() : Point
        {
            return this.dPt.clone();
        }// end function

        public function getSlope(param1:Number, param2:Number) : Number
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1 - this.dPt.x;
            var _loc_5:* = param2 - this.dPt.y;
            if (Math.abs(_loc_4) < 1e-009)
            {
                _loc_4 = 0;
            }
            if (Math.abs(_loc_5) < 1e-009)
            {
                _loc_5 = 0;
            }
            _loc_3 = _loc_5 / _loc_4;
            return _loc_3;
        }// end function

        public function getSlopePoint(param1:Point) : Number
        {
            return this.getSlope(param1.x, param1.y);
        }// end function

        public function getTurnPoint(param1:Point, param2:Number) : Point
        {
            var _loc_3:* = new Point();
            var _loc_4:* = param1.subtract(this.dPt);
            _loc_3.x = _loc_4.x * Math.cos(param2) - _loc_4.y * Math.sin(param2) + this.dPt.x;
            _loc_3.y = _loc_4.x * Math.sin(param2) + _loc_4.y * Math.cos(param2) + this.dPt.y;
            return _loc_3;
        }// end function

        public function setLocation(param1:Number, param2:Number) : void
        {
            this.dPt = new Point(param1, param2);
            this.x = this.dPt.x;
            this.y = this.dPt.y;
            return;
        }// end function

        public function setLocationPoint(param1:Point) : void
        {
            this.dPt = param1.clone();
            this.x = this.dPt.x;
            this.y = this.dPt.y;
            return;
        }// end function

        public function setSize(param1:int) : void
        {
            this.dSize = param1;
            return;
        }// end function

        public function turnPoint(param1:Number, param2:Number, param3:Number) : Point
        {
            return this.getTurnPoint(new Point(param1, param2), param3);
        }// end function

        override protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = this.getPointRadius();
            param1.drawCircle(this.dPt.x, this.dPt.y, _loc_4);
            return;
        }// end function

        private function getPointRadius() : Number
        {
            switch(this.dSize)
            {
                case SIZE_03:
                {
                    return 1.5;
                }
                case SIZE_05:
                {
                    return 2.5;
                }
                case SIZE_07:
                {
                    return 3.5;
                }
                case SIZE_09:
                {
                    return 4.5;
                }
                case SIZE_11:
                {
                    return 5.5;
                }
                case SIZE_13:
                {
                    return 6.5;
                }
                default:
                {
                    return 0.5;
                    break;
                }
            }
        }// end function

    }
}
