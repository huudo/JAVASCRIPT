package g1_p17_01_fla
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
        public var woman_index:uint;
        public var woman_timer:uint;
        public var woman_base:int;
        public var woman_move1:int;
        public var woman_move2:int;
        public var woman_start:int;
        public var woman_target:int;
        public var start_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var result_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public const _START_POINT:uint = 9;
        public const _STEP1_MOVE:uint = 8;
        public const _STEP2_MOVE:uint = 8;
        public const _BASE_FRAME:uint = 30;
        public const _BASE_LEN:uint = 50;
        public const _ARROW1_DISP_Y:int = -210;
        public const _ARROW2_DISP_Y:int = -130;
        public const _ARROW3_DISP_Y:int = 80;
        public const _ARROW_NUM_OFSY:int = -65;
        public const _ARROW_SCALE:Number = 0.5;
        public const _FUNC1_POINT_X:int = -172;
        public const _FUNC1_POINT_Y:int = -265;
        public const _FUNC2_POINT_X:int = -25;
        public const _FUNC2_POINT_Y:int = -265;
        public var point_status:Array;
        public var num_table:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var drop_box_flag:Boolean;
        public var drop_box_open:Boolean;
        public var drop_box_list:int;
        public const _DROP_BOX_LIST_MAX:int = 11;
        public const _DROP_BOX_LIST_SIZE:int = 56;
        public var list_value_text:Array;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        public function controlMain(event:Event) : void
        {
            var _loc_2:* = false;
            switch(this.Main_index)
            {
                case 0:
                {
                    this.entryStartBtn();
                    this.entryStopBtn();
                    this.entryResultBtn();
                    this.entryResetBtn();
                    this.initDropBox(this._STEP1_MOVE, this.list_value_text);
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 9:
                {
                    this.resetMainItem();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 9;
                    }
                    else if (this.getDropBoxBtn() == true)
                    {
                        this.woman_move2 = this.getDropBoxListNo();
                        this.dispActBtn(0);
                        this.setDropBoxBtn(false);
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.initMoveWoman(this.woman_base, this.num_table[this.woman_move1].num);
                        this.dispActWoman("walk");
                        this.Ins_Item_Control.Ins_NotHit.visible = true;
                        this.Ins_Item_Explain.Ins_Boder_Start.visible = true;
                        this.dispLookUpNum(true, this._FUNC1_POINT_X, this._FUNC1_POINT_Y);
                        this.dispActBtn(1);
                        this.setStartBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 20;
                    }
                    break;
                }
                case 20:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        if (this.getStopBtn() == true)
                        {
                            this.dispActWoman("stop");
                            this.dispActBtn(0);
                            this.setStopBtn(false);
                            this.Main_action = 1;
                        }
                        else
                        {
                            _loc_2 = this.controlMoveWoman();
                            this.dispMoveArrow(0);
                            if (_loc_2 == true)
                            {
                                this.dispActWoman("stop");
                                this.dispMoveBorder1();
                                this.dispActBtn(0);
                                this.Main_timer = 0;
                                this.Main_action = 0;
                                this.Main_index = 21;
                            }
                        }
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.dispActWoman("play");
                        this.dispActBtn(1);
                        this.setStartBtn(false);
                        this.Main_action = 0;
                    }
                    break;
                }
                case 21:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 9;
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.initMoveWoman(this.woman_base + this.num_table[this.woman_move1].num, this.num_table[this.woman_move2].num);
                        this.dispActWoman("play");
                        this.setStartBtn(false);
                        this.dispLookUpNum(true, this._FUNC2_POINT_X, this._FUNC2_POINT_Y);
                        this.dispActBtn(1);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 9;
                    }
                    else if (this.Main_action == 0)
                    {
                        if (this.getStopBtn() == true)
                        {
                            this.dispActWoman("stop");
                            this.dispActBtn(0);
                            this.setStopBtn(false);
                            this.Main_action = 1;
                        }
                        else
                        {
                            _loc_2 = this.controlMoveWoman();
                            this.dispMoveArrow(1);
                            if (_loc_2 == true)
                            {
                                this.dispActWoman("stop");
                                this.dispMoveBorder2();
                                this.Main_timer = 0;
                                this.Main_action = 0;
                                this.Main_index = 31;
                            }
                        }
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.dispActWoman("play");
                        this.dispActBtn(1);
                        this.setStartBtn(false);
                        this.Main_action = 0;
                    }
                    break;
                }
                case 31:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 9;
                    }
                    else
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        if (this.Main_timer > 0)
                        {
                            this.dispActBtn(2);
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 40;
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
                    else if (this.getResultBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Answer.text = "= " + String(this.point_status[this.woman_target].point);
                        this.dispMoveBorder3();
                        this.dispLookUpNum(false, this._FUNC1_POINT_X, this._FUNC1_POINT_Y);
                        this.setResultBtn(false);
                        this.Main_index = 50;
                    }
                    break;
                }
                case 50:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
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
            this.Ins_Item_Control.Ins_NotHit.visible = false;
            this.dispLookUpNum(false, this._FUNC1_POINT_X, this._FUNC1_POINT_Y);
            this.woman_base = this._START_POINT;
            this.woman_move1 = this._STEP1_MOVE;
            this.woman_move2 = this._STEP2_MOVE;
            this.dispActWoman("off");
            this.Ins_Item_Explain.Ins_Woman.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Woman.y = 0;
            this.Ins_Item_Explain.Ins_Woman.scaleX = 1;
            this.Ins_Item_Explain.Ins_ZeroPoint.visible = false;
            this.Ins_Item_Explain.Ins_ZeroPoint.x = 0;
            this.Ins_Item_Explain.Ins_ZeroPoint.y = 50;
            this.Ins_Item_Explain.Ins_Boder_Start.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Start.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Start.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Move1.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Move1.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Move1.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Move2.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Move2.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Move2.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Result1.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Result1.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Result1.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Result2.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Result2.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Result2.y = 0;
            this.Ins_Item_Explain.Ins_Step1_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step1_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1_Arrow.y = this._ARROW1_DISP_Y;
            this.Ins_Item_Explain.Ins_Step1_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.y = this._ARROW1_DISP_Y;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step1_Move.visible = false;
            this.Ins_Item_Explain.Ins_Step1_Move.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1_Move.y = this._ARROW1_DISP_Y + this._ARROW_NUM_OFSY;
            this.Ins_Item_Explain.Ins_Step1_Move.text = "";
            this.Ins_Item_Explain.Ins_Step2_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step2_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2_Arrow.y = this._ARROW2_DISP_Y;
            this.Ins_Item_Explain.Ins_Step2_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.y = this._ARROW2_DISP_Y;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step2_Move.visible = false;
            this.Ins_Item_Explain.Ins_Step2_Move.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2_Move.y = this._ARROW2_DISP_Y + this._ARROW_NUM_OFSY;
            this.Ins_Item_Explain.Ins_Step2_Move.text = "";
            this.Ins_Item_Explain.Ins_Arrow3.visible = false;
            this.Ins_Item_Explain.Ins_Arrow3.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Arrow3.y = this._ARROW3_DISP_Y;
            this.Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = "";
            this.dispActBtn(99);
            this.setStartBtn(false);
            this.setStopBtn(false);
            this.setResetBtn(false);
            this.setResultBtn(false);
            return;
        }// end function

        public function resetMainItem() : void
        {
            this.Ins_Item_Control.Ins_Answer.text = "";
            this.Ins_Item_Control.Ins_NotHit.visible = false;
            this.dispLookUpNum(false, this._FUNC1_POINT_X, this._FUNC1_POINT_Y);
            this.woman_base = this._START_POINT;
            this.dispActWoman("off");
            this.Ins_Item_Explain.Ins_Woman.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Woman.y = 0;
            this.Ins_Item_Explain.Ins_Woman.scaleX = 1;
            this.Ins_Item_Explain.Ins_ZeroPoint.visible = false;
            this.Ins_Item_Explain.Ins_ZeroPoint.x = 0;
            this.Ins_Item_Explain.Ins_ZeroPoint.y = 50;
            this.Ins_Item_Explain.Ins_Boder_Start.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Start.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Start.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Move1.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Move1.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Move1.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Move2.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Move2.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Move2.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Result1.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Result1.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Result1.y = 0;
            this.Ins_Item_Explain.Ins_Boder_Result2.visible = false;
            this.Ins_Item_Explain.Ins_Boder_Result2.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Result2.y = 0;
            this.Ins_Item_Explain.Ins_Step1_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step1_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1_Arrow.y = this._ARROW1_DISP_Y;
            this.Ins_Item_Explain.Ins_Step1_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.y = this._ARROW1_DISP_Y;
            this.Ins_Item_Explain.Ins_Step1ms_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step1_Move.visible = false;
            this.Ins_Item_Explain.Ins_Step1_Move.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step1_Move.y = this._ARROW1_DISP_Y + this._ARROW_NUM_OFSY;
            this.Ins_Item_Explain.Ins_Step1_Move.text = "";
            this.Ins_Item_Explain.Ins_Step2_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step2_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2_Arrow.y = this._ARROW2_DISP_Y;
            this.Ins_Item_Explain.Ins_Step2_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.visible = false;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.y = this._ARROW2_DISP_Y;
            this.Ins_Item_Explain.Ins_Step2ms_Arrow.Ins_Arrow.x = 0;
            this.Ins_Item_Explain.Ins_Step2_Move.visible = false;
            this.Ins_Item_Explain.Ins_Step2_Move.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Step2_Move.y = this._ARROW2_DISP_Y + this._ARROW_NUM_OFSY;
            this.Ins_Item_Explain.Ins_Step2_Move.text = "";
            this.Ins_Item_Explain.Ins_Arrow3.visible = false;
            this.Ins_Item_Explain.Ins_Arrow3.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Arrow3.y = this._ARROW3_DISP_Y;
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = "";
            this.dispActBtn(99);
            this.setStartBtn(false);
            this.setStopBtn(false);
            this.setResetBtn(false);
            this.setResultBtn(false);
            return;
        }// end function

        public function dispActBtn(param1:uint) : void
        {
            switch(param1)
            {
                case 0:
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Result_Btn.visible = false;
                    break;
                }
                case 1:
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                    this.Ins_Item_Control.Ins_Result_Btn.visible = false;
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Result_Btn.visible = true;
                    break;
                }
                case 99:
                {
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Result_Btn.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initMoveWoman(param1:int, param2:int) : void
        {
            this.woman_index = 0;
            this.woman_timer = 0;
            this.woman_start = param1;
            this.woman_target = this.woman_start + param2;
            if (param2 > 0)
            {
                this.Ins_Item_Explain.Ins_Woman.scaleX = 1;
                this.woman_index = 1;
            }
            else if (param2 < 0)
            {
                this.Ins_Item_Explain.Ins_Woman.scaleX = -1;
                this.woman_index = 2;
            }
            else
            {
                this.woman_index = 9;
            }
            this.Ins_Item_Explain.Ins_Woman.x = this.point_status[this.woman_start].dx;
            this.Ins_Item_Explain.Ins_Woman.y = 0;
            return;
        }// end function

        public function controlMoveWoman() : Boolean
        {
            var _loc_1:* = false;
            switch(this.woman_index)
            {
                case 1:
                {
                    this.Ins_Item_Explain.Ins_Woman.x = this.Ins_Item_Explain.Ins_Woman.x + this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Woman.x > this.point_status[this.woman_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Woman.x = this.point_status[this.woman_target].dx;
                        _loc_1 = true;
                    }
                    break;
                }
                case 2:
                {
                    this.Ins_Item_Explain.Ins_Woman.x = this.Ins_Item_Explain.Ins_Woman.x - this._BASE_LEN / this._BASE_FRAME;
                    if (this.Ins_Item_Explain.Ins_Woman.x < this.point_status[this.woman_target].dx)
                    {
                        this.Ins_Item_Explain.Ins_Woman.x = this.point_status[this.woman_target].dx;
                        _loc_1 = true;
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

        public function dispActWoman(param1:String) : void
        {
            switch(param1)
            {
                case "off":
                {
                    this.Ins_Item_Explain.Ins_Woman.gotoAndStop("walk");
                    break;
                }
                case "walk":
                {
                    this.Ins_Item_Explain.Ins_Woman.gotoAndPlay("walk");
                    break;
                }
                case "stop":
                {
                    this.Ins_Item_Explain.Ins_Woman.stop();
                    break;
                }
                case "play":
                {
                    this.Ins_Item_Explain.Ins_Woman.play();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispMoveArrow(param1:uint) : void
        {
            var _loc_2:* = 0;
            switch(this.woman_index)
            {
                case 1:
                {
                    switch(param1)
                    {
                        case 0:
                        {
                            this.Ins_Item_Explain.Ins_Step1_Arrow.visible = true;
                            this.Ins_Item_Explain.Ins_Step1ms_Arrow.visible = false;
                            this.Ins_Item_Explain.Ins_Step1_Arrow.scaleX = this._ARROW_SCALE;
                            this.Ins_Item_Explain.Ins_Step1_Arrow.x = this.point_status[this.woman_base].dx;
                            _loc_2 = Math.abs(this.Ins_Item_Explain.Ins_Woman.x - this.point_status[this.woman_base].dx) * (1 / this._ARROW_SCALE);
                            this.Ins_Item_Explain.Ins_Step1_Arrow.Ins_Arrow.x = _loc_2;
                            break;
                        }
                        case 1:
                        {
                            this.Ins_Item_Explain.Ins_Step2_Arrow.visible = true;
                            this.Ins_Item_Explain.Ins_Step2ms_Arrow.visible = false;
                            this.Ins_Item_Explain.Ins_Step2_Arrow.scaleX = this._ARROW_SCALE;
                            this.Ins_Item_Explain.Ins_Step2_Arrow.x = this.point_status[this.woman_base + this.num_table[this.woman_move1].num].dx;
                            _loc_2 = Math.abs(this.Ins_Item_Explain.Ins_Woman.x - this.point_status[this.woman_base + this.num_table[this.woman_move1].num].dx) * (1 / this._ARROW_SCALE);
                            this.Ins_Item_Explain.Ins_Step2_Arrow.Ins_Arrow.x = _loc_2;
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
                    switch(param1)
                    {
                        case 0:
                        {
                            this.Ins_Item_Explain.Ins_Step1_Arrow.visible = false;
                            this.Ins_Item_Explain.Ins_Step1ms_Arrow.visible = true;
                            this.Ins_Item_Explain.Ins_Step1ms_Arrow.scaleX = this._ARROW_SCALE;
                            this.Ins_Item_Explain.Ins_Step1ms_Arrow.x = this.point_status[this.woman_base].dx;
                            _loc_2 = Math.abs(this.Ins_Item_Explain.Ins_Woman.x - this.point_status[this.woman_base].dx) * (1 / this._ARROW_SCALE);
                            this.Ins_Item_Explain.Ins_Step1ms_Arrow.Ins_Arrow.x = _loc_2;
                            break;
                        }
                        case 1:
                        {
                            this.Ins_Item_Explain.Ins_Step2_Arrow.visible = false;
                            this.Ins_Item_Explain.Ins_Step2ms_Arrow.visible = true;
                            this.Ins_Item_Explain.Ins_Step2ms_Arrow.scaleX = this._ARROW_SCALE;
                            this.Ins_Item_Explain.Ins_Step2ms_Arrow.x = this.point_status[this.woman_base + this.num_table[this.woman_move1].num].dx;
                            _loc_2 = Math.abs(this.Ins_Item_Explain.Ins_Woman.x - this.point_status[this.woman_base + this.num_table[this.woman_move1].num].dx) * (1 / this._ARROW_SCALE);
                            this.Ins_Item_Explain.Ins_Step2ms_Arrow.Ins_Arrow.x = _loc_2;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 9:
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

        public function dispMoveBorder1() : void
        {
            var _loc_1:* = 0;
            this.Ins_Item_Explain.Ins_Boder_Move1.visible = true;
            this.Ins_Item_Explain.Ins_Boder_Move1.x = this.point_status[this.woman_base + this.num_table[this.woman_move1].num].dx;
            this.Ins_Item_Explain.Ins_Boder_Move1.y = 0;
            this.Ins_Item_Explain.Ins_Step1_Move.visible = true;
            this.Ins_Item_Explain.Ins_Step1_Move.x = this.Ins_Item_Explain.Ins_Boder_Start.x + this.num_table[this.woman_move1].num * this._BASE_LEN / 2 - 25;
            this.Ins_Item_Explain.Ins_Step1_Move.text = String(this.num_table[this.woman_move1].label);
            return;
        }// end function

        public function dispMoveBorder2() : void
        {
            var _loc_1:* = 0;
            this.Ins_Item_Explain.Ins_Boder_Move2.visible = true;
            this.Ins_Item_Explain.Ins_Boder_Move2.x = this.point_status[this.woman_base + this.num_table[this.woman_move1].num + this.num_table[this.woman_move2].num].dx;
            this.Ins_Item_Explain.Ins_Boder_Move2.y = 0;
            if (this.woman_move2 == 5)
            {
                this.Ins_Item_Explain.Ins_Step2_Move.visible = true;
                this.Ins_Item_Explain.Ins_Step2_Move.x = this.Ins_Item_Explain.Ins_Woman.x - 25;
                this.Ins_Item_Explain.Ins_Step2_Move.text = String(this.num_table[this.woman_move2].label);
            }
            else
            {
                this.Ins_Item_Explain.Ins_Step2_Move.visible = true;
                this.Ins_Item_Explain.Ins_Step2_Move.x = this.Ins_Item_Explain.Ins_Boder_Move1.x + this.num_table[this.woman_move2].num * this._BASE_LEN / 2 - 25;
                this.Ins_Item_Explain.Ins_Step2_Move.text = String(this.num_table[this.woman_move2].label);
            }
            return;
        }// end function

        public function dispMoveBorder3() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_1 = this.woman_base + this.num_table[this.woman_move1].num + this.num_table[this.woman_move2].num;
            this.Ins_Item_Explain.Ins_Boder_Result1.visible = true;
            this.Ins_Item_Explain.Ins_Boder_Result1.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Boder_Result1.y = 36;
            this.Ins_Item_Explain.Ins_Boder_Result2.visible = true;
            this.Ins_Item_Explain.Ins_Boder_Result2.x = this.point_status[_loc_1].dx;
            this.Ins_Item_Explain.Ins_Boder_Result2.y = 0;
            this.Ins_Item_Explain.Ins_Arrow3.visible = true;
            this.Ins_Item_Explain.Ins_Arrow3.x = this.point_status[this.woman_base].dx;
            this.Ins_Item_Explain.Ins_Arrow3.y = this._ARROW3_DISP_Y;
            _loc_2 = this.num_table[this.woman_move1].num + this.num_table[this.woman_move2].num;
            if (_loc_2 > 0)
            {
                _loc_2 = _loc_2 + 1;
            }
            else
            {
                _loc_2 = Math.abs(_loc_2) + 11;
            }
            this.Ins_Item_Explain.Ins_Arrow3.gotoAndStop(_loc_2);
            if (this.num_table[this.woman_move1].num + this.num_table[this.woman_move2].num == 0)
            {
                this.Ins_Item_Explain.Ins_ZeroPoint.visible = true;
            }
            return;
        }// end function

        public function dispLookUpNum(param1:Boolean, param2:int, param3:int) : void
        {
            this.Ins_Item_Control.Ins_LookUp.visible = param1;
            this.Ins_Item_Control.Ins_LookUp.x = param2;
            this.Ins_Item_Control.Ins_LookUp.y = param3;
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
            this.closeDropBoxBtn();
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
                    list_dy = _DROP_BOX_LIST_SIZE * (drop_box_list + 1) - _DROP_BOX_LIST_SIZE / 2;
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
                list_no = Math.round(list_dy / _DROP_BOX_LIST_SIZE);
                if (list_no < 0)
                {
                    list_no = 0;
                }
                else if (list_no > (_DROP_BOX_LIST_MAX - 1))
                {
                    list_no = _DROP_BOX_LIST_MAX - 1;
                }
                if (list_box[list_no] == "0")
                {
                    Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = String(list_box[list_no]);
                }
                else
                {
                    Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = "(" + String(list_box[list_no]) + ")";
                }
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
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = "";
            this.Ins_Item_Control.Ins_DropBox.Ins_List.visible = false;
            i;
            while (i < this._DROP_BOX_LIST_MAX)
            {
                
                ins = "Ins_Text" + (i + 1);
                wk_list = this.Ins_Item_Control.Ins_DropBox.Ins_List.getChildByName(ins);
                wk_list_mc = wk_list as MovieClip;
                wk_text = wk_list_mc.getChildByName("Ins_Func");
                wk_text_tf = wk_text as TextField;
                wk_text_tf.text = list_box[i];
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
            this.Ins_Item_Control.Ins_DropBox.Ins_Select_Text.Ins_Func.text = "(" + String(param2[this.drop_box_list]) + ")";
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
                _loc_8.text = param2[_loc_3];
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

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.woman_index = 0;
            this.woman_timer = 0;
            this.woman_base = 0;
            this.woman_move1 = 0;
            this.woman_move2 = 0;
            this.woman_start = 0;
            this.woman_target = 0;
            this.start_btn_flag = false;
            this.stop_btn_flag = false;
            this.result_btn_flag = false;
            this.reset_btn_flag = false;
            this.point_status = [{no:1, dx:this._BASE_LEN * -9, dy:0, point:"-9"}, {no:2, dx:this._BASE_LEN * -8, dy:0, point:"-8"}, {no:3, dx:this._BASE_LEN * -7, dy:0, point:"-7"}, {no:4, dx:this._BASE_LEN * -6, dy:0, point:"-6"}, {no:5, dx:this._BASE_LEN * -5, dy:0, point:"-5"}, {no:6, dx:this._BASE_LEN * -4, dy:0, point:"-4"}, {no:7, dx:this._BASE_LEN * -3, dy:0, point:"-3"}, {no:8, dx:this._BASE_LEN * -2, dy:0, point:"-2"}, {no:9, dx:this._BASE_LEN * -1, dy:0, point:"-1"}, {no:10, dx:this._BASE_LEN * 0, dy:0, point:"0"}, {no:11, dx:this._BASE_LEN * 1, dy:0, point:"+1"}, {no:12, dx:this._BASE_LEN * 2, dy:0, point:"+2"}, {no:13, dx:this._BASE_LEN * 3, dy:0, point:"+3"}, {no:14, dx:this._BASE_LEN * 4, dy:0, point:"+4"}, {no:15, dx:this._BASE_LEN * 5, dy:0, point:"+5"}, {no:16, dx:this._BASE_LEN * 6, dy:0, point:"+6"}, {no:17, dx:this._BASE_LEN * 7, dy:0, point:"+7"}, {no:18, dx:this._BASE_LEN * 8, dy:0, point:"+8"}, {no:19, dx:this._BASE_LEN * 9, dy:0, point:"+9"}];
            this.num_table = [{no:1, label:"-5", num:-5}, {no:2, label:"-4", num:-4}, {no:3, label:"-3", num:-3}, {no:4, label:"-2", num:-2}, {no:5, label:"-1", num:-1}, {no:6, label:"0", num:0}, {no:7, label:"+1", num:1}, {no:8, label:"+2", num:2}, {no:9, label:"+3", num:3}, {no:10, label:"+4", num:4}, {no:11, label:"+5", num:5}];
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
            this.drop_box_flag = false;
            this.drop_box_open = false;
            this.drop_box_list = 0;
            this.list_value_text = ["-5", "-4", "-3", "-2", "-1", "0", "+1", "+2", "+3", "+4", "+5"];
            return;
        }// end function

    }
}
