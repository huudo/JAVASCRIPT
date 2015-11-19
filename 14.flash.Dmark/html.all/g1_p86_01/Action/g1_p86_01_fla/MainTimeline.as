package g1_p86_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Ins_Item_Setting:MovieClip;
        public var Main_mode:uint;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var start_btn_flag:Boolean;
        public var next_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var other_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var setting_btn_flag:Boolean;
        public var pause_flag:Boolean;
        public var weight_touch_flag:Boolean;
        public var weight_refresh_flag:Boolean;
        public var mode_ofs_x:int;
        public var mode_ofs_y:int;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _START_MODE:uint = 0;
        public const _LIST_B1X:int = -420;
        public const _LIST_B1Y:int = -200;
        public const _LIST_B2X:int = -420;
        public const _LIST_B2Y:int = -45;
        public const _LIST_B3X:int = -420;
        public const _LIST_B3Y:int = 105;
        public const _LIST_OFSX:int = 160;
        public const _LIST_OFSY:int = 35;
        public const _WT_SIZE:int = 46;
        public const _WT_L_BASE_X:int = -340;
        public const _WT_L_BASE_Y:int = -30;
        public const _WT_R_BASE_X:int = 30;
        public const _WT_R_BASE_Y:int = -30;
        public const _WT_L_BASE_X2:int = -363;
        public const _WT_R_BASE_X2:int = 7;
        public const _PLATE1_POSY:int = -158;
        public const _PLATE2_POSY:int = -158;
        public const _PLATE_SCALE:Number = 0.5;
        public const _BALANCE_POSX1:int = -154;
        public const _BALANCE_POSY1:int = 79;
        public const _DRAGAREA_POSX1:int = -154;
        public const _DRAGAREA_POSY1:int = 210;
        public const _BALANCE_POSX2:int = 190;
        public const _BALANCE_POSY2:int = -10;
        public const _DRAGAREA_POSX2:int = 190;
        public const _DRAGAREA_POSY2:int = 110;
        public const _PLATE1_DRAGAREA_POSX1:int = -339;
        public const _PLATE1_DRAGAREA_POSY1:int = -63;
        public const _PLATE1_DRAGAREA_POSX2:int = 5;
        public const _PLATE1_DRAGAREA_POSY2:int = -152;
        public const _PLATE2_DRAGAREA_POSX1:int = 31;
        public const _PLATE2_DRAGAREA_POSY1:int = -63;
        public const _PLATE2_DRAGAREA_POSX2:int = 375;
        public const _PLATE2_DRAGAREA_POSY2:int = -152;
        public const _EXP_MOVE_POSX1:int = -20;
        public const _EXP_MOVE_POSY1:int = 180;
        public const _EXP_MOVE_POSX2:int = -20;
        public const _EXP_MOVE_POSY2:int = 260;
        public const _EXP_MOVE_POSX3:int = -20;
        public const _EXP_MOVE_POSY3:int = 270;
        public const _EXP_MOVE_POSX4:int = -100;
        public const _EXP_MOVE_POSY4:int = 290;
        public const _DRAG_AREA_1:uint = 1;
        public const _DRAG_AREA_2:uint = 2;
        public const _DRAG_AREA_3:uint = 3;
        public var quest_list:Array;
        public var quest_text:Array;
        public var quest_status:Array;
        public var quest_exp_script:Array;
        public var weight_status:Array;
        public var weight_pos1_tbl:Array;
        public var weight_pos2_tbl:Array;
        public var weight_pos3_tbl:Array;
        public var weight_pos4_tbl:Array;
        public var weight_pos5_tbl:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var quest_list_no:int;
        public var weight_num:int;
        public var weight1_counter:int;
        public var weight2_counter:int;
        public var area_weight_num:Array;
        public var balance_id:uint;
        public var game_index:int;
        public var game_timer:int;
        public var game_step:int;
        public var drop_box_flag:Boolean;
        public var drop_box_open:Boolean;
        public var drop_box_list:int;
        public const _DROP_BOX_LIST_MAX:int = 5;
        public const _DROP_BOX_LIST_SIZE:int = 52;
        public var setting_status:Array;
        public const _LIST_MARK_OFSX:int = -95;
        public var setting_list_no:uint;
        public var setting_list_rock:Boolean;
        public var setting_ret_flag:Boolean;

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
                    this.entryResetBtn();
                    this.entrySettingBtn();
                    this.entryOtherBtn();
                    this.entryNextBtn();
                    this.entryStartBtn();
                    this.entryStopBtn();
                    this.initSettingMenu();
                    if (this.Main_mode == 0)
                    {
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else
                    {
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    break;
                }
                case 10:
                {
                    this.initGame();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.quest_list_no = 1;
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.getDropBoxBtn() == true)
                    {
                        this.quest_list_no = this.getDropBoxListNo();
                        this.setDropBoxBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.getOtherBtn() == true)
                    {
                        this.quest_list_no = this.changeQuestListNo(this.quest_list_no);
                        this.setOtherBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.getSettingBtn() == true)
                    {
                        this.dispSettingMenu(1);
                        this.setSettingBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 80;
                    }
                    else
                    {
                        this.controlGame();
                    }
                    break;
                }
                case 30:
                {
                    this.initGameAnime();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 40;
                    break;
                }
                case 40:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    else if (this.getSettingBtn() == true)
                    {
                        this.dispSettingMenu(1);
                        this.setSettingBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 80;
                    }
                    else if (this.controlGameAnime() == 99)
                    {
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 41;
                    }
                    break;
                }
                case 41:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    else if (this.getNextBtn() == true)
                    {
                        var _loc_2:* = this;
                        var _loc_3:* = this.quest_list_no + 1;
                        _loc_2.quest_list_no = _loc_3;
                        if (this.quest_list_no > (this.quest_list[1].func_no.length - 1))
                        {
                            this.quest_list_no = 1;
                        }
                        this.setNextBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    break;
                }
                case 80:
                {
                    if (this.getSettingRetBtn() == true)
                    {
                        this.quest_list_no = 1;
                        this.Main_mode = this.getSettingList1();
                        this.setSettingRetBtn(false);
                        if (this.Main_mode == 0)
                        {
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 10;
                        }
                        else
                        {
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 30;
                        }
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
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.releaseSettingBtn();
            this.closeSettingMenu();
            this.releaseResetBtn();
            this.releaseOtherBtn();
            this.releaseNextBtn();
            this.releaseStartBtn();
            this.releaseStopBtn();
            stage.removeChild(this.deb_mc);
            return;
        }// end function

        public function clearMainItem() : void
        {
            return;
        }// end function

        public function initMainItem() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = "";
            this.Ins_Item_Setting.visible = false;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Main_mode = this._START_MODE;
            this.quest_list_no = 1;
            if (this.Main_mode == 0)
            {
                this.mode_ofs_x = 0;
                this.mode_ofs_y = 0;
                this.Ins_Item_Control.Ins_HitCover.visible = false;
                this.Ins_Item_Control.Ins_ExpAnime.visible = false;
            }
            else
            {
                this.mode_ofs_x = this._BALANCE_POSX2 - this._BALANCE_POSX1;
                this.mode_ofs_y = this._BALANCE_POSY2 - this._BALANCE_POSY1;
                this.Ins_Item_Control.Ins_HitCover.visible = true;
                this.Ins_Item_Control.Ins_ExpAnime.visible = true;
                this.Ins_Item_Control.Ins_ExpAnime.gotoAndStop(this.quest_list[1].func_no[this.quest_list_no]);
            }
            this.dispModeBtn(this.Main_mode);
            this.dispDragArea("Ins_DragArea", this._DRAGAREA_POSX1, this._DRAGAREA_POSY1, true);
            this.dispDragArea("Ins_Plate1_DragArea", this._PLATE1_DRAGAREA_POSX1, this._PLATE1_DRAGAREA_POSY1, true);
            this.dispDragArea("Ins_Plate2_DragArea", this._PLATE2_DRAGAREA_POSX1, this._PLATE2_DRAGAREA_POSY1, true);
            this.initSettingMenu();
            this.initQuestList();
            this.initDropBox(this.quest_list_no, this.quest_text);
            _loc_1 = 0;
            while (_loc_1 < 10)
            {
                
                _loc_2 = "Ins_Weight1_" + (_loc_1 + 1);
                this.initWeight1((_loc_1 + 1), _loc_2);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 30)
            {
                
                _loc_2 = "Ins_Weight2_" + (_loc_1 + 1);
                this.initWeight2((_loc_1 + 1), _loc_2);
                _loc_1++;
            }
            return;
        }// end function

        public function resetMainItem() : void
        {
            return;
        }// end function

        public function initGame() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = "";
            this.Ins_Item_Setting.visible = false;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.mode_ofs_x = 0;
            this.mode_ofs_y = 0;
            this.Ins_Item_Control.Ins_HitCover.visible = false;
            this.Ins_Item_Control.Ins_ExpAnime.visible = false;
            this.dispModeBtn(this.Main_mode);
            this.dispDragArea("Ins_DragArea", this._DRAGAREA_POSX1, this._DRAGAREA_POSY1, true);
            this.dispDragArea("Ins_Plate1_DragArea", this._PLATE1_DRAGAREA_POSX1, this._PLATE1_DRAGAREA_POSY1, true);
            this.dispDragArea("Ins_Plate2_DragArea", this._PLATE2_DRAGAREA_POSX1, this._PLATE2_DRAGAREA_POSY1, true);
            this.Ins_Item_Control.Ins_DropBox.visible = true;
            this.initQuestList();
            this.changeDropBox(this.quest_list_no, this.quest_text);
            this.pause_flag = false;
            this.weight_touch_flag = false;
            this.weight_refresh_flag = false;
            this.game_index = 0;
            this.weight_num = 0;
            this.weight1_counter = 0;
            this.weight2_counter = 0;
            this.balance_id = 0;
            this.dispBalance("base", this._BALANCE_POSX1, this._BALANCE_POSY1);
            _loc_2 = this.quest_list[1].func_no[this.quest_list_no];
            _loc_1 = 0;
            while (_loc_1 < 10)
            {
                
                _loc_3 = "Ins_Weight1_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 30)
            {
                
                _loc_3 = "Ins_Weight2_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            this.dispDishOnWeightL(this.quest_status[_loc_2].l_weight[0], this.quest_status[_loc_2].l_weight[1], this.quest_status[_loc_2].num, 1);
            this.dispDishOnWeightR(this.quest_status[_loc_2].r_weight[0], this.quest_status[_loc_2].r_weight[1], this.quest_status[_loc_2].num, 1);
            this.area_weight_num[0] = 0;
            this.area_weight_num[1] = this.quest_status[_loc_2].l_weight[0] + this.quest_status[_loc_2].l_weight[1];
            this.area_weight_num[2] = this.quest_status[_loc_2].r_weight[0] + this.quest_status[_loc_2].r_weight[1];
            return;
        }// end function

        public function controlGame() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            switch(this.game_index)
            {
                case 0:
                {
                    this.weight_touch_flag = true;
                    this.game_timer = 0;
                    this.game_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.weight_refresh_flag == true)
                    {
                        this.standPlate1Weight(this.weight_num);
                        this.standPlate2Weight(this.weight_num);
                        this.game_timer = 0;
                        this.game_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.game_timer + 1;
                    _loc_3.game_timer = _loc_4;
                    if (this.game_timer > 5)
                    {
                        _loc_2 = this.balancePlateWeight(this.weight_num);
                        switch(this.balance_id)
                        {
                            case 0:
                            {
                                if (_loc_2 == 1)
                                {
                                    this.dispBalance("left_down", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                else if (_loc_2 == 2)
                                {
                                    this.dispBalance("right_down", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                break;
                            }
                            case 1:
                            {
                                if (_loc_2 == 0)
                                {
                                    this.dispBalance("left_base", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                else if (_loc_2 == 2)
                                {
                                    this.dispBalance("left_right", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                break;
                            }
                            case 2:
                            {
                                if (_loc_2 == 0)
                                {
                                    this.dispBalance("right_base", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                else if (_loc_2 == 1)
                                {
                                    this.dispBalance("right_left", this._BALANCE_POSX1, this._BALANCE_POSY1);
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        this.balance_id = _loc_2;
                        this.game_timer = 0;
                        this.game_index = 40;
                    }
                    break;
                }
                case 40:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.game_timer + 1;
                    _loc_3.game_timer = _loc_4;
                    if (this.game_timer < 5)
                    {
                        this.movePlateWeight(this.weight_num);
                    }
                    else
                    {
                        this.weight_refresh_flag = false;
                        this.weight_touch_flag = true;
                        this.game_timer = 0;
                        this.game_index = 10;
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
            return _loc_1;
        }// end function

        public function initGameAnime() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = "";
            this.Ins_Item_Setting.visible = false;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.mode_ofs_x = this._BALANCE_POSX2 - this._BALANCE_POSX1;
            this.mode_ofs_y = this._BALANCE_POSY2 - this._BALANCE_POSY1;
            this.Ins_Item_Control.Ins_HitCover.visible = true;
            this.Ins_Item_Control.Ins_ExpAnime.visible = true;
            this.dispAnimeModeExp(this.quest_list[1].func_no[this.quest_list_no], "step1");
            this.dispModeBtn(this.Main_mode);
            this.dispDragArea("Ins_DragArea", this._DRAGAREA_POSX2, this._DRAGAREA_POSY2, true);
            this.dispDragArea("Ins_Plate1_DragArea", this._PLATE1_DRAGAREA_POSX2, this._PLATE1_DRAGAREA_POSY2, true);
            this.dispDragArea("Ins_Plate2_DragArea", this._PLATE2_DRAGAREA_POSX2, this._PLATE2_DRAGAREA_POSY2, true);
            this.Ins_Item_Control.Ins_DropBox.visible = false;
            this.initQuestList();
            this.changeDropBox(this.quest_list_no, this.quest_text);
            this.pause_flag = false;
            this.weight_touch_flag = false;
            this.weight_refresh_flag = false;
            this.weight_num = 0;
            this.weight1_counter = 0;
            this.weight2_counter = 0;
            this.balance_id = 0;
            this.dispBalance("base", this._BALANCE_POSX2, this._BALANCE_POSY2);
            _loc_2 = this.quest_list[1].func_no[this.quest_list_no];
            _loc_1 = 0;
            while (_loc_1 < 10)
            {
                
                _loc_3 = "Ins_Weight1_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 30)
            {
                
                _loc_3 = "Ins_Weight2_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            this.dispDishOnWeightL(this.quest_status[_loc_2].l_weight[0], this.quest_status[_loc_2].l_weight[1], this.quest_status[_loc_2].num, 1);
            this.dispDishOnWeightR(this.quest_status[_loc_2].r_weight[0], this.quest_status[_loc_2].r_weight[1], this.quest_status[_loc_2].num, 1);
            this.area_weight_num[0] = 0;
            this.area_weight_num[1] = this.quest_status[_loc_2].l_weight[0] + this.quest_status[_loc_2].l_weight[1];
            this.area_weight_num[2] = this.quest_status[_loc_2].r_weight[0] + this.quest_status[_loc_2].r_weight[1];
            this.Ins_Item_Control.Ins_Next_Btn.visible = false;
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.setNextBtn(false);
            this.setStartBtn(false);
            this.setStopBtn(false);
            this.game_index = 1;
            return;
        }// end function

        public function controlGameAnime() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = this.quest_list[1].func_no[this.quest_list_no];
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = "";
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (this.pause_flag == true)
            {
                if (this.getStartBtn() == true)
                {
                    this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                    this.setNextBtn(false);
                    this.setStartBtn(false);
                    this.setStopBtn(false);
                    this.pause_flag = false;
                }
                return _loc_1;
            }
            else if (this.getStopBtn() == true)
            {
                this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                this.setNextBtn(false);
                this.setStartBtn(false);
                this.setStopBtn(false);
                this.pause_flag = true;
                return _loc_1;
            }
            switch(this.game_index)
            {
                case 0:
                {
                    if (this.getNextBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                        this.setNextBtn(false);
                        this.setStartBtn(false);
                        this.setStopBtn(false);
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 1;
                    }
                    break;
                }
                case 1:
                {
                    if (this.getStartBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                        this.setNextBtn(false);
                        this.setStartBtn(false);
                        this.setStopBtn(false);
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 10;
                    }
                    break;
                }
                case 10:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 8)
                    {
                        this.dispAnimeModeExp(_loc_2, this.quest_exp_script[_loc_2].act1[this.game_step]);
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.game_timer = 0;
                        if (this.game_step >= this.quest_exp_script[_loc_2].act1.length)
                        {
                            this.game_step = 0;
                            this.game_timer = 0;
                            this.game_index = 11;
                        }
                    }
                    break;
                }
                case 11:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.quest_exp_script[_loc_2].act2.length)
                    {
                        
                        _loc_8 = "Ins_Weight2_" + this.quest_exp_script[_loc_2].act2[_loc_3];
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.changeWeightPriority(_loc_8, this.game_step);
                        _loc_3++;
                    }
                    _loc_3 = 0;
                    while (_loc_3 < this.quest_exp_script[_loc_2].act3.length)
                    {
                        
                        _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act3[_loc_3] + this.quest_status[_loc_2].l_weight[1]);
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.changeWeightPriority(_loc_8, this.game_step);
                        _loc_3++;
                    }
                    this.game_step = 0;
                    this.game_timer = 0;
                    this.game_index = 12;
                    break;
                }
                case 12:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer <= 30)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act2.length)
                        {
                            
                            _loc_8 = "Ins_Weight2_" + this.quest_exp_script[_loc_2].act2[_loc_3];
                            _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._EXP_MOVE_POSX1 / 30;
                            _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y) + this._EXP_MOVE_POSY1 / 30;
                            this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                            _loc_3++;
                        }
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act3.length)
                        {
                            
                            _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act3[_loc_3] + this.quest_status[_loc_2].l_weight[1]);
                            _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._EXP_MOVE_POSX2 / 30;
                            _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y) + this._EXP_MOVE_POSY2 / 30;
                            this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                            _loc_3++;
                        }
                    }
                    else
                    {
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act2.length)
                        {
                            
                            _loc_8 = "Ins_Weight2_" + this.quest_exp_script[_loc_2].act2[_loc_3];
                            this.changeWeightStatus(_loc_8, this.weight_num, this._DRAG_AREA_3, this.getPlateWeightNum(this.weight_num, this._DRAG_AREA_3));
                            _loc_3++;
                        }
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act3.length)
                        {
                            
                            _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act3[_loc_3] + this.quest_status[_loc_2].l_weight[1]);
                            this.changeWeightStatus(_loc_8, this.weight_num, this._DRAG_AREA_3, this.getPlateWeightNum(this.weight_num, this._DRAG_AREA_3));
                            _loc_3++;
                        }
                        this.standPlate1Weight(this.weight_num);
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 13;
                    }
                    break;
                }
                case 13:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 8)
                    {
                        this.dispAnimeModeExp(_loc_2, this.quest_exp_script[_loc_2].act4[this.game_step]);
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.game_timer = 0;
                        if (this.game_step >= this.quest_exp_script[_loc_2].act4.length)
                        {
                            this.game_step = 0;
                            this.game_timer = 0;
                            this.game_index = 14;
                        }
                    }
                    break;
                }
                case 14:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 30)
                    {
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 20;
                    }
                    break;
                }
                case 20:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 8)
                    {
                        if (this.quest_exp_script[_loc_2].act5[this.game_step] == "end")
                        {
                            this.game_step = 0;
                            this.game_timer = 0;
                            this.game_index = 30;
                        }
                        else
                        {
                            this.dispAnimeModeExp(_loc_2, this.quest_exp_script[_loc_2].act5[this.game_step]);
                            var _loc_11:* = this;
                            var _loc_12:* = this.game_step + 1;
                            _loc_11.game_step = _loc_12;
                            this.game_timer = 0;
                            if (this.game_step >= this.quest_exp_script[_loc_2].act5.length)
                            {
                                this.game_step = 0;
                                this.game_timer = 0;
                                this.game_index = 21;
                            }
                        }
                    }
                    break;
                }
                case 21:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer <= 15)
                    {
                        _loc_5 = this.quest_exp_script[_loc_2].x[0] - 1;
                        _loc_6 = this.quest_exp_script[_loc_2].div[0];
                        _loc_3 = 0;
                        while (_loc_3 < _loc_5)
                        {
                            
                            _loc_7 = _loc_6 * _loc_3;
                            _loc_4 = 0;
                            while (_loc_4 < _loc_6)
                            {
                                
                                _loc_8 = "Ins_Weight1_" + this.quest_exp_script[_loc_2].act6[_loc_7 + _loc_4];
                                _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._WT_SIZE / _loc_5 / 15 * (_loc_5 - _loc_3);
                                _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y);
                                this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                                _loc_4++;
                            }
                            _loc_3++;
                        }
                        _loc_5 = this.quest_exp_script[_loc_2].x[0] - 1;
                        _loc_6 = this.quest_exp_script[_loc_2].div[1];
                        _loc_3 = 0;
                        while (_loc_3 < _loc_5)
                        {
                            
                            _loc_7 = _loc_6 * _loc_3;
                            _loc_4 = 0;
                            while (_loc_4 < _loc_6)
                            {
                                
                                _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act7[_loc_7 + _loc_4] + this.quest_status[_loc_2].l_weight[1]);
                                _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._WT_SIZE / _loc_5 / 15 * (_loc_3 + 1);
                                _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y);
                                this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                                _loc_4++;
                            }
                            _loc_3++;
                        }
                    }
                    else
                    {
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 22;
                    }
                    break;
                }
                case 22:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 30)
                    {
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 23;
                    }
                    break;
                }
                case 23:
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.quest_exp_script[_loc_2].act6.length)
                    {
                        
                        _loc_8 = "Ins_Weight1_" + this.quest_exp_script[_loc_2].act6[_loc_3];
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.changeWeightPriority(_loc_8, this.game_step);
                        _loc_3++;
                    }
                    _loc_3 = 0;
                    while (_loc_3 < this.quest_exp_script[_loc_2].act7.length)
                    {
                        
                        _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act7[_loc_3] + this.quest_status[_loc_2].l_weight[1]);
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.changeWeightPriority(_loc_8, this.game_step);
                        _loc_3++;
                    }
                    this.game_step = 0;
                    this.game_timer = 0;
                    this.game_index = 24;
                    break;
                }
                case 24:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer <= 30)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act6.length)
                        {
                            
                            _loc_8 = "Ins_Weight1_" + this.quest_exp_script[_loc_2].act6[_loc_3];
                            _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._EXP_MOVE_POSX3 / 30;
                            _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y) + this._EXP_MOVE_POSY3 / 30;
                            this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                            _loc_3++;
                        }
                        _loc_5 = this.quest_exp_script[_loc_2].x[0] - 1;
                        _loc_6 = this.quest_exp_script[_loc_2].div[1];
                        _loc_3 = 0;
                        while (_loc_3 < _loc_5)
                        {
                            
                            _loc_7 = _loc_6 * _loc_3;
                            _loc_4 = 0;
                            while (_loc_4 < _loc_6)
                            {
                                
                                _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act7[_loc_7 + _loc_4] + this.quest_status[_loc_2].l_weight[1]);
                                _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this._EXP_MOVE_POSX4 / 30;
                                if (_loc_5 == 4)
                                {
                                    _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y) + this._EXP_MOVE_POSY4 / 30;
                                }
                                else
                                {
                                    _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y) + this._EXP_MOVE_POSY4 / 30 + this._WT_SIZE / _loc_5 / 60 * _loc_3;
                                }
                                this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                                _loc_4++;
                            }
                            _loc_3++;
                        }
                    }
                    else
                    {
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 25;
                    }
                    break;
                }
                case 25:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 8)
                    {
                        this.dispAnimeModeExp(_loc_2, this.quest_exp_script[_loc_2].act8[this.game_step]);
                        var _loc_11:* = this;
                        var _loc_12:* = this.game_step + 1;
                        _loc_11.game_step = _loc_12;
                        this.game_timer = 0;
                        if (this.game_step >= this.quest_exp_script[_loc_2].act8.length)
                        {
                            this.game_step = 0;
                            this.game_timer = 0;
                            this.game_index = 26;
                        }
                    }
                    break;
                }
                case 26:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer > 30)
                    {
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.game_timer + 1;
                    _loc_11.game_timer = _loc_12;
                    if (this.game_timer <= 30)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act9.length)
                        {
                            
                            _loc_8 = "Ins_Weight1_" + this.quest_exp_script[_loc_2].act9[_loc_3];
                            _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this.quest_exp_script[_loc_2].act10[0] / 30;
                            _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y);
                            this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                            _loc_3++;
                        }
                        _loc_3 = 0;
                        while (_loc_3 < this.quest_exp_script[_loc_2].act11.length)
                        {
                            
                            _loc_8 = "Ins_Weight2_" + (this.quest_exp_script[_loc_2].act11[_loc_3] + this.quest_status[_loc_2].l_weight[1]);
                            _loc_9 = this.getWeightPosX(_loc_8, this.mode_ofs_x) + this.quest_exp_script[_loc_2].act12[0] / 30;
                            _loc_10 = this.getWeightPosY(_loc_8, this.mode_ofs_y);
                            this.dispWeight(_loc_8, _loc_9, _loc_10, true);
                            _loc_3++;
                        }
                    }
                    else
                    {
                        this.Ins_Item_Control.Ins_Next_Btn.visible = true;
                        this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                        this.setNextBtn(false);
                        this.setStartBtn(false);
                        this.setStopBtn(false);
                        this.game_step = 0;
                        this.game_timer = 0;
                        this.game_index = 99;
                    }
                    break;
                }
                case 99:
                {
                    _loc_1 = 99;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function dispAnimeModeExp(param1:uint, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.Ins_Item_Control.Ins_ExpAnime.gotoAndStop(param1);
            _loc_3 = this.Ins_Item_Control.Ins_ExpAnime.getChildByName(this.quest_exp_script[param1].ins);
            _loc_4 = _loc_3 as MovieClip;
            _loc_4.gotoAndStop(param2);
            return;
        }// end function

        public function initQuestList() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.quest_text.length)
            {
                
                this.quest_text[_loc_1] = this.quest_status[this.quest_list[1].func_no[_loc_1]].text;
                _loc_1++;
            }
            return;
        }// end function

        public function changeQuestListNo(param1:int) : int
        {
            var _loc_2:* = 0;
            _loc_2 = Math.random() * this._DROP_BOX_LIST_MAX + 1;
            if (_loc_2 == param1)
            {
                _loc_2++;
                if (_loc_2 > this._DROP_BOX_LIST_MAX)
                {
                    _loc_2 = 1;
                }
            }
            return _loc_2;
        }// end function

        public function dispDishOnWeightL(param1:uint, param2:uint, param3:uint, param4:uint) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = "";
            if (param2 + param1 > 5)
            {
                _loc_5 = 0;
                while (_loc_5 < param2)
                {
                    
                    _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                    this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                    this.weight_status[this.weight_num].type = 2;
                    this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                    this.weight_status[this.weight_num].ins = _loc_9;
                    this.weight_status[this.weight_num].num = param4;
                    this.weight_status[this.weight_num].cnt = _loc_6;
                    var _loc_10:* = this;
                    var _loc_11:* = this.weight_num + 1;
                    _loc_10.weight_num = _loc_11;
                    var _loc_10:* = this;
                    var _loc_11:* = this.weight2_counter + 1;
                    _loc_10.weight2_counter = _loc_11;
                    _loc_6++;
                    _loc_5++;
                }
                _loc_7 = 5 - param2 % 5;
                if (_loc_7 < param1)
                {
                    _loc_8 = param1 - _loc_7;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_7)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_7 = 4 - param1 % 6;
                    _loc_6 = _loc_6 + _loc_8 + _loc_7;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_8)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6 = _loc_6 - 1;
                        _loc_5++;
                    }
                }
                else
                {
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
            }
            else
            {
                if (param1 + param2 == 2)
                {
                    _loc_6 = 2;
                }
                else if (param1 + param2 == 3)
                {
                    _loc_6 = 1;
                }
                else if (param1 + param2 == 4)
                {
                    _loc_6 = 1;
                }
                else
                {
                    _loc_6 = 0;
                }
                if (param1 > param2)
                {
                    _loc_5 = 0;
                    while (_loc_5 < param2)
                    {
                        
                        _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 2;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param4;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight2_counter + 1;
                        _loc_10.weight2_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
                else
                {
                    _loc_5 = 0;
                    while (_loc_5 < param2)
                    {
                        
                        _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 2;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param4;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight2_counter + 1;
                        _loc_10.weight2_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos1_tbl[_loc_6].dx, this.weight_pos1_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
            }
            return;
        }// end function

        public function dispDishOnWeightR(param1:uint, param2:uint, param3:uint, param4:uint) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = "";
            if (param2 + param1 > 5)
            {
                _loc_5 = 0;
                while (_loc_5 < param2)
                {
                    
                    _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                    this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                    this.weight_status[this.weight_num].type = 2;
                    this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                    this.weight_status[this.weight_num].ins = _loc_9;
                    this.weight_status[this.weight_num].num = param4;
                    this.weight_status[this.weight_num].cnt = _loc_6;
                    var _loc_10:* = this;
                    var _loc_11:* = this.weight_num + 1;
                    _loc_10.weight_num = _loc_11;
                    var _loc_10:* = this;
                    var _loc_11:* = this.weight2_counter + 1;
                    _loc_10.weight2_counter = _loc_11;
                    _loc_6++;
                    _loc_5++;
                }
                _loc_7 = 5 - param2 % 5;
                if (_loc_7 < param1)
                {
                    _loc_8 = param1 - _loc_7;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_7)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_7 = 4 - param1 % 6;
                    _loc_6 = _loc_6 + _loc_8 + _loc_7;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_8)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6 = _loc_6 - 1;
                        _loc_5++;
                    }
                }
                else
                {
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
            }
            else
            {
                if (param1 + param2 == 2)
                {
                    _loc_6 = 2;
                }
                else if (param1 + param2 == 3)
                {
                    _loc_6 = 1;
                }
                else if (param1 + param2 == 4)
                {
                    _loc_6 = 1;
                }
                else
                {
                    _loc_6 = 0;
                }
                if (param1 > param2)
                {
                    _loc_5 = 0;
                    while (_loc_5 < param2)
                    {
                        
                        _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 2;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param4;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight2_counter + 1;
                        _loc_10.weight2_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
                else
                {
                    _loc_5 = 0;
                    while (_loc_5 < param2)
                    {
                        
                        _loc_9 = "Ins_Weight2_" + (this.weight2_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 2;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param4;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight2_counter + 1;
                        _loc_10.weight2_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                    _loc_5 = 0;
                    while (_loc_5 < param1)
                    {
                        
                        _loc_9 = "Ins_Weight1_" + (this.weight1_counter + 1);
                        this.dispWeight(_loc_9, this.weight_pos2_tbl[_loc_6].dx, this.weight_pos2_tbl[_loc_6].dy, true);
                        this.weight_status[this.weight_num].type = 1;
                        this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                        this.weight_status[this.weight_num].ins = _loc_9;
                        this.weight_status[this.weight_num].num = param3;
                        this.weight_status[this.weight_num].cnt = _loc_6;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight_num + 1;
                        _loc_10.weight_num = _loc_11;
                        var _loc_10:* = this;
                        var _loc_11:* = this.weight1_counter + 1;
                        _loc_10.weight1_counter = _loc_11;
                        _loc_6++;
                        _loc_5++;
                    }
                }
            }
            return;
        }// end function

        public function initWeight1(param1:int, param2:String) : void
        {
            var wk_rock_flag:Boolean;
            var wk_weight:Weight1;
            var wk_swap:DisplayObject;
            var wk_last_no:int;
            var wk_area_id:uint;
            var wk_base_x:int;
            var wk_base_y:int;
            var wk_old_x:int;
            var wk_old_y:int;
            var wk_now_x:int;
            var wk_now_y:int;
            var downWeight:Function;
            var outWeight:Function;
            var moveWeight:Function;
            var wt_no:* = param1;
            var ins:* = param2;
            downWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                wk_last_no = Ins_Item_Control.Ins_WeightMc.numChildren - 1;
                wk_swap = Ins_Item_Control.Ins_WeightMc.getChildAt(wk_last_no);
                Ins_Item_Control.Ins_WeightMc.swapChildren(wk_weight, wk_swap);
                wk_weight.Ins_Hit.scaleX = 2;
                wk_weight.Ins_Hit.scaleY = wk_weight.Ins_Hit.scaleX;
                if (checkDragArea(wk_weight) == true)
                {
                    wk_area_id = 1;
                }
                else if (checkPlate1DragArea(wk_weight) == true)
                {
                    wk_area_id = 2;
                }
                else if (checkPlate2DragArea(wk_weight) == true)
                {
                    wk_area_id = 3;
                }
                else
                {
                    wk_area_id = 0;
                }
                wk_base_x = wk_weight.x;
                wk_base_y = wk_weight.y;
                wk_now_x = stage.mouseX;
                wk_now_y = stage.mouseY;
                wk_rock_flag = true;
                return;
            }// end function
            ;
            outWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                if (wk_rock_flag == false)
                {
                    return;
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                wk_weight.Ins_Hit.scaleX = 1;
                wk_weight.Ins_Hit.scaleY = wk_weight.Ins_Hit.scaleX;
                wk_rock_flag = false;
                return;
            }// end function
            ;
            moveWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                if (wk_rock_flag == true)
                {
                    wk_old_x = wk_now_x;
                    wk_old_y = wk_now_y;
                    wk_now_x = stage.mouseX;
                    wk_now_y = stage.mouseY;
                    wk_weight.x = wk_weight.x + (wk_now_x - wk_old_x);
                    wk_weight.y = wk_weight.y + (wk_now_y - wk_old_y);
                }
                return;
            }// end function
            ;
            wk_rock_flag;
            var wk_ins:* = ins;
            wk_weight = new Weight1();
            wk_last_no;
            wk_area_id;
            wk_base_x;
            wk_base_y;
            wk_old_x;
            wk_old_y;
            wk_now_x;
            wk_now_y;
            wk_weight.visible = false;
            wk_weight.x = 0;
            wk_weight.y = 0;
            wk_weight.scaleX = this._PLATE_SCALE;
            wk_weight.scaleY = wk_weight.scaleX;
            wk_weight.name = wk_ins;
            this.Ins_Item_Control.Ins_WeightMc.addChild(wk_weight);
            wk_weight.addEventListener(MouseEvent.MOUSE_DOWN, downWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_OUT, outWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_UP, outWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_MOVE, moveWeight);
            wk_weight.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Control.Ins_WeightMc.removeChild(wk_weight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_DOWN, downWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_OUT, outWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_UP, outWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_MOVE, moveWeight);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function initWeight2(param1:int, param2:String) : void
        {
            var wk_rock_flag:Boolean;
            var wk_weight:Weight2;
            var wk_swap:DisplayObject;
            var wk_last_no:int;
            var wk_area_id:uint;
            var wk_base_x:int;
            var wk_base_y:int;
            var wk_old_x:int;
            var wk_old_y:int;
            var wk_now_x:int;
            var wk_now_y:int;
            var downWeight:Function;
            var outWeight:Function;
            var moveWeight:Function;
            var wt_no:* = param1;
            var ins:* = param2;
            downWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                wk_last_no = Ins_Item_Control.Ins_WeightMc.numChildren - 1;
                wk_swap = Ins_Item_Control.Ins_WeightMc.getChildAt(wk_last_no);
                Ins_Item_Control.Ins_WeightMc.swapChildren(wk_weight, wk_swap);
                wk_weight.Ins_Hit.scaleX = 2;
                wk_weight.Ins_Hit.scaleY = wk_weight.Ins_Hit.scaleX;
                if (checkDragArea(wk_weight) == true)
                {
                    wk_area_id = 1;
                }
                else if (checkPlate1DragArea(wk_weight) == true)
                {
                    wk_area_id = 2;
                }
                else if (checkPlate2DragArea(wk_weight) == true)
                {
                    wk_area_id = 3;
                }
                else
                {
                    wk_area_id = 0;
                }
                wk_base_x = wk_weight.x;
                wk_base_y = wk_weight.y;
                wk_now_x = stage.mouseX;
                wk_now_y = stage.mouseY;
                wk_rock_flag = true;
                return;
            }// end function
            ;
            outWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                if (wk_rock_flag == false)
                {
                    return;
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                switch(wk_area_id)
                {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                wk_weight.Ins_Hit.scaleX = 1;
                wk_weight.Ins_Hit.scaleY = wk_weight.Ins_Hit.scaleX;
                wk_rock_flag = false;
                return;
            }// end function
            ;
            moveWeight = function (event:MouseEvent) : void
            {
                if (weight_touch_flag == false)
                {
                    return;
                }
                if (wk_rock_flag == true)
                {
                    wk_old_x = wk_now_x;
                    wk_old_y = wk_now_y;
                    wk_now_x = stage.mouseX;
                    wk_now_y = stage.mouseY;
                    wk_weight.x = wk_weight.x + (wk_now_x - wk_old_x);
                    wk_weight.y = wk_weight.y + (wk_now_y - wk_old_y);
                }
                return;
            }// end function
            ;
            wk_rock_flag;
            var wk_ins:* = ins;
            wk_weight = new Weight2();
            wk_last_no;
            wk_area_id;
            wk_base_x;
            wk_base_y;
            wk_old_x;
            wk_old_y;
            wk_now_x;
            wk_now_y;
            wk_weight.visible = false;
            wk_weight.x = 0;
            wk_weight.y = 0;
            wk_weight.scaleX = this._PLATE_SCALE;
            wk_weight.scaleY = wk_weight.scaleX;
            wk_weight.name = wk_ins;
            this.Ins_Item_Control.Ins_WeightMc.addChild(wk_weight);
            wk_weight.addEventListener(MouseEvent.MOUSE_DOWN, downWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_OUT, outWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_UP, outWeight);
            wk_weight.addEventListener(MouseEvent.MOUSE_MOVE, moveWeight);
            wk_weight.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Control.Ins_WeightMc.removeChild(wk_weight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_DOWN, downWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_OUT, outWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_UP, outWeight);
                wk_weight.removeEventListener(MouseEvent.MOUSE_MOVE, moveWeight);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function dispWeight(param1:String, param2:Number, param3:Number, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = this.Ins_Item_Control.Ins_WeightMc.getChildByName(param1);
            _loc_6 = _loc_5 as MovieClip;
            _loc_5.visible = param4;
            _loc_5.x = param2 + this.mode_ofs_x;
            _loc_5.y = param3 + this.mode_ofs_y;
            return;
        }// end function

        public function changeWeightPriority(param1:String, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            _loc_3 = this.Ins_Item_Control.Ins_WeightMc.getChildByName(param1);
            _loc_4 = _loc_3 as MovieClip;
            _loc_6 = this.Ins_Item_Control.Ins_WeightMc.numChildren - param2;
            _loc_5 = this.Ins_Item_Control.Ins_WeightMc.getChildAt(_loc_6);
            this.Ins_Item_Control.Ins_WeightMc.swapChildren(_loc_3, _loc_5);
            return;
        }// end function

        public function changeWeightStatus(param1:String, param2:int, param3:uint, param4:int) : void
        {
            var _loc_5:* = 0;
            _loc_5 = 0;
            while (_loc_5 < param2)
            {
                
                if (this.weight_status[_loc_5].ins == param1)
                {
                    this.weight_status[_loc_5].area = param3;
                    this.weight_status[_loc_5].cnt = param4;
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        public function getPlateWeightNum(param1:int, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = new Array(param1);
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                _loc_5[_loc_3] = 0;
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                if (this.weight_status[_loc_3].area == param2)
                {
                    _loc_5[this.weight_status[_loc_3].cnt] = 1;
                    _loc_4++;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                if (_loc_5[_loc_3] == 0)
                {
                    if (_loc_3 < _loc_4)
                    {
                        _loc_4 = _loc_3;
                        break;
                    }
                }
                _loc_3++;
            }
            return _loc_4;
        }// end function

        public function standPlateWeight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_6:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            var _loc_7:* = new Array(param1);
            var _loc_8:* = new Array(param1);
            var _loc_9:* = 0;
            var _loc_10:* = new Array(param1);
            var _loc_11:* = new Array(param1);
            var _loc_12:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                _loc_7[_loc_2] = 0;
                _loc_8[_loc_2] = 0;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                if (this.weight_status[_loc_2].area == this._DRAG_AREA_1)
                {
                    _loc_7[this.weight_status[_loc_2].cnt] = 1;
                    _loc_8[this.weight_status[_loc_2].cnt] = _loc_2;
                    if (this.weight_status[_loc_2].cnt > _loc_9)
                    {
                        _loc_9 = this.weight_status[_loc_2].cnt;
                    }
                    _loc_3++;
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                _loc_10[_loc_2] = 0;
                _loc_11[_loc_2] = 0;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                if (this.weight_status[_loc_2].area == this._DRAG_AREA_2)
                {
                    _loc_10[this.weight_status[_loc_2].cnt] = 1;
                    _loc_11[this.weight_status[_loc_2].cnt] = _loc_2;
                    if (this.weight_status[_loc_2].cnt > _loc_12)
                    {
                        _loc_12 = this.weight_status[_loc_2].cnt;
                    }
                    _loc_4++;
                }
                _loc_2++;
            }
            if (_loc_3 <= _loc_9)
            {
                _loc_2 = 0;
                while (_loc_2 <= _loc_9)
                {
                    
                    if (_loc_7[_loc_2] == 0)
                    {
                        if (_loc_2 + 5 <= _loc_9 && _loc_7[_loc_2 + 5] == 1)
                        {
                            this.weight_status[_loc_8[_loc_2 + 5]].cnt = _loc_2;
                            _loc_7[_loc_2 + 5] = 0;
                            _loc_8[_loc_2 + 5] = 0;
                        }
                    }
                    _loc_2++;
                }
            }
            if (_loc_4 <= _loc_12)
            {
                _loc_2 = 0;
                while (_loc_2 <= _loc_12)
                {
                    
                    if (_loc_10[_loc_2] == 0)
                    {
                        if (_loc_2 + 5 <= _loc_12 && _loc_10[_loc_2 + 5] == 1)
                        {
                            this.weight_status[_loc_11[_loc_2 + 5]].cnt = _loc_2;
                            _loc_10[_loc_2 + 5] = 0;
                            _loc_11[_loc_2 + 5] = 0;
                        }
                    }
                    _loc_2++;
                }
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dy + _loc_5, true);
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dy + _loc_6, true);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function standPlate1Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            var _loc_6:* = new Array(param1);
            var _loc_7:* = new Array(param1);
            var _loc_8:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                _loc_6[_loc_2] = 0;
                _loc_7[_loc_2] = 0;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                if (this.weight_status[_loc_2].area == this._DRAG_AREA_1)
                {
                    _loc_6[this.weight_status[_loc_2].cnt] = 1;
                    _loc_7[this.weight_status[_loc_2].cnt] = _loc_2;
                    if (this.weight_status[_loc_2].cnt > _loc_8)
                    {
                        _loc_8 = this.weight_status[_loc_2].cnt;
                    }
                    _loc_3++;
                }
                _loc_2++;
            }
            if (_loc_3 <= _loc_8)
            {
                _loc_2 = 0;
                while (_loc_2 <= _loc_8)
                {
                    
                    if (_loc_6[_loc_2] == 0)
                    {
                        if (_loc_2 + 5 <= _loc_8 && _loc_6[_loc_2 + 5] == 1)
                        {
                            this.weight_status[_loc_7[_loc_2 + 5]].cnt = _loc_2;
                            _loc_6[_loc_2 + 5] = 0;
                            _loc_7[_loc_2 + 5] = 0;
                        }
                    }
                    _loc_2++;
                }
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dy + _loc_4, true);
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dy + _loc_5, true);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function standPlate2Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            var _loc_6:* = new Array(param1);
            var _loc_7:* = new Array(param1);
            var _loc_8:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                _loc_6[_loc_2] = 0;
                _loc_7[_loc_2] = 0;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                if (this.weight_status[_loc_2].area == this._DRAG_AREA_2)
                {
                    _loc_6[this.weight_status[_loc_2].cnt] = 1;
                    _loc_7[this.weight_status[_loc_2].cnt] = _loc_2;
                    if (this.weight_status[_loc_2].cnt > _loc_8)
                    {
                        _loc_8 = this.weight_status[_loc_2].cnt;
                    }
                    _loc_3++;
                }
                _loc_2++;
            }
            if (_loc_3 <= _loc_8)
            {
                _loc_2 = 0;
                while (_loc_2 <= _loc_8)
                {
                    
                    if (_loc_6[_loc_2] == 0)
                    {
                        if (_loc_2 + 5 <= _loc_8 && _loc_6[_loc_2 + 5] == 1)
                        {
                            this.weight_status[_loc_7[_loc_2 + 5]].cnt = _loc_2;
                            _loc_6[_loc_2 + 5] = 0;
                            _loc_7[_loc_2 + 5] = 0;
                        }
                    }
                    _loc_2++;
                }
            }
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dy + _loc_4, true);
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dy + _loc_5, true);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function balancePlateWeight(param1:int) : uint
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                switch(this.weight_status[_loc_3].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        _loc_4 = _loc_4 + this.weight_status[_loc_3].num;
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        _loc_5 = _loc_5 + this.weight_status[_loc_3].num;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3++;
            }
            if (_loc_4 == _loc_5)
            {
                _loc_2 = 0;
            }
            else if (_loc_4 > _loc_5)
            {
                _loc_2 = 1;
            }
            else if (_loc_4 < _loc_5)
            {
                _loc_2 = 2;
            }
            return _loc_2;
        }// end function

        public function dispBalance(param1:String, param2:int, param3:int) : void
        {
            this.Ins_Item_Control.Ins_Balance.visible = true;
            this.Ins_Item_Control.Ins_Balance.x = param2;
            this.Ins_Item_Control.Ins_Balance.y = param3;
            switch(param1)
            {
                case "base":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndStop("base");
                    break;
                }
                case "left_down":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("left_down");
                    break;
                }
                case "left_base":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("left_base");
                    break;
                }
                case "left_right":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("left_right");
                    break;
                }
                case "right_down":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("right_down");
                    break;
                }
                case "right_base":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("right_base");
                    break;
                }
                case "right_left":
                {
                    this.Ins_Item_Control.Ins_Balance.gotoAndPlay("right_left");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function movePlateWeight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_6:* = (this.Ins_Item_Control.Ins_Balance.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos1_tbl[this.weight_status[_loc_2].cnt].dy + _loc_5, true);
                        _loc_3++;
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        this.dispWeight(this.weight_status[_loc_2].ins, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dx, this.weight_pos2_tbl[this.weight_status[_loc_2].cnt].dy + _loc_6, true);
                        _loc_4++;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function getWeightPosX(param1:String, param2:int) : Number
        {
            var _loc_3:* = null;
            _loc_3 = this.Ins_Item_Control.Ins_WeightMc.getChildByName(param1);
            return _loc_3.x - param2;
        }// end function

        public function getWeightPosY(param1:String, param2:int) : Number
        {
            var _loc_3:* = null;
            _loc_3 = this.Ins_Item_Control.Ins_WeightMc.getChildByName(param1);
            return _loc_3.y - param2;
        }// end function

        public function dispDragArea(param1:String, param2:int, param3:int, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = this.Ins_Item_Control.getChildByName(param1);
            _loc_6 = _loc_5 as MovieClip;
            _loc_5.visible = param4;
            _loc_5.x = param2;
            _loc_5.y = param3;
            return;
        }// end function

        public function checkDragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function checkPlate1DragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_Plate1_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function checkPlate2DragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_Plate2_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function dispModeBtn(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.Ins_Item_Control.Ins_Other_Btn.visible = true;
                    this.setOtherBtn(false);
                    this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                    this.setNextBtn(false);
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.setStartBtn(false);
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.setStopBtn(false);
                    this.Ins_Item_Control.Ins_Reset_Btn.visible = true;
                    this.setResetBtn(false);
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Control.Ins_Other_Btn.visible = false;
                    this.setOtherBtn(false);
                    this.Ins_Item_Control.Ins_Next_Btn.visible = true;
                    this.setNextBtn(false);
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.setStartBtn(false);
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.setStopBtn(false);
                    this.Ins_Item_Control.Ins_Reset_Btn.visible = true;
                    this.setResetBtn(false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function entryOtherBtn() : void
        {
            this.Ins_Item_Control.Ins_Other_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downOtherBtn);
            return;
        }// end function

        public function releaseOtherBtn() : void
        {
            this.Ins_Item_Control.Ins_Other_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downOtherBtn);
            return;
        }// end function

        public function downOtherBtn(event:MouseEvent) : void
        {
            this.other_btn_flag = true;
            return;
        }// end function

        public function getOtherBtn() : Boolean
        {
            return this.other_btn_flag;
        }// end function

        public function setOtherBtn(param1:Boolean) : void
        {
            this.other_btn_flag = param1;
            return;
        }// end function

        public function entryNextBtn() : void
        {
            this.Ins_Item_Control.Ins_Next_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downNextBtn);
            return;
        }// end function

        public function releaseNextBtn() : void
        {
            this.Ins_Item_Control.Ins_Next_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downNextBtn);
            return;
        }// end function

        public function downNextBtn(event:MouseEvent) : void
        {
            this.next_btn_flag = true;
            return;
        }// end function

        public function getNextBtn() : Boolean
        {
            return this.next_btn_flag;
        }// end function

        public function setNextBtn(param1:Boolean) : void
        {
            this.next_btn_flag = param1;
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
            this.closeDropBoxBtn();
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

        public function entrySettingBtn() : void
        {
            this.Ins_Item_Control.Ins_Setting_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downSettingBtn);
            return;
        }// end function

        public function releaseSettingBtn() : void
        {
            this.Ins_Item_Control.Ins_Setting_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downSettingBtn);
            return;
        }// end function

        public function downSettingBtn(event:MouseEvent) : void
        {
            this.closeDropBoxBtn();
            this.setting_btn_flag = true;
            return;
        }// end function

        public function getSettingBtn() : Boolean
        {
            return this.setting_btn_flag;
        }// end function

        public function setSettingBtn(param1:Boolean) : void
        {
            this.setting_btn_flag = param1;
            return;
        }// end function

        public function initDropBox(param1:int, param2:Array) : void
        {
            var list_no:int;
            var list_dy:int;
            var wk_list:DisplayObject;
            var wk_list_mc:MovieClip;
            var wk_text:DisplayObject;
            var wk_text_tf:TextField;
            var downBox:Function;
            var downBack:Function;
            var downList:Function;
            var moveList:Function;
            var list_base:* = param1;
            var list_box:* = param2;
            downBox = function (event:MouseEvent) : void
            {
                if (drop_box_open == false)
                {
                    Ins_Item_Control.Ins_DropBox.gotoAndStop("on");
                    Ins_Item_Control.Ins_DropBox.Ins_List.visible = true;
                    Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.visible = true;
                    list_dy = _DROP_BOX_LIST_SIZE * drop_box_list - _DROP_BOX_LIST_SIZE / 2;
                    Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.y = list_dy;
                    drop_box_open = true;
                }
                return;
            }// end function
            ;
            downBack = function (event:MouseEvent) : void
            {
                if (drop_box_open == true)
                {
                    Ins_Item_Control.Ins_DropBox.gotoAndStop("off");
                    Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
                    Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.visible = false;
                    drop_box_open = false;
                }
                return;
            }// end function
            ;
            downList = function (event:MouseEvent) : void
            {
                if (drop_box_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox.Ins_List.mouseY - _DROP_BOX_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROP_BOX_LIST_SIZE) + 1;
                if (list_no > _DROP_BOX_LIST_MAX)
                {
                    list_no = _DROP_BOX_LIST_MAX;
                }
                Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = list_box[list_no];
                Ins_Item_Control.Ins_DropBox.gotoAndStop("off");
                Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
                Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.visible = false;
                drop_box_open = false;
                drop_box_list = list_no;
                drop_box_flag = true;
                return;
            }// end function
            ;
            moveList = function (event:MouseEvent) : void
            {
                if (drop_box_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox.Ins_List.mouseY - _DROP_BOX_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROP_BOX_LIST_SIZE) + 1;
                if (list_no > _DROP_BOX_LIST_MAX)
                {
                    list_no = _DROP_BOX_LIST_MAX;
                }
                list_dy = _DROP_BOX_LIST_SIZE * list_no - _DROP_BOX_LIST_SIZE / 2;
                Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.y = list_dy;
                return;
            }// end function
            ;
            var i:int;
            var ins:String;
            list_no;
            list_dy;
            this.drop_box_flag = false;
            this.drop_box_open = false;
            this.drop_box_list = list_base;
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = list_box[this.drop_box_list];
            this.Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
            i;
            while (i < this._DROP_BOX_LIST_MAX)
            {
                
                ins = "Ins_Text" + (i + 1);
                wk_list = this.Ins_Item_Control.Ins_DropBox.Ins_List.getChildByName(ins);
                wk_list_mc = wk_list as MovieClip;
                wk_text = wk_list_mc.getChildByName("Ins_Func");
                wk_text_tf = wk_text as TextField;
                wk_text_tf.text = list_box[(i + 1)];
                i = (i + 1);
            }
            this.Ins_Item_Control.Ins_DropBox.addEventListener(MouseEvent.MOUSE_DOWN, downBox);
            this.Ins_Item_Control.Ins_Back.addEventListener(MouseEvent.MOUSE_DOWN, downBack);
            this.Ins_Item_Control.Ins_DropBox.Ins_List.addEventListener(MouseEvent.MOUSE_UP, downList);
            this.Ins_Item_Control.Ins_DropBox.Ins_List.addEventListener(MouseEvent.MOUSE_MOVE, moveList);
            this.Ins_Item_Control.Ins_DropBox.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Control.Ins_DropBox.removeEventListener(MouseEvent.MOUSE_DOWN, downBox);
                Ins_Item_Control.Ins_Back.removeEventListener(MouseEvent.MOUSE_DOWN, downBack);
                Ins_Item_Control.Ins_DropBox.Ins_List.removeEventListener(MouseEvent.MOUSE_UP, downList);
                Ins_Item_Control.Ins_DropBox.Ins_List.removeEventListener(MouseEvent.MOUSE_MOVE, moveList);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function changeDropBox(param1:int, param2:Array) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = "";
            this.drop_box_flag = false;
            this.drop_box_open = false;
            this.drop_box_list = param1;
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = param2[this.drop_box_list];
            this.Ins_Item_Control.Ins_DropBox.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
            _loc_3 = 0;
            while (_loc_3 < this._DROP_BOX_LIST_MAX)
            {
                
                _loc_4 = "Ins_Text" + (_loc_3 + 1);
                _loc_5 = this.Ins_Item_Control.Ins_DropBox.Ins_List.getChildByName(_loc_4);
                _loc_6 = _loc_5 as MovieClip;
                _loc_7 = _loc_6.getChildByName("Ins_Func");
                _loc_8 = _loc_7 as TextField;
                _loc_8.text = param2[(_loc_3 + 1)];
                _loc_3++;
            }
            return;
        }// end function

        public function closeDropBoxBtn() : void
        {
            this.Ins_Item_Control.Ins_DropBox.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_DropBox.Ins_List.Ins_Select.visible = false;
            this.drop_box_open = false;
            this.drop_box_flag = false;
            return;
        }// end function

        public function getDropBoxListNo() : int
        {
            return this.drop_box_list;
        }// end function

        public function getDropBoxBtn() : Boolean
        {
            return this.drop_box_flag;
        }// end function

        public function setDropBoxBtn(param1:Boolean) : void
        {
            this.drop_box_flag = param1;
            return;
        }// end function

        public function initSettingMenu() : void
        {
            var _loc_1:* = 0;
            this.setting_list_no = 0;
            this.setting_list_rock = false;
            this.entrySettingRetBtn();
            this.entrySettingBack();
            _loc_1 = 1;
            while (_loc_1 < this.quest_status.length)
            {
                
                this.initFuncListBtn(_loc_1, this.quest_status[_loc_1].ins, this.quest_status[_loc_1].text, this.quest_status[_loc_1].dx, this.quest_status[_loc_1].dy);
                _loc_1++;
            }
            _loc_1 = 1;
            while (_loc_1 < this.quest_list[1].func_no.length)
            {
                
                this.initFuncList(_loc_1, "Ins_Select", this.quest_status[this.quest_list[0].func_no[_loc_1]].text);
                _loc_1++;
            }
            this.entryList1_1_Btn();
            this.entryList1_2_Btn();
            return;
        }// end function

        public function closeSettingMenu() : void
        {
            var _loc_1:* = 0;
            this.releaseSettingRetBtn();
            this.releaseSettingBack();
            _loc_1 = 1;
            while (_loc_1 < this.quest_status.length)
            {
                
                this.clearFuncListBtn(_loc_1, this.quest_status[_loc_1].ins);
                _loc_1++;
            }
            this.releaseList1_1_Btn();
            this.releaseList1_2_Btn();
            return;
        }// end function

        public function dispSettingMenu(param1:uint) : void
        {
            var _loc_2:* = 0;
            this.Ins_Item_Setting.visible = true;
            this.Ins_Item_Control.visible = false;
            this.Ins_Item_Explain.visible = false;
            this.setting_list_no = 0;
            this.setting_list_rock = false;
            _loc_2 = 1;
            while (_loc_2 < this.quest_status.length)
            {
                
                this.dispFuncListBtn(_loc_2, this.quest_status[_loc_2].ins);
                _loc_2++;
            }
            _loc_2 = 1;
            while (_loc_2 < this.quest_list[1].func_no.length)
            {
                
                this.dispFuncList(_loc_2, "Ins_Select", this.quest_status[this.quest_list[param1].func_no[_loc_2]].text);
                _loc_2++;
            }
            switch(this.setting_status[param1].list[1])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_1.x - 60;
                    this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_2.x - 110;
                    this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initFuncListBtn(param1:int, param2:String, param3:String, param4:int, param5:int) : void
        {
            var wk_func:FuncList;
            var wk_quest:DisplayObject;
            var wk_quest_mc:MovieClip;
            var wk_quest_tx:TextField;
            var overListBtn:Function;
            var outListBtn:Function;
            var downListBtn:Function;
            var list_no:* = param1;
            var ins:* = param2;
            var func_txt:* = param3;
            var dx:* = param4;
            var dy:* = param5;
            overListBtn = function (event:MouseEvent) : void
            {
                wk_func.gotoAndStop("over");
                return;
            }// end function
            ;
            outListBtn = function (event:MouseEvent) : void
            {
                wk_func.gotoAndStop("off");
                return;
            }// end function
            ;
            downListBtn = function (event:MouseEvent) : void
            {
                if (setting_list_rock == true && setting_list_no > 0)
                {
                    dispFuncList(setting_list_no, "Ins_Select", quest_status[list_no].text);
                    quest_list[1].func_no[setting_list_no] = list_no;
                    setting_list_rock = false;
                }
                wk_func.gotoAndStop("on");
                return;
            }// end function
            ;
            var wk_ins:* = ins + "_Btn";
            wk_func = new FuncList();
            wk_func.x = dx;
            wk_func.y = dy;
            wk_func.scaleX = 0.75;
            wk_func.scaleY = wk_func.scaleX;
            wk_func.name = wk_ins;
            this.Ins_Item_Setting.addChild(wk_func);
            wk_quest = wk_func.getChildByName("Ins_Text");
            wk_quest_mc = wk_quest as MovieClip;
            wk_quest_tx = wk_quest as TextField;
            wk_quest_tx.text = func_txt;
            wk_func.addEventListener(MouseEvent.MOUSE_OVER, overListBtn);
            wk_func.addEventListener(MouseEvent.MOUSE_OUT, outListBtn);
            wk_func.addEventListener(MouseEvent.MOUSE_UP, downListBtn);
            wk_func.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Setting.removeChild(wk_func);
                wk_func.removeEventListener(MouseEvent.MOUSE_OVER, overListBtn);
                wk_func.removeEventListener(MouseEvent.MOUSE_OUT, outListBtn);
                wk_func.removeEventListener(MouseEvent.MOUSE_UP, downListBtn);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function dispFuncListBtn(param1:int, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param2 + "_Btn";
            _loc_4 = this.Ins_Item_Setting.getChildByName(_loc_3);
            _loc_5 = _loc_4 as MovieClip;
            _loc_5.gotoAndStop("off");
            return;
        }// end function

        public function clearFuncListBtn(param1:int, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param2 + "_Btn";
            _loc_4 = this.Ins_Item_Setting.getChildByName(_loc_3);
            _loc_5 = _loc_4 as MovieClip;
            this.Ins_Item_Setting.removeChild(_loc_4);
            return;
        }// end function

        public function initFuncList(param1:int, param2:String, param3:String) : void
        {
            var wk_list:DisplayObject;
            var wk_list_mc:MovieClip;
            var wk_text:DisplayObject;
            var wk_text_tx:TextField;
            var overListBtn:Function;
            var outListBtn:Function;
            var downListBtn:Function;
            var list_no:* = param1;
            var ins:* = param2;
            var func_txt:* = param3;
            overListBtn = function (event:MouseEvent) : void
            {
                if (setting_list_rock == false)
                {
                    wk_list_mc.gotoAndStop("over");
                }
                return;
            }// end function
            ;
            outListBtn = function (event:MouseEvent) : void
            {
                if (setting_list_rock == false)
                {
                    wk_list_mc.gotoAndStop("off");
                }
                return;
            }// end function
            ;
            downListBtn = function (event:MouseEvent) : void
            {
                if (setting_list_rock == false)
                {
                    setting_list_no = list_no;
                    setting_list_rock = true;
                    wk_list_mc.gotoAndStop("on");
                }
                else if (setting_list_no != list_no)
                {
                    cancelFuncList(setting_list_no, "Ins_Select", "off");
                    setting_list_no = list_no;
                    wk_list_mc.gotoAndStop("on");
                }
                return;
            }// end function
            ;
            var wk_ins:* = ins + list_no;
            wk_list = this.Ins_Item_Setting.getChildByName(wk_ins);
            wk_list_mc = wk_list as MovieClip;
            wk_list_mc.gotoAndStop("off");
            wk_text = wk_list_mc.getChildByName("Ins_Text");
            wk_text_tx = wk_text as TextField;
            wk_text_tx.text = func_txt;
            wk_list.addEventListener(MouseEvent.MOUSE_OVER, overListBtn);
            wk_list.addEventListener(MouseEvent.MOUSE_OUT, outListBtn);
            wk_list.addEventListener(MouseEvent.MOUSE_UP, downListBtn);
            wk_list.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                wk_list.removeEventListener(MouseEvent.MOUSE_OVER, overListBtn);
                wk_list.removeEventListener(MouseEvent.MOUSE_OUT, outListBtn);
                wk_list.removeEventListener(MouseEvent.MOUSE_UP, downListBtn);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function dispFuncList(param1:int, param2:String, param3:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = param2 + param1;
            _loc_5 = this.Ins_Item_Setting.getChildByName(_loc_4);
            _loc_6 = _loc_5 as MovieClip;
            _loc_6.gotoAndStop("off");
            _loc_7 = _loc_6.getChildByName("Ins_Text");
            _loc_8 = _loc_7 as TextField;
            _loc_8.text = param3;
            return;
        }// end function

        public function cancelFuncList(param1:int, param2:String, param3:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = param2 + param1;
            _loc_5 = this.Ins_Item_Setting.getChildByName(_loc_4);
            _loc_6 = _loc_5 as MovieClip;
            _loc_6.gotoAndStop(param3);
            return;
        }// end function

        public function entrySettingRetBtn() : void
        {
            this.Ins_Item_Setting.Ins_Ret.addEventListener(MouseEvent.MOUSE_UP, this.downSettingRetBtn);
            return;
        }// end function

        public function releaseSettingRetBtn() : void
        {
            this.Ins_Item_Setting.Ins_Ret.removeEventListener(MouseEvent.MOUSE_UP, this.downSettingRetBtn);
            return;
        }// end function

        public function downSettingRetBtn(event:MouseEvent) : void
        {
            this.setting_ret_flag = true;
            return;
        }// end function

        public function getSettingRetBtn() : Boolean
        {
            return this.setting_ret_flag;
        }// end function

        public function setSettingRetBtn(param1:Boolean) : void
        {
            this.setting_ret_flag = param1;
            return;
        }// end function

        public function entrySettingBack() : void
        {
            this.Ins_Item_Setting.Ins_Back.addEventListener(MouseEvent.MOUSE_UP, this.downSettingBack);
            return;
        }// end function

        public function releaseSettingBack() : void
        {
            this.Ins_Item_Setting.Ins_Back.removeEventListener(MouseEvent.MOUSE_UP, this.downSettingBack);
            return;
        }// end function

        public function downSettingBack(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            this.setting_list_no = 0;
            this.setting_list_rock = false;
            _loc_2 = 1;
            while (_loc_2 < this.quest_list[1].func_no.length)
            {
                
                this.cancelFuncList(_loc_2, "Ins_Select", "off");
                _loc_2++;
            }
            return;
        }// end function

        public function entryList1_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List1_1.addEventListener(MouseEvent.MOUSE_UP, this.downList1_1_Btn);
            return;
        }// end function

        public function releaseList1_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List1_1.removeEventListener(MouseEvent.MOUSE_UP, this.downList1_1_Btn);
            return;
        }// end function

        public function downList1_1_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[1] = 0;
            this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_1.x - 60;
            this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_1.y;
            return;
        }// end function

        public function entryList1_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List1_2.addEventListener(MouseEvent.MOUSE_UP, this.downList1_2_Btn);
            return;
        }// end function

        public function releaseList1_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List1_2.removeEventListener(MouseEvent.MOUSE_UP, this.downList1_2_Btn);
            return;
        }// end function

        public function downList1_2_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[1] = 1;
            this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_2.x - 110;
            this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_2.y;
            return;
        }// end function

        public function getSettingList1() : uint
        {
            return this.setting_status[1].list[1];
        }// end function

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.start_btn_flag = false;
            this.next_btn_flag = false;
            this.stop_btn_flag = false;
            this.other_btn_flag = false;
            this.reset_btn_flag = false;
            this.setting_btn_flag = false;
            this.pause_flag = false;
            this.weight_touch_flag = false;
            this.weight_refresh_flag = false;
            this.mode_ofs_x = 0;
            this.mode_ofs_y = 0;
            this.quest_list = [{no:0, func_no:[0, 5, 11, 21, 26, 37]}, {no:1, func_no:[0, 5, 11, 21, 26, 37]}];
            this.quest_text = ["x+1=5", "2x+1=9", "3x+3=15", "2x+1=7", "3x+2=11", "2x+1=5"];
            this.quest_status = [{no:0, ins:"q_1_1", text:"x+1=5", dx:this._LIST_B1X + this._LIST_OFSX * 0, dy:this._LIST_B1Y + this._LIST_OFSY * 0, txt_no:1, num:4, l_weight:[1, 1], r_weight:[0, 5]}, {no:1, ins:"q_1_1", text:"x+1=5", dx:this._LIST_B1X + this._LIST_OFSX * 0, dy:this._LIST_B1Y + this._LIST_OFSY * 0, txt_no:1, num:4, l_weight:[1, 1], r_weight:[0, 5]}, {no:2, ins:"q_1_2", text:"x+2=6", dx:this._LIST_B1X + this._LIST_OFSX * 1, dy:this._LIST_B1Y + this._LIST_OFSY * 0, txt_no:2, num:4, l_weight:[1, 2], r_weight:[0, 6]}, {no:3, ins:"q_1_3", text:"x+3=7", dx:this._LIST_B1X + this._LIST_OFSX * 2, dy:this._LIST_B1Y + this._LIST_OFSY * 0, txt_no:3, num:4, l_weight:[1, 3], r_weight:[0, 7]}, {no:4, ins:"q_1_4", text:"x+4=8", dx:this._LIST_B1X + this._LIST_OFSX * 3, dy:this._LIST_B1Y + this._LIST_OFSY * 0, txt_no:4, num:4, l_weight:[1, 4], r_weight:[0, 8]}, {no:5, ins:"q_1_5", text:"2x+1=9", dx:this._LIST_B1X + this._LIST_OFSX * 0, dy:this._LIST_B1Y + this._LIST_OFSY * 1, txt_no:5, num:4, l_weight:[2, 1], r_weight:[0, 9]}, {no:6, ins:"q_1_6", text:"2x+2=10", dx:this._LIST_B1X + this._LIST_OFSX * 1, dy:this._LIST_B1Y + this._LIST_OFSY * 1, txt_no:6, num:4, l_weight:[2, 2], r_weight:[0, 10]}, {no:7, ins:"q_1_7", text:"2x+3=11", dx:this._LIST_B1X + this._LIST_OFSX * 2, dy:this._LIST_B1Y + this._LIST_OFSY * 1, txt_no:7, num:4, l_weight:[2, 3], r_weight:[0, 11]}, {no:8, ins:"q_1_8", text:"2x+4=12", dx:this._LIST_B1X + this._LIST_OFSX * 3, dy:this._LIST_B1Y + this._LIST_OFSY * 1, txt_no:8, num:4, l_weight:[2, 4], r_weight:[0, 12]}, {no:9, ins:"q_1_9", text:"3x+1=13", dx:this._LIST_B1X + this._LIST_OFSX * 0, dy:this._LIST_B1Y + this._LIST_OFSY * 2, txt_no:9, num:4, l_weight:[3, 1], r_weight:[0, 13]}, {no:10, ins:"q_1_10", text:"3x+2=14", dx:this._LIST_B1X + this._LIST_OFSX * 1, dy:this._LIST_B1Y + this._LIST_OFSY * 2, txt_no:10, num:4, l_weight:[3, 2], r_weight:[0, 14]}, {no:11, ins:"q_1_11", text:"3x+3=15", dx:this._LIST_B1X + this._LIST_OFSX * 2, dy:this._LIST_B1Y + this._LIST_OFSY * 2, txt_no:11, num:4, l_weight:[3, 3], r_weight:[0, 15]}, {no:12, ins:"q_1_12", text:"3x+4=16", dx:this._LIST_B1X + this._LIST_OFSX * 3, dy:this._LIST_B1Y + this._LIST_OFSY * 2, txt_no:12, num:4, l_weight:[3, 4], r_weight:[0, 16]}, {no:13, ins:"q_1_13", text:"4x+1=17", dx:this._LIST_B1X + this._LIST_OFSX * 0, dy:this._LIST_B1Y + this._LIST_OFSY * 3, txt_no:13, num:4, l_weight:[4, 1], r_weight:[0, 17]}, {no:14, ins:"q_1_14", text:"4x+2=18", dx:this._LIST_B1X + this._LIST_OFSX * 1, dy:this._LIST_B1Y + this._LIST_OFSY * 3, txt_no:14, num:4, l_weight:[4, 2], r_weight:[0, 18]}, {no:15, ins:"q_1_15", text:"4x+3=19", dx:this._LIST_B1X + this._LIST_OFSX * 2, dy:this._LIST_B1Y + this._LIST_OFSY * 3, txt_no:15, num:4, l_weight:[4, 3], r_weight:[0, 19]}, {no:16, ins:"q_1_16", text:"4x+4=20", dx:this._LIST_B1X + this._LIST_OFSX * 3, dy:this._LIST_B1Y + this._LIST_OFSY * 3, txt_no:16, num:4, l_weight:[4, 4], r_weight:[0, 20]}, {no:17, ins:"q_2_1", text:"x+1=4", dx:this._LIST_B2X + this._LIST_OFSX * 0, dy:this._LIST_B2Y + this._LIST_OFSY * 0, txt_no:21, num:3, l_weight:[1, 1], r_weight:[0, 4]}, {no:18, ins:"q_2_2", text:"x+2=5", dx:this._LIST_B2X + this._LIST_OFSX * 1, dy:this._LIST_B2Y + this._LIST_OFSY * 0, txt_no:22, num:3, l_weight:[1, 2], r_weight:[0, 5]}, {no:19, ins:"q_2_3", text:"x+3=6", dx:this._LIST_B2X + this._LIST_OFSX * 2, dy:this._LIST_B2Y + this._LIST_OFSY * 0, txt_no:23, num:3, l_weight:[1, 3], r_weight:[0, 6]}, {no:20, ins:"q_2_4", text:"x+4=7", dx:this._LIST_B2X + this._LIST_OFSX * 3, dy:this._LIST_B2Y + this._LIST_OFSY * 0, txt_no:24, num:3, l_weight:[1, 4], r_weight:[0, 7]}, {no:21, ins:"q_2_5", text:"2x+1=7", dx:this._LIST_B2X + this._LIST_OFSX * 0, dy:this._LIST_B2Y + this._LIST_OFSY * 1, txt_no:25, num:3, l_weight:[2, 1], r_weight:[0, 7]}, {no:22, ins:"q_2_6", text:"2x+2=8", dx:this._LIST_B2X + this._LIST_OFSX * 1, dy:this._LIST_B2Y + this._LIST_OFSY * 1, txt_no:26, num:3, l_weight:[2, 2], r_weight:[0, 8]}, {no:23, ins:"q_2_7", text:"2x+3=9", dx:this._LIST_B2X + this._LIST_OFSX * 2, dy:this._LIST_B2Y + this._LIST_OFSY * 1, txt_no:27, num:3, l_weight:[2, 3], r_weight:[0, 9]}, {no:24, ins:"q_2_8", text:"2x+4=10", dx:this._LIST_B2X + this._LIST_OFSX * 3, dy:this._LIST_B2Y + this._LIST_OFSY * 1, txt_no:28, num:3, l_weight:[2, 4], r_weight:[0, 10]}, {no:25, ins:"q_2_9", text:"3x+1=10", dx:this._LIST_B2X + this._LIST_OFSX * 0, dy:this._LIST_B2Y + this._LIST_OFSY * 2, txt_no:29, num:3, l_weight:[3, 1], r_weight:[0, 10]}, {no:26, ins:"q_2_10", text:"3x+2=11", dx:this._LIST_B2X + this._LIST_OFSX * 1, dy:this._LIST_B2Y + this._LIST_OFSY * 2, txt_no:30, num:3, l_weight:[3, 2], r_weight:[0, 11]}, {no:27, ins:"q_2_11", text:"3x+3=12", dx:this._LIST_B2X + this._LIST_OFSX * 2, dy:this._LIST_B2Y + this._LIST_OFSY * 2, txt_no:31, num:3, l_weight:[3, 3], r_weight:[0, 12]}, {no:28, ins:"q_2_12", text:"3x+4=13", dx:this._LIST_B2X + this._LIST_OFSX * 3, dy:this._LIST_B2Y + this._LIST_OFSY * 2, txt_no:32, num:3, l_weight:[3, 4], r_weight:[0, 13]}, {no:29, ins:"q_2_13", text:"4x+1=13", dx:this._LIST_B2X + this._LIST_OFSX * 0, dy:this._LIST_B2Y + this._LIST_OFSY * 3, txt_no:33, num:3, l_weight:[4, 1], r_weight:[0, 13]}, {no:30, ins:"q_2_14", text:"4x+2=14", dx:this._LIST_B2X + this._LIST_OFSX * 1, dy:this._LIST_B2Y + this._LIST_OFSY * 3, txt_no:34, num:3, l_weight:[4, 2], r_weight:[0, 14]}, {no:31, ins:"q_2_15", text:"4x+3=15", dx:this._LIST_B2X + this._LIST_OFSX * 2, dy:this._LIST_B2Y + this._LIST_OFSY * 3, txt_no:35, num:3, l_weight:[4, 3], r_weight:[0, 15]}, {no:32, ins:"q_2_16", text:"4x+4=16", dx:this._LIST_B2X + this._LIST_OFSX * 3, dy:this._LIST_B2Y + this._LIST_OFSY * 3, txt_no:36, num:3, l_weight:[4, 4], r_weight:[0, 16]}, {no:33, ins:"q_3_1", text:"x+1=3", dx:this._LIST_B3X + this._LIST_OFSX * 0, dy:this._LIST_B3Y + this._LIST_OFSY * 0, txt_no:41, num:2, l_weight:[1, 1], r_weight:[0, 3]}, {no:34, ins:"q_3_2", text:"x+2=4", dx:this._LIST_B3X + this._LIST_OFSX * 1, dy:this._LIST_B3Y + this._LIST_OFSY * 0, txt_no:42, num:2, l_weight:[1, 2], r_weight:[0, 4]}, {no:35, ins:"q_3_3", text:"x+3=5", dx:this._LIST_B3X + this._LIST_OFSX * 2, dy:this._LIST_B3Y + this._LIST_OFSY * 0, txt_no:43, num:2, l_weight:[1, 3], r_weight:[0, 5]}, {no:36, ins:"q_3_4", text:"x+4=6", dx:this._LIST_B3X + this._LIST_OFSX * 3, dy:this._LIST_B3Y + this._LIST_OFSY * 0, txt_no:44, num:2, l_weight:[1, 4], r_weight:[0, 6]}, {no:37, ins:"q_3_5", text:"2x+1=5", dx:this._LIST_B3X + this._LIST_OFSX * 0, dy:this._LIST_B3Y + this._LIST_OFSY * 1, txt_no:45, num:2, l_weight:[2, 1], r_weight:[0, 5]}, {no:38, ins:"q_3_6", text:"2x+2=6", dx:this._LIST_B3X + this._LIST_OFSX * 1, dy:this._LIST_B3Y + this._LIST_OFSY * 1, txt_no:46, num:2, l_weight:[2, 2], r_weight:[0, 6]}, {no:39, ins:"q_3_7", text:"2x+3=7", dx:this._LIST_B3X + this._LIST_OFSX * 2, dy:this._LIST_B3Y + this._LIST_OFSY * 1, txt_no:47, num:2, l_weight:[2, 3], r_weight:[0, 7]}, {no:40, ins:"q_3_8", text:"2x+4=8", dx:this._LIST_B3X + this._LIST_OFSX * 3, dy:this._LIST_B3Y + this._LIST_OFSY * 1, txt_no:48, num:2, l_weight:[2, 4], r_weight:[0, 8]}, {no:41, ins:"q_3_9", text:"3x+1=7", dx:this._LIST_B3X + this._LIST_OFSX * 0, dy:this._LIST_B3Y + this._LIST_OFSY * 2, txt_no:49, num:2, l_weight:[3, 1], r_weight:[0, 7]}, {no:42, ins:"q_3_10", text:"3x+2=8", dx:this._LIST_B3X + this._LIST_OFSX * 1, dy:this._LIST_B3Y + this._LIST_OFSY * 2, txt_no:50, num:2, l_weight:[3, 2], r_weight:[0, 8]}, {no:43, ins:"q_3_11", text:"3x+3=9", dx:this._LIST_B3X + this._LIST_OFSX * 2, dy:this._LIST_B3Y + this._LIST_OFSY * 2, txt_no:51, num:2, l_weight:[3, 3], r_weight:[0, 9]}, {no:44, ins:"q_3_12", text:"3x+4=10", dx:this._LIST_B3X + this._LIST_OFSX * 3, dy:this._LIST_B3Y + this._LIST_OFSY * 2, txt_no:52, num:2, l_weight:[3, 4], r_weight:[0, 10]}, {no:45, ins:"q_3_13", text:"4x+1=9", dx:this._LIST_B3X + this._LIST_OFSX * 0, dy:this._LIST_B3Y + this._LIST_OFSY * 3, txt_no:53, num:2, l_weight:[4, 1], r_weight:[0, 9]}, {no:46, ins:"q_3_14", text:"4x+2=10", dx:this._LIST_B3X + this._LIST_OFSX * 1, dy:this._LIST_B3Y + this._LIST_OFSY * 3, txt_no:54, num:2, l_weight:[4, 2], r_weight:[0, 10]}, {no:47, ins:"q_3_15", text:"4x+3=11", dx:this._LIST_B3X + this._LIST_OFSX * 2, dy:this._LIST_B3Y + this._LIST_OFSY * 3, txt_no:55, num:2, l_weight:[4, 3], r_weight:[0, 11]}, {no:48, ins:"q_3_16", text:"4x+4=12", dx:this._LIST_B3X + this._LIST_OFSX * 3, dy:this._LIST_B3Y + this._LIST_OFSY * 3, txt_no:56, num:2, l_weight:[4, 4], r_weight:[0, 12]}, {no:49, ins:"q_3_17", text:"5x+1=11", dx:this._LIST_B3X + this._LIST_OFSX * 0, dy:this._LIST_B3Y + this._LIST_OFSY * 4, txt_no:57, num:2, l_weight:[5, 1], r_weight:[0, 11]}, {no:50, ins:"q_3_18", text:"5x+2=12", dx:this._LIST_B3X + this._LIST_OFSX * 1, dy:this._LIST_B3Y + this._LIST_OFSY * 4, txt_no:58, num:2, l_weight:[5, 2], r_weight:[0, 12]}, {no:51, ins:"q_3_19", text:"5x+3=13", dx:this._LIST_B3X + this._LIST_OFSX * 2, dy:this._LIST_B3Y + this._LIST_OFSY * 4, txt_no:59, num:2, l_weight:[5, 3], r_weight:[0, 13]}, {no:52, ins:"q_3_20", text:"5x+4=14", dx:this._LIST_B3X + this._LIST_OFSX * 3, dy:this._LIST_B3Y + this._LIST_OFSY * 4, txt_no:60, num:2, l_weight:[5, 4], r_weight:[0, 14]}];
            this.quest_exp_script = [{no:0, ins:"Ins_Exp1", x:[1], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[5], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[0], act10:[0], act11:[0], act12:[0], act11:[0], act12:[0]}, {no:1, ins:"Ins_Exp1", x:[1], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[5], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2, 3, 4], act12:[this._WT_SIZE * 0.5]}, {no:2, ins:"Ins_Exp2", x:[1], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[5, 6], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2, 3, 4], act12:[this._WT_SIZE * 0.5]}, {no:3, ins:"Ins_Exp3", x:[1], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[5, 6, 7], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3, 4], act12:[this._WT_SIZE * 0.5]}, {no:4, ins:"Ins_Exp4", x:[1], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[5, 6, 7, 8], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3, 4], act12:[this._WT_SIZE * 0.5]}, {no:5, ins:"Ins_Exp5", x:[2], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[5], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4, 8, 9], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 1], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:6, ins:"Ins_Exp6", x:[2], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[5, 10], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4, 8, 9], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:7, ins:"Ins_Exp7", x:[2], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[5, 10, 11], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4, 8, 9], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:8, ins:"Ins_Exp8", x:[2], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[5, 10, 11, 12], act4:["step5"], act5:["step6", "step7", "step8"], act6:[2], act7:[3, 4, 8, 9], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:9, ins:"Ins_Exp9", x:[3], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[13], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[3, 8, 11, 12, 4, 5, 9, 10], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:10, ins:"Ins_Exp10", x:[3], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[13, 14], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[3, 8, 11, 12, 4, 5, 9, 10], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:11, ins:"Ins_Exp11", x:[3], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[13, 14, 15], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 1], act7:[3, 8, 11, 12, 4, 5, 9, 10], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:12, ins:"Ins_Exp12", x:[3], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[13, 14, 15, 16], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 2], act7:[3, 8, 11, 12, 4, 5, 9, 10], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:13, ins:"Ins_Exp13", x:[4], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[17], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2, 3], act7:[16, 11, 12, 13, 3, 8, 9, 14, 4, 5, 10, 15], act8:["step9"], act9:[4], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:14, ins:"Ins_Exp14", x:[4], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[17, 18], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 1, 2], act7:[16, 11, 12, 13, 3, 8, 9, 14, 4, 5, 10, 15], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:15, ins:"Ins_Exp15", x:[4], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[17, 18, 19], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 1], act7:[16, 11, 12, 13, 3, 8, 9, 14, 4, 5, 10, 15], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:16, ins:"Ins_Exp16", x:[4], div:[1, 4], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[17, 18, 19, 20], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 2], act7:[16, 11, 12, 13, 3, 8, 9, 14, 4, 5, 10, 15], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 6, 7], act12:[this._WT_SIZE * 1.5]}, {no:17, ins:"Ins_Exp17", x:[1], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[4], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2, 3], act12:[this._WT_SIZE * 0]}, {no:18, ins:"Ins_Exp18", x:[1], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[4, 5], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:19, ins:"Ins_Exp19", x:[1], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[4, 5, 6], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:20, ins:"Ins_Exp20", x:[1], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[4, 5, 6, 7], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:21, ins:"Ins_Exp21", x:[2], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[7], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[4, 5, 6], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 1], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:22, ins:"Ins_Exp22", x:[2], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[7, 8], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[4, 5, 6], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:23, ins:"Ins_Exp23", x:[2], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[7, 8, 9], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[4, 5, 6], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:24, ins:"Ins_Exp24", x:[2], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[7, 8, 9, 10], act4:["step5"], act5:["step6", "step7", "step8"], act6:[2], act7:[4, 5, 6], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:25, ins:"Ins_Exp25", x:[3], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[10], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[6, 7, 8, 9, 4, 5], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:26, ins:"Ins_Exp26", x:[3], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[10, 11], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[6, 7, 8, 9, 4, 5], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:27, ins:"Ins_Exp27", x:[3], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[10, 11, 12], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 1], act7:[6, 7, 8, 9, 4, 5], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:28, ins:"Ins_Exp28", x:[3], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[10, 11, 12, 13], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 2], act7:[6, 7, 8, 9, 4, 5], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:29, ins:"Ins_Exp29", x:[4], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[13], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2, 3], act7:[11, 12, 6, 7, 8, 9, 4, 5, 10], act8:["step9"], act9:[4], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1.5]}, {no:30, ins:"Ins_Exp30", x:[4], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[13, 14], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 1, 2], act7:[11, 12, 6, 7, 8, 9, 4, 5, 10], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:31, ins:"Ins_Exp31", x:[4], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[13, 14, 15], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 1], act7:[11, 12, 6, 7, 8, 9, 4, 5, 10], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:32, ins:"Ins_Exp32", x:[4], div:[1, 3], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[13, 14, 15, 16], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 2], act7:[11, 12, 6, 7, 8, 9, 4, 5, 10], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2, 3], act12:[this._WT_SIZE * 1]}, {no:33, ins:"Ins_Exp33", x:[1], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[3], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2], act12:[this._WT_SIZE * 0.5]}, {no:34, ins:"Ins_Exp34", x:[1], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[3, 4], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 1], act11:[1, 2], act12:[this._WT_SIZE * 0.5]}, {no:35, ins:"Ins_Exp35", x:[1], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[3, 4, 5], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:36, ins:"Ins_Exp36", x:[1], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[3, 4, 5, 6], act4:["step5"], act5:["end"], act6:[0], act7:[0], act8:[""], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:37, ins:"Ins_Exp37", x:[2], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[5], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 1], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:38, ins:"Ins_Exp38", x:[2], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[5, 6], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:39, ins:"Ins_Exp39", x:[2], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[5, 6, 7], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1], act7:[3, 4], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:40, ins:"Ins_Exp40", x:[2], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[5, 6, 7, 8], act4:["step5"], act5:["step6", "step7", "step8"], act6:[2], act7:[3, 4], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:41, ins:"Ins_Exp41", x:[3], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[7], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[6, 3, 4, 5], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:42, ins:"Ins_Exp42", x:[3], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[7, 8], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2], act7:[6, 3, 4, 5], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:43, ins:"Ins_Exp43", x:[3], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[7, 8, 9], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 1], act7:[6, 3, 4, 5], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:44, ins:"Ins_Exp44", x:[3], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[7, 8, 9, 10], act4:["step5"], act5:["step6", "step7", "step8"], act6:[3, 2], act7:[6, 3, 4, 5], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:45, ins:"Ins_Exp45", x:[4], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[9], act4:["step5"], act5:["step6", "step7", "step8"], act6:[1, 2, 3], act7:[6, 7, 8, 3, 4, 5], act8:["step9"], act9:[4], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:46, ins:"Ins_Exp46", x:[4], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[9, 10], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 1, 2], act7:[6, 7, 8, 3, 4, 5], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:47, ins:"Ins_Exp47", x:[4], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[9, 10, 11], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 1], act7:[6, 7, 8, 3, 4, 5], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:48, ins:"Ins_Exp48", x:[4], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[9, 10, 11, 12], act4:["step5"], act5:["step6", "step7", "step8"], act6:[4, 3, 2], act7:[6, 7, 8, 3, 4, 5], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:49, ins:"Ins_Exp49", x:[5], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1], act3:[11], act4:["step5"], act5:["step6", "step7", "step8"], act6:[5, 1, 2, 3], act7:[6, 7, 8, 3, 4, 9, 5, 10], act8:["step9"], act9:[4], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:50, ins:"Ins_Exp50", x:[5], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2], act3:[11, 12], act4:["step5"], act5:["step6", "step7", "step8"], act6:[5, 4, 1, 2], act7:[6, 7, 8, 3, 4, 9, 5, 10], act8:["step9"], act9:[3], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:51, ins:"Ins_Exp51", x:[5], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3], act3:[11, 12, 13], act4:["step5"], act5:["step6", "step7", "step8"], act6:[5, 4, 3, 1], act7:[6, 7, 8, 3, 4, 9, 5, 10], act8:["step9"], act9:[2], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}, {no:52, ins:"Ins_Exp52", x:[5], div:[1, 2], act1:["step1", "step2", "step3", "step4"], act2:[1, 2, 3, 4], act3:[11, 12, 13, 14], act4:["step5"], act5:["step6", "step7", "step8"], act6:[5, 4, 3, 2], act7:[6, 7, 8, 3, 4, 9, 5, 10], act8:["step9"], act9:[1], act10:[this._WT_SIZE * 2], act11:[1, 2], act12:[this._WT_SIZE * 1.5]}];
            this.weight_status = [{no:1, type:0, area:0, cnt:0, ins:"", num:1}, {no:2, type:0, area:0, cnt:0, ins:"", num:1}, {no:3, type:0, area:0, cnt:0, ins:"", num:1}, {no:4, type:0, area:0, cnt:0, ins:"", num:1}, {no:5, type:0, area:0, cnt:0, ins:"", num:1}, {no:6, type:0, area:0, cnt:0, ins:"", num:1}, {no:7, type:0, area:0, cnt:0, ins:"", num:1}, {no:8, type:0, area:0, cnt:0, ins:"", num:1}, {no:9, type:0, area:0, cnt:0, ins:"", num:1}, {no:10, type:0, area:0, cnt:0, ins:"", num:1}, {no:11, type:0, area:0, cnt:0, ins:"", num:1}, {no:12, type:0, area:0, cnt:0, ins:"", num:1}, {no:13, type:0, area:0, cnt:0, ins:"", num:1}, {no:14, type:0, area:0, cnt:0, ins:"", num:1}, {no:15, type:0, area:0, cnt:0, ins:"", num:1}, {no:16, type:0, area:0, cnt:0, ins:"", num:1}, {no:17, type:0, area:0, cnt:0, ins:"", num:1}, {no:18, type:0, area:0, cnt:0, ins:"", num:1}, {no:19, type:0, area:0, cnt:0, ins:"", num:1}, {no:20, type:0, area:0, cnt:0, ins:"", num:1}, {no:21, type:0, area:0, cnt:0, ins:"", num:1}, {no:22, type:0, area:0, cnt:0, ins:"", num:1}, {no:23, type:0, area:0, cnt:0, ins:"", num:1}, {no:24, type:0, area:0, cnt:0, ins:"", num:1}, {no:25, type:0, area:0, cnt:0, ins:"", num:1}, {no:26, type:0, area:0, cnt:0, ins:"", num:1}, {no:27, type:0, area:0, cnt:0, ins:"", num:1}, {no:28, type:0, area:0, cnt:0, ins:"", num:1}, {no:29, type:0, area:0, cnt:0, ins:"", num:1}, {no:30, type:0, area:0, cnt:0, ins:"", num:1}, {no:31, type:0, area:0, cnt:0, ins:"", num:1}, {no:32, type:0, area:0, cnt:0, ins:"", num:1}, {no:33, type:0, area:0, cnt:0, ins:"", num:1}, {no:34, type:0, area:0, cnt:0, ins:"", num:1}, {no:35, type:0, area:0, cnt:0, ins:"", num:1}, {no:36, type:0, area:0, cnt:0, ins:"", num:1}, {no:37, type:0, area:0, cnt:0, ins:"", num:1}, {no:38, type:0, area:0, cnt:0, ins:"", num:1}, {no:39, type:0, area:0, cnt:0, ins:"", num:1}, {no:40, type:0, area:0, cnt:0, ins:"", num:1}];
            this.weight_pos1_tbl = [{no:1, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:2, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:3, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:4, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:5, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:6, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:7, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:8, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:9, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:10, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:11, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:12, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:13, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:14, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:15, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:16, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -3}, {no:17, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -3}, {no:18, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -3}, {no:19, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -3}, {no:20, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -3}, {no:21, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -4}, {no:22, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -4}, {no:23, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -4}, {no:24, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -4}, {no:25, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -4}, {no:26, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -5}, {no:27, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -5}, {no:28, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -5}, {no:29, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -5}, {no:30, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -5}, {no:31, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -6}, {no:32, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -6}, {no:33, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -6}, {no:34, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -6}, {no:35, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -6}, {no:36, dx:this._WT_L_BASE_X + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -7}, {no:37, dx:this._WT_L_BASE_X + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -7}, {no:38, dx:this._WT_L_BASE_X + this._WT_SIZE * 0, dy:this._WT_L_BASE_Y + this._WT_SIZE * -7}, {no:39, dx:this._WT_L_BASE_X + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -7}, {no:40, dx:this._WT_L_BASE_X + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -7}];
            this.weight_pos2_tbl = [{no:1, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:2, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:3, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:4, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:5, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:6, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:7, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:8, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:9, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:10, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:11, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:12, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:13, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:14, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:15, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:16, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -3}, {no:17, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -3}, {no:18, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -3}, {no:19, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -3}, {no:20, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -3}, {no:21, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -4}, {no:22, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -4}, {no:23, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -4}, {no:24, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -4}, {no:25, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -4}, {no:26, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -5}, {no:27, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -5}, {no:28, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -5}, {no:29, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -5}, {no:30, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -5}, {no:31, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -6}, {no:32, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -6}, {no:33, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -6}, {no:34, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -6}, {no:35, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -6}, {no:36, dx:this._WT_R_BASE_X + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -7}, {no:37, dx:this._WT_R_BASE_X + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -7}, {no:38, dx:this._WT_R_BASE_X + this._WT_SIZE * 0, dy:this._WT_R_BASE_Y + this._WT_SIZE * -7}, {no:39, dx:this._WT_R_BASE_X + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -7}, {no:40, dx:this._WT_R_BASE_X + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -7}];
            this.weight_pos3_tbl = [{no:1, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:2, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:3, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:4, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * 0}, {no:6, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:7, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:8, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:9, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -1}, {no:10, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:11, dx:this._WT_L_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:12, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}, {no:13, dx:this._WT_L_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_L_BASE_Y + this._WT_SIZE * -2}];
            this.weight_pos4_tbl = [{no:1, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:2, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:3, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:4, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * 0}, {no:6, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:7, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:8, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:9, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -1}, {no:10, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:11, dx:this._WT_R_BASE_X2 + this._WT_SIZE * -1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:12, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 1, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}, {no:13, dx:this._WT_R_BASE_X2 + this._WT_SIZE * 2, dy:this._WT_R_BASE_Y + this._WT_SIZE * -2}];
            this.weight_pos5_tbl = [{no:0, wt1:[0], wt2:[0]}, {no:1, wt1:[0, 1], wt2:[8, 2, 3, 4]}, {no:2, wt1:[0, 1, 2], wt2:[8, 7, 3, 4]}, {no:3, wt1:[0], wt2:[9, 1, 2, 3, 4]}, {no:4, wt1:[0, 1], wt2:[9, 8, 2, 3, 4]}, {no:6, wt1:[0, 1, 2], wt2:[9, 8, 7, 3, 4]}, {no:7, wt1:[0, 1, 2, 3], wt2:[9, 8, 7, 6, 4]}];
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
            this.quest_list_no = 1;
            this.weight_num = 0;
            this.weight1_counter = 0;
            this.weight2_counter = 0;
            this.area_weight_num = [0, 0, 0];
            this.balance_id = 0;
            this.game_index = 0;
            this.game_timer = 0;
            this.game_step = 0;
            this.drop_box_flag = false;
            this.drop_box_open = false;
            this.drop_box_list = 0;
            this.setting_status = [{list:[0, 0, 0, 0, 0, 0, 0], ans_time:0, disp_time:0}, {list:[0, 0, 0, 0, 0, 0, 0], ans_time:0, disp_time:0}];
            this.setting_list_no = 0;
            this.setting_list_rock = false;
            this.setting_ret_flag = false;
            return;
        }// end function

    }
}
