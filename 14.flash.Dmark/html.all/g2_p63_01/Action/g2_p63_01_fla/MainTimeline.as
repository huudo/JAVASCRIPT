package g2_p63_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Graph:MovieClip;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var save_btn_flag:Boolean;
        public var disp1_btn_flag:Boolean;
        public var disp2_btn_flag:Boolean;
        public var clear_btn_flag:Boolean;
        public var ap_rock_flag:Boolean;
        public var ap_btn_flag:Boolean;
        public var a1_btn_flag:Boolean;
        public var a2_btn_flag:Boolean;
        public var bp_rock_flag:Boolean;
        public var bp_btn_flag:Boolean;
        public var b1_btn_flag:Boolean;
        public var b2_btn_flag:Boolean;
        public var refresh_flag:Boolean;
        public var support_disp_flag:Boolean;
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
        public const _AP_BAR_L:int = -400;
        public const _AP_BAR_R:int = 400;
        public const _AP_UINT:int = 40;
        public const _AP_ZERO:int = 12;
        public const _BP_BAR_L:int = -400;
        public const _BP_BAR_R:int = 400;
        public const _BP_UINT:int = 80;
        public const _BP_ZERO:int = 5;
        public var now_func_txt:String;
        public var now_func_a:Number;
        public var now_func_b:Number;
        public var func_status:Array;
        public var bar_status:Array;
        public var ap_bar_ruler:Array;
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
                    this.entrySaveBtn();
                    this.entryDisp1Btn();
                    this.entryDisp2Btn();
                    this.entryClearBtn();
                    this.entryAPushBtn();
                    this.entryA1Btn();
                    this.entryA2Btn();
                    this.entryBPushBtn();
                    this.entryB1Btn();
                    this.entryB2Btn();
                    this.Main_timer = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.refresh_flag == true)
                    {
                        this.line_panel.clear();
                        this.dispFuncLine(this.line_panel, 0, this.getAPbarA(this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x), this.getBPbarB(this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x));
                        this.dispLinePoint(this.line_panel, 0, this.getFuncPosY(0, 0, this.getAPbarA(this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x), this.getBPbarB(this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x)));
                        this.dispFuncLineAll(this.line_panel);
                        this.dispFuncListAll();
                        this.refresh_flag = false;
                    }
                    else if (this.getClearBtn() == true)
                    {
                        this.line_panel.clear();
                        this.deleteFuncList(1);
                        this.deleteFuncList(2);
                        this.deleteFuncList(3);
                        this.deleteFuncList(4);
                        this.clearFuncLineTagAll();
                        this.setClearBtn(false);
                    }
                    else if (this.getDisp1Btn() == true)
                    {
                        this.disp_mode = 1;
                        this.line_panel.clear();
                        this.dispModeItem(this.disp_mode);
                        this.clearFuncLineTagAll();
                        this.refresh_flag = true;
                        this.setDisp1Btn(false);
                        this.Main_timer = 0;
                        this.Main_index = 20;
                    }
                    break;
                }
                case 20:
                {
                    if (this.refresh_flag == true)
                    {
                        this.dispFuncLineAfterimage(this.line_panel, 0, this.getAPbarA(this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x), this.getBPbarB(this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x));
                        this.refresh_flag = false;
                    }
                    else if (this.getClearBtn() == true)
                    {
                        this.line_panel.clear();
                        this.setClearBtn(false);
                    }
                    else if (this.getDisp2Btn() == true)
                    {
                        this.disp_mode = 0;
                        this.line_panel.clear();
                        this.dispModeItem(this.disp_mode);
                        this.refresh_flag = true;
                        this.setDisp2Btn(false);
                        this.Main_timer = 0;
                        this.Main_index = 10;
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
            this.releaseSaveBtn();
            this.releaseDisp1Btn();
            this.releaseDisp2Btn();
            this.releaseClearBtn();
            this.releaseAPushBtn();
            this.releaseA1Btn();
            this.releaseA2Btn();
            this.releaseBPushBtn();
            this.releaseB1Btn();
            this.releaseB2Btn();
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
            this.Ins_Item_Graph.visible = true;
            this.disp_mode = 0;
            this.refresh_flag = false;
            this.dispModeItem(this.disp_mode);
            this.Ins_Item_Control.Ins_FuncList.Ins_FuncN.visible = true;
            this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.visible = false;
            this.dispFuncListAll();
            this.initFuncListBtn(1);
            this.initFuncListBtn(2);
            this.initFuncListBtn(3);
            this.initFuncListBtn(4);
            this.now_func_a = this.ap_bar_ruler[this.bar_status[0].id].num;
            this.now_func_b = this.bp_bar_ruler[this.bar_status[1].id].num;
            this.dispFuncLine(this.line_panel, 0, this.now_func_a, this.now_func_b);
            this.dispLinePoint(this.line_panel, 0, this.getFuncPosY(0, 0, this.now_func_a, this.now_func_b));
            this.dispFuncTagNo(this.func_status[1].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[2].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[3].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[4].no_ins, 0, 0, false);
            this.dispAPbar(this.bar_status[0].id);
            this.dispBPbar(this.bar_status[1].id);
            return;
        }// end function

        public function dispModeItem(param1:uint) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.Ins_Item_Graph.Ins_Mode.gotoAndStop("mode0");
                    this.Ins_Item_Control.Ins_FuncList.visible = true;
                    this.Ins_Item_Control.Ins_Save_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Disp1_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Disp2_Btn.visible = false;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Graph.Ins_Mode.gotoAndStop("mode1");
                    this.Ins_Item_Control.Ins_FuncList.visible = false;
                    this.Ins_Item_Control.Ins_Save_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Disp1_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Disp2_Btn.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispFuncLineAll(param1:Graphics) : void
        {
            if (this.func_status[1].disp == true)
            {
                this.dispFuncLine(param1, 1, this.func_status[1].a, this.func_status[1].b);
                this.dispFuncLineTag(1);
            }
            else
            {
                this.dispFuncTagNo(this.func_status[1].no_ins, 0, 0, false);
            }
            if (this.func_status[2].disp == true)
            {
                this.dispFuncLine(param1, 2, this.func_status[2].a, this.func_status[2].b);
                this.dispFuncLineTag(2);
            }
            else
            {
                this.dispFuncTagNo(this.func_status[2].no_ins, 0, 0, false);
            }
            if (this.func_status[3].disp == true)
            {
                this.dispFuncLine(param1, 3, this.func_status[3].a, this.func_status[3].b);
                this.dispFuncLineTag(3);
            }
            else
            {
                this.dispFuncTagNo(this.func_status[3].no_ins, 0, 0, false);
            }
            if (this.func_status[4].disp == true)
            {
                this.dispFuncLine(param1, 4, this.func_status[4].a, this.func_status[4].b);
                this.dispFuncLineTag(4);
            }
            else
            {
                this.dispFuncTagNo(this.func_status[4].no_ins, 0, 0, false);
            }
            return;
        }// end function

        public function dispFuncLine(param1:Graphics, param2:int, param3:Number, param4:Number) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            param1.lineStyle(this.func_status[param2].size, this.func_status[param2].color, 1);
            _loc_5 = -5;
            _loc_6 = this.getFuncPosY(_loc_5, 0, param3, param4);
            param1.moveTo(this.changeGraphPosX(_loc_5), this.changeGraphPosY(_loc_6));
            _loc_7 = 5;
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
            param3 = Math.round(param3 * 4);
            param3 = param3 / 4;
            param4 = Math.round(param4 * 2);
            param4 = param4 / 2;
            param1.lineStyle(1, 4473924, 1);
            _loc_5 = -5;
            _loc_6 = this.getFuncPosY(_loc_5, 0, param3, param4);
            param1.moveTo(this.changeGraphPosX(_loc_5), this.changeGraphPosY(_loc_6));
            _loc_7 = 5;
            _loc_8 = this.getFuncPosY(_loc_7, 0, param3, param4);
            param1.lineTo(this.changeGraphPosX(_loc_7), this.changeGraphPosY(_loc_8));
            return;
        }// end function

        public function dispLinePoint(param1:Graphics, param2:Number, param3:Number) : void
        {
            param1.lineStyle(0, 0);
            param1.beginFill(0);
            param1.drawCircle(this.changeGraphPosX(param2), this.changeGraphPosY(param3), 3);
            param1.endFill();
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

        public function dispFuncListText(param1:DisplayObject, param2:int, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = param1 as MovieClip;
            _loc_5 = (_loc_4).getChildByName("Ins_A");
            _loc_7 = _loc_4.getChildByName("Ins_X");
            if (param2 == this._AP_ZERO)
            {
                _loc_5.visible = false;
                _loc_7.visible = false;
            }
            else if (this.ap_bar_ruler[param2].num_c == 1 && this.ap_bar_ruler[param2].num_c == 1)
            {
                _loc_5.visible = true;
                _loc_7.visible = true;
                this.dispNumber(_loc_5, this.ap_bar_ruler[param2].num_c, this.ap_bar_ruler[param2].num_m, this.ap_bar_ruler[param2].num_s, "", false);
            }
            else
            {
                _loc_5.visible = true;
                _loc_7.visible = true;
                this.dispNumber(_loc_5, this.ap_bar_ruler[param2].num_c, this.ap_bar_ruler[param2].num_m, this.ap_bar_ruler[param2].num_s, "", true);
            }
            _loc_6 = _loc_4.getChildByName("Ins_B");
            if (param2 != this._AP_ZERO)
            {
                if (param3 == this._BP_ZERO)
                {
                    _loc_6.visible = false;
                }
                else
                {
                    _loc_6.visible = true;
                    _loc_6.x = 117;
                    if (this.bp_bar_ruler[param3].num_s == "-")
                    {
                        this.dispNumber(_loc_6, this.bp_bar_ruler[param3].num_c, this.bp_bar_ruler[param3].num_m, "", "－", true);
                    }
                    else if (this.bp_bar_ruler[param3].num_s == "+")
                    {
                        this.dispNumber(_loc_6, this.bp_bar_ruler[param3].num_c, this.bp_bar_ruler[param3].num_m, "", "＋", true);
                    }
                    else
                    {
                        this.dispNumber(_loc_6, this.bp_bar_ruler[param3].num_c, this.bp_bar_ruler[param3].num_m, "", "", true);
                    }
                }
            }
            else
            {
                _loc_6.visible = true;
                if (this.bp_bar_ruler[param3].num_s == "-")
                {
                    _loc_6.x = 40;
                    this.dispNumber(_loc_6, this.bp_bar_ruler[param3].num_c, this.bp_bar_ruler[param3].num_m, "", "－", true);
                }
                else
                {
                    _loc_6.x = 15;
                    this.dispNumber(_loc_6, this.bp_bar_ruler[param3].num_c, this.bp_bar_ruler[param3].num_m, "", "", true);
                }
            }
            return;
        }// end function

        public function dispNumber(param1:DisplayObject, param2:int, param3:int, param4:String, param5:String, param6:Boolean) : void
        {
            var _loc_7:* = "";
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
                if (param6 == true)
                {
                    this.dispNumberText(param1, "Ins_NumBase", String(param2));
                    this.dispNumberText(param1, "Ins_NumC", "");
                    this.dispNumberText(param1, "Ins_NumM", "");
                    this.dispNumberText(param1, "Ins_NumBar", "");
                    if (param4 == "-")
                    {
                        this.dispNumberTextAndPos(param1, "Ins_NumMark", "-", -38, -16);
                    }
                    else
                    {
                        this.dispNumberText(param1, "Ins_NumMark", "");
                    }
                }
                else
                {
                    this.dispNumberText(param1, "Ins_NumBase", "");
                    this.dispNumberText(param1, "Ins_NumC", "");
                    this.dispNumberText(param1, "Ins_NumM", "");
                    this.dispNumberText(param1, "Ins_NumBar", "");
                    if (param4 == "-")
                    {
                        this.dispNumberTextAndPos(param1, "Ins_NumMark", "-", -10, -16);
                    }
                    else
                    {
                        this.dispNumberText(param1, "Ins_NumMark", "");
                    }
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
                    this.dispNumberTextAndPos(param1, "Ins_NumMark", "-", -38, -16);
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

        public function dispNumberTextAndPos(param1:DisplayObject, param2:String, param3:String, param4:int, param5:int) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_6:* = param1 as MovieClip;
            _loc_7 = (_loc_6).getChildByName(param2);
            _loc_8 = _loc_7 as MovieClip;
            _loc_9 = _loc_7 as TextField;
            _loc_9.text = param3;
            _loc_7.x = param4;
            _loc_7.y = param5;
            return;
        }// end function

        public function dispFuncLineTag(param1:int) : void
        {
            if (this.func_status[param1].slope == -1)
            {
                return;
            }
            var _loc_2:* = this.ap_bar_ruler[this.func_status[param1].slope].tag;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            switch(_loc_2)
            {
                case 0:
                {
                    _loc_3 = -218;
                    _loc_4 = this.getFuncPosY(-5, 0, this.func_status[param1].a, this.func_status[param1].b);
                    _loc_4 = this.changeGraphPosY(_loc_4);
                    this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    break;
                }
                case 1:
                {
                    _loc_3 = this.getFuncPosX(0, 5, this.func_status[param1].a, this.func_status[param1].b);
                    if (_loc_3 >= -5 && _loc_3 <= 5)
                    {
                        _loc_3 = this.changeGraphPosX(_loc_3);
                        _loc_4 = this.changeGraphPosY(5.5);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    else if (_loc_3 > 5)
                    {
                        _loc_3 = 5;
                        _loc_4 = this.getFuncPosY(5, 0, this.func_status[param1].a, this.func_status[param1].b);
                        _loc_3 = this.changeGraphPosX(_loc_3 + 0.5);
                        _loc_4 = this.changeGraphPosY(_loc_4);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    else if (_loc_3 < -5)
                    {
                        _loc_3 = -5;
                        _loc_4 = this.getFuncPosY(-5, 0, this.func_status[param1].a, this.func_status[param1].b);
                        _loc_3 = this.changeGraphPosX(_loc_3 - 0.5);
                        _loc_4 = this.changeGraphPosY(_loc_4);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    break;
                }
                case 2:
                {
                    _loc_3 = this.getFuncPosX(0, -5, this.func_status[param1].a, this.func_status[param1].b);
                    if (_loc_3 >= -5 && _loc_3 <= 5)
                    {
                        _loc_3 = this.changeGraphPosX(_loc_3);
                        _loc_4 = this.changeGraphPosY(-5.5);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    else if (_loc_3 > 5)
                    {
                        _loc_3 = 5;
                        _loc_4 = this.getFuncPosY(5, 0, this.func_status[param1].a, this.func_status[param1].b);
                        _loc_3 = this.changeGraphPosX(_loc_3 + 0.5);
                        _loc_4 = this.changeGraphPosY(_loc_4);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    else if (_loc_3 < -5)
                    {
                        _loc_3 = -5;
                        _loc_4 = this.getFuncPosY(-5, 0, this.func_status[param1].a, this.func_status[param1].b);
                        _loc_3 = this.changeGraphPosX(_loc_3 - 0.5);
                        _loc_4 = this.changeGraphPosY(_loc_4);
                        this.dispFuncTagNo(this.func_status[param1].no_ins, _loc_3, _loc_4, true);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clearFuncLineTagAll() : void
        {
            this.dispFuncTagNo(this.func_status[1].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[2].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[3].no_ins, 0, 0, false);
            this.dispFuncTagNo(this.func_status[4].no_ins, 0, 0, false);
            return;
        }// end function

        public function dispFuncTagNo(param1:String, param2:int, param3:int, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = this.Ins_Item_Graph.getChildByName(param1);
            _loc_6 = _loc_5 as MovieClip;
            _loc_5.visible = param4;
            _loc_5.x = param2;
            _loc_5.y = param3;
            return;
        }// end function

        public function dispFuncListAll() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.ap_rock_flag == false && this.bp_rock_flag == false)
            {
                this.Ins_Item_Control.Ins_FuncList.Ins_FuncN.visible = true;
                this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.visible = false;
                this.dispFuncList(0, this.bar_status[0].id, this.bar_status[1].id);
            }
            else
            {
                this.Ins_Item_Control.Ins_FuncList.Ins_FuncN.visible = false;
                this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.visible = true;
                _loc_1 = Math.floor(this.getAPbarA(this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x) * 10) / 10;
                _loc_2 = Math.floor(this.getBPbarB(this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x) * 10) / 10;
                this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.Ins_A.text = String(_loc_1);
                if (_loc_2 >= 0)
                {
                    this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.Ins_B.text = "＋" + String(_loc_2);
                }
                else
                {
                    this.Ins_Item_Control.Ins_FuncList.Ins_Func_Move.Ins_B.text = String(_loc_2);
                }
            }
            this.dispFuncList(1, this.func_status[1].a_id, this.func_status[1].b_id);
            this.dispFuncList(2, this.func_status[2].a_id, this.func_status[2].b_id);
            this.dispFuncList(3, this.func_status[3].a_id, this.func_status[3].b_id);
            this.dispFuncList(4, this.func_status[4].a_id, this.func_status[4].b_id);
            return;
        }// end function

        public function dispFuncList(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_4 = this.Ins_Item_Control.Ins_FuncList.getChildByName(this.func_status[param1].ins);
            if (param2 == -1 && param3 == -1)
            {
                _loc_4.visible = false;
            }
            else if (param2 == this._AP_ZERO && param3 == this._BP_ZERO)
            {
                _loc_4.visible = true;
                this.dispFuncListText(_loc_4, param2, param3);
            }
            else
            {
                _loc_4.visible = true;
                this.dispFuncListText(_loc_4, param2, param3);
            }
            return;
        }// end function

        public function deleteFuncList(param1:int) : void
        {
            this.func_status[param1].disp = false;
            this.func_status[param1].a = 0;
            this.func_status[param1].b = 0;
            this.func_status[param1].a_id = -1;
            this.func_status[param1].b_id = -1;
            this.func_status[param1].txt = "---";
            this.func_status[param1].slope = -1;
            this.dispFuncList(param1, this.func_status[param1].a_id, this.func_status[param1].b_id);
            return;
        }// end function

        public function getFreeFuncList() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = -1;
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                if (this.func_status[(_loc_1 + 1)].disp == false)
                {
                    _loc_2 = _loc_1 + 1;
                    break;
                }
                _loc_1++;
            }
            return _loc_2;
        }// end function

        public function initFuncListBtn(param1:int) : void
        {
            var wk_func:DisplayObject;
            var wk_func_mc:MovieClip;
            var downDelBtn:Function;
            var list_no:* = param1;
            downDelBtn = function (event:MouseEvent) : void
            {
                deleteFuncList(list_no);
                refresh_flag = true;
                return;
            }// end function
            ;
            wk_func = this.Ins_Item_Control.Ins_FuncList.getChildByName(this.func_status[list_no].btn_ins);
            wk_func_mc = wk_func as MovieClip;
            wk_func.addEventListener(MouseEvent.MOUSE_DOWN, downDelBtn);
            wk_func.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                wk_func.removeEventListener(MouseEvent.MOUSE_DOWN, downDelBtn);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x = this.ap_bar_ruler[param1].pin0;
            return;
        }// end function

        public function stickAPbar() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x = this.ap_bar_ruler[this.bar_status[0].id].pin0;
            return;
        }// end function

        public function entryAPushBtn() : void
        {
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.addEventListener(MouseEvent.MOUSE_DOWN, this.downAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.addEventListener(MouseEvent.MOUSE_UP, this.outAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.addEventListener(MouseEvent.MOUSE_OUT, this.outAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.addEventListener(MouseEvent.MOUSE_MOVE, this.moveAPushBtn);
            return;
        }// end function

        public function releaseAPushBtn() : void
        {
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.removeEventListener(MouseEvent.MOUSE_DOWN, this.downAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.removeEventListener(MouseEvent.MOUSE_UP, this.outAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.removeEventListener(MouseEvent.MOUSE_OUT, this.outAPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveAPushBtn);
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
                _loc_2 = this.Ins_Item_Control.Ins_Push_Bar.mouseX;
                if (_loc_2 < this.ap_bar_ruler[0].pin0)
                {
                    _loc_2 = this.ap_bar_ruler[0].pin0;
                }
                else if (_loc_2 > this.ap_bar_ruler[(this.ap_bar_ruler.length - 1)].pin0)
                {
                    _loc_2 = this.ap_bar_ruler[(this.ap_bar_ruler.length - 1)].pin0;
                }
                this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x = _loc_2;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x = this.bp_bar_ruler[param1].pin0;
            return;
        }// end function

        public function stickBPbar() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x = this.bp_bar_ruler[this.bar_status[1].id].pin0;
            return;
        }// end function

        public function entryBPushBtn() : void
        {
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.addEventListener(MouseEvent.MOUSE_DOWN, this.downBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.addEventListener(MouseEvent.MOUSE_UP, this.outBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.addEventListener(MouseEvent.MOUSE_OUT, this.outBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.addEventListener(MouseEvent.MOUSE_MOVE, this.moveBPushBtn);
            return;
        }// end function

        public function releaseBPushBtn() : void
        {
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.removeEventListener(MouseEvent.MOUSE_DOWN, this.downBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.removeEventListener(MouseEvent.MOUSE_UP, this.outBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.removeEventListener(MouseEvent.MOUSE_OUT, this.outBPushBtn);
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveBPushBtn);
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
                _loc_2 = this.Ins_Item_Control.Ins_Push_Bar.mouseX;
                if (_loc_2 < this.bp_bar_ruler[0].pin0)
                {
                    _loc_2 = this.bp_bar_ruler[0].pin0;
                }
                else if (_loc_2 > this.bp_bar_ruler[(this.bp_bar_ruler.length - 1)].pin0)
                {
                    _loc_2 = this.bp_bar_ruler[(this.bp_bar_ruler.length - 1)].pin0;
                }
                this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x = _loc_2;
                this.refresh_flag = true;
            }
            return;
        }// end function

        public function getBPushBtn() : Boolean
        {
            return this.bp_btn_flag;
        }// end function

        public function entrySaveBtn() : void
        {
            this.Ins_Item_Control.Ins_Save_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downSaveBtn);
            return;
        }// end function

        public function releaseSaveBtn() : void
        {
            this.Ins_Item_Control.Ins_Save_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downSaveBtn);
            return;
        }// end function

        public function downSaveBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            _loc_2 = this.getFreeFuncList();
            if (_loc_2 != -1)
            {
                this.func_status[_loc_2].disp = true;
                this.func_status[_loc_2].a = this.ap_bar_ruler[this.bar_status[0].id].num;
                this.func_status[_loc_2].b = this.bp_bar_ruler[this.bar_status[1].id].num;
                this.func_status[_loc_2].a_id = this.bar_status[0].id;
                this.func_status[_loc_2].b_id = this.bar_status[1].id;
                this.func_status[_loc_2].txt = "y=" + this.ap_bar_ruler[this.bar_status[0].id].txt + this.bp_bar_ruler[this.bar_status[1].id].txt;
                this.func_status[_loc_2].slope = this.bar_status[0].id;
                this.refresh_flag = true;
            }
            return;
        }// end function

        public function getSaveBtn() : Boolean
        {
            return this.save_btn_flag;
        }// end function

        public function entryDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downDisp1Btn);
            return;
        }// end function

        public function releaseDisp1Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp1_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downDisp1Btn);
            return;
        }// end function

        public function downDisp1Btn(event:MouseEvent) : void
        {
            this.disp1_btn_flag = true;
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
            this.Ins_Item_Control.Ins_Disp2_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downDisp2Btn);
            return;
        }// end function

        public function releaseDisp2Btn() : void
        {
            this.Ins_Item_Control.Ins_Disp2_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downDisp2Btn);
            return;
        }// end function

        public function downDisp2Btn(event:MouseEvent) : void
        {
            this.disp2_btn_flag = true;
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

        public function entryClearBtn() : void
        {
            this.Ins_Item_Control.Ins_Clear_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downClearBtn);
            return;
        }// end function

        public function releaseClearBtn() : void
        {
            this.Ins_Item_Control.Ins_Clear_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downClearBtn);
            return;
        }// end function

        public function downClearBtn(event:MouseEvent) : void
        {
            this.clear_btn_flag = true;
            return;
        }// end function

        public function getClearBtn() : Boolean
        {
            return this.clear_btn_flag;
        }// end function

        public function setClearBtn(param1:Boolean) : void
        {
            this.clear_btn_flag = param1;
            return;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x = this.ap_bar_ruler[_loc_2.id].pin0;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_A.x = this.ap_bar_ruler[_loc_2.id].pin0;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x = this.bp_bar_ruler[_loc_2.id].pin0;
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
            this.Ins_Item_Control.Ins_Push_Bar.Ins_B.x = this.bp_bar_ruler[_loc_2.id].pin0;
            this.refresh_flag = true;
            return;
        }// end function

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.save_btn_flag = false;
            this.disp1_btn_flag = false;
            this.disp2_btn_flag = false;
            this.clear_btn_flag = false;
            this.ap_rock_flag = false;
            this.ap_btn_flag = false;
            this.a1_btn_flag = false;
            this.a2_btn_flag = false;
            this.bp_rock_flag = false;
            this.bp_btn_flag = false;
            this.b1_btn_flag = false;
            this.b2_btn_flag = false;
            this.refresh_flag = false;
            this.support_disp_flag = false;
            this.disp_mode = 0;
            this.curve_dir = 0;
            this.now_func_txt = "y=2x";
            this.now_func_a = 2;
            this.now_func_b = 0;
            this.func_status = [{no:0, disp:false, ins:"Ins_FuncN", no_ins:"Ins_No1", btn_ins:"Ins_Del_Btn1", txt:"---", a:0, b:0, a_id:-1, b_id:-1, slope:-1, size:2.5, color:0}, {no:1, disp:false, ins:"Ins_Func1", no_ins:"Ins_No1", btn_ins:"Ins_Del_Btn1", txt:"---", a:0, b:0, a_id:-1, b_id:-1, slope:-1, size:2.5, color:0}, {no:2, disp:false, ins:"Ins_Func2", no_ins:"Ins_No2", btn_ins:"Ins_Del_Btn2", txt:"---", a:0, b:0, a_id:-1, b_id:-1, slope:-1, size:2.5, color:0}, {no:3, disp:false, ins:"Ins_Func3", no_ins:"Ins_No3", btn_ins:"Ins_Del_Btn3", txt:"---", a:0, b:0, a_id:-1, b_id:-1, slope:-1, size:2.5, color:0}, {no:4, disp:false, ins:"Ins_Func4", no_ins:"Ins_No4", btn_ins:"Ins_Del_Btn4", txt:"---", a:0, b:0, a_id:-1, b_id:-1, slope:-1, size:2.5, color:0}];
            this.bar_status = [{no:1, ins:"Ins_A", id:18}, {no:2, ins:"Ins_B", id:5}];
            this.ap_bar_ruler = [{num:-5, num_c:5, num_m:1, num_s:"-", txt:"-5x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 0, pin1:this._AP_BAR_L + this._AP_UINT * 0, pin2:this._AP_BAR_L + this._AP_UINT * 0.5}, {num:-4.5, num_c:9, num_m:2, num_s:"-", txt:"-9/2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 1, pin1:this._AP_BAR_L + this._AP_UINT * 0.5, pin2:this._AP_BAR_L + this._AP_UINT * 1.5}, {num:-4, num_c:4, num_m:1, num_s:"-", txt:"-4x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 2, pin1:this._AP_BAR_L + this._AP_UINT * 1.5, pin2:this._AP_BAR_L + this._AP_UINT * 2.5}, {num:-3.5, num_c:7, num_m:2, num_s:"-", txt:"-7/2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 3, pin1:this._AP_BAR_L + this._AP_UINT * 2.5, pin2:this._AP_BAR_L + this._AP_UINT * 3.5}, {num:-3, num_c:3, num_m:1, num_s:"-", txt:"-3x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 4, pin1:this._AP_BAR_L + this._AP_UINT * 3.5, pin2:this._AP_BAR_L + this._AP_UINT * 4.5}, {num:-2.5, num_c:5, num_m:2, num_s:"-", txt:"-5/2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 5, pin1:this._AP_BAR_L + this._AP_UINT * 4.5, pin2:this._AP_BAR_L + this._AP_UINT * 5.5}, {num:-2, num_c:2, num_m:1, num_s:"-", txt:"-2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 6, pin1:this._AP_BAR_L + this._AP_UINT * 5.5, pin2:this._AP_BAR_L + this._AP_UINT * 6.5}, {num:-1.5, num_c:3, num_m:2, num_s:"-", txt:"-3/2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 7, pin1:this._AP_BAR_L + this._AP_UINT * 6.5, pin2:this._AP_BAR_L + this._AP_UINT * 7.5}, {num:-1, num_c:1, num_m:1, num_s:"-", txt:"-x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 8, pin1:this._AP_BAR_L + this._AP_UINT * 7.5, pin2:this._AP_BAR_L + this._AP_UINT * 8.5}, {num:-2 / 3, num_c:2, num_m:3, num_s:"-", txt:"-2/3x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 8.66, pin1:this._AP_BAR_L + this._AP_UINT * 8.5, pin2:this._AP_BAR_L + this._AP_UINT * 8.88}, {num:-0.5, num_c:1, num_m:2, num_s:"-", txt:"-1/2x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 9, pin1:this._AP_BAR_L + this._AP_UINT * 8.88, pin2:this._AP_BAR_L + this._AP_UINT * 9.16}, {num:-1 / 3, num_c:1, num_m:2, num_s:"-", txt:"-1/3x", tag:2, pin0:this._AP_BAR_L + this._AP_UINT * 9.33, pin1:this._AP_BAR_L + this._AP_UINT * 9.16, pin2:this._AP_BAR_L + this._AP_UINT * 9.66}, {num:0, num_c:0, num_m:0, num_s:"", txt:"", tag:0, pin0:this._AP_BAR_L + this._AP_UINT * 10, pin1:this._AP_BAR_L + this._AP_UINT * 9.66, pin2:this._AP_BAR_L + this._AP_UINT * 10.16}, {num:1 / 3, num_c:1, num_m:3, num_s:"", txt:"1/3x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 10.66, pin1:this._AP_BAR_L + this._AP_UINT * 10.16, pin2:this._AP_BAR_L + this._AP_UINT * 10.88}, {num:0.5, num_c:1, num_m:2, num_s:"", txt:"1/2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 11, pin1:this._AP_BAR_L + this._AP_UINT * 10.88, pin2:this._AP_BAR_L + this._AP_UINT * 11.16}, {num:2 / 3, num_c:2, num_m:3, num_s:"", txt:"2/3x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 11.33, pin1:this._AP_BAR_L + this._AP_UINT * 11.16, pin2:this._AP_BAR_L + this._AP_UINT * 11.66}, {num:1, num_c:1, num_m:1, num_s:"", txt:"x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 12, pin1:this._AP_BAR_L + this._AP_UINT * 11.66, pin2:this._AP_BAR_L + this._AP_UINT * 12.5}, {num:1.5, num_c:3, num_m:2, num_s:"", txt:"3/2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 13, pin1:this._AP_BAR_L + this._AP_UINT * 12.5, pin2:this._AP_BAR_L + this._AP_UINT * 13.5}, {num:2, num_c:2, num_m:1, num_s:"", txt:"2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 14, pin1:this._AP_BAR_L + this._AP_UINT * 13.5, pin2:this._AP_BAR_L + this._AP_UINT * 14.5}, {num:2.5, num_c:5, num_m:2, num_s:"", txt:"5/2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 15, pin1:this._AP_BAR_L + this._AP_UINT * 14.5, pin2:this._AP_BAR_L + this._AP_UINT * 15.5}, {num:3, num_c:3, num_m:1, num_s:"", txt:"3x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 16, pin1:this._AP_BAR_L + this._AP_UINT * 15.5, pin2:this._AP_BAR_L + this._AP_UINT * 16.5}, {num:3.5, num_c:7, num_m:2, num_s:"", txt:"7/2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 17, pin1:this._AP_BAR_L + this._AP_UINT * 16.5, pin2:this._AP_BAR_L + this._AP_UINT * 17.5}, {num:4, num_c:4, num_m:1, num_s:"", txt:"4x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 18, pin1:this._AP_BAR_L + this._AP_UINT * 17.5, pin2:this._AP_BAR_L + this._AP_UINT * 18.5}, {num:4.5, num_c:9, num_m:2, num_s:"", txt:"9/2x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 19, pin1:this._AP_BAR_L + this._AP_UINT * 18.5, pin2:this._AP_BAR_L + this._AP_UINT * 19.5}, {num:5, num_c:5, num_m:1, num_s:"", txt:"5x", tag:1, pin0:this._AP_BAR_L + this._AP_UINT * 20, pin1:this._AP_BAR_L + this._AP_UINT * 19.5, pin2:this._AP_BAR_L + this._AP_UINT * 20}];
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
