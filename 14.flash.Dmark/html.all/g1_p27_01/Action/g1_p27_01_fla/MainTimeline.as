package g1_p27_01_fla
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
        public var reset_btn_flag:Boolean;
        public var setting_btn_flag:Boolean;
        public var pause_flag:Boolean;
        public var random_card_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _FR_CARD_OPEN:uint = 30;
        public const _FR_CARD_CLOSE:uint = 30;
        public const _HELP_NUM_OFSY:uint = 170;
        public var game_mode_status:Array;
        public var card_status:Array;
        public var card_box:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var card_click_flag:Boolean;
        public var card_number_flag:Boolean;
        public var answer_disp_flag:Boolean;
        public var card_type:uint;
        public var card_counter:uint;
        public var answer_time:uint;
        public var answer_disp_time:uint;
        public var card_id:Array;
        public var play_card:uint;
        public var quest_num:uint;
        public var quest_counter:uint;
        public var game_index:int;
        public var game_timer:int;
        public var setting_status:Array;
        public var setting_bar_pos:Array;
        public const _LIST_MARK_OFSX:int = -95;
        public var setting_ret_flag:Boolean;
        public var list6_bar_flag:Boolean;
        public const _SETTING_BAR_L:int = -250;
        public const _SETTING_BAR_R:int = 250;
        public const _SETTING_BAR_UNIT:int = 2;
        public var list7_bar_flag:Boolean;

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
                    this.entryStartBtn();
                    this.entryNextBtn();
                    this.entryStopBtn();
                    this.entryResetBtn();
                    this.entrySettingBtn();
                    this.initSettingMenu();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
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
                        this.setResetBtn(false);
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
                    else if (this.controlGame() > 0)
                    {
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 80:
                {
                    if (this.getSettingRetBtn() == true)
                    {
                        this.setSettingRetBtn(false);
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
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.releaseStartBtn();
            this.releaseNextBtn();
            this.releaseStopBtn();
            this.releaseResetBtn();
            this.releaseSettingBtn();
            this.closeSettingMenu();
            stage.removeChild(this.deb_mc);
            return;
        }// end function

        public function clearMainItem() : void
        {
            return;
        }// end function

        public function initMainItem() : void
        {
            this.Ins_Item_Setting.visible = false;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Ins_Item_Explain.Ins_Card_Field.gotoAndStop(this.game_mode_status[0].label);
            this.Ins_Item_Explain.Ins_Rule.visible = true;
            return;
        }// end function

        public function resetMainItem() : void
        {
            return;
        }// end function

        public function initGame() : void
        {
            var _loc_1:* = 0;
            this.Ins_Item_Setting.visible = false;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.card_type = this.setting_status[1].list[1];
            if (this.setting_status[1].list[2] == 0)
            {
                this.card_number_flag = true;
            }
            else
            {
                this.card_number_flag = false;
            }
            if (this.setting_status[1].list[3] < 3)
            {
                this.random_card_flag = false;
                this.play_card = this.setting_status[1].list[3];
            }
            else
            {
                this.random_card_flag = true;
                if (this.random_card_flag == true)
                {
                    this.play_card = 0;
                }
            }
            if (this.setting_status[1].list[5] == 0)
            {
                this.card_click_flag = false;
            }
            else
            {
                this.card_click_flag = true;
            }
            if (this.setting_status[1].list[4] == 0)
            {
                this.Ins_Item_Explain.Ins_AnsBox.visible = true;
                this.answer_disp_flag = true;
            }
            else
            {
                this.Ins_Item_Explain.Ins_AnsBox.visible = false;
                this.answer_disp_flag = false;
            }
            _loc_1 = this.setting_status[1].list[6];
            this.answer_time = this.setting_status[1].ans_time[_loc_1] * 30;
            _loc_1 = this.setting_status[1].list[7];
            this.answer_disp_time = this.setting_status[1].disp_time[_loc_1] * 30;
            this.quest_counter = 0;
            this.card_counter = 0;
            this.shuffleCard();
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Next_Btn.visible = false;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.Ins_Item_Explain.Ins_Card_Field.gotoAndStop(this.game_mode_status[this.play_card].label);
            this.Ins_Item_Explain.Ins_AnsBox.Ins_Ans.text = "";
            this.Ins_Item_Explain.Ins_AnsBox.Ins_AnsWaku.gotoAndStop("off");
            this.Ins_Item_Explain.Ins_Quest.text = this.quest_counter + 1;
            this.setCardStatus(this.play_card, 1, false, "off", 0);
            this.setCardStatus(this.play_card, 2, false, "off", 0);
            this.setCardStatus(this.play_card, 3, false, "off", 0);
            this.setCardStatus(this.play_card, 4, false, "off", 0);
            this.setCardBackStatus(this.play_card, 1, false, "stay");
            this.setCardBackStatus(this.play_card, 2, false, "stay");
            this.setCardBackStatus(this.play_card, 3, false, "stay");
            this.setCardBackStatus(this.play_card, 4, false, "stay");
            this.Ins_Item_Explain.Ins_CardNum1.visible = false;
            this.Ins_Item_Explain.Ins_CardNum2.visible = false;
            this.Ins_Item_Explain.Ins_CardNum3.visible = false;
            this.Ins_Item_Explain.Ins_CardNum4.visible = false;
            this.game_index = 0;
            this.game_timer = 0;
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
                    if (this.getStartBtn() == true)
                    {
                        switch(this.play_card)
                        {
                            case 0:
                            {
                                this.setCardBackStatus(0, 1, true, "in");
                                this.setCardBackStatus(0, 2, true, "in");
                                this.setCardBackStatus(0, 3, false, "in");
                                this.setCardBackStatus(0, 4, false, "in");
                                break;
                            }
                            case 1:
                            {
                                this.setCardBackStatus(1, 1, true, "in");
                                this.setCardBackStatus(1, 2, true, "in");
                                this.setCardBackStatus(1, 3, true, "in");
                                this.setCardBackStatus(1, 4, false, "in");
                                break;
                            }
                            case 2:
                            {
                                this.setCardBackStatus(2, 1, true, "in");
                                this.setCardBackStatus(2, 2, true, "in");
                                this.setCardBackStatus(2, 3, true, "in");
                                this.setCardBackStatus(2, 4, true, "in");
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        this.Ins_Item_Explain.Ins_Rule.visible = false;
                        this.setStartBtn(false);
                        this.game_timer = 0;
                        this.game_index = 1;
                    }
                    break;
                }
                case 1:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.game_timer + 1;
                    _loc_3.game_timer = _loc_4;
                    if (this.game_timer > 15)
                    {
                        if (this.card_click_flag == true)
                        {
                            this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                            this.Ins_Item_Control.Ins_Next_Btn.visible = true;
                            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                        }
                        else
                        {
                            this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                            this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                            this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                        }
                        this.game_timer = 0;
                        this.game_index = 10;
                    }
                    break;
                }
                case 10:
                {
                    this.Ins_Item_Explain.Ins_AnsBox.Ins_Ans.text = "";
                    this.Ins_Item_Explain.Ins_Quest.text = this.quest_counter + 1;
                    this.Ins_Item_Explain.Ins_Card_Field.gotoAndStop(this.game_mode_status[this.play_card].label);
                    this.card_id[0] = 0;
                    this.card_id[1] = 0;
                    this.card_id[2] = 0;
                    this.card_id[3] = 0;
                    switch(this.play_card)
                    {
                        case 0:
                        {
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[0] = this.card_box[this.card_counter++];
                            this.setCardStatus(0, 1, true, "off", (this.card_id[0] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[1] = this.card_box[this.card_counter++];
                            this.setCardStatus(0, 2, true, "off", (this.card_id[1] + 1) + this.card_type * 40);
                            this.setCardStatus(0, 3, false, "off", 0);
                            this.setCardStatus(0, 4, false, "off", 0);
                            this.setCardBackStatus(0, 1, false, "stay");
                            this.setCardBackStatus(0, 2, false, "stay");
                            this.setCardBackStatus(0, 3, false, "stay");
                            this.setCardBackStatus(0, 4, false, "stay");
                            break;
                        }
                        case 1:
                        {
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[0] = this.card_box[this.card_counter++];
                            this.setCardStatus(1, 1, true, "off", (this.card_id[0] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[1] = this.card_box[this.card_counter++];
                            this.setCardStatus(1, 2, true, "off", (this.card_id[1] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[2] = this.card_box[this.card_counter++];
                            this.setCardStatus(1, 3, true, "off", (this.card_id[2] + 1) + this.card_type * 40);
                            this.setCardStatus(1, 4, false, "off", 0);
                            this.setCardBackStatus(1, 1, false, "stay");
                            this.setCardBackStatus(1, 2, false, "stay");
                            this.setCardBackStatus(1, 3, false, "stay");
                            this.setCardBackStatus(1, 4, false, "stay");
                            break;
                        }
                        case 2:
                        {
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[0] = this.card_box[this.card_counter++];
                            this.setCardStatus(2, 1, true, "off", (this.card_id[0] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[1] = this.card_box[this.card_counter++];
                            this.setCardStatus(2, 2, true, "off", (this.card_id[1] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[2] = this.card_box[this.card_counter++];
                            this.setCardStatus(2, 3, true, "off", (this.card_id[2] + 1) + this.card_type * 40);
                            var _loc_3:* = this;
                            _loc_3.card_counter = this.card_counter + 1;
                            this.card_id[3] = this.card_box[this.card_counter++];
                            this.setCardStatus(2, 4, true, "off", (this.card_id[3] + 1) + this.card_type * 40);
                            this.setCardBackStatus(2, 1, false, "stay");
                            this.setCardBackStatus(2, 2, false, "stay");
                            this.setCardBackStatus(2, 3, false, "stay");
                            this.setCardBackStatus(2, 4, false, "stay");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    this.game_timer = 0;
                    this.game_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getNextBtn() == true)
                    {
                        switch(this.play_card)
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
                            default:
                            {
                                break;
                            }
                        }
                    }
                    if (this.game_timer > this._FR_CARD_OPEN)
                    {
                        switch(this.play_card)
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
                            default:
                            {
                                break;
                            }
                        }
                    }
                    break;
                }
                case 21:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.game_timer + 1;
                    _loc_3.game_timer = _loc_4;
                    if (this.game_timer > 15)
                    {
                        if (this.card_type == 0 && this.card_number_flag == true)
                        {
                            this.dispCardNum(this.play_card, true);
                        }
                        this.game_timer = 0;
                        this.game_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    if (this.card_click_flag == true)
                    {
                        if (this.answer_disp_flag == true)
                        {
                            if (this.getNextBtn() == true)
                            {
                                this.Ins_Item_Explain.Ins_AnsBox.Ins_AnsWaku.gotoAndStop("on");
                                this.setNextBtn(false);
                                this.game_timer = 0;
                                this.game_index = 40;
                            }
                        }
                        else
                        {
                            this.Ins_Item_Explain.Ins_AnsBox.Ins_AnsWaku.gotoAndStop("on");
                            this.setNextBtn(false);
                            this.game_timer = 0;
                            this.game_index = 40;
                        }
                    }
                    else
                    {
                        this.countAutoTimer();
                        if (this.game_timer > this.answer_time)
                        {
                            this.Ins_Item_Explain.Ins_AnsBox.Ins_AnsWaku.gotoAndStop("on");
                            this.game_timer = 0;
                            this.game_index = 40;
                        }
                    }
                    break;
                }
                case 40:
                {
                    if (this.answer_disp_flag == true)
                    {
                        switch(this.play_card)
                        {
                            case 0:
                            {
                                _loc_2 = this.card_status[this.card_id[0]].num + this.card_status[this.card_id[1]].num;
                                break;
                            }
                            case 1:
                            {
                                _loc_2 = this.card_status[this.card_id[0]].num + this.card_status[this.card_id[1]].num + this.card_status[this.card_id[2]].num;
                                break;
                            }
                            case 2:
                            {
                                _loc_2 = this.card_status[this.card_id[0]].num + this.card_status[this.card_id[1]].num + this.card_status[this.card_id[2]].num + this.card_status[this.card_id[3]].num;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        this.Ins_Item_Explain.Ins_AnsBox.Ins_Ans.text = _loc_2;
                    }
                    this.game_timer = 0;
                    this.game_index = 50;
                    break;
                }
                case 50:
                {
                    if (this.getNextBtn() == true)
                    {
                        switch(this.play_card)
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
                            default:
                            {
                                break;
                            }
                        }
                    }
                    if (this.game_timer > this.answer_disp_time)
                    {
                        switch(this.play_card)
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
                            default:
                            {
                                break;
                            }
                        }
                    }
                    break;
                }
                case 51:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.game_timer + 1;
                    _loc_3.game_timer = _loc_4;
                    if (this.game_timer > 15)
                    {
                        if (this.card_type == 0 && this.card_number_flag == true)
                        {
                            this.dispCardNum(this.play_card, false);
                        }
                        var _loc_3:* = this;
                        var _loc_4:* = this.quest_counter + 1;
                        _loc_3.quest_counter = _loc_4;
                        if (this.quest_counter < this.quest_num)
                        {
                            if (this.random_card_flag == true)
                            {
                                this.play_card = Math.floor(Math.random() * 3);
                            }
                            this.game_timer = 0;
                            this.game_index = 10;
                        }
                        else
                        {
                            _loc_1 = 1;
                            this.game_timer = 0;
                            this.game_index = 99;
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
            return _loc_1;
        }// end function

        public function shuffleCard() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.card_status.length)
            {
                
                this.card_box[_loc_1] = _loc_1;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.card_status.length)
            {
                
                _loc_2 = Math.floor(Math.random() * this.card_status.length);
                if (_loc_1 != _loc_2)
                {
                    _loc_3 = this.card_box[_loc_1];
                    this.card_box[_loc_1] = this.card_box[_loc_2];
                    this.card_box[_loc_2] = _loc_3;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function countAutoTimer() : void
        {
            if (this.pause_flag == false)
            {
                if (this.getStopBtn() == true)
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.setStopBtn(false);
                    this.pause_flag = true;
                }
                else
                {
                    var _loc_1:* = this;
                    var _loc_2:* = this.game_timer + 1;
                    _loc_1.game_timer = _loc_2;
                }
            }
            else if (this.getStartBtn() == true)
            {
                this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                this.Ins_Item_Control.Ins_Next_Btn.visible = false;
                this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                this.setStartBtn(false);
                this.pause_flag = false;
            }
            return;
        }// end function

        public function setCardStatus(param1:uint, param2:uint, param3:Boolean, param4:String, param5:uint) : void
        {
            switch(param2)
            {
                case 1:
                {
                    this.Ins_Item_Explain.Ins_Card1.visible = param3;
                    this.Ins_Item_Explain.Ins_Card1.x = this.game_mode_status[param1].card1_pos[0];
                    this.Ins_Item_Explain.Ins_Card1.y = this.game_mode_status[param1].card1_pos[1];
                    this.Ins_Item_Explain.Ins_Card1.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_Card1.scaleY = this.Ins_Item_Explain.Ins_Card1.scaleX;
                    switch(param4)
                    {
                        case "off":
                        case "mark":
                        {
                            this.Ins_Item_Explain.Ins_Card1.gotoAndStop(param4);
                            break;
                        }
                        case "open":
                        case "close":
                        {
                            this.Ins_Item_Explain.Ins_Card1.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (param5 > 0)
                    {
                        this.Ins_Item_Explain.Ins_Card1.Ins_Mark.gotoAndStop(param5);
                    }
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_Card2.visible = param3;
                    this.Ins_Item_Explain.Ins_Card2.x = this.game_mode_status[param1].card2_pos[0];
                    this.Ins_Item_Explain.Ins_Card2.y = this.game_mode_status[param1].card2_pos[1];
                    this.Ins_Item_Explain.Ins_Card2.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_Card2.scaleY = this.Ins_Item_Explain.Ins_Card2.scaleX;
                    switch(param4)
                    {
                        case "off":
                        case "mark":
                        {
                            this.Ins_Item_Explain.Ins_Card2.gotoAndStop(param4);
                            break;
                        }
                        case "open":
                        case "close":
                        {
                            this.Ins_Item_Explain.Ins_Card2.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (param5 > 0)
                    {
                        this.Ins_Item_Explain.Ins_Card2.Ins_Mark.gotoAndStop(param5);
                    }
                    break;
                }
                case 3:
                {
                    this.Ins_Item_Explain.Ins_Card3.visible = param3;
                    this.Ins_Item_Explain.Ins_Card3.x = this.game_mode_status[param1].card3_pos[0];
                    this.Ins_Item_Explain.Ins_Card3.y = this.game_mode_status[param1].card3_pos[1];
                    this.Ins_Item_Explain.Ins_Card3.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_Card3.scaleY = this.Ins_Item_Explain.Ins_Card3.scaleX;
                    switch(param4)
                    {
                        case "off":
                        case "mark":
                        {
                            this.Ins_Item_Explain.Ins_Card3.gotoAndStop(param4);
                            break;
                        }
                        case "open":
                        case "close":
                        {
                            this.Ins_Item_Explain.Ins_Card3.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (param5 > 0)
                    {
                        this.Ins_Item_Explain.Ins_Card3.Ins_Mark.gotoAndStop(param5);
                    }
                    break;
                }
                case 4:
                {
                    this.Ins_Item_Explain.Ins_Card4.visible = param3;
                    this.Ins_Item_Explain.Ins_Card4.x = this.game_mode_status[param1].card4_pos[0];
                    this.Ins_Item_Explain.Ins_Card4.y = this.game_mode_status[param1].card4_pos[1];
                    this.Ins_Item_Explain.Ins_Card4.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_Card4.scaleY = this.Ins_Item_Explain.Ins_Card4.scaleX;
                    switch(param4)
                    {
                        case "off":
                        case "mark":
                        {
                            this.Ins_Item_Explain.Ins_Card4.gotoAndStop(param4);
                            break;
                        }
                        case "open":
                        case "close":
                        {
                            this.Ins_Item_Explain.Ins_Card4.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (param5 > 0)
                    {
                        this.Ins_Item_Explain.Ins_Card4.Ins_Mark.gotoAndStop(param5);
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

        public function setCardBackStatus(param1:uint, param2:uint, param3:Boolean, param4:String) : void
        {
            switch(param2)
            {
                case 1:
                {
                    this.Ins_Item_Explain.Ins_CardBack1.visible = param3;
                    this.Ins_Item_Explain.Ins_CardBack1.x = this.game_mode_status[param1].card1_pos[0];
                    this.Ins_Item_Explain.Ins_CardBack1.y = this.game_mode_status[param1].card1_pos[1];
                    this.Ins_Item_Explain.Ins_CardBack1.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_CardBack1.scaleY = this.Ins_Item_Explain.Ins_CardBack1.scaleX;
                    switch(param4)
                    {
                        case "stay":
                        {
                            this.Ins_Item_Explain.Ins_CardBack1.gotoAndStop(param4);
                            break;
                        }
                        case "in":
                        {
                            this.Ins_Item_Explain.Ins_CardBack1.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_CardBack2.visible = param3;
                    this.Ins_Item_Explain.Ins_CardBack2.x = this.game_mode_status[param1].card2_pos[0];
                    this.Ins_Item_Explain.Ins_CardBack2.y = this.game_mode_status[param1].card2_pos[1];
                    this.Ins_Item_Explain.Ins_CardBack2.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_CardBack2.scaleY = this.Ins_Item_Explain.Ins_CardBack1.scaleX;
                    switch(param4)
                    {
                        case "stay":
                        {
                            this.Ins_Item_Explain.Ins_CardBack2.gotoAndStop(param4);
                            break;
                        }
                        case "in":
                        {
                            this.Ins_Item_Explain.Ins_CardBack2.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 3:
                {
                    this.Ins_Item_Explain.Ins_CardBack3.visible = param3;
                    this.Ins_Item_Explain.Ins_CardBack3.x = this.game_mode_status[param1].card3_pos[0];
                    this.Ins_Item_Explain.Ins_CardBack3.y = this.game_mode_status[param1].card3_pos[1];
                    this.Ins_Item_Explain.Ins_CardBack3.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_CardBack3.scaleY = this.Ins_Item_Explain.Ins_CardBack1.scaleX;
                    switch(param4)
                    {
                        case "stay":
                        {
                            this.Ins_Item_Explain.Ins_CardBack3.gotoAndStop(param4);
                            break;
                        }
                        case "in":
                        {
                            this.Ins_Item_Explain.Ins_CardBack3.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 4:
                {
                    this.Ins_Item_Explain.Ins_CardBack4.visible = param3;
                    this.Ins_Item_Explain.Ins_CardBack4.x = this.game_mode_status[param1].card4_pos[0];
                    this.Ins_Item_Explain.Ins_CardBack4.y = this.game_mode_status[param1].card4_pos[1];
                    this.Ins_Item_Explain.Ins_CardBack4.scaleX = this.game_mode_status[param1].card_scale;
                    this.Ins_Item_Explain.Ins_CardBack4.scaleY = this.Ins_Item_Explain.Ins_CardBack1.scaleX;
                    switch(param4)
                    {
                        case "stay":
                        {
                            this.Ins_Item_Explain.Ins_CardBack4.gotoAndStop(param4);
                            break;
                        }
                        case "in":
                        {
                            this.Ins_Item_Explain.Ins_CardBack4.gotoAndPlay(param4);
                            break;
                        }
                        default:
                        {
                            break;
                        }
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

        public function dispCardNum(param1:uint, param2:Boolean) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.Ins_Item_Explain.Ins_CardNum1.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum1.gotoAndStop((this.card_id[0] + 1));
                    this.Ins_Item_Explain.Ins_CardNum1.x = this.game_mode_status[param1].card1_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum1.y = this.game_mode_status[param1].card1_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum2.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum2.gotoAndStop((this.card_id[1] + 1));
                    this.Ins_Item_Explain.Ins_CardNum2.x = this.game_mode_status[param1].card2_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum2.y = this.game_mode_status[param1].card2_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum3.visible = false;
                    this.Ins_Item_Explain.Ins_CardNum4.visible = false;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Explain.Ins_CardNum1.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum1.gotoAndStop((this.card_id[0] + 1));
                    this.Ins_Item_Explain.Ins_CardNum1.x = this.game_mode_status[param1].card1_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum1.y = this.game_mode_status[param1].card1_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum2.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum2.gotoAndStop((this.card_id[1] + 1));
                    this.Ins_Item_Explain.Ins_CardNum2.x = this.game_mode_status[param1].card2_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum2.y = this.game_mode_status[param1].card2_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum3.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum3.gotoAndStop((this.card_id[2] + 1));
                    this.Ins_Item_Explain.Ins_CardNum3.x = this.game_mode_status[param1].card3_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum3.y = this.game_mode_status[param1].card3_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum4.visible = false;
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_CardNum1.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum1.gotoAndStop((this.card_id[0] + 1));
                    this.Ins_Item_Explain.Ins_CardNum1.x = this.game_mode_status[param1].card1_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum1.y = this.game_mode_status[param1].card1_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum2.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum2.gotoAndStop((this.card_id[1] + 1));
                    this.Ins_Item_Explain.Ins_CardNum2.x = this.game_mode_status[param1].card2_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum2.y = this.game_mode_status[param1].card2_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum3.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum3.gotoAndStop((this.card_id[2] + 1));
                    this.Ins_Item_Explain.Ins_CardNum3.x = this.game_mode_status[param1].card3_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum3.y = this.game_mode_status[param1].card3_pos[1] + this._HELP_NUM_OFSY;
                    this.Ins_Item_Explain.Ins_CardNum4.visible = param2;
                    this.Ins_Item_Explain.Ins_CardNum4.gotoAndStop((this.card_id[3] + 1));
                    this.Ins_Item_Explain.Ins_CardNum4.x = this.game_mode_status[param1].card4_pos[0];
                    this.Ins_Item_Explain.Ins_CardNum4.y = this.game_mode_status[param1].card4_pos[1] + this._HELP_NUM_OFSY;
                    break;
                }
                default:
                {
                    break;
                }
            }
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

        public function entryStopBtn() : void
        {
            this.Ins_Item_Control.Ins_Stop_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStopBtn);
            return;
        }// end function

        public function releaseStopBtn() : void
        {
            this.Ins_Item_Control.Ins_Next_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStopBtn);
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

        public function initSettingMenu() : void
        {
            this.entrySettingRetBtn();
            this.entryList1_1_Btn();
            this.entryList1_2_Btn();
            this.entryList2_1_Btn();
            this.entryList2_2_Btn();
            this.entryList3_1_Btn();
            this.entryList3_2_Btn();
            this.entryList3_3_Btn();
            this.entryList3_4_Btn();
            this.entryList4_1_Btn();
            this.entryList4_2_Btn();
            this.entryList5_1_Btn();
            this.entryList5_2_Btn();
            this.entryList6_2_Bar();
            this.entryList7_2_Bar();
            return;
        }// end function

        public function closeSettingMenu() : void
        {
            this.releaseSettingRetBtn();
            this.releaseList1_1_Btn();
            this.releaseList1_2_Btn();
            this.releaseList2_1_Btn();
            this.releaseList2_2_Btn();
            this.releaseList3_1_Btn();
            this.releaseList3_2_Btn();
            this.releaseList3_3_Btn();
            this.releaseList3_4_Btn();
            this.releaseList4_1_Btn();
            this.releaseList4_2_Btn();
            this.releaseList5_1_Btn();
            this.releaseList5_2_Btn();
            this.releaseList6_2_Bar();
            this.releaseList7_2_Bar();
            return;
        }// end function

        public function dispSettingMenu(param1:uint) : void
        {
            var _loc_2:* = 0;
            this.Ins_Item_Setting.visible = true;
            this.Ins_Item_Control.visible = false;
            this.Ins_Item_Explain.visible = false;
            this.Ins_Item_Setting.Ins_List1_Cover.visible = false;
            switch(this.setting_status[param1].list[1])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_1.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_2.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.setting_status[param1].list[1])
            {
                case 0:
                {
                    this.setting_status[param1].list[2] = 0;
                    this.Ins_Item_Setting.Ins_List2_Cover.visible = false;
                    break;
                }
                case 1:
                {
                    this.setting_status[param1].list[2] = 1;
                    this.Ins_Item_Setting.Ins_List2_Cover.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.setting_status[param1].list[2])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M2.x = this.Ins_Item_Setting.Ins_List2_1.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M2.y = this.Ins_Item_Setting.Ins_List2_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M2.x = this.Ins_Item_Setting.Ins_List2_2.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M2.y = this.Ins_Item_Setting.Ins_List2_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.Ins_Item_Setting.Ins_List3_Cover.visible = false;
            switch(this.setting_status[param1].list[3])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_1.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_2.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_2.y;
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_3.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_3.y;
                    break;
                }
                case 3:
                {
                    this.Ins_Item_Setting.Ins_M4.x = this.Ins_Item_Setting.Ins_List3_4.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M4.y = this.Ins_Item_Setting.Ins_List3_4.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.Ins_Item_Setting.Ins_List4_Cover.visible = false;
            switch(this.setting_status[param1].list[4])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M4.x = this.Ins_Item_Setting.Ins_List4_1.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M4.y = this.Ins_Item_Setting.Ins_List4_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M4.x = this.Ins_Item_Setting.Ins_List4_2.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M4.y = this.Ins_Item_Setting.Ins_List4_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.setting_status[param1].list[4])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_List5_Cover.visible = false;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_List5_Cover.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.setting_status[param1].list[5])
            {
                case 0:
                {
                    this.Ins_Item_Setting.Ins_M5.x = this.Ins_Item_Setting.Ins_List5_1.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M5.y = this.Ins_Item_Setting.Ins_List5_1.y;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_M5.x = this.Ins_Item_Setting.Ins_List5_2.x + this._LIST_MARK_OFSX;
                    this.Ins_Item_Setting.Ins_M5.y = this.Ins_Item_Setting.Ins_List5_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.setting_status[param1].list[5])
            {
                case 0:
                {
                    if (this.setting_status[param1].list[4] == 0)
                    {
                        this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                        this.Ins_Item_Setting.Ins_List7_Cover.visible = false;
                    }
                    else
                    {
                        this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                        this.Ins_Item_Setting.Ins_List7_Cover.visible = true;
                    }
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Setting.Ins_List6_Cover.visible = true;
                    this.Ins_Item_Setting.Ins_List7_Cover.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2 = this.setting_status[param1].list[6];
            this.Ins_Item_Setting.Ins_List6_1.text = String(this.setting_status[param1].ans_time[_loc_2]) + "秒";
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x = this.setting_bar_pos[_loc_2];
            _loc_2 = this.setting_status[param1].list[7];
            this.Ins_Item_Setting.Ins_List7_1.text = String(this.setting_status[param1].disp_time[_loc_2]) + "秒";
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x = this.setting_bar_pos[_loc_2];
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
            this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_1.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_1.y;
            this.Ins_Item_Setting.Ins_List2_Cover.visible = false;
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
            this.Ins_Item_Setting.Ins_M1.x = this.Ins_Item_Setting.Ins_List1_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M1.y = this.Ins_Item_Setting.Ins_List1_2.y;
            this.setting_status[1].list[2] = 1;
            this.Ins_Item_Setting.Ins_M2.x = this.Ins_Item_Setting.Ins_List2_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M2.y = this.Ins_Item_Setting.Ins_List2_2.y;
            this.Ins_Item_Setting.Ins_List2_Cover.visible = true;
            return;
        }// end function

        public function entryList2_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List2_1.addEventListener(MouseEvent.MOUSE_UP, this.downList2_1_Btn);
            return;
        }// end function

        public function releaseList2_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List2_1.removeEventListener(MouseEvent.MOUSE_UP, this.downList2_1_Btn);
            return;
        }// end function

        public function downList2_1_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[2] = 0;
            this.Ins_Item_Setting.Ins_M2.x = this.Ins_Item_Setting.Ins_List2_1.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M2.y = this.Ins_Item_Setting.Ins_List2_1.y;
            return;
        }// end function

        public function entryList2_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List2_2.addEventListener(MouseEvent.MOUSE_UP, this.downList2_2_Btn);
            return;
        }// end function

        public function releaseList2_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List2_2.removeEventListener(MouseEvent.MOUSE_UP, this.downList2_2_Btn);
            return;
        }// end function

        public function downList2_2_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[2] = 1;
            this.Ins_Item_Setting.Ins_M2.x = this.Ins_Item_Setting.Ins_List2_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M2.y = this.Ins_Item_Setting.Ins_List2_2.y;
            return;
        }// end function

        public function entryList3_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_1.addEventListener(MouseEvent.MOUSE_UP, this.downList3_1_Btn);
            return;
        }// end function

        public function releaseList3_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_1.removeEventListener(MouseEvent.MOUSE_UP, this.downList3_1_Btn);
            return;
        }// end function

        public function downList3_1_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[3] = 0;
            this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_1.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_1.y;
            return;
        }// end function

        public function entryList3_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_2.addEventListener(MouseEvent.MOUSE_UP, this.downList3_2_Btn);
            return;
        }// end function

        public function releaseList3_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_2.removeEventListener(MouseEvent.MOUSE_UP, this.downList3_2_Btn);
            return;
        }// end function

        public function downList3_2_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[3] = 1;
            this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_2.y;
            return;
        }// end function

        public function entryList3_3_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_3.addEventListener(MouseEvent.MOUSE_UP, this.downList3_3_Btn);
            return;
        }// end function

        public function releaseList3_3_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_3.removeEventListener(MouseEvent.MOUSE_UP, this.downList3_3_Btn);
            return;
        }// end function

        public function downList3_3_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[3] = 2;
            this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_3.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_3.y;
            return;
        }// end function

        public function entryList3_4_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_4.addEventListener(MouseEvent.MOUSE_UP, this.downList3_4_Btn);
            return;
        }// end function

        public function releaseList3_4_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List3_4.removeEventListener(MouseEvent.MOUSE_UP, this.downList3_4_Btn);
            return;
        }// end function

        public function downList3_4_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[3] = 3;
            this.Ins_Item_Setting.Ins_M3.x = this.Ins_Item_Setting.Ins_List3_4.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M3.y = this.Ins_Item_Setting.Ins_List3_4.y;
            return;
        }// end function

        public function entryList4_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List4_1.addEventListener(MouseEvent.MOUSE_UP, this.downList4_1_Btn);
            return;
        }// end function

        public function releaseList4_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List4_1.removeEventListener(MouseEvent.MOUSE_UP, this.downList4_1_Btn);
            return;
        }// end function

        public function downList4_1_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[4] = 0;
            this.Ins_Item_Setting.Ins_M4.x = this.Ins_Item_Setting.Ins_List4_1.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M4.y = this.Ins_Item_Setting.Ins_List4_1.y;
            this.Ins_Item_Setting.Ins_List5_Cover.visible = false;
            if (this.setting_status[1].list[5] == 0)
            {
                this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                this.Ins_Item_Setting.Ins_List7_Cover.visible = false;
            }
            return;
        }// end function

        public function entryList4_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List4_2.addEventListener(MouseEvent.MOUSE_UP, this.downList4_2_Btn);
            return;
        }// end function

        public function releaseList4_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List4_2.removeEventListener(MouseEvent.MOUSE_UP, this.downList4_2_Btn);
            return;
        }// end function

        public function downList4_2_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[4] = 1;
            this.Ins_Item_Setting.Ins_M4.x = this.Ins_Item_Setting.Ins_List4_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M4.y = this.Ins_Item_Setting.Ins_List4_2.y;
            this.Ins_Item_Setting.Ins_List5_Cover.visible = false;
            if (this.setting_status[1].list[5] == 0)
            {
                this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                this.Ins_Item_Setting.Ins_List7_Cover.visible = false;
            }
            return;
        }// end function

        public function entryList5_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List5_1.addEventListener(MouseEvent.MOUSE_UP, this.downList5_1_Btn);
            return;
        }// end function

        public function releaseList5_1_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List5_1.removeEventListener(MouseEvent.MOUSE_UP, this.downList5_1_Btn);
            return;
        }// end function

        public function downList5_1_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[5] = 0;
            this.Ins_Item_Setting.Ins_M5.x = this.Ins_Item_Setting.Ins_List5_1.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M5.y = this.Ins_Item_Setting.Ins_List5_1.y;
            if (this.setting_status[1].list[4] == 0)
            {
                this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                this.Ins_Item_Setting.Ins_List7_Cover.visible = false;
            }
            else
            {
                this.Ins_Item_Setting.Ins_List6_Cover.visible = false;
                this.Ins_Item_Setting.Ins_List7_Cover.visible = true;
            }
            return;
        }// end function

        public function entryList5_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List5_2.addEventListener(MouseEvent.MOUSE_UP, this.downList5_2_Btn);
            return;
        }// end function

        public function releaseList5_2_Btn() : void
        {
            this.Ins_Item_Setting.Ins_List5_2.removeEventListener(MouseEvent.MOUSE_UP, this.downList5_2_Btn);
            return;
        }// end function

        public function downList5_2_Btn(event:MouseEvent) : void
        {
            this.setting_status[1].list[5] = 1;
            this.Ins_Item_Setting.Ins_M5.x = this.Ins_Item_Setting.Ins_List5_2.x + this._LIST_MARK_OFSX;
            this.Ins_Item_Setting.Ins_M5.y = this.Ins_Item_Setting.Ins_List5_2.y;
            this.Ins_Item_Setting.Ins_List6_Cover.visible = true;
            this.Ins_Item_Setting.Ins_List7_Cover.visible = true;
            return;
        }// end function

        public function entryList6_2_Bar() : void
        {
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_DOWN, this.downList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_UP, this.outList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_OUT, this.outList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_MOVE, this.moveList6_2_Bar);
            this.list6_bar_flag = false;
            return;
        }// end function

        public function releaseList6_2_Bar() : void
        {
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_DOWN, this.downList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_UP, this.outList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_OUT, this.outList6_2_Bar);
            this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveList6_2_Bar);
            return;
        }// end function

        public function downList6_2_Bar(event:MouseEvent) : void
        {
            this.list6_bar_flag = true;
            return;
        }// end function

        public function outList6_2_Bar(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.list6_bar_flag == true)
            {
                _loc_2 = Math.round((this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x + this._SETTING_BAR_R) * this._SETTING_BAR_UNIT / 100);
                this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x = this.setting_bar_pos[_loc_2];
                this.setting_status[1].list[6] = _loc_2;
                this.Ins_Item_Setting.Ins_List6_1.text = String(this.setting_status[1].ans_time[_loc_2]) + "秒";
            }
            this.list6_bar_flag = false;
            return;
        }// end function

        public function moveList6_2_Bar(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.list6_bar_flag == true)
            {
                this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x = this.Ins_Item_Setting.Ins_List6_2.mouseX;
                if (this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x < this._SETTING_BAR_L)
                {
                    this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x = this._SETTING_BAR_L;
                }
                else if (this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x > this._SETTING_BAR_R)
                {
                    this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x = this._SETTING_BAR_R;
                }
                _loc_2 = Math.round((this.Ins_Item_Setting.Ins_List6_2.Ins_Pin.x + this._SETTING_BAR_R) * this._SETTING_BAR_UNIT / 100);
                if (_loc_2 != this.setting_status[1].list[6])
                {
                    this.Ins_Item_Setting.Ins_List6_1.text = String(this.setting_status[1].ans_time[_loc_2]) + "秒";
                }
            }
            return;
        }// end function

        public function entryList7_2_Bar() : void
        {
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_DOWN, this.downList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_UP, this.outList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_OUT, this.outList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.addEventListener(MouseEvent.MOUSE_MOVE, this.moveList7_2_Bar);
            this.list6_bar_flag = false;
            return;
        }// end function

        public function releaseList7_2_Bar() : void
        {
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_DOWN, this.downList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_UP, this.outList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_OUT, this.outList7_2_Bar);
            this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveList7_2_Bar);
            return;
        }// end function

        public function downList7_2_Bar(event:MouseEvent) : void
        {
            this.list7_bar_flag = true;
            return;
        }// end function

        public function outList7_2_Bar(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.list7_bar_flag == true)
            {
                _loc_2 = Math.round((this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x + this._SETTING_BAR_R) * this._SETTING_BAR_UNIT / 100);
                this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x = this.setting_bar_pos[_loc_2];
                this.setting_status[1].list[7] = _loc_2;
                this.Ins_Item_Setting.Ins_List7_1.text = String(this.setting_status[1].disp_time[_loc_2]) + "秒";
            }
            this.list7_bar_flag = false;
            return;
        }// end function

        public function moveList7_2_Bar(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this.list7_bar_flag == true)
            {
                this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x = this.Ins_Item_Setting.Ins_List7_2.mouseX;
                if (this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x < this._SETTING_BAR_L)
                {
                    this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x = this._SETTING_BAR_L;
                }
                else if (this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x > this._SETTING_BAR_R)
                {
                    this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x = this._SETTING_BAR_R;
                }
                _loc_2 = Math.round((this.Ins_Item_Setting.Ins_List7_2.Ins_Pin.x + this._SETTING_BAR_R) * this._SETTING_BAR_UNIT / 100);
                if (_loc_2 != this.setting_status[1].list[7])
                {
                    this.Ins_Item_Setting.Ins_List7_1.text = String(this.setting_status[1].disp_time[_loc_2]) + "秒";
                }
            }
            return;
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
            this.reset_btn_flag = false;
            this.setting_btn_flag = false;
            this.pause_flag = false;
            this.random_card_flag = false;
            this.game_mode_status = [{no:0, label:"num2", card_num:2, card_scale:0.5, card1_pos:[-207, -10], card2_pos:[-3, -10], card3_pos:[0, 0], card4_pos:[0, 0]}, {no:1, label:"num3", card_num:3, card_scale:0.5, card1_pos:[-309, -10], card2_pos:[-105, -10], card3_pos:[99, -10], card4_pos:[0, 0]}, {no:2, label:"num4", card_num:4, card_scale:0.5, card1_pos:[-411, -10], card2_pos:[-207, -10], card3_pos:[-3, -10], card4_pos:[201, -10]}];
            this.card_status = [{no:0, ins:"", num:1}, {no:1, ins:"", num:2}, {no:2, ins:"", num:3}, {no:3, ins:"", num:4}, {no:4, ins:"", num:5}, {no:5, ins:"", num:6}, {no:6, ins:"", num:7}, {no:7, ins:"", num:8}, {no:8, ins:"", num:9}, {no:10, ins:"", num:10}, {no:11, ins:"", num:-1}, {no:12, ins:"", num:-2}, {no:13, ins:"", num:-3}, {no:14, ins:"", num:-4}, {no:15, ins:"", num:-5}, {no:16, ins:"", num:-6}, {no:17, ins:"", num:-7}, {no:18, ins:"", num:-8}, {no:19, ins:"", num:-9}, {no:20, ins:"", num:-10}, {no:21, ins:"", num:1}, {no:22, ins:"", num:2}, {no:23, ins:"", num:3}, {no:24, ins:"", num:4}, {no:25, ins:"", num:5}, {no:26, ins:"", num:6}, {no:27, ins:"", num:7}, {no:28, ins:"", num:8}, {no:29, ins:"", num:9}, {no:30, ins:"", num:10}, {no:31, ins:"", num:-1}, {no:32, ins:"", num:-2}, {no:33, ins:"", num:-3}, {no:34, ins:"", num:-4}, {no:35, ins:"", num:-5}, {no:36, ins:"", num:-6}, {no:37, ins:"", num:-7}, {no:38, ins:"", num:-8}, {no:39, ins:"", num:-9}, {no:40, ins:"", num:-10}];
            this.card_box = new Array(this.card_status.length);
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
            this.card_click_flag = false;
            this.card_number_flag = false;
            this.answer_disp_flag = true;
            this.card_type = 0;
            this.card_counter = 0;
            this.answer_time = 0;
            this.answer_disp_time = 0;
            this.card_id = [0, 0, 0, 0];
            this.play_card = 0;
            this.quest_num = 10;
            this.quest_counter = 0;
            this.game_index = 0;
            this.game_timer = 0;
            this.setting_status = [{list:[0, 0, 1, 0, 0, 1, 5, 5], ans_time:[0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], disp_time:[0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}, {list:[0, 0, 1, 0, 0, 1, 5, 5], ans_time:[0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], disp_time:[0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}];
            this.setting_bar_pos = [-250, -200, -150, -100, -50, 0, 50, 100, 150, 200, 250];
            this.setting_ret_flag = false;
            return;
        }// end function

    }
}
