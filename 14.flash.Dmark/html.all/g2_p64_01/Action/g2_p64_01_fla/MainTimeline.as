﻿package g2_p64_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Exp_Cover:MovieClip;
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Ins_Item_Graph:MovieClip;
        public var Ins_Item_Notes:MovieClip;
        public var Ins_Item_Table:MovieClip;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var disp1_btn_flag:Boolean;
        public var disp2_btn_flag:Boolean;
        public var disp3_btn_flag:Boolean;
        public var disp1_on_flag:Boolean;
        public var disp2_on_flag:Boolean;
        public var disp3_on_flag:Boolean;
        public var check_box1_flag:Boolean;
        public var check_box2_flag:Boolean;
        public var ap_rock_flag:Boolean;
        public var ap_btn_flag:Boolean;
        public var a1_btn_flag:Boolean;
        public var a2_btn_flag:Boolean;
        public var bp_rock_flag:Boolean;
        public var bp_btn_flag:Boolean;
        public var b1_btn_flag:Boolean;
        public var b2_btn_flag:Boolean;
        public var refresh_flag:Boolean;
        public var notes_disp_flag:Boolean;
        public var disp_mode:uint;
        public var curve_dir:Number;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _PUSH_BAR_OFS:int = 0;
        public const _PUSH_BAR_LX:int = -540;
        public const _PUSH_BAR_RX:int = 540;
        public const _UNIT_MAX:uint = 5;
        public const _UNIT_SIZE:uint = 40;
        public const _UNIT_FLIP_X:int = 1;
        public const _UNIT_FLIP_Y:int = -1;
        public const _AP_BAR_ZERO:uint = 5;
        public const _FUNC_START_A:uint = 7;
        public const _FUNC_START_B:uint = 8;
        public const _EXP_SCALE:Number = 0.7;
        public var now_func_a:Number;
        public var now_func_b:Number;
        public var func_status:Array;
        public var bar_status:Array;
        public const _AP_BAR_L:int = -400;
        public const _AP_BAR_R:int = 400;
        public const _AP_UINT:int = 80;
        public var ap_bar_ruler:Array;
        public const _BP_BAR_L:int = -400;
        public const _BP_BAR_R:int = 400;
        public const _BP_UINT:int = 80;
        public var bp_bar_ruler:Array;
        public var line_shape:Object;
        public var line_panel:Object;
        public var save_shape:Object;
        public var save_panel:Object;
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
                    this.entryDisp1Btn();
                    this.entryDisp2Btn();
                    this.entryDisp3Btn();
                    this.entryAPushBtn();
                    this.entryA1Btn();
                    this.entryA2Btn();
                    this.entryBPushBtn();
                    this.entryB1Btn();
                    this.entryB2Btn();
                    this.entryCheckBox1(false);
                    this.entryCheckBox2(false);
                    this.Main_timer = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.refresh_flag == true)
                    {
                        this.line_panel.clear();
                        this.dispFuncLine(this.line_panel, 0, this.getAPbarA(this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x), this.getBPbarB(this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x));
                        this.dispTableNumberAll();
                        this.dispExplainFunc();
                        this.dispGraphNumberA(this.bar_status[0].id, this.getAPbarA(this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x), this.getBPbarB(this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x));
                        this.dispGraphNumberB(this.bar_status[1].id, this.getAPbarA(this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x), this.getBPbarB(this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x));
                        this.dispFusenRed(this.check_box1_flag);
                        this.dispFusenBlue(this.check_box2_flag);
                        this.refresh_flag = false;
                    }
                    if (this.getDisp1Btn() == true)
                    {
                        if (this.disp1_on_flag == true)
                        {
                            this.Ins_Exp_Cover.Ins_Exp1.visible = false;
                        }
                        else
                        {
                            this.Ins_Exp_Cover.Ins_Exp1.visible = true;
                        }
                        this.setDisp1Btn(false);
                    }
                    else if (this.getDisp2Btn() == true)
                    {
                        if (this.disp2_on_flag == true)
                        {
                            this.Ins_Exp_Cover.Ins_Exp2.visible = false;
                        }
                        else
                        {
                            this.Ins_Exp_Cover.Ins_Exp2.visible = true;
                        }
                        this.setDisp2Btn(false);
                    }
                    else if (this.getDisp3Btn() == true)
                    {
                        if (this.disp3_on_flag == true)
                        {
                            this.Ins_Exp_Cover.Ins_Exp3.visible = false;
                        }
                        else
                        {
                            this.Ins_Exp_Cover.Ins_Exp3.visible = true;
                        }
                        this.setDisp3Btn(false);
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
            this.Ins_Item_Graph.Ins_Line_Mc.removeChild(this.line_shape);
            this.Ins_Item_Graph.Ins_Save_Mc.removeChild(this.save_shape);
            this.releaseDisp1Btn();
            this.releaseDisp2Btn();
            this.releaseDisp3Btn();
            this.releaseAPushBtn();
            this.releaseA1Btn();
            this.releaseA2Btn();
            this.releaseBPushBtn();
            this.releaseB1Btn();
            this.releaseB2Btn();
            this.releaseCheckBox1();
            this.releaseCheckBox2();
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
            this.Ins_Item_Table.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Ins_Item_Graph.visible = true;
            this.Ins_Item_Notes.visible = true;
            this.Ins_Exp_Cover.visible = true;
            this.Ins_Exp_Cover.Ins_Exp1.visible = false;
            this.Ins_Exp_Cover.Ins_Exp2.visible = false;
            this.Ins_Exp_Cover.Ins_Exp3.visible = false;
            this.disp_mode = 0;
            this.refresh_flag = false;
            this.now_func_a = this.ap_bar_ruler[this.bar_status[0].id].num;
            this.now_func_b = this.bp_bar_ruler[this.bar_status[1].id].num;
            this.dispFuncLine(this.line_panel, 0, this.now_func_a, this.now_func_b);
            this.dispTableNumberAll();
            this.dispExplainFunc();
            this.dispGraphNumberA(this.bar_status[0].id, this.now_func_a, this.now_func_b);
            this.dispGraphNumberB(this.bar_status[1].id, this.now_func_a, this.now_func_b);
            this.dispAPbar(this.bar_status[0].id);
            this.dispBPbar(this.bar_status[1].id);
            this.dispFusenRed(this.check_box1_flag);
            this.dispFusenBlue(this.check_box2_flag);
            return;
        }// end function

        public function changeExplainNotes(param1:Boolean) : void
        {
            this.Ins_Item_Notes.visible = param1;
            return;
        }// end function

        public function dispFusenRed(param1:Boolean) : void
        {
            this.Ins_Item_Notes.Ins_Fusen_R1.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_R2.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_R3.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_R3.x = this.Ins_Item_Notes.Ins_Arrow_R3.x + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.x;
            this.Ins_Item_Notes.Ins_Fusen_R3.y = this.Ins_Item_Notes.Ins_Arrow_R3.y + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.y;
            return;
        }// end function

        public function dispFusenBlue(param1:Boolean) : void
        {
            this.Ins_Item_Notes.Ins_Fusen_B1.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_B2.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_B3.visible = param1;
            this.Ins_Item_Notes.Ins_Fusen_B3.x = this.Ins_Item_Notes.Ins_Arrow_B3.x + this.Ins_Item_Notes.Ins_Arrow_B3.Ins_LineB.x;
            this.Ins_Item_Notes.Ins_Fusen_B3.y = this.Ins_Item_Notes.Ins_Arrow_B3.y + this.Ins_Item_Notes.Ins_Arrow_B3.Ins_LineB.y;
            return;
        }// end function

        public function dispFuncLine(param1:Graphics, param2:int, param3:Number, param4:Number) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param3 == 0)
            {
                return;
            }
            param1.lineStyle(this.func_status[param2].size, this.func_status[param2].color, 1);
            _loc_5 = -5.5;
            _loc_6 = this.getFuncPosY(_loc_5, 0, param3, param4);
            param1.moveTo(this.changeGraphPosX(_loc_5), this.changeGraphPosY(_loc_6));
            _loc_7 = 5.5;
            _loc_8 = this.getFuncPosY(_loc_7, 0, param3, param4);
            param1.lineTo(this.changeGraphPosX(_loc_7), this.changeGraphPosY(_loc_8));
            return;
        }// end function

        public function dispFuncLineAfterimage(param1:Graphics, param2:int, param3:Number, param4:Number) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param3 == 0)
            {
                return;
            }
            param3 = Math.round(param3 * 10);
            param3 = param3 / 10;
            param1.lineStyle(1, 4473924, 1);
            _loc_5 = -5.5;
            _loc_6 = this.getFuncPosY(_loc_5, 0, param3, param4);
            param1.moveTo(this.changeGraphPosX(_loc_5), this.changeGraphPosY(_loc_6));
            _loc_7 = 5.5;
            _loc_8 = this.getFuncPosY(_loc_7, 0, param3, param4);
            param1.lineTo(this.changeGraphPosX(_loc_7), this.changeGraphPosY(_loc_8));
            return;
        }// end function

        public function getFuncPosX(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = 0;
            _loc_5 = (param2 - param4) / param3;
            return _loc_5;
        }// end function

        public function getFuncPosY(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = 0;
            _loc_5 = param3 * param1 + param4;
            return _loc_5;
        }// end function

        public function changeGraphPosX(param1:Number) : Number
        {
            return param1 * this._UNIT_SIZE * this._UNIT_FLIP_X;
        }// end function

        public function changeGraphPosY(param1:Number) : Number
        {
            return param1 * this._UNIT_SIZE * this._UNIT_FLIP_Y;
        }// end function

        public function dispTableNumberAll() : void
        {
            this.dispTableNumberY("Ins_NumY1", -2, this.now_func_a, this.now_func_b);
            this.dispTableNumberY("Ins_NumY2", -1, this.now_func_a, this.now_func_b);
            this.dispTableNumberY("Ins_NumY3", 0, this.now_func_a, this.now_func_b);
            this.dispTableNumberY("Ins_NumY4", 1, this.now_func_a, this.now_func_b);
            this.dispTableNumberY("Ins_NumY5", 2, this.now_func_a, this.now_func_b);
            this.dispTableNumberAdd("Ins_NumAdd1", this.now_func_a, this.now_func_b);
            this.dispTableNumberAdd("Ins_NumAdd2", this.now_func_a, this.now_func_b);
            this.dispTableNumberAdd("Ins_NumAdd3", this.now_func_a, this.now_func_b);
            this.dispTableNumberAdd("Ins_NumAdd4", this.now_func_a, this.now_func_b);
            return;
        }// end function

        public function dispTableNumberY(param1:String, param2:int, param3:Number, param4:Number) : void
        {
            var _loc_8:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = "";
            _loc_8 = this.Ins_Item_Table.getChildByName(param1);
            if (param3 >= 0)
            {
                _loc_5 = param2 * this.ap_bar_ruler[this.bar_status[0].id].num_c + param4 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
            }
            else
            {
                _loc_5 = param2 * (this.ap_bar_ruler[this.bar_status[0].id].num_c * -1) + param4 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
            }
            if (_loc_5 < 0)
            {
                _loc_7 = "-";
            }
            else
            {
                _loc_7 = "";
            }
            this.dispNumber(_loc_8, Math.abs(_loc_5), this.ap_bar_ruler[this.bar_status[0].id].num_m, _loc_7, "");
            return;
        }// end function

        public function dispTableNumberAdd(param1:String, param2:Number, param3:Number) : void
        {
            var _loc_9:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = "";
            _loc_9 = this.Ins_Item_Table.Ins_AddNum.getChildByName(param1);
            if (param2 >= 0)
            {
                _loc_6 = 0 * this.ap_bar_ruler[this.bar_status[0].id].num_c + param3 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
                _loc_7 = 1 * this.ap_bar_ruler[this.bar_status[0].id].num_c + param3 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
                _loc_4 = _loc_7 - _loc_6;
            }
            else
            {
                _loc_6 = 0 * (this.ap_bar_ruler[this.bar_status[0].id].num_c * -1) + param3 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
                _loc_7 = 1 * (this.ap_bar_ruler[this.bar_status[0].id].num_c * -1) + param3 * this.ap_bar_ruler[this.bar_status[0].id].num_m;
                _loc_4 = _loc_7 - _loc_6;
            }
            if (_loc_4 < 0)
            {
                _loc_8 = "-";
            }
            else
            {
                _loc_8 = "";
            }
            this.dispNumber(_loc_9, Math.abs(_loc_4), this.ap_bar_ruler[this.bar_status[0].id].num_m, _loc_8, "");
            return;
        }// end function

        public function dispExplainFunc() : void
        {
            var _loc_1:* = null;
            _loc_1 = this.Ins_Item_Explain.getChildByName("Ins_A");
            this.dispNumber(_loc_1, this.ap_bar_ruler[this.bar_status[0].id].num_c, this.ap_bar_ruler[this.bar_status[0].id].num_m, this.ap_bar_ruler[this.bar_status[0].id].num_s, "");
            _loc_1 = this.Ins_Item_Explain.getChildByName("Ins_B");
            if (this.bp_bar_ruler[this.bar_status[1].id].num_s == "-")
            {
                this.dispNumber(_loc_1, this.bp_bar_ruler[this.bar_status[1].id].num_c, this.bp_bar_ruler[this.bar_status[1].id].num_m, "", "－");
            }
            else if (this.bp_bar_ruler[this.bar_status[1].id].num_s == "+")
            {
                this.dispNumber(_loc_1, this.bp_bar_ruler[this.bar_status[1].id].num_c, this.bp_bar_ruler[this.bar_status[1].id].num_m, "", "＋");
            }
            else
            {
                this.dispNumber(_loc_1, this.bp_bar_ruler[this.bar_status[1].id].num_c, this.bp_bar_ruler[this.bar_status[1].id].num_m, "", "");
            }
            return;
        }// end function

        public function dispGraphNumber() : void
        {
            return;
        }// end function

        public function dispGraphNumberA(param1:int, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            this.Ins_Item_Notes.Ins_Arrow_R3.gotoAndStop((param1 + 1));
            _loc_5 = 0.25;
            _loc_6 = this.getFuncPosY(_loc_5, 0, param2, param3);
            this.Ins_Item_Notes.Ins_Arrow_R3.x = this.changeGraphPosX(_loc_5) * this._EXP_SCALE + 322;
            this.Ins_Item_Notes.Ins_Arrow_R3.y = this.changeGraphPosY(_loc_6) * this._EXP_SCALE - 88;
            if (param1 == this._AP_BAR_ZERO)
            {
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineX");
                _loc_4.visible = false;
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineY");
                _loc_4.visible = false;
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineY_Back");
                _loc_4.visible = false;
                this.Ins_Item_Notes.Ins_ArrowA.visible = false;
            }
            else
            {
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineX");
                _loc_4.visible = true;
                this.dispNumber(_loc_4, 1, 1, "", "");
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineY");
                _loc_4.visible = true;
                this.dispNumber(_loc_4, this.ap_bar_ruler[param1].num_c, this.ap_bar_ruler[param1].num_m, this.ap_bar_ruler[param1].num_s, "");
                _loc_4 = this.Ins_Item_Notes.Ins_Arrow_R3.getChildByName("Ins_LineY_Back");
                _loc_4.visible = true;
                this.Ins_Item_Notes.Ins_ArrowA.visible = true;
                _loc_6 = Math.abs(60 - (this.Ins_Item_Notes.Ins_Arrow_R3.y + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.y));
                if (_loc_6 < 336)
                {
                    _loc_6 = 336 - _loc_6;
                    this.Ins_Item_Notes.Ins_ArrowA.Ins_Mask.y = _loc_6 * (10 / 7);
                }
                else
                {
                    _loc_6 = 0;
                }
                if (this.Ins_Item_Notes.Ins_Arrow_R3.y + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.y < 60)
                {
                    this.Ins_Item_Notes.Ins_ArrowA.scaleY = this._EXP_SCALE;
                    this.Ins_Item_Notes.Ins_ArrowA.x = this.Ins_Item_Notes.Ins_Arrow_R3.x + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.x - 6;
                    this.Ins_Item_Notes.Ins_ArrowA.y = this.Ins_Item_Notes.Ins_Arrow_R3.y + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.y - _loc_6;
                }
                else
                {
                    this.Ins_Item_Notes.Ins_ArrowA.scaleY = this._EXP_SCALE * -1;
                    this.Ins_Item_Notes.Ins_ArrowA.x = this.Ins_Item_Notes.Ins_Arrow_R3.x + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.x - 6;
                    this.Ins_Item_Notes.Ins_ArrowA.y = this.Ins_Item_Notes.Ins_Arrow_R3.y + this.Ins_Item_Notes.Ins_Arrow_R3.Ins_LineY.y + _loc_6;
                }
            }
            return;
        }// end function

        public function dispGraphNumberB(param1:int, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            this.Ins_Item_Notes.Ins_Arrow_B3.gotoAndStop((param1 + 1));
            this.Ins_Item_Notes.Ins_Arrow_B3.x = 275;
            this.Ins_Item_Notes.Ins_Arrow_B3.y = 1;
            _loc_4 = this.Ins_Item_Notes.Ins_Arrow_B3.getChildByName("Ins_LineB");
            _loc_4.visible = true;
            this.dispNumber(_loc_4, this.bp_bar_ruler[param1].num_c, this.bp_bar_ruler[param1].num_m, this.bp_bar_ruler[param1].num_s, "");
            _loc_4 = this.Ins_Item_Notes.Ins_Arrow_B3.getChildByName("Ins_LineB_Back");
            _loc_4.visible = true;
            return;
        }// end function

        public function dispNumber(param1:DisplayObject, param2:int, param3:int, param4:String, param5:String) : void
        {
            var _loc_6:* = "";
            if (param2 == 0)
            {
                this.dispNumberText(param1, "Ins_NumBase", "0");
                this.dispNumberText(param1, "Ins_NumC", "");
                this.dispNumberText(param1, "Ins_NumM", "");
                this.dispNumberText(param1, "Ins_NumBar", "");
                this.dispNumberText(param1, "Ins_NumMark", "");
                if (param5 != "")
                {
                    this.dispNumberText(param1, "Ins_NumPM", param5);
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumPM", "");
                }
            }
            else if (param2 > 0 && param3 == 1)
            {
                this.dispNumberText(param1, "Ins_NumBase", String(param2));
                this.dispNumberText(param1, "Ins_NumC", "");
                this.dispNumberText(param1, "Ins_NumM", "");
                this.dispNumberText(param1, "Ins_NumBar", "");
                if (param4 == "-")
                {
                    this.dispNumberText(param1, "Ins_NumMark", "-");
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumMark", "");
                }
                if (param5 != "")
                {
                    this.dispNumberText(param1, "Ins_NumPM", param5);
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumPM", "");
                }
            }
            else if (param2 > 0 && param3 > 1)
            {
                this.dispNumberText(param1, "Ins_NumBase", "");
                this.dispNumberText(param1, "Ins_NumC", String(param2));
                this.dispNumberText(param1, "Ins_NumM", String(param3));
                this.dispNumberText(param1, "Ins_NumBar", "―");
                if (param4 == "-")
                {
                    this.dispNumberText(param1, "Ins_NumMark", "-");
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumMark", "");
                }
                if (param5 != "")
                {
                    this.dispNumberText(param1, "Ins_NumPM", param5);
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumPM", "");
                }
            }
            return;
        }// end function

        public function dispNumberText(param1:DisplayObject, param2:String, param3:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = param1 as MovieClip;
            _loc_5 = (_loc_4).getChildByName(param2);
            _loc_6 = _loc_5 as MovieClip;
            _loc_7 = _loc_5 as TextField;
            _loc_7.text = param3;
            return;
        }// end function

        public function getAPbarA(param1:int) : Number
        {
            var _loc_2:* = 0;
            _loc_2 = param1 / (this._UNIT_SIZE * 2);
            return _loc_2;
        }// end function

        public function dispAPbar(param1:uint) : void
        {
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x = this.ap_bar_ruler[param1].pin0;
            return;
        }// end function

        public function stickAPbar() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.ap_bar_ruler.length)
            {
                
                _loc_4 = this.ap_bar_ruler[_loc_1].pin1;
                _loc_5 = this.ap_bar_ruler[_loc_1].pin2;
                if (_loc_3 >= _loc_4 && _loc_3 <= _loc_5)
                {
                    _loc_2 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            this.bar_status[0].id = _loc_2;
            this.now_func_a = this.ap_bar_ruler[this.bar_status[0].id].num;
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x = this.ap_bar_ruler[this.bar_status[0].id].pin0;
            return;
        }// end function

        public function entryAPushBtn() : void
        {
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.addEventListener(MouseEvent.MOUSE_UP, this.outAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.addEventListener(MouseEvent.MOUSE_MOVE, this.moveAPushBtn);
            return;
        }// end function

        public function releaseAPushBtn() : void
        {
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.outAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outAPushBtn);
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveAPushBtn);
            return;
        }// end function

        public function downAPushBtn(event:MouseEvent) : void
        {
            this.ap_rock_flag = true;
            this.ap_btn_flag = true;
            return;
        }// end function

        public function outAPushBtn(event:MouseEvent) : void
        {
            this.stickAPbar();
            this.refresh_flag = true;
            this.ap_rock_flag = false;
            this.ap_btn_flag = false;
            return;
        }// end function

        public function moveAPushBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.ap_rock_flag == true)
            {
                _loc_2 = this.Ins_Item_Control.Ins_BarA.mouseX;
                if (_loc_2 < this.ap_bar_ruler[0].pin0)
                {
                    _loc_2 = this.ap_bar_ruler[0].pin0;
                }
                else if (_loc_2 > this.ap_bar_ruler[(this.ap_bar_ruler.length - 1)].pin0)
                {
                    _loc_2 = this.ap_bar_ruler[(this.ap_bar_ruler.length - 1)].pin0;
                }
                this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x = _loc_2;
                this.refresh_flag = true;
            }
            return;
        }// end function

        public function getAPushBtn() : Boolean
        {
            return this.ap_btn_flag;
        }// end function

        public function getBPbarB(param1:int) : Number
        {
            var _loc_2:* = 0;
            _loc_2 = param1 / (this._UNIT_SIZE * 2);
            return _loc_2;
        }// end function

        public function dispBPbar(param1:uint) : void
        {
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x = this.bp_bar_ruler[param1].pin0;
            return;
        }// end function

        public function stickBPbar() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.bp_bar_ruler.length)
            {
                
                _loc_4 = this.bp_bar_ruler[_loc_1].pin1;
                _loc_5 = this.bp_bar_ruler[_loc_1].pin2;
                if (_loc_3 >= _loc_4 && _loc_3 <= _loc_5)
                {
                    _loc_2 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            this.bar_status[1].id = _loc_2;
            this.now_func_b = this.bp_bar_ruler[this.bar_status[1].id].num;
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x = this.bp_bar_ruler[this.bar_status[1].id].pin0;
            return;
        }// end function

        public function entryBPushBtn() : void
        {
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.addEventListener(MouseEvent.MOUSE_UP, this.outBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.addEventListener(MouseEvent.MOUSE_MOVE, this.moveBPushBtn);
            return;
        }// end function

        public function releaseBPushBtn() : void
        {
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.outBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outBPushBtn);
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveBPushBtn);
            return;
        }// end function

        public function downBPushBtn(event:MouseEvent) : void
        {
            this.bp_rock_flag = true;
            this.bp_btn_flag = true;
            return;
        }// end function

        public function outBPushBtn(event:MouseEvent) : void
        {
            this.stickBPbar();
            this.refresh_flag = true;
            this.bp_rock_flag = false;
            this.bp_btn_flag = false;
            return;
        }// end function

        public function moveBPushBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.bp_rock_flag == true)
            {
                _loc_2 = this.Ins_Item_Control.Ins_BarB.mouseX;
                if (_loc_2 < this.bp_bar_ruler[0].pin0)
                {
                    _loc_2 = this.bp_bar_ruler[0].pin0;
                }
                else if (_loc_2 > this.bp_bar_ruler[(this.bp_bar_ruler.length - 1)].pin0)
                {
                    _loc_2 = this.bp_bar_ruler[(this.bp_bar_ruler.length - 1)].pin0;
                }
                this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x = _loc_2;
                this.refresh_flag = true;
            }
            return;
        }// end function

        public function getBPushBtn() : Boolean
        {
            return this.bp_btn_flag;
        }// end function

        public function entryA1Btn() : void
        {
            this.Ins_Item_Control.Ins_A1_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downA1Btn);
            return;
        }// end function

        public function releaseA1Btn() : void
        {
            this.Ins_Item_Control.Ins_A1_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downA1Btn);
            return;
        }// end function

        public function downA1Btn(event:MouseEvent) : void
        {
            var _loc_2:* = this.bar_status[0];
            var _loc_3:* = _loc_2.id - 1;
            _loc_2.id = _loc_3;
            if (_loc_2.id < 0)
            {
                _loc_2.id = 0;
            }
            this.now_func_a = this.ap_bar_ruler[_loc_2.id].num;
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x = this.ap_bar_ruler[_loc_2.id].pin0;
            this.refresh_flag = true;
            return;
        }// end function

        public function entryA2Btn() : void
        {
            this.Ins_Item_Control.Ins_A2_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downA2Btn);
            return;
        }// end function

        public function releaseA2Btn() : void
        {
            this.Ins_Item_Control.Ins_A2_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downA2Btn);
            return;
        }// end function

        public function downA2Btn(event:MouseEvent) : void
        {
            var _loc_2:* = this.bar_status[0];
            var _loc_3:* = _loc_2.id + 1;
            _loc_2.id = _loc_3;
            if (_loc_2.id > (this.ap_bar_ruler.length - 1))
            {
                _loc_2.id = this.ap_bar_ruler.length - 1;
            }
            this.now_func_a = this.ap_bar_ruler[_loc_2.id].num;
            this.Ins_Item_Control.Ins_BarA.Ins_APush_Btn.x = this.ap_bar_ruler[_loc_2.id].pin0;
            this.refresh_flag = true;
            return;
        }// end function

        public function entryB1Btn() : void
        {
            this.Ins_Item_Control.Ins_B1_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downB1Btn);
            return;
        }// end function

        public function releaseB1Btn() : void
        {
            this.Ins_Item_Control.Ins_B1_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downB1Btn);
            return;
        }// end function

        public function downB1Btn(event:MouseEvent) : void
        {
            var _loc_2:* = this.bar_status[1];
            var _loc_3:* = _loc_2.id - 1;
            _loc_2.id = _loc_3;
            if (_loc_2.id < 0)
            {
                _loc_2.id = 0;
            }
            this.now_func_b = this.bp_bar_ruler[_loc_2.id].num;
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x = this.bp_bar_ruler[_loc_2.id].pin0;
            this.refresh_flag = true;
            return;
        }// end function

        public function entryB2Btn() : void
        {
            this.Ins_Item_Control.Ins_B2_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downB2Btn);
            return;
        }// end function

        public function releaseB2Btn() : void
        {
            this.Ins_Item_Control.Ins_B2_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downB2Btn);
            return;
        }// end function

        public function downB2Btn(event:MouseEvent) : void
        {
            var _loc_2:* = this.bar_status[1];
            var _loc_3:* = _loc_2.id + 1;
            _loc_2.id = _loc_3;
            if (_loc_2.id > (this.bp_bar_ruler.length - 1))
            {
                _loc_2.id = this.bp_bar_ruler.length - 1;
            }
            this.now_func_b = this.bp_bar_ruler[_loc_2.id].num;
            this.Ins_Item_Control.Ins_BarB.Ins_BPush_Btn.x = this.bp_bar_ruler[_loc_2.id].pin0;
            this.refresh_flag = true;
            return;
        }// end function

        public function entryDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp1Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp1Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp1Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.gotoAndStop("on");
            this.disp1_on_flag = true;
            return;
        }// end function

        public function releaseDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp1Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp1Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp1Btn);
            return;
        }// end function

        public function downDisp1Btn(event:MouseEvent) : void
        {
            if (this.disp1_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.gotoAndStop("on");
                this.disp1_on_flag = true;
            }
            else
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.gotoAndStop("off");
                this.disp1_on_flag = false;
            }
            this.disp1_btn_flag = true;
            return;
        }// end function

        public function overDisp1Btn(event:MouseEvent) : void
        {
            if (this.disp1_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp1Btn(event:MouseEvent) : void
        {
            if (this.disp1_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp1_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp1Btn() : Boolean
        {
            return this.disp1_btn_flag;
        }// end function

        public function setDisp1Btn(param1:Boolean) : void
        {
            this.disp1_btn_flag = param1;
            return;
        }// end function

        public function entryDisp2Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp2Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp2Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp2Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.gotoAndStop("on");
            this.disp2_on_flag = true;
            return;
        }// end function

        public function releaseDisp2Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp2Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp2Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp2Btn);
            return;
        }// end function

        public function downDisp2Btn(event:MouseEvent) : void
        {
            if (this.disp2_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.gotoAndStop("on");
                this.disp2_on_flag = true;
            }
            else
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.gotoAndStop("off");
                this.disp2_on_flag = false;
            }
            this.disp2_btn_flag = true;
            return;
        }// end function

        public function overDisp2Btn(event:MouseEvent) : void
        {
            if (this.disp2_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp2Btn(event:MouseEvent) : void
        {
            if (this.disp2_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp2_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp2Btn() : Boolean
        {
            return this.disp2_btn_flag;
        }// end function

        public function setDisp2Btn(param1:Boolean) : void
        {
            this.disp2_btn_flag = param1;
            return;
        }// end function

        public function entryDisp3Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_DOWN, this.downDisp3Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_OVER, this.overDisp3Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.addEventListener(MouseEvent.MOUSE_OUT, this.outDisp3Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.gotoAndStop("on");
            this.disp3_on_flag = true;
            return;
        }// end function

        public function releaseDisp3Btn() : void
        {
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_DOWN, this.downDisp3Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_OVER, this.overDisp3Btn);
            this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.removeEventListener(MouseEvent.MOUSE_OUT, this.outDisp3Btn);
            return;
        }// end function

        public function downDisp3Btn(event:MouseEvent) : void
        {
            if (this.disp3_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.gotoAndStop("on");
                this.disp3_on_flag = true;
            }
            else
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.gotoAndStop("off");
                this.disp3_on_flag = false;
            }
            this.disp3_btn_flag = true;
            return;
        }// end function

        public function overDisp3Btn(event:MouseEvent) : void
        {
            if (this.disp3_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.gotoAndStop("over");
            }
            return;
        }// end function

        public function outDisp3Btn(event:MouseEvent) : void
        {
            if (this.disp3_on_flag == false)
            {
                this.Ins_Item_Control.Ins_Select.Ins_Disp3_Btn.gotoAndStop("off");
            }
            return;
        }// end function

        public function getDisp3Btn() : Boolean
        {
            return this.disp3_btn_flag;
        }// end function

        public function setDisp3Btn(param1:Boolean) : void
        {
            this.disp3_btn_flag = param1;
            return;
        }// end function

        public function entryCheckBox1(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Check_Box1_On.addEventListener(MouseEvent.MOUSE_DOWN, this.clickBox1On);
            this.Ins_Item_Control.Ins_Check_Box1_Off.addEventListener(MouseEvent.MOUSE_DOWN, this.clickBox1Off);
            if (param1 == true)
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = false;
                this.check_box1_flag = true;
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = true;
                this.check_box1_flag = false;
            }
            return;
        }// end function

        public function releaseCheckBox1() : void
        {
            this.Ins_Item_Control.Ins_Check_Box1_On.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickBox1On);
            this.Ins_Item_Control.Ins_Check_Box1_Off.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickBox1Off);
            return;
        }// end function

        public function clickBox1On(event:MouseEvent) : void
        {
            if (this.check_box1_flag == true)
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = true;
                this.check_box1_flag = false;
                this.dispFusenRed(this.check_box1_flag);
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = false;
                this.check_box1_flag = true;
                this.dispFusenRed(this.check_box1_flag);
            }
            return;
        }// end function

        public function clickBox1Off(event:MouseEvent) : void
        {
            if (this.check_box1_flag == true)
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = true;
                this.check_box1_flag = false;
                this.dispFusenRed(this.check_box1_flag);
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box1_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box1_Off.visible = false;
                this.check_box1_flag = true;
                this.dispFusenRed(this.check_box1_flag);
            }
            return;
        }// end function

        public function getCheckBox1() : Boolean
        {
            return this.check_box1_flag;
        }// end function

        public function entryCheckBox2(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Check_Box2_On.addEventListener(MouseEvent.MOUSE_DOWN, this.clickBox2On);
            this.Ins_Item_Control.Ins_Check_Box2_Off.addEventListener(MouseEvent.MOUSE_DOWN, this.clickBox2Off);
            if (param1 == true)
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = false;
                this.check_box2_flag = true;
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = true;
                this.check_box2_flag = false;
            }
            return;
        }// end function

        public function releaseCheckBox2() : void
        {
            this.Ins_Item_Control.Ins_Check_Box2_On.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickBox2On);
            this.Ins_Item_Control.Ins_Check_Box2_Off.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickBox2Off);
            return;
        }// end function

        public function clickBox2On(event:MouseEvent) : void
        {
            if (this.check_box2_flag == true)
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = true;
                this.check_box2_flag = false;
                this.dispFusenBlue(this.check_box2_flag);
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = false;
                this.check_box2_flag = true;
                this.dispFusenBlue(this.check_box2_flag);
            }
            return;
        }// end function

        public function clickBox2Off(event:MouseEvent) : void
        {
            if (this.check_box2_flag == true)
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = true;
                this.check_box2_flag = false;
                this.dispFusenBlue(this.check_box2_flag);
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box2_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box2_Off.visible = false;
                this.check_box2_flag = true;
                this.dispFusenBlue(this.check_box2_flag);
            }
            return;
        }// end function

        public function getCheckBox2() : Boolean
        {
            return this.check_box2_flag;
        }// end function

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.disp1_btn_flag = false;
            this.disp2_btn_flag = false;
            this.disp3_btn_flag = false;
            this.disp1_on_flag = false;
            this.disp2_on_flag = false;
            this.disp3_on_flag = false;
            this.check_box1_flag = false;
            this.check_box2_flag = false;
            this.ap_rock_flag = false;
            this.ap_btn_flag = false;
            this.a1_btn_flag = false;
            this.a2_btn_flag = false;
            this.bp_rock_flag = false;
            this.bp_btn_flag = false;
            this.b1_btn_flag = false;
            this.b2_btn_flag = false;
            this.refresh_flag = false;
            this.notes_disp_flag = true;
            this.disp_mode = 0;
            this.curve_dir = 0;
            this.now_func_a = 0;
            this.now_func_b = 0;
            this.func_status = [{no:0, disp:false, ins:"Ins_Func1", no_ins:"Ins_No1", btn_ins:"Ins_Del_Btn1", txt:"---", a:0, b:0, slope:-1, size:2, color:0}, {no:1, disp:false, ins:"Ins_Func1", no_ins:"Ins_No1", btn_ins:"Ins_Del_Btn1", txt:"---", a:0, b:0, slope:-1, size:2, color:0}, {no:2, disp:false, ins:"Ins_Func2", no_ins:"Ins_No2", btn_ins:"Ins_Del_Btn2", txt:"---", a:0, b:0, slope:-1, size:2, color:0}, {no:3, disp:false, ins:"Ins_Func3", no_ins:"Ins_No3", btn_ins:"Ins_Del_Btn3", txt:"---", a:0, b:0, slope:-1, size:2, color:0}, {no:4, disp:false, ins:"Ins_Func4", no_ins:"Ins_No4", btn_ins:"Ins_Del_Btn4", txt:"---", a:0, b:0, slope:-1, size:2, color:0}, {no:5, disp:false, ins:"Ins_Func5", no_ins:"Ins_No5", btn_ins:"Ins_Del_Btn5", txt:"---", a:0, b:0, slope:-1, size:2, color:0}];
            this.bar_status = [{no:1, ins:"Ins_APush_Btn", id:this._FUNC_START_A}, {no:2, ins:"Ins_BPush_Btn", id:this._FUNC_START_B}];
            this.ap_bar_ruler = [{num:-5, num_c:5, num_m:1, num_s:"-", txt:"-5x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 0, pin1:this._AP_BAR_L + this._AP_UINT * 0, pin2:this._AP_BAR_L + this._AP_UINT * 0.5}, {num:-4, num_c:4, num_m:1, num_s:"-", txt:"-4x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 1, pin1:this._AP_BAR_L + this._AP_UINT * 0.5, pin2:this._AP_BAR_L + this._AP_UINT * 1.5}, {num:-3, num_c:3, num_m:1, num_s:"-", txt:"-3x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 2, pin1:this._AP_BAR_L + this._AP_UINT * 1.5, pin2:this._AP_BAR_L + this._AP_UINT * 2.5}, {num:-2, num_c:2, num_m:1, num_s:"-", txt:"-2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 3, pin1:this._AP_BAR_L + this._AP_UINT * 2.5, pin2:this._AP_BAR_L + this._AP_UINT * 3.5}, {num:-1, num_c:1, num_m:1, num_s:"-", txt:"-x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 4, pin1:this._AP_BAR_L + this._AP_UINT * 3.5, pin2:this._AP_BAR_L + this._AP_UINT * 4.5}, {num:0, num_c:0, num_m:0, num_s:"", txt:"", tag:0, pin0:this._AP_BAR_L + this._AP_UINT * 5, pin1:this._AP_BAR_L + this._AP_UINT * 4.5, pin2:this._AP_BAR_L + this._AP_UINT * 5.5}, {num:1, num_c:1, num_m:1, num_s:"", txt:"x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 6, pin1:this._AP_BAR_L + this._AP_UINT * 5.5, pin2:this._AP_BAR_L + this._AP_UINT * 6.5}, {num:2, num_c:2, num_m:1, num_s:"", txt:"2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 7, pin1:this._AP_BAR_L + this._AP_UINT * 6.5, pin2:this._AP_BAR_L + this._AP_UINT * 7.5}, {num:3, num_c:3, num_m:1, num_s:"", txt:"3x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 8, pin1:this._AP_BAR_L + this._AP_UINT * 7.5, pin2:this._AP_BAR_L + this._AP_UINT * 8.5}, {num:4, num_c:4, num_m:1, num_s:"", txt:"4x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 9, pin1:this._AP_BAR_L + this._AP_UINT * 8.5, pin2:this._AP_BAR_L + this._AP_UINT * 9.5}, {num:5, num_c:5, num_m:1, num_s:"", txt:"5x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 10, pin1:this._AP_BAR_L + this._AP_UINT * 9.5, pin2:this._AP_BAR_L + this._AP_UINT * 10}];
            this.bp_bar_ruler = [{num:-5, num_c:5, num_m:1, num_s:"-", txt:"-5", pin0:this._BP_BAR_L + this._BP_UINT * 0, pin1:this._BP_BAR_L + this._BP_UINT * 0, pin2:this._BP_BAR_L + this._BP_UINT * 0.5}, {num:-4, num_c:4, num_m:1, num_s:"-", txt:"-4", pin0:this._BP_BAR_L + this._BP_UINT * 1, pin1:this._BP_BAR_L + this._BP_UINT * 0.5, pin2:this._BP_BAR_L + this._BP_UINT * 1.5}, {num:-3, num_c:3, num_m:1, num_s:"-", txt:"-3", pin0:this._BP_BAR_L + this._BP_UINT * 2, pin1:this._BP_BAR_L + this._BP_UINT * 1.5, pin2:this._BP_BAR_L + this._BP_UINT * 2.5}, {num:-2, num_c:2, num_m:1, num_s:"-", txt:"-2", pin0:this._BP_BAR_L + this._BP_UINT * 3, pin1:this._BP_BAR_L + this._BP_UINT * 2.5, pin2:this._BP_BAR_L + this._BP_UINT * 3.5}, {num:-1, num_c:1, num_m:1, num_s:"-", txt:"-1", pin0:this._BP_BAR_L + this._BP_UINT * 4, pin1:this._BP_BAR_L + this._BP_UINT * 3.5, pin2:this._BP_BAR_L + this._BP_UINT * 4.5}, {num:0, num_c:0, num_m:0, num_s:"+", txt:"", pin0:this._BP_BAR_L + this._BP_UINT * 5, pin1:this._BP_BAR_L + this._BP_UINT * 4.5, pin2:this._BP_BAR_L + this._BP_UINT * 5.5}, {num:1, num_c:1, num_m:1, num_s:"+", txt:"+1", pin0:this._BP_BAR_L + this._BP_UINT * 6, pin1:this._BP_BAR_L + this._BP_UINT * 5.5, pin2:this._BP_BAR_L + this._BP_UINT * 6.5}, {num:2, num_c:2, num_m:1, num_s:"+", txt:"+2", pin0:this._BP_BAR_L + this._BP_UINT * 7, pin1:this._BP_BAR_L + this._BP_UINT * 6.5, pin2:this._BP_BAR_L + this._BP_UINT * 7.5}, {num:3, num_c:3, num_m:1, num_s:"+", txt:"+3", pin0:this._BP_BAR_L + this._BP_UINT * 8, pin1:this._BP_BAR_L + this._BP_UINT * 7.5, pin2:this._BP_BAR_L + this._BP_UINT * 8.5}, {num:4, num_c:4, num_m:1, num_s:"+", txt:"+4", pin0:this._BP_BAR_L + this._BP_UINT * 9, pin1:this._BP_BAR_L + this._BP_UINT * 8.5, pin2:this._BP_BAR_L + this._BP_UINT * 9.5}, {num:5, num_c:5, num_m:1, num_s:"+", txt:"+5", pin0:this._BP_BAR_L + this._BP_UINT * 10, pin1:this._BP_BAR_L + this._BP_UINT * 9.5, pin2:this._BP_BAR_L + this._BP_UINT * 10}];
            this.line_shape = new Shape();
            this.Ins_Item_Graph.Ins_Line_Mc.addChild(this.line_shape);
            this.line_panel = this.line_shape.graphics;
            this.save_shape = new Shape();
            this.Ins_Item_Graph.Ins_Save_Mc.addChild(this.save_shape);
            this.save_panel = this.save_shape.graphics;
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
