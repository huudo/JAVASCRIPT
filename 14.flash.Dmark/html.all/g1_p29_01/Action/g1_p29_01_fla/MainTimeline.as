package g1_p29_01_fla
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
        public var man_index:uint;
        public var man_timer:uint;
        public var man_dir:int;
        public var man_base:int;
        public var man_move1:int;
        public var man_start:int;
        public var man_target:int;
        public var start_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var result_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var walk_btn_flag:Boolean;
        public const _BASE_SPEED_E:int = 4;
        public const _BASE_SPEED_W:int = -4;
        public const _START_POINT:uint = 9;
        public const _STEP1_DIR:int = 0;
        public const _STEP1_MOVE:uint = 6;
        public const _BASE_FRAME:uint = 60;
        public const _BASE_LEN:uint = 112;
        public const _ARROW_DISP_RX:int = 75;
        public const _ARROW_DISP_RY:int = -35;
        public const _ARROW_DISP_LX:int = -75;
        public const _ARROW_DISP_LY:int = -35;
        public var point_status:Array;
        public var num_table:Array;
        public var walk_act_table1:Array;
        public var walk_act_table2:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var dropbox1_flag:Boolean;
        public var dropbox1_open:Boolean;
        public var dropbox1_list:int;
        public const _DROPBOX1_LIST_MAX:int = 2;
        public const _DROPBOX1_LIST_SIZE:int = 56;
        public var dropbox1_list_value:Array;
        public var dropbox2_flag:Boolean;
        public var dropbox2_open:Boolean;
        public var dropbox2_list:int;
        public const _DROPBOX2_LIST_MAX:int = 7;
        public const _DROPBOX2_LIST_SIZE:int = 56;
        public var dropbox2_list_value:Array;

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
                    this.entryResultBtn();
                    this.entryResetBtn();
                    this.entryWalkBtn();
                    this.initDropBox1(this._STEP1_DIR, this.dropbox1_list_value);
                    this.initDropBox2(this._STEP1_MOVE, this.dropbox2_list_value);
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 9:
                {
                    this.resetMainItem();
                    this.setWalkBtn(false);
                    this.setStartBtn(false);
                    this.setStopBtn(false);
                    this.setResultBtn(false);
                    this.setResetBtn(false);
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                    }
                    else if (this.getDropBox1Btn() == true)
                    {
                        this.man_dir = this.getDropBox1ListNo();
                        if (this.man_dir == this._STEP1_DIR)
                        {
                            this.Ins_Item_Explain.Ins_Man.scaleX = 1;
                            this.Ins_Item_Explain.Ins_PerKm1.visible = true;
                            this.Ins_Item_Explain.Ins_PerKm2.visible = false;
                            this.Ins_Item_Control.Ins_Move.text = "(+4)×";
                            this.dispExpMoveMan(true, 1);
                        }
                        else
                        {
                            this.Ins_Item_Explain.Ins_Man.scaleX = -1;
                            this.Ins_Item_Explain.Ins_PerKm1.visible = false;
                            this.Ins_Item_Explain.Ins_PerKm2.visible = true;
                            this.Ins_Item_Control.Ins_Move.text = "(-4)×";
                            this.dispExpMoveMan(true, -1);
                        }
                        this.setDropBox1Btn(false);
                    }
                    else if (this.getDropBox2Btn() == true)
                    {
                        this.man_move1 = this.getDropBox2ListNo();
                        this.setDropBox2Btn(false);
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.man_dir = this.getDropBox1ListNo();
                        this.man_move1 = this.getDropBox2ListNo();
                        this.initMoveMan(this.man_dir, this.man_base, this.num_table[this.man_move1].num);
                        this.Ins_Item_Control.Ins_NotHit1.visible = true;
                        this.Ins_Item_Control.Ins_NotHit2.visible = true;
                        this.Ins_Item_Explain.Ins_Exp_Man.visible = false;
                        this.clearExplainAll();
                        this.dispActBtn(1);
                        this.setStartBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 20;
                    }
                    else if (this.getResultBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_NotHit1.visible = true;
                        this.Ins_Item_Control.Ins_NotHit2.visible = true;
                        this.setResultBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 40;
                    }
                    else if (this.getWalkBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_NotHit1.visible = true;
                        this.Ins_Item_Control.Ins_NotHit2.visible = true;
                        this.clearExplainAll();
                        this.dispExpMoveMan(false, 1);
                        this.setWalkBtn(false);
                        if (this.man_dir == this._STEP1_DIR)
                        {
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 50;
                        }
                        else
                        {
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 55;
                        }
                    }
                    break;
                }
                case 20:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.dispActBtn(0);
                        this.setResetBtn(false);
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        if (this.getStopBtn() == true)
                        {
                            this.dispActMan("stop");
                            this.dispActBtn(0);
                            this.setStopBtn(false);
                            this.Main_action = 1;
                        }
                        else if (this.controlMoveMan() == true)
                        {
                            this.dispExplainResult(this.num_table[this.man_move1].time, this.num_table[this.man_move1].num);
                            this.dispActMan("stop");
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 80;
                        }
                    }
                    else if (this.Main_action == 1)
                    {
                        if (this.getStartBtn() == true)
                        {
                            this.dispActMan("play");
                            this.dispActBtn(1);
                            this.setStartBtn(false);
                            this.Main_action = 0;
                        }
                    }
                    break;
                }
                case 40:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.dispActBtn(0);
                        this.setResetBtn(false);
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        this.dispExpMoveManTarget(this.man_dir, 3, this.man_move1);
                        this.Main_action = 1;
                    }
                    else
                    {
                        _loc_2 = Math.abs(this.num_table[this.man_move1].num) * 30;
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        if (this.Main_timer < _loc_2)
                        {
                            if (this.man_dir == this._STEP1_DIR)
                            {
                                if (this.num_table[this.man_move1].num > 0)
                                {
                                    this.dispExpMoveArrow1(true, 1, this._BASE_LEN * this.num_table[this.man_move1].num / _loc_2 * this.Main_timer);
                                }
                                else
                                {
                                    this.dispExpMoveArrow1(true, -1, this._BASE_LEN * this.num_table[this.man_move1].num / _loc_2 * this.Main_timer);
                                }
                            }
                            else if (this.num_table[this.man_move1].num > 0)
                            {
                                this.dispExpMoveArrow2(true, -1, this._BASE_LEN * this.num_table[this.man_move1].num / _loc_2 * this.Main_timer);
                            }
                            else
                            {
                                this.dispExpMoveArrow2(true, 1, this._BASE_LEN * this.num_table[this.man_move1].num / _loc_2 * this.Main_timer);
                            }
                        }
                        else
                        {
                            if (this.man_dir == this._STEP1_DIR)
                            {
                                if (this.num_table[this.man_move1].num > 0)
                                {
                                    this.dispExpMoveArrow1(true, 1, this._BASE_LEN * this.num_table[this.man_move1].num);
                                    this.dispMoveResult1(this.num_table[this.man_move1].time, this.num_table[this.man_move1].num * this._BASE_SPEED_E);
                                }
                                else
                                {
                                    this.dispExpMoveArrow1(true, -1, this._BASE_LEN * this.num_table[this.man_move1].num);
                                    this.dispMoveResult2(this.num_table[this.man_move1].time, this.num_table[this.man_move1].num * this._BASE_SPEED_E);
                                }
                            }
                            else if (this.num_table[this.man_move1].num > 0)
                            {
                                this.dispExpMoveArrow2(true, -1, this._BASE_LEN * this.num_table[this.man_move1].num);
                                this.dispMoveResult2(this.num_table[this.man_move1].time, this.num_table[this.man_move1].num * this._BASE_SPEED_W);
                            }
                            else
                            {
                                this.dispExpMoveArrow2(true, 1, this._BASE_LEN * this.num_table[this.man_move1].num);
                                this.dispMoveResult1(this.num_table[this.man_move1].time, this.num_table[this.man_move1].num * this._BASE_SPEED_W);
                            }
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 80;
                        }
                    }
                    break;
                }
                case 50:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.dispActBtn(0);
                        this.setResetBtn(false);
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.visible = true;
                        this.dispActMan("walk");
                        this.Ins_Item_Explain.Ins_Man.x = -448;
                        this.Ins_Item_Explain.Ins_Man.y = 0;
                        this.Ins_Item_Explain.Ins_Man.scaleX = 1;
                        this.Main_action = 1;
                    }
                    else
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x + this._BASE_LEN / this._BASE_FRAME;
                        if (this.Ins_Item_Explain.Ins_Man.x > this.walk_act_table1[this.Main_action].pos)
                        {
                            this.dispWalkMoveMan(this.walk_act_table1[this.Main_action].ins, true, 1);
                            if (this.walk_act_table1[this.Main_action].no == 4)
                            {
                                this.Ins_Item_Explain.Ins_Now.visible = true;
                            }
                            var _loc_3:* = this;
                            var _loc_4:* = this.Main_action + 1;
                            _loc_3.Main_action = _loc_4;
                        }
                        if (this.Ins_Item_Explain.Ins_Man.x > 448)
                        {
                            this.dispActMan("off");
                            this.dispWalkMoveMan(this.walk_act_table1[4].ins, false, 1);
                            this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_base].dx;
                            this.Ins_Item_Explain.Ins_Man.y = 0;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 80;
                        }
                    }
                    break;
                }
                case 55:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.dispActBtn(0);
                        this.setResetBtn(false);
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.visible = true;
                        this.dispActMan("walk");
                        this.Ins_Item_Explain.Ins_Man.x = 448;
                        this.Ins_Item_Explain.Ins_Man.y = 0;
                        this.Ins_Item_Explain.Ins_Man.scaleX = -1;
                        this.Main_action = 1;
                    }
                    else
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x - this._BASE_LEN / this._BASE_FRAME;
                        if (this.Ins_Item_Explain.Ins_Man.x < this.walk_act_table2[this.Main_action].pos)
                        {
                            this.dispWalkMoveMan(this.walk_act_table2[this.Main_action].ins, true, -1);
                            if (this.walk_act_table2[this.Main_action].no == 4)
                            {
                                this.Ins_Item_Explain.Ins_Now.visible = true;
                            }
                            var _loc_3:* = this;
                            var _loc_4:* = this.Main_action + 1;
                            _loc_3.Main_action = _loc_4;
                        }
                        if (this.Ins_Item_Explain.Ins_Man.x < -448)
                        {
                            this.dispActMan("off");
                            this.dispWalkMoveMan(this.walk_act_table2[4].ins, false, -1);
                            this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_base].dx;
                            this.Ins_Item_Explain.Ins_Man.y = 0;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 80;
                        }
                    }
                    break;
                }
                case 80:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.dispActBtn(0);
                        this.setResetBtn(false);
                        this.Main_index = 9;
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
            this.releaseStopBtn();
            this.releaseResultBtn();
            this.releaseResetBtn();
            this.releaseWalkBtn();
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
            this.Ins_Item_Control.Ins_Answer.text = "";
            this.Ins_Item_Control.Ins_NotHit1.visible = false;
            this.Ins_Item_Control.Ins_NotHit2.visible = false;
            this.man_base = this._START_POINT;
            this.man_dir = this._STEP1_DIR;
            this.man_move1 = this._STEP1_MOVE;
            this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_base].dx;
            this.Ins_Item_Explain.Ins_Man.y = 0;
            this.Ins_Item_Explain.Ins_PerKm1.visible = false;
            this.Ins_Item_Explain.Ins_PerKm1.x = this._ARROW_DISP_RX;
            this.Ins_Item_Explain.Ins_PerKm1.y = this._ARROW_DISP_RY;
            this.Ins_Item_Explain.Ins_PerKm2.visible = false;
            this.Ins_Item_Explain.Ins_PerKm2.x = this._ARROW_DISP_LX;
            this.Ins_Item_Explain.Ins_PerKm2.y = this._ARROW_DISP_LY;
            this.Ins_Item_Explain.Ins_Now.visible = true;
            this.Ins_Item_Explain.Ins_Now.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_Now.y = -120;
            this.Ins_Item_Explain.Ins_After.visible = false;
            this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_After.y = -120;
            this.Ins_Item_Explain.Ins_Befoer.visible = false;
            this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_Befoer.y = -120;
            if (this.man_dir == this._STEP1_DIR)
            {
                this.Ins_Item_Explain.Ins_Man.scaleX = 1;
                this.dispActMan("off");
                this.Ins_Item_Explain.Ins_PerKm1.visible = true;
                this.Ins_Item_Explain.Ins_PerKm2.visible = false;
                this.Ins_Item_Control.Ins_Move.text = "(+4)×";
                this.dispExpMoveMan(true, 1);
            }
            else
            {
                this.Ins_Item_Explain.Ins_Man.scaleX = -1;
                this.dispActMan("off");
                this.Ins_Item_Explain.Ins_PerKm1.visible = false;
                this.Ins_Item_Explain.Ins_PerKm2.visible = true;
                this.Ins_Item_Control.Ins_Move.text = "(-4)×";
                this.dispExpMoveMan(true, -1);
            }
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_Start_Btn.visible = false;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.dispExpMoveArrow1(false, 1, 0);
            this.dispExpMoveArrow2(false, 1, 0);
            return;
        }// end function

        public function resetMainItem() : void
        {
            this.Ins_Item_Control.Ins_Answer.text = "";
            this.Ins_Item_Control.Ins_NotHit1.visible = false;
            this.Ins_Item_Control.Ins_NotHit2.visible = false;
            this.man_base = this._START_POINT;
            this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_base].dx;
            this.Ins_Item_Explain.Ins_Man.y = 0;
            this.Ins_Item_Explain.Ins_PerKm1.visible = false;
            this.Ins_Item_Explain.Ins_PerKm1.x = this._ARROW_DISP_RX;
            this.Ins_Item_Explain.Ins_PerKm1.y = this._ARROW_DISP_RY;
            this.Ins_Item_Explain.Ins_PerKm2.visible = false;
            this.Ins_Item_Explain.Ins_PerKm2.x = this._ARROW_DISP_LX;
            this.Ins_Item_Explain.Ins_PerKm2.y = this._ARROW_DISP_LY;
            this.Ins_Item_Explain.Ins_Now.visible = true;
            this.Ins_Item_Explain.Ins_Now.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_Now.y = -120;
            this.Ins_Item_Explain.Ins_After.visible = false;
            this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_After.y = -120;
            this.Ins_Item_Explain.Ins_Befoer.visible = false;
            this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
            this.Ins_Item_Explain.Ins_Befoer.y = -120;
            if (this.man_dir == this._STEP1_DIR)
            {
                this.Ins_Item_Explain.Ins_Man.scaleX = 1;
                this.dispActMan("off");
                this.Ins_Item_Explain.Ins_PerKm1.visible = true;
                this.Ins_Item_Explain.Ins_PerKm2.visible = false;
                this.Ins_Item_Control.Ins_Move.text = "(+4)×";
                this.dispExpMoveMan(true, 1);
            }
            else
            {
                this.Ins_Item_Explain.Ins_Man.scaleX = -1;
                this.dispActMan("off");
                this.Ins_Item_Explain.Ins_PerKm1.visible = false;
                this.Ins_Item_Explain.Ins_PerKm2.visible = true;
                this.Ins_Item_Control.Ins_Move.text = "(-4)×";
                this.dispExpMoveMan(true, -1);
            }
            this.Ins_Item_Control.Ins_Start_Btn.visible = false;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.dispExpMoveArrow1(false, 1, 0);
            this.dispExpMoveArrow2(false, 1, 0);
            return;
        }// end function

        public function dispExplainResult(param1:int, param2:int) : void
        {
            if (this.man_dir == this._STEP1_DIR)
            {
                if (param2 >= 0)
                {
                    this.Ins_Item_Explain.Ins_After.visible = true;
                    this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
                    this.Ins_Item_Explain.Ins_Befoer.visible = false;
                    this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
                    this.dispMoveResult1(param1, param2 * this._BASE_SPEED_E);
                }
                else
                {
                    this.Ins_Item_Explain.Ins_After.visible = false;
                    this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
                    this.Ins_Item_Explain.Ins_Befoer.visible = true;
                    this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
                    this.dispMoveResult2(param1, param2 * this._BASE_SPEED_E);
                }
            }
            else if (param2 >= 0)
            {
                this.Ins_Item_Explain.Ins_After.visible = true;
                this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
                this.Ins_Item_Explain.Ins_Befoer.visible = false;
                this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
                this.dispMoveResult2(param1, param2 * this._BASE_SPEED_W);
            }
            else
            {
                this.Ins_Item_Explain.Ins_After.visible = false;
                this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x;
                this.Ins_Item_Explain.Ins_Befoer.visible = true;
                this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x;
                this.dispMoveResult1(param1, param2 * this._BASE_SPEED_W);
            }
            return;
        }// end function

        public function clearExplainAll() : void
        {
            this.Ins_Item_Explain.Ins_Now.visible = false;
            this.Ins_Item_Explain.Ins_PerKm1.visible = false;
            this.Ins_Item_Explain.Ins_PerKm2.visible = false;
            this.Ins_Item_Explain.Ins_After.visible = false;
            this.Ins_Item_Explain.Ins_Befoer.visible = false;
            return;
        }// end function

        public function dispActBtn(param1:uint) : void
        {
            return;
        }// end function

        public function initMoveMan(param1:int, param2:uint, param3:int) : void
        {
            this.man_index = 0;
            this.man_timer = 0;
            if (param1 == this._STEP1_DIR)
            {
                this.man_start = param2;
                this.man_target = this.man_start + param3;
                if (param3 > 0)
                {
                    this.dispActMan("walk");
                    this.man_index = 1;
                }
                else if (param3 < 0)
                {
                    this.dispActMan("back");
                    this.man_index = 2;
                }
                else
                {
                    this.man_index = 9;
                }
            }
            else
            {
                this.man_start = param2;
                this.man_target = this.man_start + param3 * -1;
                if (param3 > 0)
                {
                    this.dispActMan("walk");
                    this.man_index = 3;
                }
                else if (param3 < 0)
                {
                    this.dispActMan("back");
                    this.man_index = 4;
                }
                else
                {
                    this.man_index = 9;
                }
            }
            this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_start].dx;
            this.Ins_Item_Explain.Ins_Man.y = 0;
            return;
        }// end function

        public function controlMoveMan() : Boolean
        {
            var _loc_1:* = false;
            switch(this.man_index)
            {
                case 1:
                {
                    this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x + this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Man.x > this.point_status[this.man_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_target].dx;
                        _loc_1 = true;
                        this.man_index = 9;
                    }
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x - this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Man.x < this.point_status[this.man_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_target].dx;
                        _loc_1 = true;
                        this.man_index = 9;
                    }
                    break;
                }
                case 3:
                {
                    this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x - this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Man.x < this.point_status[this.man_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_target].dx;
                        _loc_1 = true;
                        this.man_index = 9;
                    }
                    break;
                }
                case 4:
                {
                    this.Ins_Item_Explain.Ins_Man.x = this.Ins_Item_Explain.Ins_Man.x + this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Man.x > this.point_status[this.man_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Man.x = this.point_status[this.man_target].dx;
                        _loc_1 = true;
                        this.man_index = 9;
                    }
                    break;
                }
                case 9:
                {
                    _loc_1 = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function dispActMan(param1:String) : void
        {
            switch(param1)
            {
                case "off":
                {
                    this.Ins_Item_Explain.Ins_Man.gotoAndStop("off");
                    break;
                }
                case "walk":
                {
                    this.Ins_Item_Explain.Ins_Man.gotoAndPlay("walk");
                    break;
                }
                case "back":
                {
                    this.Ins_Item_Explain.Ins_Man.gotoAndPlay("back");
                    break;
                }
                case "stop":
                {
                    this.Ins_Item_Explain.Ins_Man.stop();
                    break;
                }
                case "play":
                {
                    this.Ins_Item_Explain.Ins_Man.play();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispMoveResult1(param1:int, param2:int) : void
        {
            if (param2 > 0)
            {
                this.Ins_Item_Explain.Ins_After.Ins_Num.text = Math.abs(param1);
                this.Ins_Item_Control.Ins_Answer.text = "= +" + String(param2);
            }
            else
            {
                this.Ins_Item_Explain.Ins_After.Ins_Num.text = Math.abs(param1);
                this.Ins_Item_Control.Ins_Answer.text = "= " + String(param2);
            }
            return;
        }// end function

        public function dispMoveResult2(param1:int, param2:int) : void
        {
            this.Ins_Item_Explain.Ins_Befoer.Ins_Num.text = Math.abs(param1);
            this.Ins_Item_Control.Ins_Answer.text = "= " + String(param2);
            return;
        }// end function

        public function dispExpMoveMan(param1:Boolean, param2:int) : void
        {
            this.Ins_Item_Explain.Ins_Exp_Man.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.visible = param1;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.scaleX = param2;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.scaleX = param2;
            return;
        }// end function

        public function dispExpMoveManTarget(param1:int, param2:int, param3:int) : void
        {
            this.Ins_Item_Explain.Ins_Now.visible = true;
            this.Ins_Item_Explain.Ins_PerKm1.visible = false;
            this.Ins_Item_Explain.Ins_PerKm2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.visible = false;
            this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.visible = false;
            switch(param2)
            {
                case 0:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.visible = true;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.visible = true;
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.visible = true;
                    break;
                }
                case 3:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.visible = true;
                    break;
                }
                case 4:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.visible = true;
                    break;
                }
                case 5:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.visible = true;
                    break;
                }
                case 6:
                {
                    this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 == this._STEP1_DIR)
            {
                if (this.num_table[param3].num == 0)
                {
                    this.Ins_Item_Explain.Ins_After.visible = false;
                    this.Ins_Item_Explain.Ins_Befoer.visible = false;
                }
                else if (this.num_table[param3].num > 0)
                {
                    this.Ins_Item_Explain.Ins_After.visible = true;
                    this.Ins_Item_Explain.Ins_Befoer.visible = false;
                    this.Ins_Item_Explain.Ins_After.Ins_Num.text = Math.abs(this.num_table[param3].num);
                    this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x + this._BASE_LEN * this.num_table[param3].num;
                }
                else
                {
                    this.Ins_Item_Explain.Ins_After.visible = false;
                    this.Ins_Item_Explain.Ins_Befoer.visible = true;
                    this.Ins_Item_Explain.Ins_Befoer.Ins_Num.text = Math.abs(this.num_table[param3].num);
                    this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x + this._BASE_LEN * this.num_table[param3].num;
                }
                switch(param3)
                {
                    case 0:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.visible = true;
                        break;
                    }
                    case 1:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.visible = true;
                        break;
                    }
                    case 2:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.visible = true;
                        break;
                    }
                    case 3:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.visible = true;
                        break;
                    }
                    case 4:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.visible = true;
                        break;
                    }
                    case 5:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.visible = true;
                        break;
                    }
                    case 6:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.visible = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            else
            {
                if (this.num_table[param3].num == 0)
                {
                    this.Ins_Item_Explain.Ins_After.visible = false;
                    this.Ins_Item_Explain.Ins_Befoer.visible = false;
                }
                else if (this.num_table[param3].num > 0)
                {
                    this.Ins_Item_Explain.Ins_After.visible = true;
                    this.Ins_Item_Explain.Ins_Befoer.visible = false;
                    this.Ins_Item_Explain.Ins_After.Ins_Num.text = Math.abs(this.num_table[param3].num);
                    this.Ins_Item_Explain.Ins_After.x = this.Ins_Item_Explain.Ins_Man.x - this._BASE_LEN * this.num_table[param3].num;
                }
                else
                {
                    this.Ins_Item_Explain.Ins_After.visible = false;
                    this.Ins_Item_Explain.Ins_Befoer.visible = true;
                    this.Ins_Item_Explain.Ins_Befoer.Ins_Num.text = Math.abs(this.num_table[param3].num);
                    this.Ins_Item_Explain.Ins_Befoer.x = this.Ins_Item_Explain.Ins_Man.x - this._BASE_LEN * this.num_table[param3].num;
                }
                switch(param3)
                {
                    case 0:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move7.visible = true;
                        break;
                    }
                    case 1:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move6.visible = true;
                        break;
                    }
                    case 2:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move5.visible = true;
                        break;
                    }
                    case 3:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move4.visible = true;
                        break;
                    }
                    case 4:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move3.visible = true;
                        break;
                    }
                    case 5:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move2.visible = true;
                        break;
                    }
                    case 6:
                    {
                        this.Ins_Item_Explain.Ins_Exp_Man.Ins_Move1.visible = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function dispExpMoveArrow1(param1:Boolean, param2:int, param3:Number) : void
        {
            if (param1 == true)
            {
                this.Ins_Item_Explain.Ins_Exp_Move1.visible = true;
                this.Ins_Item_Explain.Ins_Exp_Move1.scaleX = param2;
                this.Ins_Item_Explain.Ins_Exp_Move1.Ins_Arrow.x = Math.abs(param3);
            }
            else
            {
                this.Ins_Item_Explain.Ins_Exp_Move1.visible = false;
            }
            return;
        }// end function

        public function dispExpMoveArrow2(param1:Boolean, param2:int, param3:Number) : void
        {
            if (param1 == true)
            {
                this.Ins_Item_Explain.Ins_Exp_Move2.visible = true;
                this.Ins_Item_Explain.Ins_Exp_Move2.scaleX = param2;
                this.Ins_Item_Explain.Ins_Exp_Move2.Ins_Arrow.x = Math.abs(param3);
            }
            else
            {
                this.Ins_Item_Explain.Ins_Exp_Move2.visible = false;
            }
            return;
        }// end function

        public function dispWalkMoveMan(param1:String, param2:Boolean, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_4 = this.Ins_Item_Explain.Ins_Exp_Man.getChildByName(param1);
            _loc_5 = _loc_4 as MovieClip;
            _loc_4.visible = param2;
            _loc_4.scaleX = param3;
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
            this.closeDropBox1Btn();
            this.closeDropBox2Btn();
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
            this.closeDropBox1Btn();
            this.closeDropBox2Btn();
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

        public function entryResultBtn() : void
        {
            this.Ins_Item_Control.Ins_Result_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downResultBtn);
            return;
        }// end function

        public function releaseResultBtn() : void
        {
            this.Ins_Item_Control.Ins_Result_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downResultBtn);
            return;
        }// end function

        public function downResultBtn(event:MouseEvent) : void
        {
            this.closeDropBox1Btn();
            this.closeDropBox2Btn();
            this.result_btn_flag = true;
            return;
        }// end function

        public function getResultBtn() : Boolean
        {
            return this.result_btn_flag;
        }// end function

        public function setResultBtn(param1:Boolean) : void
        {
            this.result_btn_flag = param1;
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
            this.closeDropBox1Btn();
            this.closeDropBox2Btn();
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

        public function entryWalkBtn() : void
        {
            this.Ins_Item_Control.Ins_Walk_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downWalkBtn);
            return;
        }// end function

        public function releaseWalkBtn() : void
        {
            this.Ins_Item_Control.Ins_Walk_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downWalkBtn);
            return;
        }// end function

        public function downWalkBtn(event:MouseEvent) : void
        {
            this.closeDropBox1Btn();
            this.closeDropBox2Btn();
            this.walk_btn_flag = true;
            return;
        }// end function

        public function getWalkBtn() : Boolean
        {
            return this.walk_btn_flag;
        }// end function

        public function setWalkBtn(param1:Boolean) : void
        {
            this.walk_btn_flag = param1;
            return;
        }// end function

        public function initDropBox1(param1:int, param2:Array) : void
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
                if (dropbox1_open == false)
                {
                    Ins_Item_Control.Ins_DropBox1.gotoAndStop("on");
                    Ins_Item_Control.Ins_DropBox1.Ins_List.visible = true;
                    Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.visible = true;
                    list_dy = _DROPBOX1_LIST_SIZE * (dropbox1_list + 1) - _DROPBOX1_LIST_SIZE / 2;
                    Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.y = list_dy;
                    dropbox1_open = true;
                    if (dropbox2_open == true)
                    {
                        closeDropBox2Btn();
                    }
                }
                return;
            }// end function
            ;
            downBack = function (event:MouseEvent) : void
            {
                if (dropbox1_open == true)
                {
                    Ins_Item_Control.Ins_DropBox1.gotoAndStop("off");
                    Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
                    Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.visible = false;
                    dropbox1_open = false;
                }
                return;
            }// end function
            ;
            downList = function (event:MouseEvent) : void
            {
                if (dropbox1_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox1.Ins_List.mouseY - _DROPBOX1_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROPBOX1_LIST_SIZE);
                if (list_no < 0)
                {
                    list_no = 0;
                }
                else if (list_no > (_DROPBOX1_LIST_MAX - 1))
                {
                    list_no = _DROPBOX1_LIST_MAX - 1;
                }
                Ins_Item_Control.Ins_DropBox1.Ins_Select_Text.Ins_Func.text = list_box[list_no];
                Ins_Item_Control.Ins_DropBox1.gotoAndStop("off");
                Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
                Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.visible = false;
                dropbox1_open = false;
                dropbox1_list = list_no;
                dropbox1_flag = true;
                return;
            }// end function
            ;
            moveList = function (event:MouseEvent) : void
            {
                if (dropbox1_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox1.Ins_List.mouseY - _DROPBOX1_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROPBOX1_LIST_SIZE) + 1;
                if (list_no > _DROPBOX1_LIST_MAX)
                {
                    list_no = _DROPBOX1_LIST_MAX;
                }
                list_dy = _DROPBOX1_LIST_SIZE * list_no - _DROPBOX1_LIST_SIZE / 2;
                Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.y = list_dy;
                return;
            }// end function
            ;
            var i:int;
            var ins:String;
            list_no;
            list_dy;
            this.dropbox1_flag = false;
            this.dropbox1_open = false;
            this.dropbox1_list = list_base;
            this.Ins_Item_Control.Ins_DropBox1.Ins_Select_Text.Ins_Func.text = list_box[this.dropbox1_list];
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
            i;
            while (i < this._DROPBOX1_LIST_MAX)
            {
                
                ins = "Ins_Text" + (i + 1);
                wk_list = this.Ins_Item_Control.Ins_DropBox1.Ins_List.getChildByName(ins);
                wk_list_mc = wk_list as MovieClip;
                wk_text = wk_list_mc.getChildByName("Ins_Func");
                wk_text_tf = wk_text as TextField;
                wk_text_tf.text = list_box[i];
                i = (i + 1);
            }
            this.Ins_Item_Control.Ins_DropBox1.addEventListener(MouseEvent.MOUSE_DOWN, downBox);
            this.Ins_Item_Control.Ins_Back.addEventListener(MouseEvent.MOUSE_DOWN, downBack);
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.addEventListener(MouseEvent.MOUSE_UP, downList);
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.addEventListener(MouseEvent.MOUSE_MOVE, moveList);
            this.Ins_Item_Control.Ins_DropBox1.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Control.Ins_DropBox1.removeEventListener(MouseEvent.MOUSE_DOWN, downBox);
                Ins_Item_Control.Ins_Back.removeEventListener(MouseEvent.MOUSE_DOWN, downBack);
                Ins_Item_Control.Ins_DropBox1.Ins_List.removeEventListener(MouseEvent.MOUSE_UP, downList);
                Ins_Item_Control.Ins_DropBox1.Ins_List.removeEventListener(MouseEvent.MOUSE_MOVE, moveList);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function changeDropBox1(param1:int, param2:Array) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = "";
            this.dropbox1_flag = false;
            this.dropbox1_open = false;
            this.dropbox1_list = param1;
            this.Ins_Item_Control.Ins_DropBox1.Ins_Select_Text.Ins_Func.text = param2[this.dropbox1_list];
            this.Ins_Item_Control.Ins_DropBox1.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
            _loc_3 = 0;
            while (_loc_3 < this._DROPBOX1_LIST_MAX)
            {
                
                _loc_4 = "Ins_Text" + (_loc_3 + 1);
                _loc_5 = this.Ins_Item_Control.Ins_DropBox1.Ins_List.getChildByName(_loc_4);
                _loc_6 = _loc_5 as MovieClip;
                _loc_7 = _loc_6.getChildByName("Ins_Func");
                _loc_8 = _loc_7 as TextField;
                _loc_8.text = param2[_loc_3];
                _loc_3++;
            }
            return;
        }// end function

        public function closeDropBox1Btn() : void
        {
            this.Ins_Item_Control.Ins_DropBox1.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_DropBox1.Ins_List.Ins_Select.visible = false;
            this.dropbox1_flag = false;
            this.dropbox1_open = false;
            return;
        }// end function

        public function getDropBox1ListNo() : int
        {
            return this.dropbox1_list;
        }// end function

        public function getDropBox1Btn() : Boolean
        {
            return this.dropbox1_flag;
        }// end function

        public function setDropBox1Btn(param1:Boolean) : void
        {
            this.dropbox1_flag = param1;
            return;
        }// end function

        public function initDropBox2(param1:int, param2:Array) : void
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
                if (dropbox2_open == false)
                {
                    Ins_Item_Control.Ins_DropBox2.gotoAndStop("on");
                    Ins_Item_Control.Ins_DropBox2.Ins_List.visible = true;
                    Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.visible = true;
                    list_dy = _DROPBOX2_LIST_SIZE * (dropbox2_list + 1) - _DROPBOX2_LIST_SIZE / 2;
                    Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.y = list_dy;
                    dropbox2_open = true;
                    if (dropbox1_open == true)
                    {
                        closeDropBox1Btn();
                    }
                }
                return;
            }// end function
            ;
            downBack = function (event:MouseEvent) : void
            {
                if (dropbox2_open == true)
                {
                    Ins_Item_Control.Ins_DropBox2.gotoAndStop("off");
                    Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
                    Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.visible = false;
                    dropbox2_open = false;
                }
                return;
            }// end function
            ;
            downList = function (event:MouseEvent) : void
            {
                if (dropbox2_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox2.Ins_List.mouseY - _DROPBOX2_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROPBOX2_LIST_SIZE);
                if (list_no < 0)
                {
                    list_no = 0;
                }
                else if (list_no > (_DROPBOX2_LIST_MAX - 1))
                {
                    list_no = _DROPBOX2_LIST_MAX - 1;
                }
                Ins_Item_Control.Ins_DropBox2.Ins_Select_Text.Ins_Func.text = list_box[list_no];
                Ins_Item_Control.Ins_DropBox2.gotoAndStop("off");
                Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
                Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.visible = false;
                dropbox2_open = false;
                dropbox2_list = list_no;
                dropbox2_flag = true;
                return;
            }// end function
            ;
            moveList = function (event:MouseEvent) : void
            {
                if (dropbox2_open == false)
                {
                    return;
                }
                list_dy = Ins_Item_Control.Ins_DropBox2.Ins_List.mouseY - _DROPBOX2_LIST_SIZE * 0.5;
                list_no = Math.round(list_dy / _DROPBOX2_LIST_SIZE) + 1;
                if (list_no > _DROPBOX2_LIST_MAX)
                {
                    list_no = _DROPBOX2_LIST_MAX;
                }
                list_dy = _DROPBOX2_LIST_SIZE * list_no - _DROPBOX2_LIST_SIZE / 2;
                Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.y = list_dy;
                return;
            }// end function
            ;
            var i:int;
            var ins:String;
            list_no;
            list_dy;
            this.dropbox2_flag = false;
            this.dropbox2_open = false;
            this.dropbox2_list = list_base;
            this.Ins_Item_Control.Ins_DropBox2.Ins_Select_Text.Ins_Func.text = list_box[this.dropbox2_list];
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
            i;
            while (i < this._DROPBOX2_LIST_MAX)
            {
                
                ins = "Ins_Text" + (i + 1);
                wk_list = this.Ins_Item_Control.Ins_DropBox2.Ins_List.getChildByName(ins);
                wk_list_mc = wk_list as MovieClip;
                wk_text = wk_list_mc.getChildByName("Ins_Func");
                wk_text_tf = wk_text as TextField;
                wk_text_tf.text = list_box[i];
                i = (i + 1);
            }
            this.Ins_Item_Control.Ins_DropBox2.addEventListener(MouseEvent.MOUSE_DOWN, downBox);
            this.Ins_Item_Control.Ins_Back.addEventListener(MouseEvent.MOUSE_DOWN, downBack);
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.addEventListener(MouseEvent.MOUSE_UP, downList);
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.addEventListener(MouseEvent.MOUSE_MOVE, moveList);
            this.Ins_Item_Control.Ins_DropBox2.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                Ins_Item_Control.Ins_DropBox2.removeEventListener(MouseEvent.MOUSE_DOWN, downBox);
                Ins_Item_Control.Ins_Back.removeEventListener(MouseEvent.MOUSE_DOWN, downBack);
                Ins_Item_Control.Ins_DropBox2.Ins_List.removeEventListener(MouseEvent.MOUSE_UP, downList);
                Ins_Item_Control.Ins_DropBox2.Ins_List.removeEventListener(MouseEvent.MOUSE_MOVE, moveList);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function changeDropBox2(param1:int, param2:Array) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = "";
            this.dropbox2_flag = false;
            this.dropbox2_open = false;
            this.dropbox2_list = param1;
            this.Ins_Item_Control.Ins_DropBox2.Ins_Select_Text.Ins_Func.text = param2[this.dropbox2_list];
            this.Ins_Item_Control.Ins_DropBox2.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
            _loc_3 = 0;
            while (_loc_3 < this._DROPBOX2_LIST_MAX)
            {
                
                _loc_4 = "Ins_Text" + (_loc_3 + 1);
                _loc_5 = this.Ins_Item_Control.Ins_DropBox2.Ins_List.getChildByName(_loc_4);
                _loc_6 = _loc_5 as MovieClip;
                _loc_7 = _loc_6.getChildByName("Ins_Func");
                _loc_8 = _loc_7 as TextField;
                _loc_8.text = param2[_loc_3];
                _loc_3++;
            }
            return;
        }// end function

        public function closeDropBox2Btn() : void
        {
            this.Ins_Item_Control.Ins_DropBox2.gotoAndStop("off");
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_DropBox2.Ins_List.Ins_Select.visible = false;
            this.dropbox2_flag = false;
            this.dropbox2_open = false;
            return;
        }// end function

        public function getDropBox2ListNo() : int
        {
            return this.dropbox2_list;
        }// end function

        public function getDropBox2Btn() : Boolean
        {
            return this.dropbox2_flag;
        }// end function

        public function setDropBox2Btn(param1:Boolean) : void
        {
            this.dropbox2_flag = param1;
            return;
        }// end function

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.man_index = 0;
            this.man_timer = 0;
            this.man_dir = 0;
            this.man_base = 0;
            this.man_move1 = 0;
            this.man_start = 0;
            this.man_target = 0;
            this.start_btn_flag = false;
            this.stop_btn_flag = false;
            this.result_btn_flag = false;
            this.reset_btn_flag = false;
            this.walk_btn_flag = false;
            this.point_status = [{no:0, dx:this._BASE_LEN * -9, dy:0, point:-9}, {no:1, dx:this._BASE_LEN * -8, dy:0, point:-8}, {no:2, dx:this._BASE_LEN * -7, dy:0, point:-7}, {no:3, dx:this._BASE_LEN * -6, dy:0, point:-6}, {no:4, dx:this._BASE_LEN * -5, dy:0, point:-5}, {no:5, dx:this._BASE_LEN * -4, dy:0, point:-4}, {no:6, dx:this._BASE_LEN * -3, dy:0, point:-3}, {no:7, dx:this._BASE_LEN * -2, dy:0, point:-2}, {no:8, dx:this._BASE_LEN * -1, dy:0, point:-1}, {no:9, dx:this._BASE_LEN * 0, dy:0, point:0}, {no:10, dx:this._BASE_LEN * 1, dy:0, point:1}, {no:11, dx:this._BASE_LEN * 2, dy:0, point:2}, {no:12, dx:this._BASE_LEN * 3, dy:0, point:3}, {no:13, dx:this._BASE_LEN * 4, dy:0, point:4}, {no:14, dx:this._BASE_LEN * 5, dy:0, point:5}, {no:15, dx:this._BASE_LEN * 6, dy:0, point:6}, {no:16, dx:this._BASE_LEN * 7, dy:0, point:7}, {no:17, dx:this._BASE_LEN * 8, dy:0, point:8}, {no:18, dx:this._BASE_LEN * 9, dy:0, point:9}];
            this.num_table = [{no:1, label:"-3", num:-3, time:3}, {no:2, label:"-2", num:-2, time:2}, {no:3, label:"-1", num:-1, time:1}, {no:4, label:"0", num:0, time:0}, {no:5, label:"+1", num:1, time:1}, {no:6, label:"+2", num:2, time:2}, {no:7, label:"+3", num:3, time:3}];
            this.walk_act_table1 = [{no:0, ins:"Ins_Move1", pos:-600}, {no:1, ins:"Ins_Move1", pos:this._BASE_LEN * -3}, {no:2, ins:"Ins_Move2", pos:this._BASE_LEN * -2}, {no:3, ins:"Ins_Move3", pos:this._BASE_LEN * -1}, {no:4, ins:"Ins_Move4", pos:this._BASE_LEN * 0}, {no:5, ins:"Ins_Move5", pos:this._BASE_LEN * 1}, {no:6, ins:"Ins_Move6", pos:this._BASE_LEN * 2}, {no:7, ins:"Ins_Move7", pos:this._BASE_LEN * 3}, {no:8, ins:"Ins_Move7", pos:600}];
            this.walk_act_table2 = [{no:0, ins:"Ins_Move7", pos:600}, {no:1, ins:"Ins_Move7", pos:this._BASE_LEN * 3}, {no:2, ins:"Ins_Move6", pos:this._BASE_LEN * 2}, {no:3, ins:"Ins_Move5", pos:this._BASE_LEN * 1}, {no:4, ins:"Ins_Move4", pos:this._BASE_LEN * 0}, {no:5, ins:"Ins_Move3", pos:this._BASE_LEN * -1}, {no:6, ins:"Ins_Move2", pos:this._BASE_LEN * -2}, {no:7, ins:"Ins_Move1", pos:this._BASE_LEN * -3}, {no:8, ins:"Ins_Move1", pos:-600}];
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
            this.dropbox1_flag = false;
            this.dropbox1_open = false;
            this.dropbox1_list = 0;
            this.dropbox1_list_value = ["東向き", "西向き"];
            this.dropbox2_flag = false;
            this.dropbox2_open = false;
            this.dropbox2_list = 0;
            this.dropbox2_list_value = ["-3", "-2", "-1", "0", "+1", "+2", "+3"];
            return;
        }// end function

    }
}
