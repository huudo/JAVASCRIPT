package g3_p85_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var refresh_flag:Boolean;
        public var push_btn_flag:Boolean;
        public var start_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var len_P:Number;
        public var len_Q:Number;
        public var pq_move_flag:Boolean;
        public const _MIN_FRAME:uint = 30;
        public const _PUSH_BAR_LX:int = -300;
        public const _PUSH_BAR_RX:int = 300;
        public const _MOVE_FRAME:uint = 120;
        public const _START_LEN_P:uint = 2;
        public const _RESET_LEN_P:uint = 0;
        public const _SQUARE_H:uint = 6;
        public const _SQUARE_W:uint = 6;
        public const _LEN_MAX:uint = 6;
        public const _LEN_TO_PIX:uint = 65;
        public const _BAR_TO_LEN:uint = 100;
        public const _RECT_COLOR:Number = 16641512;
        public var point_status:Array;
        public var line_status:Array;
        public var area_shape:Object;
        public var area_panel:Object;
        public var line_shape:Object;
        public var line_panel:Object;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function controlMain(event:Event) : void
        {
            switch(this.Main_index)
            {
                case 0:
                {
                    this.entryPushBtn();
                    this.entryStartBtn();
                    this.entryStopBtn();
                    this.entryResetBtn();
                    this.Main_timer = 0;
                    this.Main_index = 10;
                    break;
                }
                case 9:
                {
                    this.resetMainItem();
                    this.Main_timer = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.getStartBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                        this.pq_move_flag = true;
                        this.setStartBtn(false);
                    }
                    else if (this.getStopBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                        this.pq_move_flag = false;
                        this.setStopBtn(false);
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_index = 9;
                    }
                    this.movePointPQ();
                    if (this.refresh_flag == true)
                    {
                        this.dispTriangleAPQ();
                        this.dispArrowPQ(false);
                        this.refresh_flag = false;
                    }
                    break;
                }
                case 50:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.Ins_Item_Explain.Ins_Square.Ins_Area_Mc.removeChild(this.area_shape);
            this.Ins_Item_Explain.Ins_Square.Ins_Line_Mc.removeChild(this.line_shape);
            this.releasePushBtn();
            this.releaseStartBtn();
            this.releaseStopBtn();
            this.releaseResetBtn();
            stage.removeChild(this.deb_mc);
            return;
        }// end function

        public function clearMainItem() : void
        {
            return;
        }// end function

        public function initMainItem() : void
        {
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.len_P = 2;
            this.len_Q = 2;
            this.pq_move_flag = false;
            this.Ins_Item_Explain.Ins_Square.Ins_P.visible = true;
            this.Ins_Item_Explain.Ins_Square.Ins_P.x = this.getLengthPtoX(this.len_P);
            this.Ins_Item_Explain.Ins_Square.Ins_P.y = this.getLengthPtoY(this.len_P);
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.visible = false;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.x = this.Ins_Item_Explain.Ins_Square.Ins_P.x - 60;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.y = this.Ins_Item_Explain.Ins_Square.Ins_P.y - 30;
            this.Ins_Item_Explain.Ins_Square.Ins_Q.visible = true;
            this.Ins_Item_Explain.Ins_Square.Ins_Q.x = this.getLengthQtoX(this.len_Q);
            this.Ins_Item_Explain.Ins_Square.Ins_Q.y = this.getLengthQtoY(this.len_Q);
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.visible = false;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.x = this.Ins_Item_Explain.Ins_Square.Ins_Q.x + 30;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.y = this.Ins_Item_Explain.Ins_Square.Ins_Q.y + 60;
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x = this._PUSH_BAR_LX + this._BAR_TO_LEN * this.len_P;
            this.dispTriangleAPQ();
            this.dispArrowPQ(true);
            return;
        }// end function

        public function resetMainItem() : void
        {
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.len_P = 0;
            this.len_Q = 0;
            this.pq_move_flag = false;
            this.Ins_Item_Explain.Ins_Square.Ins_P.visible = true;
            this.Ins_Item_Explain.Ins_Square.Ins_P.x = this.getLengthPtoX(this.len_P);
            this.Ins_Item_Explain.Ins_Square.Ins_P.y = this.getLengthPtoY(this.len_P);
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.visible = false;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.x = this.Ins_Item_Explain.Ins_Square.Ins_P.x - 60;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.y = this.Ins_Item_Explain.Ins_Square.Ins_P.y - 30;
            this.Ins_Item_Explain.Ins_Square.Ins_Q.visible = true;
            this.Ins_Item_Explain.Ins_Square.Ins_Q.x = this.getLengthQtoX(this.len_Q);
            this.Ins_Item_Explain.Ins_Square.Ins_Q.y = this.getLengthQtoY(this.len_Q);
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.visible = false;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.x = this.Ins_Item_Explain.Ins_Square.Ins_Q.x + 30;
            this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.y = this.Ins_Item_Explain.Ins_Square.Ins_Q.y + 60;
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x = this._PUSH_BAR_LX + this._BAR_TO_LEN * this.len_P;
            this.dispTriangleAPQ();
            this.dispArrowPQ(true);
            return;
        }// end function

        public function movePointPQ() : void
        {
            if (this.pq_move_flag == true)
            {
                this.len_P = this.len_P + this._LEN_MAX / this._MOVE_FRAME;
                this.len_Q = this.len_P;
                if (this.len_P <= this._LEN_MAX)
                {
                    this.Ins_Item_Explain.Ins_Square.Ins_P.x = this.getLengthPtoX(this.len_P);
                    this.Ins_Item_Explain.Ins_Square.Ins_P.y = this.getLengthPtoY(this.len_P);
                    this.Ins_Item_Explain.Ins_Square.Ins_Q.x = this.getLengthQtoX(this.len_Q);
                    this.Ins_Item_Explain.Ins_Square.Ins_Q.y = this.getLengthQtoY(this.len_Q);
                    this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x = this._PUSH_BAR_LX + this.len_P * this._BAR_TO_LEN;
                    this.refresh_flag = true;
                }
                else
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.len_P = this._LEN_MAX;
                    this.len_Q = this.len_P;
                    this.pq_move_flag = false;
                    this.refresh_flag = true;
                }
            }
            return;
        }// end function

        public function dispLinePQ(param1:Boolean) : void
        {
            if (param1 == true)
            {
                this.line_panel.clear();
                this.line_panel.lineStyle(this.line_status[0].size, this.line_status[0].color, 1);
                this.line_panel.moveTo(this.Ins_Item_Explain.Ins_Square.Ins_P.x, this.Ins_Item_Explain.Ins_Square.Ins_P.y);
                this.line_panel.lineTo(this.Ins_Item_Explain.Ins_Square.Ins_Q.x, this.Ins_Item_Explain.Ins_Square.Ins_Q.y);
            }
            else
            {
                this.line_panel.clear();
            }
            return;
        }// end function

        public function dispTriangleAPQ() : void
        {
            this.area_panel.clear();
            this.area_panel.lineStyle(this.line_status[1].size, this.line_status[1].color, 1);
            this.area_panel.beginFill(this._RECT_COLOR, 1);
            this.area_panel.moveTo(this.point_status[0].dx, this.point_status[0].dy);
            this.area_panel.lineTo(this.Ins_Item_Explain.Ins_Square.Ins_P.x, this.Ins_Item_Explain.Ins_Square.Ins_P.y);
            this.area_panel.lineTo(this.Ins_Item_Explain.Ins_Square.Ins_Q.x, this.Ins_Item_Explain.Ins_Square.Ins_Q.y);
            this.area_panel.endFill();
            return;
        }// end function

        public function dispArrowPQ(param1:Boolean) : void
        {
            if (param1 == true)
            {
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.visible = true;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.x = this.Ins_Item_Explain.Ins_Square.Ins_P.x - 30;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.y = this.Ins_Item_Explain.Ins_Square.Ins_P.y + 60;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.visible = true;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.x = this.Ins_Item_Explain.Ins_Square.Ins_Q.x - 60;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.y = this.Ins_Item_Explain.Ins_Square.Ins_Q.y - 30;
            }
            else
            {
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.visible = false;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.x = this.Ins_Item_Explain.Ins_Square.Ins_P.x - 30;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowP.y = this.Ins_Item_Explain.Ins_Square.Ins_P.y + 60;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.visible = false;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.x = this.Ins_Item_Explain.Ins_Square.Ins_Q.x - 60;
                this.Ins_Item_Explain.Ins_Square.Ins_ArrowQ.y = this.Ins_Item_Explain.Ins_Square.Ins_Q.y - 30;
            }
            return;
        }// end function

        public function getLengthPtoX(param1:Number) : int
        {
            var _loc_2:* = 0;
            if (param1 <= this._SQUARE_W)
            {
                _loc_2 = this.point_status[0].dx;
            }
            else if (param1 <= this._SQUARE_H + this._SQUARE_W)
            {
                _loc_2 = this.point_status[0].dx + (param1 - this._SQUARE_H) * this._LEN_TO_PIX;
            }
            else
            {
                _loc_2 = this.point_status[2].dx;
            }
            return _loc_2;
        }// end function

        public function getLengthPtoY(param1:Number) : int
        {
            var _loc_2:* = 0;
            if (param1 <= this._SQUARE_W)
            {
                _loc_2 = this.point_status[0].dy + param1 * this._LEN_TO_PIX;
            }
            else if (param1 <= this._SQUARE_H + this._SQUARE_W)
            {
                _loc_2 = this.point_status[1].dy;
            }
            else
            {
                _loc_2 = this.point_status[2].dy - (param1 - (this._SQUARE_H + this._SQUARE_W)) * this._LEN_TO_PIX;
            }
            return _loc_2;
        }// end function

        public function getLengthQtoX(param1:Number) : int
        {
            var _loc_2:* = 0;
            if (param1 <= this._SQUARE_H)
            {
                _loc_2 = this.point_status[3].dx - param1 * this._LEN_TO_PIX;
            }
            else if (param1 <= this._SQUARE_H + this._SQUARE_W)
            {
                _loc_2 = this.point_status[0].dx;
            }
            else
            {
                _loc_2 = this.point_status[1].dx + (param1 - (this._SQUARE_H + this._SQUARE_W)) * this._LEN_TO_PIX;
            }
            return _loc_2;
        }// end function

        public function getLengthQtoY(param1:Number) : int
        {
            var _loc_2:* = 0;
            if (param1 <= this._SQUARE_H)
            {
                _loc_2 = this.point_status[3].dy;
            }
            else if (param1 <= this._SQUARE_H + this._SQUARE_W)
            {
                _loc_2 = this.point_status[0].dy + (param1 - this._SQUARE_H) * this._LEN_TO_PIX;
            }
            else
            {
                _loc_2 = this.point_status[1].dy;
            }
            return _loc_2;
        }// end function

        public function entryPushBtn() : void
        {
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.addEventListener(MouseEvent.MOUSE_UP, this.outPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.addEventListener(MouseEvent.MOUSE_MOVE, this.movePushBtn);
            return;
        }// end function

        public function releasePushBtn() : void
        {
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.outPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outPushBtn);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.removeEventListener(MouseEvent.MOUSE_MOVE, this.movePushBtn);
            return;
        }// end function

        public function downPushBtn(event:MouseEvent) : void
        {
            this.push_btn_flag = true;
            return;
        }// end function

        public function outPushBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            _loc_2 = this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x;
            _loc_2 = Math.round((_loc_2 - this._PUSH_BAR_LX) / this._BAR_TO_LEN);
            this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x = this._PUSH_BAR_LX + _loc_2 * this._BAR_TO_LEN;
            this.len_P = _loc_2;
            this.Ins_Item_Explain.Ins_Square.Ins_P.x = this.getLengthPtoX(this.len_P);
            this.Ins_Item_Explain.Ins_Square.Ins_P.y = this.getLengthPtoY(this.len_P);
            this.len_Q = this.len_P;
            this.Ins_Item_Explain.Ins_Square.Ins_Q.x = this.getLengthQtoX(this.len_Q);
            this.Ins_Item_Explain.Ins_Square.Ins_Q.y = this.getLengthQtoY(this.len_Q);
            this.refresh_flag = true;
            this.push_btn_flag = false;
            return;
        }// end function

        public function movePushBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.push_btn_flag == true)
            {
                _loc_2 = this.Ins_Item_Control.Ins_Bar.mouseX;
                if (_loc_2 < this._PUSH_BAR_LX)
                {
                    _loc_2 = this._PUSH_BAR_LX;
                }
                else if (_loc_2 > this._PUSH_BAR_RX)
                {
                    _loc_2 = this._PUSH_BAR_RX;
                }
                this.Ins_Item_Control.Ins_Bar.Ins_Push_Btn.x = _loc_2;
                this.len_P = (_loc_2 - this._PUSH_BAR_LX) / this._BAR_TO_LEN;
                this.Ins_Item_Explain.Ins_Square.Ins_P.x = this.getLengthPtoX(this.len_P);
                this.Ins_Item_Explain.Ins_Square.Ins_P.y = this.getLengthPtoY(this.len_P);
                this.len_Q = this.len_P;
                this.Ins_Item_Explain.Ins_Square.Ins_Q.x = this.getLengthQtoX(this.len_Q);
                this.Ins_Item_Explain.Ins_Square.Ins_Q.y = this.getLengthQtoY(this.len_Q);
                this.refresh_flag = true;
            }
            return;
        }// end function

        public function getPushBtn() : Boolean
        {
            return this.push_btn_flag;
        }// end function

        public function entryStartBtn() : void
        {
            this.Ins_Item_Control.Ins_Start_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStartBtn);
            return;
        }// end function

        public function releaseStartBtn() : void
        {
            this.Ins_Item_Control.Ins_Start_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStartBtn);
            return;
        }// end function

        public function downStartBtn(event:MouseEvent) : void
        {
            this.start_btn_flag = true;
            return;
        }// end function

        public function getStartBtn() : Boolean
        {
            return this.start_btn_flag;
        }// end function

        public function setStartBtn(param1:Boolean) : void
        {
            this.start_btn_flag = param1;
            return;
        }// end function

        public function entryStopBtn() : void
        {
            this.Ins_Item_Control.Ins_Stop_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStopBtn);
            return;
        }// end function

        public function releaseStopBtn() : void
        {
            this.Ins_Item_Control.Ins_Stop_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStopBtn);
            return;
        }// end function

        public function downStopBtn(event:MouseEvent) : void
        {
            this.stop_btn_flag = true;
            return;
        }// end function

        public function getStopBtn() : Boolean
        {
            return this.stop_btn_flag;
        }// end function

        public function setStopBtn(param1:Boolean) : void
        {
            this.stop_btn_flag = param1;
            return;
        }// end function

        public function entryResetBtn() : void
        {
            this.Ins_Item_Control.Ins_Reset_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downResetBtn);
            return;
        }// end function

        public function releaseResetBtn() : void
        {
            this.Ins_Item_Control.Ins_Reset_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downResetBtn);
            return;
        }// end function

        public function downResetBtn(event:MouseEvent) : void
        {
            this.reset_btn_flag = true;
            return;
        }// end function

        public function getResetBtn() : Boolean
        {
            return this.reset_btn_flag;
        }// end function

        public function setResetBtn(param1:Boolean) : void
        {
            this.reset_btn_flag = param1;
            return;
        }// end function

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.refresh_flag = false;
            this.push_btn_flag = false;
            this.start_btn_flag = false;
            this.stop_btn_flag = false;
            this.reset_btn_flag = false;
            this.len_P = 0;
            this.len_Q = 0;
            this.pq_move_flag = true;
            this.point_status = [{ins:"", dx:-195, dy:-195}, {ins:"", dx:-195, dy:195}, {ins:"", dx:195, dy:195}, {ins:"", dx:195, dy:-195}, {ins:"Ins_P", dx:-195, dy:-195}, {ins:"Ins_Q", dx:195, dy:-195}];
            this.line_status = [{ins:"", size:2.5, color:16716947, sx:-195, sy:-195}, {ins:"", size:2, color:0, sx:-195, sy:-195}];
            this.area_shape = new Shape();
            this.Ins_Item_Explain.Ins_Square.Ins_Area_Mc.addChild(this.area_shape);
            this.area_panel = this.area_shape.graphics;
            this.line_shape = new Shape();
            this.Ins_Item_Explain.Ins_Square.Ins_Line_Mc.addChild(this.line_shape);
            this.line_panel = this.line_shape.graphics;
            this.initMainItem();
            this.deb_mc = new MovieClip();
            stage.addChild(this.deb_mc);
            this.deb_mc.mouseChildren = false;
            this.deb_mc.mouseEnabled = false;
            this.deb_text = new TextField();
            this.deb_mc.addChild(this.deb_text);
            this.deb_text.textColor = 0;
            this.deb_text.width = 320;
            this.deb_text.height = 40;
            this.deb_text.x = 0;
            this.deb_text.y = 240;
            this.Ins_Item_Control.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                removeEventListener(event.type, arguments.callee);
                clearMainItem();
                clearMainEvent();
                return;
            }// end function
            );
            addEventListener(Event.ENTER_FRAME, this.controlMain);
            return;
        }// end function

    }
}
