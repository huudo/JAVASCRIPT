package fl.motion
{
    import flash.display.*;
    import flash.geom.*;

    public class Animator extends AnimatorBase
    {

        public function Animator(param1:XML = null, param2:DisplayObject = null)
        {
            this.motion = new Motion(param1);
            super(param1, param2);
            return;
        }// end function

        override public function set motion(param1:MotionBase) : void
        {
            super.motion = param1;
            var _loc_2:* = param1 as Motion;
            if (_loc_2 && _loc_2.source && _loc_2.source.transformationPoint)
            {
                this.transformationPoint = _loc_2.source.transformationPoint.clone();
            }
            return;
        }// end function

        override protected function setTargetState() : void
        {
            this.targetState.scaleX = this._target.scaleX;
            this.targetState.scaleY = this._target.scaleY;
            this.targetState.skewX = MatrixTransformer.getSkewX(this._target.transform.matrix);
            this.targetState.skewY = MatrixTransformer.getSkewY(this._target.transform.matrix);
            this.targetState.bounds = this._target.getBounds(this._target);
            this.initTransformPointInternal(this._target.transform.matrix);
            this.targetState.z = 0;
            var _loc_1:* = 0;
            this.targetState.rotationY = 0;
            this.targetState.rotationX = _loc_1;
            return;
        }// end function

        private function initTransformPointInternal(param1:Matrix) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_2:* = this.targetState.bounds;
            if (this.transformationPoint)
            {
                _loc_3 = this.transformationPoint.x * _loc_2.width + _loc_2.left;
                _loc_4 = this.transformationPoint.y * _loc_2.height + _loc_2.top;
                this.targetState.transformPointInternal = new Point(_loc_3, _loc_4);
                _loc_5 = param1.transformPoint(this.targetState.transformPointInternal);
                this.targetState.x = _loc_5.x;
                this.targetState.y = _loc_5.y;
            }
            else
            {
                this.targetState.transformPointInternal = new Point(0, 0);
                this.targetState.x = this._target.x;
                this.targetState.y = this._target.y;
            }
            return;
        }// end function

        override protected function setTimeClassic(param1:int, param2:MotionBase, param3:KeyframeBase) : Boolean
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = false;
            var _loc_15:* = null;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = null;
            var _loc_22:* = NaN;
            var _loc_4:* = param2 as Motion;
            if (!(param2 as Motion))
            {
                return false;
            }
            var _loc_5:* = _loc_4.getMatrix(param1);
            if (_loc_4.getMatrix(param1))
            {
                if (!motionArray || !_lastMatrixApplied || !matricesEqual(_loc_5, _lastMatrixApplied))
                {
                    this._target.transform.matrix = _loc_5;
                    _lastMatrixApplied = _loc_5;
                }
            }
            else
            {
                if (motionArray && _loc_4 != _lastMotionUsed)
                {
                    this.transformationPoint = motion_internal::transformationPoint ? (motion_internal::transformationPoint) : (new Point(0.5, 0.5));
                    this.initTransformPointInternal(motion_internal::initialMatrix);
                    _lastMotionUsed = _loc_4;
                }
                _loc_6 = _loc_4.getValue(param1, Tweenables.X);
                _loc_7 = _loc_4.getValue(param1, Tweenables.Y);
                _loc_8 = new Point(_loc_6, _loc_7);
                if (this.positionMatrix)
                {
                    _loc_8 = this.positionMatrix.transformPoint(_loc_8);
                }
                _loc_8.x = _loc_8.x + this.targetState.x;
                _loc_8.y = _loc_8.y + this.targetState.y;
                _loc_9 = _loc_4.getValue(param1, Tweenables.SCALE_X) * this.targetState.scaleX;
                _loc_10 = _loc_4.getValue(param1, Tweenables.SCALE_Y) * this.targetState.scaleY;
                _loc_11 = 0;
                _loc_12 = 0;
                if (this.orientToPath)
                {
                    _loc_18 = _loc_4.getValue((param1 + 1), Tweenables.X);
                    _loc_19 = _loc_4.getValue((param1 + 1), Tweenables.Y);
                    _loc_20 = Math.atan2(_loc_19 - _loc_7, _loc_18 - _loc_6) * (180 / Math.PI);
                    if (!isNaN(_loc_20))
                    {
                        _loc_11 = _loc_20 + this.targetState.skewX;
                        _loc_12 = _loc_20 + this.targetState.skewY;
                    }
                }
                else
                {
                    _loc_11 = _loc_4.getValue(param1, Tweenables.SKEW_X) + this.targetState.skewX;
                    _loc_12 = _loc_4.getValue(param1, Tweenables.SKEW_Y) + this.targetState.skewY;
                }
                _loc_13 = new Matrix(_loc_9 * Math.cos(_loc_12 * (Math.PI / 180)), _loc_9 * Math.sin(_loc_12 * (Math.PI / 180)), (-_loc_10) * Math.sin(_loc_11 * (Math.PI / 180)), _loc_10 * Math.cos(_loc_11 * (Math.PI / 180)), 0, 0);
                _loc_14 = false;
                if (_loc_4.useRotationConcat(param1))
                {
                    _loc_21 = new Matrix();
                    _loc_22 = _loc_4.getValue(param1, Tweenables.ROTATION_CONCAT);
                    _loc_21.rotate(_loc_22);
                    _loc_13.concat(_loc_21);
                    _loc_14 = true;
                }
                _loc_13.tx = _loc_8.x;
                _loc_13.ty = _loc_8.y;
                _loc_15 = _loc_13.transformPoint(this.targetState.transformPointInternal);
                _loc_16 = _loc_13.tx - _loc_15.x;
                _loc_17 = _loc_13.ty - _loc_15.y;
                _loc_13.tx = _loc_13.tx + _loc_16;
                _loc_13.ty = _loc_13.ty + _loc_17;
                if (!motionArray || !_lastMatrixApplied || !matricesEqual(_loc_13, _lastMatrixApplied))
                {
                    if (!_loc_14)
                    {
                        this._target.rotation = _loc_12;
                    }
                    this._target.transform.matrix = _loc_13;
                    if (_loc_14 && this._target.scaleX == 0 && this._target.scaleY == 0)
                    {
                        this._target.scaleX = _loc_9;
                        this._target.scaleY = _loc_10;
                    }
                    _lastMatrixApplied = _loc_13;
                }
            }
            if (_lastCacheAsBitmapApplied != param3.cacheAsBitmap || !_cacheAsBitmapHasBeenApplied)
            {
                this._target.cacheAsBitmap = param3.cacheAsBitmap;
                _cacheAsBitmapHasBeenApplied = true;
                _lastCacheAsBitmapApplied = param3.cacheAsBitmap;
            }
            return true;
        }// end function

        public static function fromXMLString(param1:String, param2:DisplayObject = null) : Animator
        {
            return new Animator(new XML(param1), param2);
        }// end function

        public static function matricesEqual(param1:Matrix, param2:Matrix) : Boolean
        {
            return param1.a == param2.a && param1.b == param2.b && param1.c == param2.c && param1.d == param2.d && param1.tx == param2.tx && param1.ty == param2.ty;
        }// end function

    }
}
