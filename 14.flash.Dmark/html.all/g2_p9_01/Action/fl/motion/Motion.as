package fl.motion
{
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Motion extends MotionBase
    {
        public var source:Source;
        private var _keyframesCompact:Array;
        private static var typeCache:Object = {};

        public function Motion(param1:XML = null)
        {
            var _loc_2:* = null;
            this.keyframes = [];
            this.parseXML(param1);
            if (!this.source)
            {
                this.source = new Source();
            }
            if (this.duration == 0)
            {
                _loc_2 = this.getNewKeyframe() as Keyframe;
                _loc_2.index = 0;
                this.addKeyframe(_loc_2);
            }
            return;
        }// end function

        public function get keyframesCompact() : Array
        {
            var _loc_1:* = null;
            this._keyframesCompact = [];
            for each (_loc_1 in this.keyframes)
            {
                
                if (_loc_1)
                {
                    this._keyframesCompact.push(_loc_1);
                }
            }
            return this._keyframesCompact;
        }// end function

        public function set keyframesCompact(param1:Array) : void
        {
            var _loc_2:* = null;
            this._keyframesCompact = param1.concat();
            this.keyframes = [];
            for each (_loc_2 in this._keyframesCompact)
            {
                
                this.addKeyframe(_loc_2);
            }
            return;
        }// end function

        override public function getColorTransform(param1:int) : ColorTransform
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_2:* = null;
            var _loc_3:* = this.getCurrentKeyframe(param1, "color") as Keyframe;
            if (!_loc_3 || !_loc_3.color)
            {
                return null;
            }
            var _loc_4:* = _loc_3.color;
            var _loc_5:* = param1 - _loc_3.index;
            var _loc_6:* = _loc_3.getTween("color") || _loc_3.getTween("alpha") || _loc_3.getTween();
            if (_loc_5 == 0 || !_loc_6)
            {
                _loc_2 = _loc_4;
            }
            else if (_loc_6)
            {
                _loc_7 = this.getNextKeyframe(param1, "color") as Keyframe;
                if (!_loc_7 || !_loc_7.color)
                {
                    _loc_2 = _loc_4;
                }
                else
                {
                    _loc_8 = _loc_7.color;
                    _loc_9 = _loc_7.index - _loc_3.index;
                    _loc_10 = _loc_6.getValue(_loc_5, 0, 1, _loc_9);
                    _loc_2 = Color.interpolateTransform(_loc_4, _loc_8, _loc_10);
                }
            }
            return _loc_2;
        }// end function

        override public function getFilters(param1:Number) : Array
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_2:* = null;
            var _loc_3:* = this.getCurrentKeyframe(param1, "filters") as Keyframe;
            if (!_loc_3 || _loc_3.filters && !_loc_3.filters.length)
            {
                return [];
            }
            var _loc_4:* = _loc_3.filters;
            var _loc_5:* = param1 - _loc_3.index;
            var _loc_6:* = _loc_3.getTween("filters") || _loc_3.getTween();
            if (_loc_5 == 0 || !_loc_6)
            {
                _loc_2 = _loc_4;
            }
            else if (_loc_6)
            {
                _loc_7 = this.getNextKeyframe(param1, "filters") as Keyframe;
                if (!_loc_7 || !_loc_7.filters.length)
                {
                    _loc_2 = _loc_4;
                }
                else
                {
                    _loc_8 = _loc_7.filters;
                    _loc_9 = _loc_7.index - _loc_3.index;
                    _loc_10 = _loc_6.getValue(_loc_5, 0, 1, _loc_9);
                    _loc_2 = interpolateFilters(_loc_4, _loc_8, _loc_10);
                }
            }
            return _loc_2;
        }// end function

        override protected function findTweenedValue(param1:Number, param2:String, param3:KeyframeBase, param4:Number, param5:Number) : Number
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_6:* = param3 as Keyframe;
            if (!(param3 as Keyframe))
            {
                return NaN;
            }
            var _loc_7:* = _loc_6.getTween(param2) || _loc_6.getTween();
            if (!(_loc_6.getTween(param2) || _loc_6.getTween()) || !_loc_6.tweenScale && (param2 == Tweenables.SCALE_X || param2 == Tweenables.SCALE_Y) || _loc_6.rotateDirection == RotateDirection.NONE && (param2 == Tweenables.ROTATION || param2 == Tweenables.SKEW_X || param2 == Tweenables.SKEW_Y))
            {
                return param5;
            }
            var _loc_8:* = param2;
            if (_loc_7.target == "")
            {
                _loc_8 = "";
            }
            var _loc_9:* = this.getNextKeyframe(param1, _loc_8) as Keyframe;
            if (!(this.getNextKeyframe(param1, _loc_8) as Keyframe) || _loc_9.blank)
            {
                return param5;
            }
            _loc_10 = _loc_9.getValue(param2);
            if (isNaN(_loc_10))
            {
                _loc_10 = param5;
            }
            _loc_11 = _loc_10 - param5;
            if (param2 == Tweenables.SKEW_X || param2 == Tweenables.SKEW_Y || param2 == Tweenables.ROTATION)
            {
                if (_loc_6.rotateDirection == RotateDirection.AUTO)
                {
                    _loc_11 = _loc_11 % 360;
                    if (_loc_11 > 180)
                    {
                        _loc_11 = _loc_11 - 360;
                    }
                    else if (_loc_11 < -180)
                    {
                        _loc_11 = _loc_11 + 360;
                    }
                }
                else if (_loc_6.rotateDirection == RotateDirection.CW)
                {
                    if (_loc_11 < 0)
                    {
                        _loc_11 = _loc_11 % 360 + 360;
                    }
                    _loc_11 = _loc_11 + _loc_6.rotateTimes * 360;
                }
                else
                {
                    if (_loc_11 > 0)
                    {
                        _loc_11 = _loc_11 % 360 - 360;
                    }
                    _loc_11 = _loc_11 - _loc_6.rotateTimes * 360;
                }
            }
            _loc_12 = _loc_9.index - _loc_6.index;
            return _loc_7.getValue(param4, param5, _loc_11, _loc_12);
        }// end function

        private function parseXML(param1:XML) : Motion
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!param1)
            {
                return this;
            }
            if (param1.@duration.length())
            {
                this.duration = parseInt(param1.@duration);
            }
            var _loc_2:* = param1.elements();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length())
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4.localName() == "source")
                {
                    _loc_5 = _loc_4.children()[0];
                    this.source = new Source(_loc_5);
                }
                else if (_loc_4.localName() == "Keyframe")
                {
                    this.addKeyframe(this.getNewKeyframe(_loc_4));
                }
                _loc_3 = _loc_3 + 1;
            }
            return this;
        }// end function

        override protected function getNewKeyframe(param1:XML = null) : KeyframeBase
        {
            return new Keyframe(param1);
        }// end function

        public static function fromXMLString(param1:String) : Motion
        {
            var _loc_2:* = new XML(param1);
            return new Motion(_loc_2);
        }// end function

        public static function interpolateFilters(param1:Array, param2:Array, param3:Number) : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1.length != param2.length)
            {
                return null;
            }
            var _loc_4:* = [];
            var _loc_5:* = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_7 = param2[_loc_5];
                _loc_8 = interpolateFilter(_loc_6, _loc_7, param3);
                if (_loc_8)
                {
                    _loc_4.push(_loc_8);
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function interpolateFilter(param1:BitmapFilter, param2:BitmapFilter, param3:Number) : BitmapFilter
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
            var _loc_23:* = 0;
            var _loc_24:* = NaN;
            var _loc_25:* = 0;
            var _loc_26:* = NaN;
            var _loc_27:* = 0;
            var _loc_28:* = NaN;
            var _loc_29:* = 0;
            var _loc_30:* = 0;
            var _loc_31:* = NaN;
            if (!param2 || param1["constructor"] != param2["constructor"])
            {
                return param1;
            }
            if (param3 > 1)
            {
                param3 = 1;
            }
            else if (param3 < 0)
            {
                param3 = 0;
            }
            var _loc_4:* = 1 - param3;
            var _loc_5:* = param1.clone();
            var _loc_6:* = getTypeInfo(param1);
            var _loc_7:* = _loc_6.accessor;
            for each (_loc_8 in _loc_7)
            {
                
                _loc_9 = _loc_8.@name.toString();
                _loc_10 = _loc_8.@type;
                if (_loc_10 == "Number" || _loc_10 == "int")
                {
                    _loc_5[_loc_9] = param1[_loc_9] * _loc_4 + param2[_loc_9] * param3;
                    continue;
                }
                if (_loc_10 == "uint")
                {
                    switch(_loc_9)
                    {
                        case "color":
                        case "highlightColor":
                        case "shadowColor":
                        {
                            _loc_11 = param1[_loc_9];
                            _loc_12 = param2[_loc_9];
                            _loc_13 = Color.interpolateColor(_loc_11, _loc_12, param3);
                            _loc_5[_loc_9] = _loc_13;
                            break;
                        }
                        default:
                        {
                            _loc_5[_loc_9] = param1[_loc_9] * _loc_4 + param2[_loc_9] * param3;
                            break;
                            break;
                        }
                    }
                }
            }
            if (param1 is GradientGlowFilter || param1 is GradientBevelFilter)
            {
                _loc_14 = [];
                _loc_15 = [];
                _loc_16 = [];
                _loc_17 = param1["ratios"].length;
                _loc_18 = param2["ratios"].length;
                _loc_19 = Math.max(_loc_17, _loc_18);
                _loc_20 = 0;
                while (_loc_20 < _loc_19)
                {
                    
                    _loc_21 = Math.min(_loc_20, (_loc_17 - 1));
                    _loc_22 = param1["ratios"][_loc_21];
                    _loc_23 = param1["colors"][_loc_21];
                    _loc_24 = param1["alphas"][_loc_21];
                    _loc_25 = Math.min(_loc_20, (_loc_18 - 1));
                    _loc_26 = param2["ratios"][_loc_25];
                    _loc_27 = param2["colors"][_loc_25];
                    _loc_28 = param2["alphas"][_loc_25];
                    _loc_29 = _loc_22 * _loc_4 + _loc_26 * param3;
                    _loc_30 = Color.interpolateColor(_loc_23, _loc_27, param3);
                    _loc_31 = _loc_24 * _loc_4 + _loc_28 * param3;
                    _loc_14[_loc_20] = _loc_29;
                    _loc_15[_loc_20] = _loc_30;
                    _loc_16[_loc_20] = _loc_31;
                    _loc_20++;
                }
                _loc_5["colors"] = _loc_15;
                _loc_5["alphas"] = _loc_16;
                _loc_5["ratios"] = _loc_14;
            }
            return _loc_5;
        }// end function

        private static function getTypeInfo(param1) : XML
        {
            var _loc_2:* = "";
            if (param1 is String)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = getQualifiedClassName(param1);
            }
            if (_loc_2 in typeCache)
            {
                return typeCache[_loc_2];
            }
            if (param1 is String)
            {
                param1 = getDefinitionByName(param1);
            }
            var _loc_3:* = describeType(param1);
            typeCache[_loc_2] = describeType(param1);
            return _loc_3;
        }// end function

    }
}
