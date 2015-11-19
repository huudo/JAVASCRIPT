package phcomm
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import phcomm.clipstage.*;

    public class LineObject extends ShapeObject
    {
        private var dSP:PointObject;
        private var dEP:PointObject;
        private var dDrawBox:Boolean;
        private var dSlowLine:SlowLineObject;
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
        public static const CROSS_NORMAL:int = 0;
        public static const CROSS_POINT_1S:int = 1;
        public static const CROSS_POINT_1E:int = 2;
        public static const CROSS_POINT_2S:int = 3;
        public static const CROSS_POINT_2E:int = 4;
        public static const SAME_POINT:int = 10;
        public static const SAME_POINT_SS:int = 11;
        public static const SAME_POINT_SE:int = 12;
        public static const SAME_POINT_ES:int = 13;
        public static const SAME_POINT_EE:int = 14;
        public static const NOT_CROSS:int = -1;
        public static const LINE_ON:int = -10;
        public static const LINE_INNER1:int = -11;
        public static const LINE_INNER2:int = -12;
        public static const LINE_EQUALS:int = -20;

        public function LineObject(... args) : void
        {
            this.dSP = null;
            this.dEP = null;
            if (args.length >= 2)
            {
                if (args[0] is Point && args[1] is Point)
                {
                    this.dSP = new PointObject(Point(args[0]));
                    this.dEP = new PointObject(Point(args[1]));
                }
                else if (args.length >= 4)
                {
                    this.dSP = new PointObject(Number(args[0]), Number(args[1]));
                    this.dEP = new PointObject(Number(args[2]), Number(args[3]));
                }
            }
            else if (args.length < 1)
            {
                this.dSP = new PointObject();
                this.dEP = new PointObject();
            }
            if (this.dSP == null || this.dEP == null)
            {
                throw new ArgumentError("パラメータの指定が正しくありません. LineObject.LineObject");
            }
            this.dSlowLine = null;
            this.dDrawBox = false;
            return;
        }// end function

        public function checkCross(... args) : int
        {
            args = NOT_CROSS;
            if (args.length >= 1)
            {
                if (args[0] is LineObject)
                {
                    args = this.checkCrossDetail(LineObject(args[0]));
                }
                else if (args.length >= 2)
                {
                    if (args[0] is Point && args[1] is Point)
                    {
                        args = this.checkCrossDetail(Point(args[0]), Point(args[1]));
                    }
                }
            }
            if (args <= LINE_ON)
            {
                return LINE_ON;
            }
            if (args >= SAME_POINT)
            {
                return SAME_POINT;
            }
            if (args >= CROSS_NORMAL && args < SAME_POINT)
            {
                return CROSS_NORMAL;
            }
            return args;
        }// end function

        public function checkCrossDetail(... args) : int
        {
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_19:* = null;
            args = 0.1;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (args.length >= 1)
            {
                if (args[0] is LineObject)
                {
                    _loc_3 = new Vector.<Point>(2, true);
                    _loc_4 = new Vector.<Point>(2, true);
                    _loc_19 = LineObject(args[0]);
                    _loc_3[1] = _loc_19.getStartLocation();
                    _loc_4[1] = _loc_19.getEndLocation();
                    if (args.length >= 2)
                    {
                        if (!isNaN(Number(args[1])))
                        {
                            args = Number(args[1]);
                        }
                    }
                }
                else if (args.length >= 2)
                {
                    if (args[0] is Point && args[1] is Point)
                    {
                        _loc_3 = new Vector.<Point>(2, true);
                        _loc_4 = new Vector.<Point>(2, true);
                        _loc_3[1] = Point(args[0]).clone();
                        _loc_4[1] = Point(args[1]).clone();
                        if (args.length >= 3)
                        {
                            if (!isNaN(Number(args[2])))
                            {
                                args = Number(args[2]);
                            }
                        }
                    }
                }
            }
            if (_loc_3 == null || _loc_4 == null)
            {
                throw new ArgumentError("指定された引数は使用できません。" + args.toString());
            }
            _loc_3[0] = this.getStartLocation();
            _loc_4[0] = this.getEndLocation();
            if (this.isSamePoint(_loc_3[0], _loc_3[1], args) && this.isSamePoint(_loc_4[0], _loc_4[1], args))
            {
                return LINE_EQUALS;
            }
            if (this.isSamePoint(_loc_3[0], _loc_4[1], args) && this.isSamePoint(_loc_4[0], _loc_3[1], args))
            {
                return LINE_EQUALS;
            }
            if (this.isSamePoint(_loc_3[1], _loc_4[1], args) && this.isSamePoint(_loc_3[0], _loc_3[1], args))
            {
                return LINE_INNER1;
            }
            if (this.isSamePoint(_loc_3[1], _loc_4[1], args) && this.isSamePoint(_loc_4[0], _loc_4[1], args))
            {
                return LINE_INNER1;
            }
            if (this.isSamePoint(_loc_3[0], _loc_4[0], args) && this.isSamePoint(_loc_3[0], _loc_3[1], args))
            {
                return LINE_INNER2;
            }
            if (this.isSamePoint(_loc_3[0], _loc_4[0], args) && this.isSamePoint(_loc_4[0], _loc_4[1], args))
            {
                return LINE_INNER2;
            }
            var _loc_5:* = new Vector.<Number>(2, true);
            var _loc_6:* = new Vector.<Number>(2, true);
            _loc_7 = 0;
            while (_loc_7 < 2)
            {
                
                _loc_8 = Math.abs(_loc_3[_loc_7].x - _loc_4[_loc_7].x);
                _loc_9 = Math.abs(_loc_3[_loc_7].y - _loc_4[_loc_7].y);
                if (_loc_9 < args)
                {
                    _loc_5[_loc_7] = 0;
                    _loc_6[_loc_7] = _loc_3[_loc_7].y;
                }
                else if (_loc_8 < args)
                {
                    _loc_5[_loc_7] = Number.NaN;
                    _loc_6[_loc_7] = Number.NaN;
                }
                else
                {
                    _loc_5[_loc_7] = (_loc_3[_loc_7].y - _loc_4[_loc_7].y) / (_loc_3[_loc_7].x - _loc_4[_loc_7].x);
                    _loc_6[_loc_7] = _loc_3[_loc_7].y - _loc_5[_loc_7] * _loc_3[_loc_7].x;
                }
                _loc_7++;
            }
            var _loc_10:* = new Vector.<Number>(2, true);
            var _loc_11:* = new Vector.<Number>(2, true);
            var _loc_12:* = new Vector.<Number>(2, true);
            var _loc_13:* = new Vector.<Number>(2, true);
            _loc_7 = 0;
            while (_loc_7 < 2)
            {
                
                _loc_10[_loc_7] = Math.max(_loc_3[_loc_7].x, _loc_4[_loc_7].x);
                _loc_11[_loc_7] = Math.min(_loc_3[_loc_7].x, _loc_4[_loc_7].x);
                _loc_12[_loc_7] = Math.max(_loc_3[_loc_7].y, _loc_4[_loc_7].y);
                _loc_13[_loc_7] = Math.min(_loc_3[_loc_7].y, _loc_4[_loc_7].y);
                _loc_7++;
            }
            if (isNaN(_loc_5[0]) && isNaN(_loc_5[1]))
            {
                _loc_8 = Math.abs(_loc_3[0].x - _loc_3[1].x);
                if (_loc_8 < args)
                {
                    if (_loc_3[1].y >= _loc_13[0] && _loc_3[1].y <= _loc_12[0] && _loc_4[1].y >= _loc_13[0] && _loc_4[1].y <= _loc_12[0])
                    {
                        return LINE_INNER1;
                    }
                    if (_loc_3[0].y >= _loc_13[1] && _loc_3[0].y <= _loc_12[1] && _loc_4[0].y >= _loc_13[1] && _loc_4[0].y <= _loc_12[1])
                    {
                        return LINE_INNER2;
                    }
                    if (_loc_3[1].y > _loc_13[0] && _loc_3[1].y < _loc_12[0])
                    {
                        return LINE_ON;
                    }
                    if (_loc_4[1].y > _loc_13[0] && _loc_4[1].y < _loc_12[0])
                    {
                        return LINE_ON;
                    }
                    if (this.isSamePoint(_loc_3[0], _loc_3[1], args))
                    {
                        return SAME_POINT_SS;
                    }
                    if (this.isSamePoint(_loc_3[0], _loc_4[1], args))
                    {
                        return SAME_POINT_SE;
                    }
                    if (this.isSamePoint(_loc_4[0], _loc_3[1], args))
                    {
                        return SAME_POINT_ES;
                    }
                    if (this.isSamePoint(_loc_4[0], _loc_4[1], args))
                    {
                        return SAME_POINT_EE;
                    }
                }
                return this.isCheckCrossTip(_loc_3[0], _loc_4[0], _loc_3[1], _loc_4[1], args);
            }
            if (_loc_5[0] == 0 && _loc_5[1] == 0)
            {
                _loc_9 = Math.abs(_loc_3[0].y - _loc_3[1].y);
                if (_loc_9 < args)
                {
                    if (_loc_3[1].x >= _loc_11[0] && _loc_3[1].x <= _loc_10[0] && _loc_4[1].x >= _loc_11[0] && _loc_4[1].x <= _loc_10[0])
                    {
                        return LINE_INNER1;
                    }
                    if (_loc_3[0].x >= _loc_11[1] && _loc_3[0].x <= _loc_10[1] && _loc_4[0].x >= _loc_11[1] && _loc_4[0].x <= _loc_10[1])
                    {
                        return LINE_INNER2;
                    }
                    if (_loc_3[1].x > _loc_11[0] && _loc_3[1].x < _loc_10[0])
                    {
                        return LINE_ON;
                    }
                    if (_loc_4[1].x > _loc_11[0] && _loc_4[1].x < _loc_10[0])
                    {
                        return LINE_ON;
                    }
                    if (this.isSamePoint(_loc_3[0], _loc_3[1], args))
                    {
                        return SAME_POINT_SS;
                    }
                    if (this.isSamePoint(_loc_3[0], _loc_4[1], args))
                    {
                        return SAME_POINT_SE;
                    }
                    if (this.isSamePoint(_loc_4[0], _loc_3[1], args))
                    {
                        return SAME_POINT_ES;
                    }
                    if (this.isSamePoint(_loc_4[0], _loc_4[1], args))
                    {
                        return SAME_POINT_EE;
                    }
                }
                return this.isCheckCrossTip(_loc_3[0], _loc_4[0], _loc_3[1], _loc_4[1], args);
            }
            var _loc_14:* = new Vector.<Number>(2, true);
            _loc_7 = 0;
            while (_loc_7 < 2)
            {
                
                _loc_14[_loc_7] = this.dSP.getAnglePoint(_loc_4[_loc_7], _loc_3[_loc_7]);
                if (_loc_14[_loc_7] < 0)
                {
                    while (_loc_14[_loc_7] < 0)
                    {
                        
                        _loc_14[_loc_7] = _loc_14[_loc_7] + Math.PI * 2;
                    }
                }
                if (_loc_14[_loc_7] >= Math.PI * 2)
                {
                    while (_loc_14[_loc_7] >= Math.PI * 2)
                    {
                        
                        _loc_14[_loc_7] = _loc_14[_loc_7] - Math.PI * 2;
                    }
                }
                if (_loc_14[_loc_7] > Math.PI)
                {
                    _loc_14[_loc_7] = _loc_14[_loc_7] - Math.PI;
                }
                _loc_7++;
            }
            var _loc_15:* = Math.abs(_loc_14[0] - _loc_14[1]);
            var _loc_16:* = Math.abs(_loc_6[0] - _loc_6[1]);
            if (_loc_15 < args && _loc_16 < args)
            {
                if (_loc_3[1].x >= _loc_11[0] && _loc_3[1].x <= _loc_10[0] && _loc_4[1].x >= _loc_11[0] && _loc_4[1].x <= _loc_10[0] && _loc_3[1].y >= _loc_13[0] && _loc_3[1].y <= _loc_12[0] && _loc_4[1].y >= _loc_13[0] && _loc_4[1].y <= _loc_12[0])
                {
                    return LINE_INNER1;
                }
                if (_loc_3[0].x >= _loc_11[1] && _loc_3[0].x <= _loc_10[1] && _loc_4[0].x >= _loc_11[1] && _loc_4[0].x <= _loc_10[1] && _loc_3[0].y >= _loc_13[1] && _loc_3[0].y <= _loc_12[1] && _loc_4[0].y >= _loc_13[1] && _loc_4[0].y <= _loc_12[1])
                {
                    return LINE_INNER2;
                }
                if (_loc_3[1].x > _loc_11[0] && _loc_3[1].x < _loc_10[0] && _loc_3[1].y > _loc_13[0] && _loc_3[1].y < _loc_12[0])
                {
                    return LINE_ON;
                }
                if (_loc_4[1].y > _loc_13[0] && _loc_4[1].y < _loc_12[0] && _loc_4[1].x > _loc_11[0] && _loc_4[1].x < _loc_10[0])
                {
                    return LINE_ON;
                }
                return this.isCheckCrossTip(_loc_3[0], _loc_4[0], _loc_3[1], _loc_4[1], args);
            }
            if (this.isSamePoint(_loc_3[0], _loc_3[1], args))
            {
                return SAME_POINT_SS;
            }
            if (this.isSamePoint(_loc_3[0], _loc_4[1], args))
            {
                return SAME_POINT_SE;
            }
            if (this.isSamePoint(_loc_4[0], _loc_3[1], args))
            {
                return SAME_POINT_ES;
            }
            if (this.isSamePoint(_loc_4[0], _loc_4[1], args))
            {
                return SAME_POINT_EE;
            }
            var _loc_17:* = new Point(Number.NaN, Number.NaN);
            if (isNaN(_loc_5[0]) && _loc_5[1] == 0)
            {
                _loc_17.x = _loc_3[0].x;
                _loc_17.y = _loc_3[1].y;
            }
            else if (_loc_5[1] == 0 && isNaN(_loc_5[1]))
            {
                _loc_17.x = _loc_3[1].x;
                _loc_17.y = _loc_3[0].y;
            }
            else if (isNaN(_loc_5[0]))
            {
                _loc_17.x = _loc_3[0].x;
                _loc_17.y = _loc_5[1] * _loc_17.x + _loc_6[1];
            }
            else if (isNaN(_loc_5[1]))
            {
                _loc_17.x = _loc_3[1].x;
                _loc_17.y = _loc_5[0] * _loc_17.x + _loc_6[0];
            }
            else if (_loc_5[0] == 0)
            {
                _loc_17.y = _loc_3[0].y;
                _loc_17.x = (_loc_17.y - _loc_6[1]) / _loc_5[1];
            }
            else if (_loc_5[1] == 0)
            {
                _loc_17.y = _loc_3[1].y;
                _loc_17.x = (_loc_17.y - _loc_6[0]) / _loc_5[0];
            }
            else
            {
                _loc_17.x = -1 * (_loc_6[0] - _loc_6[1]) / (_loc_5[0] - _loc_5[1]);
                _loc_17.y = _loc_5[0] * _loc_17.x + _loc_6[0];
            }
            var _loc_18:* = true;
            if (this.isSamePoint(_loc_17, _loc_3[0], args))
            {
                if (!isNaN(_loc_5[1]) && (_loc_17.x <= _loc_11[1] || _loc_17.x >= _loc_10[1]))
                {
                    _loc_18 = false;
                }
                if (_loc_5[1] != 0 && (_loc_17.y <= _loc_13[1] || _loc_17.y >= _loc_12[1]))
                {
                    _loc_18 = false;
                }
                if (_loc_18)
                {
                    return CROSS_POINT_1S;
                }
                return NOT_CROSS;
            }
            else if (this.isSamePoint(_loc_17, _loc_4[0], args))
            {
                if (!isNaN(_loc_5[1]) && (_loc_17.x <= _loc_11[1] || _loc_17.x >= _loc_10[1]))
                {
                    _loc_18 = false;
                }
                if (_loc_5[1] != 0 && (_loc_17.y <= _loc_13[1] || _loc_17.y >= _loc_12[1]))
                {
                    _loc_18 = false;
                }
                if (_loc_18)
                {
                    return CROSS_POINT_1E;
                }
                return NOT_CROSS;
            }
            else if (this.isSamePoint(_loc_17, _loc_3[1], args))
            {
                if (!isNaN(_loc_5[0]) && (_loc_17.x <= _loc_11[0] || _loc_17.x >= _loc_10[0]))
                {
                    _loc_18 = false;
                }
                if (_loc_5[0] != 0 && (_loc_17.y <= _loc_13[0] || _loc_17.y >= _loc_12[0]))
                {
                    _loc_18 = false;
                }
                if (_loc_18)
                {
                    return CROSS_POINT_2S;
                }
                return NOT_CROSS;
            }
            else if (this.isSamePoint(_loc_17, _loc_4[1], args))
            {
                if (!isNaN(_loc_5[0]) && (_loc_17.x <= _loc_11[0] || _loc_17.x >= _loc_10[0]))
                {
                    _loc_18 = false;
                }
                if (_loc_5[0] != 0 && (_loc_17.y <= _loc_13[0] || _loc_17.y >= _loc_12[0]))
                {
                    _loc_18 = false;
                }
                if (_loc_18)
                {
                    return CROSS_POINT_2E;
                }
                return NOT_CROSS;
            }
            if (!isNaN(_loc_5[0]) && (_loc_17.x <= _loc_11[0] || _loc_17.x >= _loc_10[0]))
            {
                _loc_18 = false;
            }
            if (!isNaN(_loc_5[1]) && (_loc_17.x <= _loc_11[1] || _loc_17.x >= _loc_10[1]))
            {
                _loc_18 = false;
            }
            if (_loc_5[0] != 0 && (_loc_17.y <= _loc_13[0] || _loc_17.y >= _loc_12[0]))
            {
                _loc_18 = false;
            }
            if (_loc_5[1] != 0 && (_loc_17.y <= _loc_13[1] || _loc_17.y >= _loc_12[1]))
            {
                _loc_18 = false;
            }
            if (_loc_18)
            {
                return CROSS_NORMAL;
            }
            return NOT_CROSS;
        }// end function

        public function contain(param1:Number, param2:Number) : Boolean
        {
            return this.containPoint(new Point(param1, param2));
        }// end function

        public function containPoint(param1:Point) : Boolean
        {
            var _loc_2:* = this.dSP.getLocation();
            if (Point.distance(_loc_2, param1) <= this.lineRange)
            {
                return true;
            }
            var _loc_3:* = this.dEP.getLocation();
            if (Point.distance(_loc_3, param1) <= this.lineRange)
            {
                return true;
            }
            var _loc_4:* = this.getPerpendicularLeg(param1.x, param1.y);
            if (isNaN(_loc_4.x) || isNaN(_loc_4.y))
            {
                return false;
            }
            if (Math.abs(_loc_2.x - _loc_3.x) > 0.0001)
            {
                if (Math.min(_loc_2.x, _loc_3.x) > param1.x)
                {
                    return false;
                }
                if (Math.max(_loc_2.x, _loc_3.x) < param1.x)
                {
                    return false;
                }
            }
            if (Math.abs(_loc_2.y - _loc_3.y) > 0.0001)
            {
                if (Math.min(_loc_2.y, _loc_3.y) > param1.y)
                {
                    return false;
                }
                if (Math.max(_loc_2.y, _loc_3.y) < param1.y)
                {
                    return false;
                }
            }
            if (Point.distance(_loc_4, param1) <= this.lineRange)
            {
                return true;
            }
            return false;
        }// end function

        public function createRange() : GraphicsPath
        {
            var _loc_1:* = new PointObject();
            var _loc_2:* = new GraphicsPath();
            var _loc_3:* = this.getAngle();
            _loc_1.setLocationPoint(this.getStartLocation());
            var _loc_4:* = _loc_1.calcPoint(-this.lineRange, _loc_3);
            _loc_1.setLocationPoint(_loc_4);
            var _loc_5:* = _loc_1.calcPoint(this.lineRange, ComOther.toRadian(90) + _loc_3);
            var _loc_6:* = _loc_1.calcPoint(this.lineRange, ComOther.toRadian(-90) + _loc_3);
            _loc_1.setLocationPoint(this.getEndLocation());
            var _loc_7:* = _loc_1.calcPoint(this.lineRange, _loc_3);
            _loc_1.setLocationPoint(_loc_7);
            var _loc_8:* = _loc_1.calcPoint(this.lineRange, ComOther.toRadian(90) + _loc_3);
            var _loc_9:* = _loc_1.calcPoint(this.lineRange, ComOther.toRadian(-90) + _loc_3);
            _loc_2.moveTo(_loc_8.x, _loc_8.y);
            _loc_2.lineTo(_loc_5.x, _loc_5.y);
            _loc_2.lineTo(_loc_6.x, _loc_6.y);
            _loc_2.lineTo(_loc_9.x, _loc_9.y);
            _loc_2.lineTo(_loc_8.x, _loc_8.y);
            return _loc_2;
        }// end function

        public function draw(param1:Graphics) : void
        {
            this.dDrawBox = false;
            this.drawAction(param1, false);
            return;
        }// end function

        public function drawBox(param1:Graphics) : void
        {
            this.dDrawBox = true;
            this.drawAction(param1, false);
            return;
        }// end function

        public function getAngle() : Number
        {
            return this.dSP.getAnglePoint(this.dEP.getLocation());
        }// end function

        public function getCross(param1:Number, param2:Number, param3:Number) : Vector.<Point>
        {
            var _loc_14:* = NaN;
            var _loc_4:* = this.getStartLocation();
            var _loc_5:* = this.getEndLocation();
            var _loc_6:* = new Point(param1, param2);
            var _loc_7:* = param3;
            var _loc_8:* = new Vector.<Point>(1, true);
            _loc_8[0] = new Point(Number.NaN, Number.NaN);
            var _loc_9:* = Point.distance(_loc_6, _loc_4);
            var _loc_10:* = Point.distance(_loc_6, _loc_5);
            if (_loc_9 < _loc_7 && _loc_10 < _loc_7)
            {
                return _loc_8;
            }
            var _loc_11:* = new Vector.<Point>;
            var _loc_12:* = new Point(0, 0);
            var _loc_13:* = new Point(0, 0);
            _loc_12.x = _loc_4.x - _loc_6.x;
            _loc_12.y = _loc_4.y - _loc_6.y;
            _loc_13.x = _loc_5.x - _loc_6.x;
            _loc_13.y = _loc_5.y - _loc_6.y;
            if (Math.abs(_loc_12.x - _loc_13.x) < 0.01)
            {
                if (Math.abs(_loc_12.x) > _loc_7)
                {
                    return _loc_8;
                }
                _loc_14 = _loc_7 * _loc_7 - _loc_12.x * _loc_12.x;
                if (Math.abs(_loc_14) < 0.01)
                {
                    _loc_11.push(new Point());
                    _loc_11[0].x = _loc_4.x;
                    _loc_11[0].y = _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_9 <= _loc_7)
                {
                    if (_loc_4.y <= _loc_5.y)
                    {
                        _loc_11.push(new Point());
                        _loc_11[0].x = _loc_4.x;
                        _loc_11[0].y = Math.sqrt(_loc_14) + _loc_6.y;
                        _loc_11.fixed = true;
                        return _loc_11;
                    }
                    _loc_11.push(new Point());
                    _loc_11[0].x = _loc_4.x;
                    _loc_11[0].y = -1 * Math.sqrt(_loc_14) + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_10 <= _loc_7)
                {
                    if (_loc_4.y <= _loc_5.y)
                    {
                        _loc_11.push(new Point());
                        _loc_11[0].x = _loc_4.x;
                        _loc_11[0].y = -1 * Math.sqrt(_loc_14) + _loc_6.y;
                        _loc_11.fixed = true;
                        return _loc_11;
                    }
                    _loc_11.push(new Point());
                    _loc_11[0].x = _loc_4.x;
                    _loc_11[0].y = Math.sqrt(_loc_14) + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                _loc_11.push(new Point());
                _loc_11[0].x = _loc_4.x;
                _loc_11[0].y = -1 * Math.sqrt(_loc_14) + _loc_6.y;
                _loc_11.push(new Point());
                _loc_11[1].x = _loc_4.x;
                _loc_11[1].y = Math.sqrt(_loc_14) + _loc_6.y;
                _loc_11.fixed = true;
                return _loc_11;
            }
            if (Math.abs(_loc_12.y - _loc_13.y) < 0.01)
            {
                if (Math.abs(_loc_12.y) > _loc_7)
                {
                    return _loc_8;
                }
                _loc_14 = _loc_7 * _loc_7 - _loc_12.y * _loc_12.y;
                if (Math.abs(_loc_14) < 0.01)
                {
                    _loc_11.push(new Point());
                    _loc_11[0].y = _loc_4.y;
                    _loc_11[0].x = _loc_6.x;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_9 <= _loc_7)
                {
                    if (_loc_4.x <= _loc_5.x)
                    {
                        _loc_11.push(new Point());
                        _loc_11[0].y = _loc_4.y;
                        _loc_11[0].x = Math.sqrt(_loc_14) + _loc_6.x;
                        _loc_11.fixed = true;
                        return _loc_11;
                    }
                    _loc_11.push(new Point());
                    _loc_11[0].y = _loc_4.y;
                    _loc_11[0].x = -1 * Math.sqrt(_loc_14) + _loc_6.x;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_10 <= _loc_7)
                {
                    if (_loc_4.x <= _loc_5.x)
                    {
                        _loc_11.push(new Point());
                        _loc_11[0].y = _loc_4.y;
                        _loc_11[0].x = -1 * Math.sqrt(_loc_14) + _loc_6.x;
                        _loc_11.fixed = true;
                        return _loc_11;
                    }
                    _loc_11.push(new Point());
                    _loc_11[0].y = _loc_4.y;
                    _loc_11[0].x = Math.sqrt(_loc_14) + _loc_6.x;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                _loc_11.push(new Point());
                _loc_11[0].y = _loc_4.y;
                _loc_11[0].x = -1 * Math.sqrt(_loc_14) + _loc_6.x;
                _loc_11.push(new Point());
                _loc_11[1].y = _loc_4.y;
                _loc_11[1].x = Math.sqrt(_loc_14) + _loc_6.x;
                _loc_11.fixed = true;
                return _loc_11;
            }
            var _loc_15:* = (_loc_12.y - _loc_13.y) / (_loc_12.x - _loc_13.x);
            var _loc_16:* = _loc_12.y - _loc_15 * _loc_12.x;
            _loc_14 = 2 * _loc_15 * _loc_16 * (2 * _loc_15 * _loc_16) - 4 * (_loc_15 * _loc_15 + 1) * (_loc_16 * _loc_16 - _loc_7 * _loc_7);
            if (_loc_14 < 0)
            {
                return _loc_8;
            }
            _loc_11.push(new Point());
            _loc_11.push(new Point());
            _loc_11[0].x = (-2 * _loc_15 * _loc_16 + Math.sqrt(_loc_14)) / (2 * (_loc_15 * _loc_15 + 1));
            _loc_11[1].x = (-2 * _loc_15 * _loc_16 - Math.sqrt(_loc_14)) / (2 * (_loc_15 * _loc_15 + 1));
            _loc_11[0].y = _loc_15 * _loc_11[0].x + _loc_16;
            _loc_11[1].y = _loc_15 * _loc_11[1].x + _loc_16;
            if (Math.abs(_loc_11[0].x - _loc_11[1].x) < 0.01)
            {
                _loc_11.pop();
                _loc_11[0].x = _loc_11[0].x + _loc_6.x;
                _loc_11[0].y = _loc_11[0].y + _loc_6.y;
                _loc_11.fixed = true;
                return _loc_11;
            }
            if (_loc_9 <= _loc_7)
            {
                if (_loc_4.x <= _loc_5.x && _loc_4.y <= _loc_5.y)
                {
                    _loc_11.pop();
                    _loc_11[0].x = _loc_11[0].x + _loc_6.x;
                    _loc_11[0].y = _loc_11[0].y + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x > _loc_5.x && _loc_4.y <= _loc_5.y)
                {
                    _loc_11[1].x = _loc_11[1].x + _loc_6.x;
                    _loc_11[1].y = _loc_11[1].y + _loc_6.y;
                    _loc_11.shift();
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x <= _loc_5.x && _loc_4.y > _loc_5.y)
                {
                    _loc_11.pop();
                    _loc_11[0].x = _loc_11[0].x + _loc_6.x;
                    _loc_11[0].y = _loc_11[0].y + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x > _loc_5.x && _loc_4.y > _loc_5.y)
                {
                    _loc_11[1].x = _loc_11[1].x + _loc_6.x;
                    _loc_11[1].y = _loc_11[1].y + _loc_6.y;
                    _loc_11.shift();
                    _loc_11.fixed = true;
                    return _loc_11;
                }
            }
            if (_loc_10 <= _loc_7)
            {
                if (_loc_4.x <= _loc_5.x && _loc_4.y <= _loc_5.y)
                {
                    _loc_11[1].x = _loc_11[1].x + _loc_6.x;
                    _loc_11[1].y = _loc_11[1].y + _loc_6.y;
                    _loc_11.shift();
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x > _loc_5.x && _loc_4.y <= _loc_5.y)
                {
                    _loc_11.pop();
                    _loc_11[0].x = _loc_11[0].x + _loc_6.x;
                    _loc_11[0].y = _loc_11[0].y + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x <= _loc_5.x && _loc_4.y > _loc_5.y)
                {
                    _loc_11[1].x = _loc_11[1].x + _loc_6.x;
                    _loc_11[1].y = _loc_11[1].y + _loc_6.y;
                    _loc_11.shift();
                    _loc_11.fixed = true;
                    return _loc_11;
                }
                if (_loc_4.x > _loc_5.x && _loc_4.y > _loc_5.y)
                {
                    _loc_11.pop();
                    _loc_11[0].x = _loc_11[0].x + _loc_6.x;
                    _loc_11[0].y = _loc_11[0].y + _loc_6.y;
                    _loc_11.fixed = true;
                    return _loc_11;
                }
            }
            _loc_11[0].x = _loc_11[0].x + _loc_6.x;
            _loc_11[0].y = _loc_11[0].y + _loc_6.y;
            _loc_11[1].x = _loc_11[1].x + _loc_6.x;
            _loc_11[1].y = _loc_11[1].y + _loc_6.y;
            return _loc_11;
        }// end function

        public function getCrossPoint(param1:Point, param2:Number) : Vector.<Point>
        {
            return this.getCross(param1.x, param1.y, param2);
        }// end function

        public function getCrossCircle(param1:CircleObject) : Vector.<Point>
        {
            return this.getCrossPoint(param1.getLocation(), param1.getRadius());
        }// end function

        public function getEndLocation() : Point
        {
            return this.dEP.getLocation();
        }// end function

        public function getIntercept() : Number
        {
            return this.dSP.getInterceptPoint(this.dEP.getLocation());
        }// end function

        public function getLength() : Number
        {
            var _loc_1:* = Point.distance(this.dSP.getLocation(), this.dEP.getLocation());
            return _loc_1;
        }// end function

        public function getPerpendicularLeg(param1:Number, param2:Number) : Point
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = this.dSP.getLocation();
            var _loc_4:* = this.dEP.getLocation();
            if (this.dSP.containPoint(_loc_4))
            {
                return _loc_3;
            }
            if (this.dSP.contain(param1, param2))
            {
                return _loc_3;
            }
            if (this.dEP.contain(param1, param2))
            {
                return _loc_4;
            }
            var _loc_5:* = this.getSlope();
            var _loc_6:* = this.getAngle();
            var _loc_7:* = this.getIntercept();
            if (!isFinite(_loc_5))
            {
                return new Point(_loc_3.x, param2);
            }
            if (_loc_5 == 0)
            {
                return new Point(param1, _loc_7);
            }
            _loc_6 = _loc_6 + Math.PI / 2;
            _loc_8 = this.dSP.calcPoint(9999999, _loc_6, param1, param2);
            _loc_9 = this.dSP.calcPoint(-9999999, _loc_6, param1, param2);
            return this.getPointFromPoint(_loc_8, _loc_9);
        }// end function

        public function getPerpendicularLegPoint(param1:Point) : Point
        {
            return this.getPerpendicularLeg(param1.x, param1.y);
        }// end function

        public function getPoint(param1:Number, param2:Number, param3:Number, param4:Number) : Point
        {
            return this.getPointFromLine(new LineObject(param1, param2, param3, param4));
        }// end function

        public function getPointFromPoint(param1:Point, param2:Point) : Point
        {
            return this.getPointFromLine(new LineObject(param1, param2));
        }// end function

        public function getPointFromLine(param1:LineObject) : Point
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = new Point(NaN, NaN);
            var _loc_5:* = new Point(NaN, NaN);
            var _loc_6:* = this.getStartLocation();
            var _loc_7:* = this.getEndLocation();
            var _loc_8:* = this.getSlope();
            var _loc_9:* = this.getIntercept();
            var _loc_10:* = param1.getStartLocation();
            var _loc_11:* = param1.getEndLocation();
            var _loc_12:* = param1.getSlope();
            var _loc_13:* = param1.getIntercept();
            if (_loc_6.equals(_loc_10))
            {
                _loc_5 = _loc_6.clone();
                return _loc_5;
            }
            if (_loc_6.equals(_loc_11))
            {
                _loc_5 = _loc_6.clone();
                return _loc_5;
            }
            if (_loc_7.equals(_loc_10))
            {
                _loc_5 = _loc_7.clone();
                return _loc_5;
            }
            if (_loc_7.equals(_loc_11))
            {
                _loc_5 = _loc_7.clone();
                return _loc_5;
            }
            if (!isFinite(_loc_8) && !isFinite(_loc_12))
            {
                if (_loc_10.y > _loc_11.y)
                {
                    _loc_2 = _loc_10.y;
                    _loc_3 = _loc_11.y;
                }
                else
                {
                    _loc_2 = _loc_11.y;
                    _loc_3 = _loc_10.y;
                }
                if (_loc_6.x == _loc_10.x)
                {
                    if (this.crossCheck(_loc_10.y, _loc_11.y, _loc_6.y))
                    {
                        _loc_5 = _loc_6.clone();
                        return _loc_5;
                    }
                    if (this.crossCheck(_loc_10.y, _loc_11.y, _loc_7.y))
                    {
                        _loc_5 = _loc_7.clone();
                        return _loc_5;
                    }
                    if (_loc_6.y <= _loc_3 && _loc_2 <= _loc_7.y || _loc_7.y <= _loc_3 && _loc_2 <= _loc_6.y)
                    {
                        _loc_5 = _loc_10.clone();
                        return _loc_5;
                    }
                }
                _loc_5 = _loc_4;
                return _loc_5;
            }
            if (!isFinite(_loc_8))
            {
                _loc_5.x = _loc_6.x;
                _loc_5.y = _loc_5.x * _loc_12 + _loc_13;
                if (!this.crossCheck(_loc_6.y, _loc_7.y, _loc_5.y))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                if (!this.crossCheck(_loc_10.x, _loc_11.x, _loc_5.x))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                return _loc_5;
            }
            if (!isFinite(_loc_12))
            {
                _loc_5.x = _loc_10.x;
                _loc_5.y = _loc_5.x * _loc_8 + _loc_9;
                if (!this.crossCheck(_loc_10.y, _loc_11.y, _loc_5.y))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                if (!this.crossCheck(_loc_6.x, _loc_7.x, _loc_5.x))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                return _loc_5;
            }
            if (_loc_8 != _loc_12)
            {
                _loc_5.x = (_loc_13 - _loc_9) / (_loc_8 - _loc_12);
                _loc_5.y = _loc_5.x * _loc_12 + _loc_13;
                if (!this.crossCheck(_loc_6.y, _loc_7.y, _loc_5.y))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                if (!this.crossCheck(_loc_6.x, _loc_7.x, _loc_5.x))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                if (!this.crossCheck(_loc_10.y, _loc_11.y, _loc_5.y))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                if (!this.crossCheck(_loc_10.x, _loc_11.x, _loc_5.x))
                {
                    _loc_5 = _loc_4;
                    return _loc_5;
                }
                return _loc_5;
            }
            if (_loc_9 == _loc_13)
            {
                if (this.crossCheck(_loc_10.x, _loc_11.x, _loc_6.x))
                {
                    _loc_5 = _loc_6.clone();
                    return _loc_5;
                }
                if (this.crossCheck(_loc_10.x, _loc_11.x, _loc_7.x))
                {
                    _loc_5 = _loc_7.clone();
                    return _loc_5;
                }
                if (this.crossCheck(_loc_6.x, _loc_7.x, _loc_10.x))
                {
                    _loc_5 = _loc_10.clone();
                    return _loc_5;
                }
                return _loc_5;
            }
            return _loc_5;
        }// end function

        public function getSlope() : Number
        {
            return this.dSP.getSlopePoint(this.dEP.getLocation());
        }// end function

        public function getStartLocation() : Point
        {
            return this.dSP.getLocation();
        }// end function

        public function setLocation(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.dSP.setLocation(param1, param2);
            this.dEP.setLocation(param3, param4);
            this.x = param1 < param3 ? (param1) : (param3);
            this.y = param2 < param4 ? (param2) : (param4);
            return;
        }// end function

        public function setLocationPoint(param1:Point, param2:Point) : void
        {
            this.dSP.setLocationPoint(param1);
            this.dEP.setLocationPoint(param2);
            this.x = param1.x < param2.x ? (param1.x) : (param2.x);
            this.y = param1.y < param2.y ? (param1.y) : (param2.y);
            return;
        }// end function

        public function slowLine(param1:Function, param2:DisplayObject, param3:Number, param4:int) : void
        {
            this.dSlowLine = new SlowLineObject();
            this.dSlowLine.copyProperty(this);
            this.dSlowLine.startLine(this.dSP.getLocation(), this.dEP.getLocation(), param4, param3, param2, this.onSlowLineEnd, param1);
            return;
        }// end function

        public function slowLineSpecial(param1:Function, param2:DisplayObject, param3:Number, param4:Number, param5:Vector.<Point>, param6:Number, param7:int) : void
        {
            var _loc_8:* = new Point(param3, param4);
            var _loc_9:* = new Vector.<Point>(param5.length, true);
            var _loc_10:* = 0;
            while (_loc_10 < param5.length)
            {
                
                _loc_9[_loc_10] = _loc_8;
                _loc_10 = _loc_10 + 1;
            }
            this.dSlowLine = new SlowLineObject();
            this.dSlowLine.copyProperty(this);
            this.dSlowLine.setSameEnd(true);
            this.dSlowLine.startLine(param5, _loc_9, param7, param6, param2, this.onSlowLineEnd, param1);
            return;
        }// end function

        public function slowLineSpread(param1:Function, param2:DisplayObject, param3:Number, param4:Number, param5:Vector.<Point>, param6:Number, param7:int) : void
        {
            var _loc_8:* = new Point(param3, param4);
            var _loc_9:* = new Vector.<Point>(param5.length, true);
            var _loc_10:* = 0;
            while (_loc_10 < param5.length)
            {
                
                _loc_9[_loc_10] = _loc_8;
                _loc_10 = _loc_10 + 1;
            }
            this.dSlowLine = new SlowLineObject();
            this.dSlowLine.copyProperty(this);
            this.dSlowLine.setSameEnd(true);
            this.dSlowLine.startLine(_loc_9, param5, param7, param6, param2, this.onSlowLineEnd, param1);
            return;
        }// end function

        override protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = this.dSP.getLocation();
            var _loc_5:* = this.dEP.getLocation();
            if (_loc_4.equals(_loc_5))
            {
                return;
            }
            if (this.dDrawBox)
            {
                param1.drawRect(_loc_4.x, _loc_4.y, _loc_5.x - _loc_4.x, _loc_5.y - _loc_4.y);
            }
            else
            {
                param1.moveTo(_loc_4.x, _loc_4.y);
                param1.lineTo(_loc_5.x, _loc_5.y);
            }
            return;
        }// end function

        override protected function getShapePath() : Array
        {
            var _loc_1:* = this.dSP.getLocation();
            var _loc_2:* = this.dEP.getLocation();
            if (_loc_1.equals(_loc_2))
            {
                return new Array();
            }
            var _loc_3:* = new Array();
            if (!this.dDrawBox)
            {
                this.setShapePointStraight(_loc_1, _loc_2, _loc_3);
                return _loc_3;
            }
            var _loc_4:* = new Point();
            var _loc_5:* = new Point();
            _loc_4.x = _loc_1.x;
            _loc_4.y = _loc_1.y;
            _loc_5.x = _loc_2.x;
            _loc_5.y = _loc_1.y;
            this.setShapePointStraight(_loc_4, _loc_5, _loc_3);
            _loc_4.x = _loc_2.x;
            _loc_4.y = _loc_1.y;
            _loc_5.x = _loc_2.x;
            _loc_5.y = _loc_2.y;
            this.setShapePointStraight(_loc_4, _loc_5, _loc_3);
            _loc_4.x = _loc_2.x;
            _loc_4.y = _loc_2.y;
            _loc_5.x = _loc_1.x;
            _loc_5.y = _loc_2.y;
            this.setShapePointStraight(_loc_4, _loc_5, _loc_3);
            _loc_4.x = _loc_1.x;
            _loc_4.y = _loc_2.y;
            _loc_5.x = _loc_1.x;
            _loc_5.y = _loc_1.y;
            this.setShapePointStraight(_loc_4, _loc_5, _loc_3);
            return _loc_3;
        }// end function

        private function onSlowLineEnd(param1:Function) : void
        {
            this.dSlowLine.clear();
            this.dSlowLine = null;
            param1.apply(NaN, new StageEvent(StageEvent.SLOW_LINE_END));
            return;
        }// end function

        private function crossCheck(param1:Number, param2:Number, param3:Number) : Boolean
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (param1 > param2)
            {
                _loc_4 = param1;
                _loc_5 = param2;
            }
            else
            {
                _loc_4 = param2;
                _loc_5 = param1;
            }
            var _loc_6:* = ComOther.dComp(_loc_5, param3, 5) >= 0;
            if (ComOther.dComp(_loc_5, param3, 5) >= 0)
            {
                _loc_6 = ComOther.dComp(param3, _loc_4, 5) >= 0;
            }
            return _loc_6;
        }// end function

        private function isCheckCrossTip(param1:Point, param2:Point, param3:Point, param4:Point, param5:Number) : int
        {
            if (this.isSamePoint(param1, param3, param5))
            {
                return SAME_POINT_SS;
            }
            if (this.isSamePoint(param1, param4, param5))
            {
                return SAME_POINT_SE;
            }
            if (this.isSamePoint(param2, param3, param5))
            {
                return SAME_POINT_ES;
            }
            if (this.isSamePoint(param2, param4, param5))
            {
                return SAME_POINT_EE;
            }
            return NOT_CROSS;
        }// end function

        private function isSamePoint(param1:Point, param2:Point, param3:Number) : Boolean
        {
            var _loc_4:* = Number.NaN;
            if (isNaN(param1.x) && isNaN(param2.x))
            {
                _loc_4 = 0;
            }
            else
            {
                if (isNaN(param1.x) || isNaN(param2.x))
                {
                    return false;
                }
                _loc_4 = Math.abs(param1.x - param2.x);
            }
            var _loc_5:* = Number.NaN;
            if (isNaN(param1.y) && isNaN(param2.y))
            {
                _loc_5 = 0;
            }
            else
            {
                if (isNaN(param1.y) || isNaN(param2.y))
                {
                    return false;
                }
                _loc_5 = Math.abs(param1.y - param2.y);
            }
            if (_loc_4 < param3 && _loc_5 < param3)
            {
                return true;
            }
            return false;
        }// end function

    }
}
