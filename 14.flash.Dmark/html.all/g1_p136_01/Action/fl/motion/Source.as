package fl.motion
{
    import flash.geom.*;

    public class Source extends Object
    {
        public var frameRate:Number = NaN;
        public var elementType:String = "";
        public var symbolName:String = "";
        public var instanceName:String = "";
        public var linkageID:String = "";
        public var x:Number = 0;
        public var y:Number = 0;
        public var scaleX:Number = 1;
        public var scaleY:Number = 1;
        public var skewX:Number = 0;
        public var skewY:Number = 0;
        public var rotation:Number = 0;
        public var transformationPoint:Point;
        public var dimensions:Rectangle;

        public function Source(param1:XML = null)
        {
            this.parseXML(param1);
            return;
        }// end function

        private function parseXML(param1:XML = null) : Source
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!param1)
            {
                return this;
            }
            if (param1.@instanceName)
            {
                this.instanceName = String(param1.@instanceName);
            }
            if (param1.@symbolName)
            {
                this.symbolName = String(param1.@symbolName);
            }
            if (param1.@linkageID)
            {
                this.linkageID = String(param1.@linkageID);
            }
            if (!isNaN(param1.@frameRate))
            {
                this.frameRate = Number(param1.@frameRate);
            }
            var _loc_2:* = param1.elements();
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.localName() == "transformationPoint")
                {
                    _loc_4 = _loc_3.children()[0];
                    this.transformationPoint = new Point(Number(_loc_4.@x), Number(_loc_4.@y));
                    continue;
                }
                if (_loc_3.localName() == "dimensions")
                {
                    _loc_5 = _loc_3.children()[0];
                    this.dimensions = new Rectangle(Number(_loc_5.@left), Number(_loc_5.@top), Number(_loc_5.@width), Number(_loc_5.@height));
                }
            }
            return this;
        }// end function

    }
}
