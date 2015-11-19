package dtcontent.content
{
    import dtcontent.connect.*;
    import flash.display.*;
    import flash.events.*;

    dynamic public class ContentMain extends MovieClip
    {
        public var backMC:MovieClip;
        public var btnFirst:SimpleButton;
        public var btnStart:SimpleButton;
        public var btnStop:SimpleButton;
        public var mc0:MovieClip;
        public var mc1:MovieClip;
        public var waku:MovieClip;
        public var dtFileData:Object;
        public var dtCommonArea:Array;
        public var lcpList:Array;
        public var acpList:Array;
        public var iconCount:uint = 0;
        public var swfWidth:int = -1;
        public var swfHeight:int = -1;
        protected var _cpVisible:Boolean = false;
        protected var _iconVisible:Boolean = false;
        protected var _linkCPProhibited:Boolean = true;
        protected var _paragNumVisible:Boolean = false;
        protected var _paragLineVisible:Boolean = false;
        protected var _captionVisible:Boolean = true;
        protected var _editorIconVisible:Boolean = false;
        protected var _editorSelected:Boolean = false;
        protected var _toolSelected:Boolean = false;
        protected var _zoomSelected:Boolean = false;
        protected var _editorMode:Boolean = false;
        protected var _editorTextMode:Boolean = false;

        public function ContentMain()
        {
            this.lcpList = new Array();
            this.acpList = new Array();
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function init() : void
        {
            try
            {
                this.mc0.visible = true;
                this.mc1.visible = false;
                this.btnStop.visible = false;
                this.btnFirst.visible = false;
            }
            catch (e:Error)
            {
                trace("init:" + e.message);
            }
            return;
        }// end function

        public function btnStartClick(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                this.mc0.visible = false;
                this.mc1.visible = true;
                this.btnStart.visible = false;
                this.btnStop.visible = true;
                this.btnFirst.visible = true;
                this.mc1.animeStart();
            }
            catch (e:Error)
            {
                trace("btnStartClick:" + e.message);
            }
            return;
        }// end function

        public function btnStopClick(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                this.mc1.animeStop();
            }
            catch (e:Error)
            {
                trace("btnStopClick:" + e.message);
            }
            return;
        }// end function

        public function btnFirstClick(event:MouseEvent) : void
        {
            var event:* = event;
            try
            {
                this.mc1.init();
            }
            catch (e:Error)
            {
                trace("btnFirstClick:" + e.message);
            }
            return;
        }// end function

        public function frameToContent(param1:String, param2) : Boolean
        {
            switch(param1)
            {
                case ConnectConst.SET_COMMON_AREA:
                {
                    this.dtCommonArea = param2;
                    break;
                }
                case ConnectConst.SET_FILE_DATA:
                {
                    this.dtFileData = param2;
                    break;
                }
                case ConnectConst.CP_VISIBLE:
                {
                    this.cpVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.ICON_VISIBLE:
                {
                    this.iconVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.EDITOR_SELECTED:
                {
                    this.editorSelected = Boolean(param2);
                    break;
                }
                case ConnectConst.TOOL_SELECTED:
                {
                    this.toolSelected = Boolean(param2);
                    break;
                }
                case ConnectConst.ZOOM_SELECTED:
                {
                    this.zoomSelected = Boolean(param2);
                    break;
                }
                case ConnectConst.LINK_CP_PROHIBITED:
                {
                    this.linkCPProhibited = Boolean(param2);
                    break;
                }
                case ConnectConst.EDITOR_MODE:
                {
                    this.editorMode = Boolean(param2);
                    break;
                }
                case ConnectConst.EDITOR_TEXT_MODE:
                {
                    this.editorTextMode = Boolean(param2);
                    break;
                }
                case ConnectConst.EDITOR_ICON_VISIBLE:
                {
                    this.editorIconVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.PARAG_NUM_VISIBLE:
                {
                    this.paragNumVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.PARAG_LINE_VISIBLE:
                {
                    this.paragLineVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.CAPTION_VISIBLE:
                {
                    this.captionVisible = Boolean(param2);
                    break;
                }
                case ConnectConst.DISP_START:
                {
                    if (this.hasOwnProperty("onMessageDispStart"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessageDispStart"](param2);
                    }
                    break;
                }
                case ConnectConst.DISP_COMPLETE:
                {
                    if (this.hasOwnProperty("onMessageDispComplete"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessageDispComplete"](param2);
                    }
                    break;
                }
                case ConnectConst.CLOSE:
                {
                    if (this.hasOwnProperty("onMessageClose"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessageClose"](param2);
                    }
                    break;
                }
                case ConnectConst.PAUSE:
                {
                    if (this.hasOwnProperty("onMessagePause"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessagePause"](param2);
                    }
                    break;
                }
                case ConnectConst.RESUME:
                {
                    if (this.hasOwnProperty("onMessageResume"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessageResume"](param2);
                    }
                    break;
                }
                case ConnectConst.FILE_LOADED:
                {
                    if (this.hasOwnProperty("onMessageFileLoaded"))
                    {
                        var _loc_3:* = this;
                        _loc_3["onMessageFileLoaded"](param2);
                    }
                    break;
                }
                default:
                {
                    return false;
                    break;
                }
            }
            return true;
        }// end function

        public function contentToFrame(param1:String, param2) : Boolean
        {
            var _loc_3:* = null;
            if (parent && stage && parent == stage)
            {
                return false;
            }
            _loc_3 = new ConnectEvent(ConnectEvent.CONNECT, param1, param2);
            dispatchEvent(_loc_3);
            return true;
        }// end function

        public function initialize() : void
        {
            stop();
            this.cpVisible = this._cpVisible;
            this.iconVisible = this._iconVisible;
            this.paragNumVisible = this._paragNumVisible;
            this.paragLineVisible = this._paragLineVisible;
            this.captionVisible = this._captionVisible;
            this.editorIconVisible = this._editorIconVisible;
            this.editorMode = this._editorMode;
            this.editorTextMode = this._editorTextMode;
            if (this.hasOwnProperty("editor"))
            {
                this["editor"].visible = false;
            }
            return;
        }// end function

        public function set cpVisible(param1:Boolean) : void
        {
            this._cpVisible = param1;
            if (this._cpVisible == true)
            {
                ContentLinkClickPoint.cpAlpha = ContentLinkClickPoint.cpAlphaStyle;
                ContentActionClickPoint.cpAlpha = ContentActionClickPoint.cpAlphaStyle;
            }
            else
            {
                ContentLinkClickPoint.cpAlpha = 0;
                ContentActionClickPoint.cpAlpha = 0;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.lcpList.length)
            {
                
                this.lcpList[_loc_2].alpha = ContentLinkClickPoint.cpAlpha;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this.acpList.length)
            {
                
                this.acpList[_loc_2].alpha = ContentActionClickPoint.cpAlpha;
                _loc_2++;
            }
            return;
        }// end function

        public function get cpVisible() : Boolean
        {
            return this._cpVisible;
        }// end function

        public function set iconVisible(param1:Boolean) : void
        {
            this._iconVisible = param1;
            if (this.hasOwnProperty("dtIcon"))
            {
                this["dtIcon"].visible = this._iconVisible;
            }
            return;
        }// end function

        public function get iconVisible() : Boolean
        {
            return this._iconVisible;
        }// end function

        public function set paragNumVisible(param1:Boolean) : void
        {
            this._paragNumVisible = param1;
            if (this.hasOwnProperty("dtParagNum"))
            {
                this["dtParagNum"].visible = this._paragNumVisible;
            }
            return;
        }// end function

        public function get paragNumVisible() : Boolean
        {
            return this._paragNumVisible;
        }// end function

        public function set paragLineVisible(param1:Boolean) : void
        {
            this._paragLineVisible = param1;
            if (this.hasOwnProperty("dtParagLine"))
            {
                this["dtParagLine"].visible = this._paragLineVisible;
            }
            return;
        }// end function

        public function get paragLineVisible() : Boolean
        {
            return this._paragLineVisible;
        }// end function

        public function set captionVisible(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            this._captionVisible = param1;
            if (this.hasOwnProperty("dtCaptionList"))
            {
                _loc_2 = this["dtCaptionList"];
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_2[_loc_3].visible = this._captionVisible;
                    if (_loc_2[_loc_3].parent)
                    {
                        _loc_2[_loc_3].parent.addChild(_loc_2[_loc_3]);
                    }
                    _loc_3++;
                }
            }
            else if (this.hasOwnProperty("dtCaption"))
            {
                this["dtCaption"].visible = this._captionVisible;
                addChild(this["dtCaption"]);
            }
            return;
        }// end function

        public function get captionVisible() : Boolean
        {
            return this._captionVisible;
        }// end function

        public function set editorIconVisible(param1:Boolean) : void
        {
            this._editorIconVisible = param1;
            if (this.hasOwnProperty("editorIcon"))
            {
                this["editorIcon"].visible = this._editorIconVisible;
            }
            return;
        }// end function

        public function get editorIconVisible() : Boolean
        {
            return this._editorIconVisible;
        }// end function

        public function set linkCPProhibited(param1:Boolean) : void
        {
            this._linkCPProhibited = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.lcpList.length)
            {
                
                this.lcpList[_loc_2].prohibited = param1;
                _loc_2++;
            }
            return;
        }// end function

        public function get linkCPProhibited() : Boolean
        {
            return this._linkCPProhibited;
        }// end function

        public function set editorSelected(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (param1 == true)
            {
                _loc_2 = 0;
                while (_loc_2 < this.lcpList.length)
                {
                    
                    this.lcpList[_loc_2].alpha = 0;
                    _loc_2++;
                }
                _loc_2 = 0;
                while (_loc_2 < this.acpList.length)
                {
                    
                    this.acpList[_loc_2].alpha = 0;
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this.lcpList.length)
                {
                    
                    this.lcpList[_loc_2].alpha = ContentLinkClickPoint.cpAlpha;
                    _loc_2++;
                }
                _loc_2 = 0;
                while (_loc_2 < this.acpList.length)
                {
                    
                    this.acpList[_loc_2].alpha = ContentActionClickPoint.cpAlpha;
                    _loc_2++;
                }
            }
            this._editorSelected = param1;
            return;
        }// end function

        public function get editorSelected() : Boolean
        {
            return this._editorSelected;
        }// end function

        public function set toolSelected(param1:Boolean) : void
        {
            this._toolSelected = param1;
            return;
        }// end function

        public function get toolSelected() : Boolean
        {
            return this._toolSelected;
        }// end function

        public function set zoomSelected(param1:Boolean) : void
        {
            this._zoomSelected = param1;
            return;
        }// end function

        public function get zoomSelected() : Boolean
        {
            return this._zoomSelected;
        }// end function

        public function set editorMode(param1:Boolean) : void
        {
            this._editorMode = param1;
            return;
        }// end function

        public function get editorMode() : Boolean
        {
            return this._editorMode;
        }// end function

        public function set editorTextMode(param1:Boolean) : void
        {
            this._editorTextMode = param1;
            var _loc_2:* = 1;
            var _loc_3:* = 1;
            while (this.hasOwnProperty("dtTextEdit" + this.formatZero(_loc_2, 3)))
            {
                
                this["dtTextEdit" + this.formatZero(_loc_2, 3)].visible = param1;
                this["dtTextView" + this.formatZero(_loc_2, 3)].visible = !param1;
                _loc_3 = 1;
                while (this.hasOwnProperty("dtTextEdit" + this.formatZero(_loc_2, 3) + "_" + this.formatZero(_loc_3, 3)))
                {
                    
                    this["dtTextEdit" + this.formatZero(_loc_2, 3) + "_" + this.formatZero(_loc_3, 3)].visible = param1;
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function get editorTextMode() : Boolean
        {
            return this._editorTextMode;
        }// end function

        public function setEditorText(param1:Array) : void
        {
            var _loc_2:* = 1;
            while (this.hasOwnProperty("dtTextEdit" + this.formatZero(_loc_2, 3)))
            {
                
                this["dtTextEdit" + this.formatZero(_loc_2, 3)].text = param1[(_loc_2 - 1)];
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function getEditorText() : Array
        {
            var _loc_1:* = new Array();
            var _loc_2:* = 1;
            while (this.hasOwnProperty("dtTextEdit" + this.formatZero(_loc_2, 3)))
            {
                
                _loc_1.push(this["dtTextEdit" + this.formatZero(_loc_2, 3)].text);
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public function formatZero(param1:int, param2:uint) : String
        {
            return ("0000000000000000000000000" + param1.toString()).substr(-param2);
        }// end function

        public function checkChild(param1, param2:String) : Boolean
        {
            var _loc_3:* = null;
            _loc_3 = param1.getChildByName(param2);
            if (_loc_3 != null)
            {
                return true;
            }
            return false;
        }// end function

        public function getKyokaInitial() : String
        {
            var _loc_1:* = this.loaderInfo.url.split("/");
            return _loc_1[(_loc_1.length - 1)].substr(0, 1);
        }// end function

        function frame1()
        {
            this.initialize();
            this.init();
            this.btnStart.addEventListener(MouseEvent.CLICK, this.btnStartClick);
            this.btnStop.addEventListener(MouseEvent.CLICK, this.btnStopClick);
            this.btnFirst.addEventListener(MouseEvent.CLICK, this.btnFirstClick);
            this.waku.visible = false;
            return;
        }// end function

    }
}
