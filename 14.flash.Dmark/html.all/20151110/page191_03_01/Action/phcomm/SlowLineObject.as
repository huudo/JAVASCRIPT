package phcomm
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import sketchbook.graphics.*;

    public class SlowLineObject extends ShapeObject
    {
        private var mCanvas:DisplayObject;
        private var mFunction:Function;
        private var mParameter:Object;
        private var mIsSameEnd:Boolean;
        private var mLinePointS:Vector.<Point>;
        private var mLinePointE:Vector.<Point>;
        private var mArcPointC:Vector.<Point>;
        private var mArcRadius:Vector.<Number>;
        private var mArcStart:Vector.<Number>;
        private var mArcAngle:Vector.<Number>;
        private var mIsDrawLine:Boolean;
        private var mIsDrawArc:Boolean;
        private var mRateStep:Vector.<Number>;
        private var mDrawRatio:Vector.<Number>;
        private var mDrawIndex:uint;
        private var mTimer:Timer;
        public static const SOLID:int = 1;
        public static const DOT:int = 2;
        public static const DASH:int = 3;
        public static const DASHDOT:int = 4;
        public static const DASHDOTDOT:int = 5;
        public static const FINEDOT:int = 6;

        public function SlowLineObject() : void
        {
            this.mTimer = null;
            this.mIsDrawLine = false;
            this.mIsDrawArc = false;
            this.mRateStep = null;
            this.mDrawRatio = null;
            this.mCanvas = null;
            this.mFunction = null;
            this.mParameter = null;
            this.mLinePointS = null;
            this.mLinePointE = null;
            this.mArcPointC = null;
            this.mArcRadius = null;
            this.mArcStart = null;
            this.mArcAngle = null;
            this.mDrawIndex = 0;
            this.mIsSameEnd = false;
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            if (this.mTimer != null)
            {
                this.mTimer.reset();
                this.mTimer = null;
            }
            this.mIsDrawLine = false;
            this.mIsDrawArc = false;
            this.mRateStep = null;
            this.mDrawRatio = null;
            this.mDrawIndex = 0;
            this.mCanvas = null;
            this.mFunction = null;
            this.mParameter = null;
            if (this.mLinePointS != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mLinePointS.length)
                {
                    
                    this.mLinePointS[_loc_1] = null;
                    _loc_1 = _loc_1 + 1;
                }
                this.mLinePointS = null;
            }
            if (this.mLinePointE != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mLinePointE.length)
                {
                    
                    this.mLinePointE[_loc_1] = null;
                    _loc_1 = _loc_1 + 1;
                }
                this.mLinePointE = null;
            }
            if (this.mArcPointC != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this.mArcPointC.length)
                {
                    
                    this.mArcPointC[_loc_1] = null;
                    _loc_1 = _loc_1 + 1;
                }
                this.mArcPointC = null;
            }
            this.mArcRadius = null;
            this.mArcStart = null;
            this.mArcAngle = null;
            this.graphics.clear();
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function copyProperty(param1:ShapeObject) : void
        {
            this.lineWidth = param1.lineWidth;
            this.lineStyle = param1.lineStyle;
            this.lineColor = param1.lineColor;
            this.lineAlpha = param1.lineAlpha;
            this.fillColor = param1.fillColor;
            this.fillAlpha = param1.fillAlpha;
            this.lineRange = param1.lineRange;
            this.linePixelHinting = param1.linePixelHinting;
            this.lineCaps = param1.lineCaps;
            this.lineJoints = param1.lineJoints;
            return;
        }// end function

        public function getSameEnd() : Boolean
        {
            return this.mIsSameEnd;
        }// end function

        public function startArc(param1:Object, param2:Object, param3:Object, param4:Object, param5:int, param6:Number, param7:DisplayObject, param8:Function = null, ... args) : void
        {
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            this.clear();
            if (param1 == null || param2 == null || param3 == null || param4 == null)
            {
                throw new ArgumentError("円弧の情報にnullを指定することはできません。");
            }
            args = this.checkStartProperty(param5, param6, param7);
            if (args != null)
            {
                throw args;
            }
            if (param1 is Vector.<Point> && param2 is Vector.<Number> && param3 is Vector.<Number> && param4 is Vector.<Number>)
            {
                _loc_12 = this.Vector.<Point>(param1);
                _loc_13 = this.Vector.<Number>(param2);
                _loc_14 = this.Vector.<Number>(param3);
                _loc_15 = this.Vector.<Number>(param4);
                _loc_16 = _loc_12.length == _loc_13.length;
                if (_loc_16)
                {
                    _loc_16 = _loc_12.length == _loc_14.length;
                }
                if (_loc_16)
                {
                    _loc_16 = _loc_12.length == _loc_15.length;
                }
                if (!_loc_16)
                {
                    throw new ArgumentError("円弧の情報の指定個数が異なっています。");
                }
                this.mArcPointC = new Vector.<Point>(_loc_12.length, true);
                this.mArcRadius = new Vector.<Number>(_loc_13.length, true);
                this.mArcStart = new Vector.<Number>(_loc_14.length, true);
                this.mArcAngle = new Vector.<Number>(_loc_15.length, true);
                _loc_11 = 0;
                while (_loc_11 < this.mArcPointC.length)
                {
                    
                    this.mArcPointC[_loc_11] = _loc_12[_loc_11].clone();
                    this.mArcRadius[_loc_11] = _loc_13[_loc_11];
                    this.mArcStart[_loc_11] = _loc_14[_loc_11];
                    this.mArcAngle[_loc_11] = _loc_15[_loc_11];
                    _loc_11 = _loc_11 + 1;
                }
            }
            else if (param1 is Point && !isNaN(Number(param2)) && !isNaN(Number(param3)) && !isNaN(Number(param4)))
            {
                _loc_17 = Point(param1);
                _loc_18 = Number(param2);
                _loc_19 = Number(param3);
                _loc_20 = Number(param4);
                this.mArcPointC = new Vector.<Point>(1, true);
                this.mArcRadius = new Vector.<Number>(1, true);
                this.mArcStart = new Vector.<Number>(1, true);
                this.mArcAngle = new Vector.<Number>(1, true);
                this.mArcPointC[0] = _loc_17.clone();
                this.mArcRadius[0] = _loc_18;
                this.mArcStart[0] = _loc_19;
                this.mArcAngle[0] = _loc_20;
            }
            if (this.mArcPointC == null || this.mArcRadius == null || this.mArcStart == null || this.mArcAngle == null)
            {
                throw new ArgumentError("円弧の情報の指定方法に誤りがあります。");
            }
            this.setDrawProperty(this.mArcAngle, param6, param5, param7, param8, args);
            this.mIsDrawArc = true;
            this.useDrawHelper = true;
            this.mTimer.start();
            return;
        }// end function

        public function startLine(param1:Object, param2:Object, param3:int, param4:Number, param5:DisplayObject, param6:Function = null, ... args) : void
        {
            var _loc_9:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this.clear();
            if (param1 == null || param2 == null)
            {
                throw new ArgumentError("座標にnullを指定することはできません。");
            }
            args = this.checkStartProperty(param3, param4, param5);
            if (args != null)
            {
                throw args;
            }
            if (param1 is Vector.<Point> && param2 is Vector.<Point>)
            {
                _loc_11 = this.Vector.<Point>(param1);
                _loc_12 = this.Vector.<Point>(param2);
                if (_loc_11.length != _loc_12.length)
                {
                    throw new ArgumentError("座標の指定個数が異なっています。");
                }
                this.mLinePointS = new Vector.<Point>(_loc_11.length, true);
                this.mLinePointE = new Vector.<Point>(_loc_12.length, true);
                _loc_9 = 0;
                while (_loc_9 < this.mLinePointS.length)
                {
                    
                    this.mLinePointS[_loc_9] = _loc_11[_loc_9].clone();
                    this.mLinePointE[_loc_9] = _loc_12[_loc_9].clone();
                    _loc_9 = _loc_9 + 1;
                }
            }
            else if (param1 is Point && param2 is Point)
            {
                _loc_13 = Point(param1);
                _loc_14 = Point(param2);
                this.mLinePointS = new Vector.<Point>(1, true);
                this.mLinePointE = new Vector.<Point>(1, true);
                this.mLinePointS[0] = _loc_13.clone();
                this.mLinePointE[0] = _loc_14.clone();
            }
            if (this.mLinePointS == null || this.mLinePointE == null)
            {
                throw new ArgumentError("座標の指定方法に誤りがあります。");
            }
            var _loc_10:* = new Vector.<Number>(this.mLinePointS.length, true);
            _loc_9 = 0;
            while (_loc_9 < _loc_10.length)
            {
                
                _loc_10[_loc_9] = Point.distance(this.mLinePointS[_loc_9], this.mLinePointE[_loc_9]);
                _loc_9 = _loc_9 + 1;
            }
            this.setDrawProperty(_loc_10, param4, param3, param5, param6, args);
            this.mIsDrawLine = true;
            this.useDrawHelper = false;
            this.mTimer.start();
            return;
        }// end function

        public function setSameEnd(param1:Boolean) : void
        {
            this.mIsSameEnd = param1;
            return;
        }// end function

        override protected function drawShapeSolid(param1:Graphics, param2:Boolean, param3:Boolean) : void
        {
            if (this.mIsDrawLine)
            {
                this.drawLineSolid(param1, this.mDrawIndex);
                return;
            }
            return;
        }// end function

        override protected function drawShapeSolidHelper(param1:GraphicsHelper, param2:Boolean, param3:Boolean) : void
        {
            if (this.mIsDrawArc)
            {
                this.drawArcSolid(param1, this.mDrawIndex);
                return;
            }
            return;
        }// end function

        override protected function getShapePath() : Array
        {
            if (this.mIsDrawLine)
            {
                return this.getLinePath(this.mDrawIndex);
            }
            if (this.mIsDrawArc)
            {
                return this.getArcPath(this.mDrawIndex);
            }
            return new Array();
        }// end function

        private function checkStartProperty(param1:int, param2:Number, param3:DisplayObject) : ArgumentError
        {
            if (param3 == null)
            {
                return new ArgumentError("描画先にnullを指定することはできません。");
            }
            if (!(param3 is Shape) && !(param3 is Sprite))
            {
                return new ArgumentError("描画先にはShapeまたはSpriteを指定してください。");
            }
            if (param3 is Shape && param3.parent == null)
            {
                return new ArgumentError("描画先は表示ツリー上に設定されている必要があります。");
            }
            if (param3 is Shape && param3.parent is Loader)
            {
                return new ArgumentError("指定された描画先は使用できません。");
            }
            if (param2 <= 0)
            {
                return new ArgumentError("描画単位は0より大きい値を指定してください。");
            }
            if (param1 <= 0)
            {
                return new ArgumentError("一時停止時間は0より大きい値を指定してください。");
            }
            return null;
        }// end function

        private function drawArcSolid(param1:GraphicsHelper, param2:uint) : void
        {
            var _loc_3:* = this.getArcDrawAngle(param2);
            if (this.mArcRadius[param2] <= 0 && _loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = this.getArcNotch(this.mArcRadius[param2], _loc_3);
            param1.drawArc(this.mArcPointC[param2].x, this.mArcPointC[param2].y, this.mArcRadius[param2], _loc_3, this.mArcStart[param2], _loc_4);
            return;
        }// end function

        private function drawLineSolid(param1:Graphics, param2:uint) : void
        {
            var _loc_3:* = this.getLineDrawPoint(param2);
            if (!_loc_3.equals(this.mLinePointS[param2]))
            {
                param1.moveTo(this.mLinePointS[param2].x, this.mLinePointS[param2].y);
                param1.lineTo(_loc_3.x, _loc_3.y);
            }
            return;
        }// end function

        private function getArcDrawAngle(param1:uint) : Number
        {
            if (param1 < 0 || param1 >= this.mArcPointC.length)
            {
                return Number.NaN;
            }
            if (this.mDrawRatio[param1] <= 0)
            {
                return 0;
            }
            if (this.mDrawRatio[param1] >= 1)
            {
                return this.mArcAngle[param1];
            }
            return this.mArcAngle[param1] * this.mDrawRatio[param1];
        }// end function

        private function getLineDrawPoint(param1:uint) : Point
        {
            if (param1 < 0 || param1 >= this.mLinePointS.length)
            {
                return null;
            }
            if (this.mDrawRatio[param1] <= 0)
            {
                return this.mLinePointS[param1];
            }
            if (this.mDrawRatio[param1] >= 1)
            {
                return this.mLinePointE[param1];
            }
            return Point.interpolate(this.mLinePointE[param1], this.mLinePointS[param1], this.mDrawRatio[param1]);
        }// end function

        private function getArcPath(param1:uint) : Array
        {
            var _loc_2:* = new Array();
            var _loc_3:* = this.getArcDrawAngle(param1);
            if (this.mArcRadius[param1] <= 0 && _loc_3 == 0)
            {
                return new Array();
            }
            this.setShapePointArc(this.mArcPointC[param1], this.mArcRadius[param1], this.mArcStart[param1], _loc_3, _loc_2);
            return _loc_2;
        }// end function

        private function getLinePath(param1:uint) : Array
        {
            var _loc_2:* = this.getLineDrawPoint(param1);
            var _loc_3:* = new Array();
            this.setShapePointStraight(this.mLinePointS[param1], _loc_2, _loc_3);
            return _loc_3;
        }// end function

        private function setDrawProperty(param1:Vector.<Number>, param2:Number, param3:int, param4:DisplayObject, param5:Function, param6) : void
        {
            var _loc_7:* = 0;
            var _loc_9:* = NaN;
            this.mRateStep = new Vector.<Number>(param1.length, true);
            _loc_7 = 0;
            while (_loc_7 < this.mRateStep.length)
            {
                
                if (param1[_loc_7] == 0)
                {
                    this.mRateStep[_loc_7] = 1;
                }
                else
                {
                    this.mRateStep[_loc_7] = Math.abs(param2 / param1[_loc_7]);
                    if (this.mRateStep[_loc_7] > 1)
                    {
                        this.mRateStep[_loc_7] = 1;
                    }
                }
                _loc_7 = _loc_7 + 1;
            }
            if (this.mIsSameEnd && this.mRateStep.length > 1)
            {
                _loc_9 = this.mRateStep[0];
                _loc_7 = 1;
                while (_loc_7 < this.mRateStep.length)
                {
                    
                    _loc_9 = _loc_9 + this.mRateStep[_loc_7];
                    _loc_7 = _loc_7 + 1;
                }
                _loc_9 = _loc_9 / this.mRateStep.length;
                _loc_7 = 0;
                while (_loc_7 < this.mRateStep.length)
                {
                    
                    this.mRateStep[_loc_7] = _loc_9;
                    _loc_7 = _loc_7 + 1;
                }
            }
            this.mDrawRatio = new Vector.<Number>(param1.length, true);
            _loc_7 = 0;
            while (_loc_7 < this.mDrawRatio.length)
            {
                
                this.mDrawRatio[_loc_7] = 0;
                _loc_7 = _loc_7 + 1;
            }
            this.mCanvas = param4;
            this.mFunction = param5;
            this.mParameter = param6;
            var _loc_8:* = int.MIN_VALUE;
            if (this.mCanvas.parent != null)
            {
                if (!(this.mCanvas.parent is Loader))
                {
                    _loc_8 = param4.parent.getChildIndex(this.mCanvas);
                }
            }
            if (_loc_8 != int.MIN_VALUE)
            {
                this.mCanvas.parent.addChildAt(this, (_loc_8 + 1));
            }
            if (_loc_8 == int.MIN_VALUE)
            {
                Sprite(this.mCanvas).addChild(this);
            }
            this.mTimer = new Timer(param3);
            this.mTimer.addEventListener(TimerEvent.TIMER, this.timerAction);
            return;
        }// end function

        private function timerAction(event:TimerEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_2:* = true;
            var _loc_3:* = 0;
            while (_loc_3 < this.mDrawRatio.length)
            {
                
                if (this.mDrawRatio[_loc_3] < 1)
                {
                    this.mDrawRatio[_loc_3] = this.mDrawRatio[_loc_3] + this.mRateStep[_loc_3];
                    if (this.mDrawRatio[_loc_3] >= 1)
                    {
                        this.mDrawRatio[_loc_3] = 1;
                    }
                    else
                    {
                        _loc_2 = false;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2)
            {
                this.mTimer.stop();
                if (this.parent != null)
                {
                    this.parent.removeChild(this);
                }
                if (this.mCanvas is Sprite)
                {
                    _loc_4 = Sprite(this.mCanvas).graphics;
                }
                else
                {
                    _loc_4 = Shape(this.mCanvas).graphics;
                }
                this.mDrawIndex = 0;
                while (this.mDrawIndex < this.mDrawRatio.length)
                {
                    
                    this.drawAction(_loc_4, false);
                    var _loc_7:* = this;
                    var _loc_8:* = this.mDrawIndex + 1;
                    _loc_7.mDrawIndex = _loc_8;
                }
            }
            else
            {
                this.graphics.clear();
                this.mDrawIndex = 0;
                while (this.mDrawIndex < this.mDrawRatio.length)
                {
                    
                    this.drawAction(this.graphics, false);
                    var _loc_7:* = this;
                    var _loc_8:* = this.mDrawIndex + 1;
                    _loc_7.mDrawIndex = _loc_8;
                }
            }
            if (_loc_2)
            {
                _loc_5 = this.mFunction;
                _loc_6 = this.mParameter;
                this.clear();
                if (_loc_5 != null)
                {
                    if (_loc_6.length > 0)
                    {
                        _loc_5.apply(NaN, _loc_6);
                    }
                    else
                    {
                        _loc_5.call();
                    }
                }
                _loc_5 = null;
                _loc_6 = null;
            }
            return;
        }// end function

    }
}
