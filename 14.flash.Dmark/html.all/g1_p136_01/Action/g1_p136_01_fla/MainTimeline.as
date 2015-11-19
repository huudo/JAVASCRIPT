package g1_p136_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Ins_Item_Graph:MovieClip;
        public var Main_mode:uint;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var Disp_mode:int;
        public var Explain_index:uint;
        public var Graph_index:uint;
        public var start_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var disp_mode1_flag:Boolean;
        public var disp_mode3_flag:Boolean;
        public var disp_mode2_flag:Boolean;
        public var disp_fusen_flag:Boolean;
        public var pause_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _EXP_SEC_FRAME:uint = 5;
        public const _GRAPH_SIZE_W:uint = 720;
        public const _GRAPH_SIZE_H:uint = 360;
        public const _FR_FUSEN:uint = 200;
        public const _FR_MAN_STOP:uint = 301;
        public var line_status:Array;
        public var chara_status:Array;
        public var line_shape_g:Object;
        public var line_panel_g:Object;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var move_frame:int;
        public var move_timer1:int;
        public var move_timer2:int;
        public var move_length1:Number;
        public var move_length2:Number;
        public var move_per_len1:Number;
        public var move_per_len2:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function controlMain(event:Event) : void
        {
            var _loc_2:* = 0;
            switch(this.Main_index)
            {
                case 0:
                {
                    this.entryStartBtn();
                    this.entryStopBtn();
                    this.entryResetBtn();
                    this.entryDisp1Btn();
                    this.entryDisp2Btn();
                    this.entryDisp3Btn();
                    this.entryCheckBox();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    this.initExplain();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getStartBtn() == true)
                    {
                        this.dispExplain();
                        this.changeActionBtn("Ins_Stop_Btn");
                        this.dispStopClock("start");
                        this.setStartBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    if (this.pause_flag == false)
                    {
                        if (this.getStopBtn() == true)
                        {
                            this.Ins_Item_Explain.Ins_Road.Ins_Auto.stop();
                            this.Ins_Item_Explain.Ins_Man.stop();
                            this.changeActionBtn("Ins_Start_Btn");
                            this.dispStopClock("stop");
                            this.setStopBtn(false);
                            this.pause_flag = true;
                        }
                        else
                        {
                            var _loc_3:* = this;
                            var _loc_4:* = this.move_frame + 1;
                            _loc_3.move_frame = _loc_4;
                            _loc_2 = this.moveAutoRoad();
                            this.controlGraph(this.move_timer1, this.move_timer2, this._EXP_SEC_FRAME);
                            if (_loc_2 == 2)
                            {
                            }
                            else if (_loc_2 == 3)
                            {
                                this.Ins_Item_Explain.Ins_Road.Ins_Auto.stop();
                                this.Main_timer = 0;
                                this.Main_action = 0;
                                this.Main_index = 50;
                            }
                            if (this.getCheckBox() == true && this.move_frame == this._FR_FUSEN)
                            {
                                this.dispClockFusen(true);
                            }
                            else if (this.move_frame == this._FR_MAN_STOP)
                            {
                                this.Ins_Item_Explain.Ins_Road.Ins_Auto.stop();
                                this.Ins_Item_Explain.Ins_Man.stop();
                                this.changeActionBtn("Ins_Start_Btn");
                                this.dispStopClock("stop");
                                this.pause_flag = true;
                            }
                        }
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.Ins_Item_Explain.Ins_Road.Ins_Auto.play();
                        if (this.move_frame < this._FR_MAN_STOP)
                        {
                            this.Ins_Item_Explain.Ins_Man.play();
                        }
                        this.changeActionBtn("Ins_Stop_Btn");
                        this.dispStopClock("start");
                        this.setStartBtn(false);
                        this.pause_flag = false;
                    }
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    break;
                }
                case 50:
                {
                    this.Ins_Item_Explain.Ins_Road.Ins_Auto.stop();
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    break;
                }
                case 99:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.dispClockTimer(this.move_frame, this._EXP_SEC_FRAME);
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.Ins_Item_Graph.Ins_Line_Mc.removeChild(this.line_shape_g);
            this.releaseStartBtn();
            this.releaseStopBtn();
            this.releaseResetBtn();
            this.releaseDisp1Btn();
            this.releaseDisp2Btn();
            this.releaseDisp3Btn();
            this.releaseCheckBox();
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
            this.Disp_mode = 0;
            this.changeDispMode(this.Disp_mode);
            this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("on");
            this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("off");
            this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("off");
            this.dispClockFusen(false);
            return;
        }// end function

        public function changeDispMode(param1:uint) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.Ins_Item_Explain.visible = true;
                    this.Ins_Item_Explain.x = 550;
                    this.Ins_Item_Explain.y = 210;
                    this.Ins_Item_Explain.scaleX = 1;
                    this.Ins_Item_Explain.scaleY = this.Ins_Item_Explain.scaleX;
                    this.Ins_Item_Graph.visible = false;
                    this.Ins_Item_Control.Ins_Clock.y = 186;
                    this.Ins_Item_Control.Ins_Clock.scaleX = 0.65;
                    this.Ins_Item_Control.Ins_Clock.scaleY = this.Ins_Item_Control.Ins_Clock.scaleX;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Explain.visible = true;
                    this.Ins_Item_Explain.x = 550;
                    this.Ins_Item_Explain.y = 100;
                    this.Ins_Item_Explain.scaleX = 0.9;
                    this.Ins_Item_Explain.scaleY = this.Ins_Item_Explain.scaleX;
                    this.Ins_Item_Graph.visible = true;
                    this.Ins_Item_Graph.x = 520;
                    this.Ins_Item_Graph.y = 315;
                    this.Ins_Item_Graph.scaleX = 0.5;
                    this.Ins_Item_Graph.scaleY = this.Ins_Item_Graph.scaleX;
                    this.Ins_Item_Control.Ins_Clock.y = 210;
                    this.Ins_Item_Control.Ins_Clock.scaleX = 0.5;
                    this.Ins_Item_Control.Ins_Clock.scaleY = this.Ins_Item_Control.Ins_Clock.scaleX;
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Graph.visible = true;
                    this.Ins_Item_Graph.x = 490;
                    this.Ins_Item_Graph.y = 230;
                    this.Ins_Item_Graph.scaleX = 0.85;
                    this.Ins_Item_Graph.scaleY = this.Ins_Item_Graph.scaleX;
                    this.Ins_Item_Explain.visible = false;
                    this.Ins_Item_Control.Ins_Clock.y = 210;
                    this.Ins_Item_Control.Ins_Clock.scaleX = 0.5;
                    this.Ins_Item_Control.Ins_Clock.scaleY = this.Ins_Item_Control.Ins_Clock.scaleX;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initExplain() : void
        {
            this.changeActionBtn("Ins_Start_Btn");
            this.Ins_Item_Explain.Ins_Exp.visible = true;
            this.move_frame = 1;
            this.move_timer1 = 0;
            this.move_timer2 = 0;
            this.move_length1 = 0;
            this.move_length2 = 0;
            this.pause_flag = false;
            this.Ins_Item_Explain.Ins_Woman.visible = false;
            this.Ins_Item_Explain.Ins_Woman.x = this.chara_status[0].start_pos[0];
            this.Ins_Item_Explain.Ins_Woman.y = this.chara_status[0].start_pos[1];
            this.Ins_Item_Explain.Ins_Man.visible = false;
            this.Ins_Item_Explain.Ins_Man.gotoAndStop("walk");
            this.Ins_Item_Explain.Ins_Man.x = this.chara_status[1].start_pos[0];
            this.Ins_Item_Explain.Ins_Man.y = this.chara_status[1].start_pos[1];
            this.Ins_Item_Explain.Ins_Road.Ins_Auto.gotoAndStop("move");
            this.line_panel_g.clear();
            this.move_per_len1 = Math.abs(this.chara_status[0].goal_pos[0] - this.chara_status[0].start_pos[0]) / 120;
            this.move_per_len2 = Math.abs(this.chara_status[1].goal_pos[0] - this.chara_status[1].start_pos[0]) / 60;
            this.dispStopClock("off");
            this.dispClockFusen(false);
            return;
        }// end function

        public function dispExplain() : void
        {
            this.Ins_Item_Explain.Ins_Exp.visible = false;
            this.Ins_Item_Explain.Ins_Woman.visible = true;
            this.Ins_Item_Explain.Ins_Man.visible = true;
            this.Ins_Item_Explain.Ins_Man.gotoAndPlay("walk");
            this.Ins_Item_Explain.Ins_Road.Ins_Auto.gotoAndPlay("move");
            return;
        }// end function

        public function dispClockTimer(param1:uint, param2:uint) : void
        {
            var _loc_3:* = 0;
            if (param1 == 0)
            {
                this.Ins_Item_Control.Ins_Clock.Ins_Time1.text = "0";
                this.Ins_Item_Control.Ins_Clock.Ins_Time2.text = "0";
                this.Ins_Item_Control.Ins_Clock.Ins_Time3.text = "0";
            }
            else
            {
                _loc_3 = param1 / (param2 * 100);
                param1 = param1 % (param2 * 100);
                if (_loc_3 > 0)
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time1.text = _loc_3;
                }
                else
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time1.text = "0";
                }
                _loc_3 = param1 / (param2 * 10);
                param1 = param1 % (param2 * 10);
                if (_loc_3 > 0)
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time2.text = _loc_3;
                }
                else
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time2.text = "0";
                }
                _loc_3 = param1 / (param2 * 1);
                param1 = param1 % (param2 * 1);
                if (_loc_3 > 0)
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time3.text = _loc_3;
                }
                else
                {
                    this.Ins_Item_Control.Ins_Clock.Ins_Time3.text = "0";
                }
            }
            return;
        }// end function

        public function changeActionBtn(param1:String) : void
        {
            switch(param1)
            {
                case "Ins_Start_Btn":
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    break;
                }
                case "Ins_Stop_Btn":
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispStopClock(param1:String) : void
        {
            switch(param1)
            {
                case "off":
                {
                    this.Ins_Item_Control.Ins_Clock.gotoAndStop("off");
                    break;
                }
                case "start":
                {
                    this.Ins_Item_Control.Ins_Clock.gotoAndPlay("start");
                    break;
                }
                case "stop":
                {
                    this.Ins_Item_Control.Ins_Clock.gotoAndPlay("stop");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispClockFusen(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Clock.Ins_Fusen.visible = param1;
            return;
        }// end function

        public function moveAutoRoad() : int
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            var _loc_3:* = 0;
            this.Ins_Item_Explain.Ins_Woman.x = this.Ins_Item_Explain.Ins_Woman.x + this.move_per_len1 / this._EXP_SEC_FRAME;
            this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x + this.move_per_len2 / this._EXP_SEC_FRAME;
            if (this.Ins_Item_Explain.Ins_Woman.x > this.chara_status[0].goal_pos[0])
            {
                this.Ins_Item_Explain.Ins_Woman.x = this.chara_status[0].goal_pos[0];
                _loc_1 = true;
            }
            else
            {
                var _loc_4:* = this;
                var _loc_5:* = this.move_timer1 + 1;
                _loc_4.move_timer1 = _loc_5;
            }
            if (this.Ins_Item_Explain.Ins_Man.x > this.chara_status[1].goal_pos[0])
            {
                this.Ins_Item_Explain.Ins_Man.x = this.chara_status[1].goal_pos[0];
                _loc_2 = true;
            }
            else
            {
                var _loc_4:* = this;
                var _loc_5:* = this.move_timer2 + 1;
                _loc_4.move_timer2 = _loc_5;
            }
            if (_loc_1 == true && _loc_2 == false)
            {
                _loc_3 = 1;
            }
            else if (_loc_1 == false && _loc_2 == true)
            {
                _loc_3 = 2;
            }
            else if (_loc_1 == true && _loc_2 == true)
            {
                _loc_3 = 3;
            }
            return _loc_3;
        }// end function

        public function controlExplain(param1:uint, param2:uint) : void
        {
            return;
        }// end function

        public function controlGraph(param1:uint, param2:uint, param3:uint) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.line_panel_g.clear();
            _loc_4 = param1 / param3 * (this._GRAPH_SIZE_W / 120);
            _loc_5 = (this.Ins_Item_Explain.Ins_Woman.x - this.chara_status[0].start_pos[0]) / Math.abs(this.chara_status[1].goal_pos[0] - this.chara_status[1].start_pos[0]) * this._GRAPH_SIZE_H * -1;
            this.dispLine1(this.line_status[0].sx, this.line_status[0].sy, this.line_status[0].sx + Math.round(_loc_4), this.line_status[0].sy + Math.round(_loc_5));
            _loc_4 = param2 / param3 * (this._GRAPH_SIZE_W / 120);
            _loc_5 = (this.Ins_Item_Explain.Ins_Man.x - this.chara_status[1].start_pos[0]) / Math.abs(this.chara_status[1].goal_pos[0] - this.chara_status[1].start_pos[0]) * this._GRAPH_SIZE_H * -1;
            this.dispLine2(this.line_status[1].sx, this.line_status[1].sy, this.line_status[1].sx + Math.round(_loc_4), this.line_status[1].sy + Math.round(_loc_5));
            return;
        }// end function

        public function dispLine1(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.line_panel_g.lineStyle(this.line_status[0].size, this.line_status[0].color, 1);
            this.line_panel_g.moveTo(param1, param2);
            this.line_panel_g.lineTo(param3, param4);
            return;
        }// end function

        public function dispLine2(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.line_panel_g.lineStyle(this.line_status[1].size, this.line_status[1].color, 1);
            this.line_panel_g.moveTo(param1, param2);
            this.line_panel_g.lineTo(param3, param4);
            return;
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

        public function entryDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp1Btn);
            this.Ins_Item_Control.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp1Btn);
            this.Ins_Item_Control.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp1Btn);
            return;
        }// end function

        public function releaseDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp1Btn);
            this.Ins_Item_Control.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp1Btn);
            this.Ins_Item_Control.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp1Btn);
            return;
        }// end function

        public function downDisp1Btn(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("on");
            this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("off");
            this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("off");
            this.disp_mode1_flag = true;
            this.Disp_mode = 0;
            this.changeDispMode(this.Disp_mode);
            return;
        }// end function

        public function overDisp1Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 0)
            {
                this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp1Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 0)
            {
                this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp1Btn() : Boolean
        {
            return this.disp_mode1_flag;
        }// end function

        public function setDisp1Btn(param1:Boolean) : void
        {
            this.disp_mode1_flag = param1;
            return;
        }// end function

        public function entryDisp2Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp2Btn);
            this.Ins_Item_Control.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp2Btn);
            this.Ins_Item_Control.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp2Btn);
            return;
        }// end function

        public function releaseDisp2Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp2Btn);
            this.Ins_Item_Control.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp2Btn);
            this.Ins_Item_Control.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp2Btn);
            return;
        }// end function

        public function downDisp2Btn(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("off");
            this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("on");
            this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("off");
            this.disp_mode2_flag = true;
            this.Disp_mode = 1;
            this.changeDispMode(this.Disp_mode);
            return;
        }// end function

        public function overDisp2Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 1)
            {
                this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp2Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 1)
            {
                this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp2Btn() : Boolean
        {
            return this.disp_mode2_flag;
        }// end function

        public function setDisp2Btn(param1:Boolean) : void
        {
            this.disp_mode2_flag = param1;
            return;
        }// end function

        public function entryDisp3Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp3Btn);
            this.Ins_Item_Control.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp3Btn);
            this.Ins_Item_Control.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp3Btn);
            return;
        }// end function

        public function releaseDisp3Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp3Btn);
            this.Ins_Item_Control.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp3Btn);
            this.Ins_Item_Control.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp3Btn);
            return;
        }// end function

        public function downDisp3Btn(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.gotoAndStop("off");
            this.Ins_Item_Control.Ins_Disp2_Btn.gotoAndStop("off");
            this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("on");
            this.disp_mode3_flag = true;
            this.Disp_mode = 2;
            this.changeDispMode(this.Disp_mode);
            return;
        }// end function

        public function overDisp3Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 2)
            {
                this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp3Btn(event:MouseEvent) : void
        {
            if (this.Disp_mode != 2)
            {
                this.Ins_Item_Control.Ins_Disp3_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp3Btn() : Boolean
        {
            return this.disp_mode3_flag;
        }// end function

        public function setDisp3Btn(param1:Boolean) : void
        {
            this.disp_mode3_flag = param1;
            return;
        }// end function

        public function entryCheckBox() : void
        {
            this.Ins_Item_Control.Ins_Check_BoxOn.addEventListener(MouseEvent.CLICK, this.clickBoxOn);
            this.Ins_Item_Control.Ins_Check_BoxOff.addEventListener(MouseEvent.CLICK, this.clickBoxOff);
            this.Ins_Item_Control.Ins_Check_BoxOn.visible = true;
            this.Ins_Item_Control.Ins_Check_BoxOff.visible = false;
            this.disp_fusen_flag = true;
            return;
        }// end function

        public function releaseCheckBox() : void
        {
            this.Ins_Item_Control.Ins_Check_BoxOn.removeEventListener(MouseEvent.CLICK, this.clickBoxOn);
            this.Ins_Item_Control.Ins_Check_BoxOff.removeEventListener(MouseEvent.CLICK, this.clickBoxOff);
            return;
        }// end function

        public function clickBoxOn(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Check_BoxOn.visible = false;
            this.Ins_Item_Control.Ins_Check_BoxOff.visible = true;
            this.dispClockFusen(false);
            this.disp_fusen_flag = false;
            return;
        }// end function

        public function clickBoxOff(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Check_BoxOn.visible = true;
            this.Ins_Item_Control.Ins_Check_BoxOff.visible = false;
            this.dispClockFusen(true);
            this.disp_fusen_flag = true;
            return;
        }// end function

        public function getCheckBox() : Boolean
        {
            return this.disp_fusen_flag;
        }// end function

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.Disp_mode = 0;
            this.Explain_index = 0;
            this.Graph_index = 0;
            this.start_btn_flag = false;
            this.stop_btn_flag = false;
            this.reset_btn_flag = false;
            this.disp_mode1_flag = false;
            this.disp_mode3_flag = false;
            this.disp_mode2_flag = false;
            this.disp_fusen_flag = false;
            this.pause_flag = false;
            this.line_status = [{size:3, color:16711680, sx:-360, sy:210}, {size:3, color:0, sx:-360, sy:210}];
            this.chara_status = [{ins:"Ins_Woman", speed:0.5, start_pos:[-402, -36], goal_pos:[378, -36]}, {ins:"Ins_Man", speed:1, start_pos:[-402, 34], goal_pos:[378, 34]}];
            this.line_shape_g = new Shape();
            this.Ins_Item_Graph.Ins_Line_Mc.addChild(this.line_shape_g);
            this.line_panel_g = this.line_shape_g.graphics;
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
            this.move_frame = 0;
            this.move_timer1 = 0;
            this.move_timer2 = 0;
            this.move_length1 = 0;
            this.move_length2 = 0;
            this.move_per_len1 = 0;
            this.move_per_len2 = 0;
            return;
        }// end function

    }
}
