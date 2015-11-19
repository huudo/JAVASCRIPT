package fl.motion
{
    import flash.filters.*;
    import flash.utils.*;

    public class Keyframe extends KeyframeBase
    {
        public var tweens:Array;
        public var tweenScale:Boolean = true;
        public var tweenSnap:Boolean = false;
        public var tweenSync:Boolean = false;

        public function Keyframe(param1:XML = null)
        {
            super(param1);
            this.tweens = [];
            this.parseXML(param1);
            return;
        }// end function

        private function parseXML(param1:XML = null) : KeyframeBase
        {
            var tweenableName:String;
            var elements:XMLList;
            var filtersArray:Array;
            var child:XML;
            var bgColorStr:String;
            var attribute:XML;
            var attributeValue:String;
            var name:String;
            var tweenChildren:XMLList;
            var tweenChild:XML;
            var tweenName:String;
            var filtersChildren:XMLList;
            var filterXML:XML;
            var filterName:String;
            var filterClassName:String;
            var filterClass:Object;
            var filterInstance:BitmapFilter;
            var filterTypeInfo:XML;
            var accessorList:XMLList;
            var ratios:Array;
            var attrib:XML;
            var attribName:String;
            var accessor:XML;
            var attribType:String;
            var attribValue:String;
            var uintValue:uint;
            var valuesArray:Array;
            var xml:* = param1;
            if (!xml)
            {
                return this;
            }
            var indexString:* = xml.@index.toXMLString();
            var indexValue:* = parseInt(indexString);
            if (indexString)
            {
                this.index = indexValue;
            }
            else
            {
                throw new Error("<Keyframe> is missing the required attribute \"index\".");
            }
            if (xml.@label.length())
            {
                this.label = xml.@label;
            }
            if (xml.@tweenScale.length())
            {
                this.tweenScale = xml.@tweenScale.toString() == "true";
            }
            if (xml.@tweenSnap.length())
            {
                this.tweenSnap = xml.@tweenSnap.toString() == "true";
            }
            if (xml.@tweenSync.length())
            {
                this.tweenSync = xml.@tweenSync.toString() == "true";
            }
            if (xml.@blendMode.length())
            {
                this.blendMode = xml.@blendMode;
            }
            if (xml.@cacheAsBitmap.length())
            {
                this.cacheAsBitmap = xml.@cacheAsBitmap.toString() == "true";
            }
            if (xml.@opaqueBackground.length())
            {
                bgColorStr = xml.@opaqueBackground.toString();
                if (bgColorStr == "null")
                {
                    this.opaqueBackground = null;
                }
                else
                {
                    this.opaqueBackground = parseInt(bgColorStr);
                }
            }
            if (xml.@visible.length())
            {
                this.visible = xml.@visible.toString() == "true";
            }
            if (xml.@rotateDirection.length())
            {
                this.rotateDirection = xml.@rotateDirection;
            }
            if (xml.@rotateTimes.length())
            {
                this.rotateTimes = parseInt(xml.@rotateTimes);
            }
            if (xml.@orientToPath.length())
            {
                this.orientToPath = xml.@orientToPath.toString() == "true";
            }
            if (xml.@blank.length())
            {
                this.blank = xml.@blank.toString() == "true";
            }
            var tweenableNames:Array;
            var _loc_3:* = 0;
            var _loc_4:* = tweenableNames;
            while (_loc_4 in _loc_3)
            {
                
                tweenableName = _loc_4[_loc_3];
                attribute = xml.attribute(tweenableName)[0];
                if (!attribute)
                {
                    continue;
                }
                attributeValue = attribute.toString();
                if (attributeValue)
                {
                    this[tweenableName] = Number(attributeValue);
                }
            }
            elements = xml.elements();
            filtersArray;
            var _loc_3:* = 0;
            var _loc_4:* = elements;
            while (_loc_4 in _loc_3)
            {
                
                child = _loc_4[_loc_3];
                name = child.localName();
                if (name == "tweens")
                {
                    tweenChildren = child.elements();
                    var _loc_5:* = 0;
                    var _loc_6:* = tweenChildren;
                    while (_loc_6 in _loc_5)
                    {
                        
                        tweenChild = _loc_6[_loc_5];
                        tweenName = tweenChild.localName();
                        if (tweenName == "SimpleEase")
                        {
                            this.tweens.push(new SimpleEase(tweenChild));
                            continue;
                        }
                        if (tweenName == "CustomEase")
                        {
                            this.tweens.push(new CustomEase(tweenChild));
                            continue;
                        }
                        if (tweenName == "BezierEase")
                        {
                            this.tweens.push(new BezierEase(tweenChild));
                            continue;
                        }
                        if (tweenName == "FunctionEase")
                        {
                            this.tweens.push(new FunctionEase(tweenChild));
                        }
                    }
                }
                else if (name == "filters")
                {
                    filtersChildren = child.elements();
                    var _loc_5:* = 0;
                    var _loc_6:* = filtersChildren;
                    while (_loc_6 in _loc_5)
                    {
                        
                        filterXML = _loc_6[_loc_5];
                        filterName = filterXML.localName();
                        filterClassName = "flash.filters." + filterName;
                        if (filterName == "AdjustColorFilter")
                        {
                            continue;
                        }
                        filterClass = getDefinitionByName(filterClassName);
                        filterInstance = new filterClass;
                        filterTypeInfo = describeType(filterInstance);
                        accessorList = filterTypeInfo.accessor;
                        ratios;
                        var _loc_7:* = 0;
                        var _loc_8:* = filterXML.attributes();
                        while (_loc_8 in _loc_7)
                        {
                            
                            attrib = _loc_8[_loc_7];
                            attribName = attrib.localName();
                            var _loc_10:* = 0;
                            var _loc_11:* = accessorList;
                            var _loc_9:* = new XMLList("");
                            for each (_loc_12 in _loc_11)
                            {
                                
                                var _loc_13:* = _loc_11[_loc_10];
                                with (_loc_11[_loc_10])
                                {
                                    if (@name == attribName)
                                    {
                                        _loc_9[_loc_10] = _loc_12;
                                    }
                                }
                            }
                            accessor = _loc_9[0];
                            attribType = accessor.@type;
                            attribValue = attrib.toString();
                            if (attribType == "int")
                            {
                                filterInstance[attribName] = parseInt(attribValue);
                                continue;
                            }
                            if (attribType == "uint")
                            {
                                filterInstance[attribName] = parseInt(attribValue) as uint;
                                uintValue = parseInt(attribValue) as uint;
                                continue;
                            }
                            if (attribType == "Number")
                            {
                                filterInstance[attribName] = Number(attribValue);
                                continue;
                            }
                            if (attribType == "Boolean")
                            {
                                filterInstance[attribName] = attribValue == "true";
                                continue;
                            }
                            if (attribType == "Array")
                            {
                                attribValue = attribValue.substring(1, (attribValue.length - 1));
                                valuesArray;
                                if (attribName == "ratios" || attribName == "colors")
                                {
                                    valuesArray = splitUint(attribValue);
                                }
                                else if (attribName == "alphas")
                                {
                                    valuesArray = splitNumber(attribValue);
                                }
                                if (attribName == "ratios")
                                {
                                    ratios = valuesArray;
                                }
                                else if (valuesArray)
                                {
                                    filterInstance[attribName] = valuesArray;
                                }
                                continue;
                            }
                            if (attribType == "String")
                            {
                                filterInstance[attribName] = attribValue;
                            }
                        }
                        if (ratios.length)
                        {
                            filterInstance["ratios"] = ratios;
                        }
                        filtersArray.push(filterInstance);
                    }
                }
                else if (name == "color")
                {
                    this.color = Color.fromXML(child);
                }
                this.filters = filtersArray;
            }
            return this;
        }// end function

        public function getTween(param1:String = "") : ITween
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.tweens)
            {
                
                if (_loc_2.target == param1 || _loc_2.target == "rotation" && (param1 == "skewX" || param1 == "skewY") || _loc_2.target == "position" && (param1 == "x" || param1 == "y") || _loc_2.target == "scale" && (param1 == "scaleX" || param1 == "scaleY"))
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        override protected function hasTween() : Boolean
        {
            return this.getTween() != null;
        }// end function

        override public function get tweensLength() : int
        {
            return this.tweens.length;
        }// end function

        private static function splitNumber(param1:String) : Array
        {
            var _loc_2:* = param1.split(",");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = Number(_loc_2[_loc_3]);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private static function splitUint(param1:String) : Array
        {
            var _loc_2:* = param1.split(",");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = parseInt(_loc_2[_loc_3]) as uint;
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private static function splitInt(param1:String) : Array
        {
            var _loc_2:* = param1.split(",");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3] = parseInt(_loc_2[_loc_3]) as int;
                _loc_3++;
            }
            return _loc_2;
        }// end function

    }
}
