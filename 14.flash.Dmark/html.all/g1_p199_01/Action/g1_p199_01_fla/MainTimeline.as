package g1_p199_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Ins_Item_Sample:MovieClip;
        public var Main_mode:uint;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var circle_mode_id:uint;
        public var pie_open_id:uint;
        public var pause_flag:Boolean;
        public var start_btn_flag:Boolean;
        public var stop_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var piece_btn_flag:Boolean;
        public var explain_flag:Boolean;
        public var refresh_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _BASE_CIRCLE:uint = 0;
        public const _CIRCLE_DISP_X:int = 0;
        public const _CIRCLE_DISP_Y:int = 0;
        public const _CIRCLE_SCALE:Number = 0.75;
        public var pie_status:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var explain_index:int;
        public var explain_timer:int;
        public var circle_r_dx:Number;
        public var circle_r_dy:Number;
        public var circle_r_dir:Number;
        public var circle_b_dx:Number;
        public var circle_b_dy:Number;
        public var circle_b_dir:Number;
        public var hitpie_rock_flag:Boolean;

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
                    this.entryPieceBtn();
                    this.entryStartBtn();
                    this.entryStopBtn();
                    this.entryResetBtn();
                    this.entryOpenPieBtn();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    this.initExplain();
                    this.dispPieceBtn(true);
                    this.dispStartBtn(true);
                    this.dispStopBtn(true);
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getPieceBtn() == true)
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.circle_mode_id + 1;
                        _loc_3.circle_mode_id = _loc_4;
                        if (this.circle_mode_id < this.pie_status.length)
                        {
                            this.pie_open_id = this.pie_open_id * 2;
                            this.refresh_flag = true;
                        }
                        else
                        {
                            this.circle_mode_id = this.pie_status.length - 1;
                        }
                        this.setPieceBtn(false);
                    }
                    else if (this.getStartBtn() == true)
                    {
                        this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                        this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                        this.dispPieceBtn(false);
                        this.setStartBtn(false);
                        this.setStopBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setPieceBtn(false);
                        this.setStartBtn(false);
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.refresh_flag == true)
                    {
                        this.dispCircleMode(this.Ins_Item_Explain, this.circle_mode_id);
                        this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
                        this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
                        this.dispExplainR(this.Ins_Item_Explain, 0, 0, this.circle_mode_id, this.pie_open_id, true);
                        this.dispCircleMode(this.Ins_Item_Sample, this.circle_mode_id);
                        this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
                        this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
                        this.dispExplainR(this.Ins_Item_Sample, 0, 0, this.circle_mode_id, this.pie_open_id, true);
                    }
                    break;
                }
                case 30:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setPieceBtn(false);
                        this.setStartBtn(false);
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.controlExplain() == 99)
                    {
                        this.dispStartBtn(false);
                        this.dispStopBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 50;
                    }
                    break;
                }
                case 50:
                {
                    if (this.getResetBtn() == true)
                    {
                        this.setPieceBtn(false);
                        this.setStartBtn(false);
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
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.releasePieceBtn();
            this.releaseStartBtn();
            this.releaseStopBtn();
            this.releaseResetBtn();
            this.releaseOpenPieBtn();
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
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Ins_Item_Sample.visible = false;
            this.explain_index = 0;
            this.explain_timer = 0;
            this.pause_flag = false;
            this.refresh_flag = false;
            this.explain_flag = false;
            this.Ins_Item_Explain.x = this._DISPLAY_W / 2;
            this.Ins_Item_Explain.y = this._DISPLAY_H / 2;
            this.Ins_Item_Explain.scaleX = this._CIRCLE_SCALE;
            this.Ins_Item_Explain.scaleY = this.Ins_Item_Explain.scaleX;
            this.Ins_Item_Sample.x = this._DISPLAY_W / 2 + 320;
            this.Ins_Item_Sample.y = this._DISPLAY_H / 2 - 90;
            this.Ins_Item_Sample.scaleX = this._CIRCLE_SCALE;
            this.Ins_Item_Sample.scaleY = this.Ins_Item_Sample.scaleX;
            this.circle_mode_id = this._BASE_CIRCLE;
            this.pie_open_id = this.pie_status[this.circle_mode_id].num_min;
            this.Ins_Item_Explain.Ins_Circle_Cover.visible = true;
            this.dispCircleMode(this.Ins_Item_Explain, this.circle_mode_id);
            this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispCircleMode(this.Ins_Item_Sample, this.circle_mode_id);
            this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.Ins_Item_Explain.Ins_Circle_Back.visible = false;
            this.Ins_Item_Explain.Ins_Circle_Back.x = this._CIRCLE_DISP_X;
            this.Ins_Item_Explain.Ins_Circle_Back.y = this._CIRCLE_DISP_Y;
            _loc_1 = 0;
            while (_loc_1 < this.pie_status.length)
            {
                
                this.scaleCirclePie(this.pie_status[_loc_1].ins1, 1, 1);
                this.scaleCirclePie(this.pie_status[_loc_1].ins2, 1, 1);
                _loc_1++;
            }
            this.dispOpenPieBtn(true, 90 - this.pie_status[this.circle_mode_id].dir * this.pie_open_id);
            this.dispExplainR(this.Ins_Item_Explain, 0, 0, this.circle_mode_id, this.pie_open_id, true);
            this.dispExplainR(this.Ins_Item_Sample, 0, 0, this.circle_mode_id, this.pie_open_id, true);
            this.dispExplainL(this.Ins_Item_Explain, 0, 275, true);
            this.Ins_Item_Explain.Ins_Exp_r2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_r2.x = 0;
            this.Ins_Item_Explain.Ins_Exp_r2.y = 0;
            this.Ins_Item_Explain.Ins_Exp_l2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_l2.x = 0;
            this.Ins_Item_Explain.Ins_Exp_l2.y = 0;
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.setStartBtn(false);
            this.setStopBtn(false);
            return;
        }// end function

        public function initExplain() : void
        {
            var _loc_1:* = 0;
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.Ins_Item_Sample.visible = false;
            this.explain_index = 0;
            this.explain_timer = 0;
            this.pause_flag = false;
            this.refresh_flag = false;
            this.explain_flag = false;
            this.Ins_Item_Explain.x = this._DISPLAY_W / 2;
            this.Ins_Item_Explain.y = this._DISPLAY_H / 2;
            this.Ins_Item_Explain.scaleX = this._CIRCLE_SCALE;
            this.Ins_Item_Explain.scaleY = this.Ins_Item_Explain.scaleX;
            this.Ins_Item_Sample.x = this._DISPLAY_W / 2 + 320;
            this.Ins_Item_Sample.y = this._DISPLAY_H / 2 - 90;
            this.Ins_Item_Sample.scaleX = this._CIRCLE_SCALE;
            this.Ins_Item_Sample.scaleY = this.Ins_Item_Sample.scaleX;
            this.circle_mode_id = this._BASE_CIRCLE;
            this.pie_open_id = this.pie_status[this.circle_mode_id].num_min;
            this.Ins_Item_Explain.Ins_Circle_Cover.visible = false;
            this.dispCircleMode(this.Ins_Item_Explain, this.circle_mode_id);
            this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispOpenPie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispCircleMode(this.Ins_Item_Sample, this.circle_mode_id);
            this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins1, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.dispOpenPie(this.Ins_Item_Sample, this.pie_status[this.circle_mode_id].ins2, this.pie_open_id, this.pie_status[this.circle_mode_id].num_max);
            this.Ins_Item_Explain.Ins_Circle_Back.visible = true;
            this.Ins_Item_Explain.Ins_Circle_Back.x = this._CIRCLE_DISP_X;
            this.Ins_Item_Explain.Ins_Circle_Back.y = this._CIRCLE_DISP_Y;
            this.rotationCirclePie(this.pie_status[0].ins1, 0);
            this.rotationCirclePie(this.pie_status[1].ins1, 0);
            this.rotationCirclePie(this.pie_status[2].ins1, 0);
            this.rotationCirclePie(this.pie_status[3].ins1, 0);
            _loc_1 = 0;
            while (_loc_1 < this.pie_status.length)
            {
                
                this.scaleCirclePie(this.pie_status[_loc_1].ins1, 1, 1);
                this.scaleCirclePie(this.pie_status[_loc_1].ins2, 1, 1);
                _loc_1++;
            }
            this.dispOpenPieBtn(true, 90 - this.pie_status[this.circle_mode_id].dir * this.pie_open_id);
            this.dispExplainR(this.Ins_Item_Explain, 0, 0, this.circle_mode_id, this.pie_open_id, true);
            this.dispExplainR(this.Ins_Item_Sample, 0, 0, this.circle_mode_id, this.pie_open_id, true);
            this.dispExplainL(this.Ins_Item_Explain, 0, 275, true);
            this.Ins_Item_Explain.Ins_Exp_r2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_r2.x = 0;
            this.Ins_Item_Explain.Ins_Exp_r2.y = 0;
            this.Ins_Item_Explain.Ins_Exp_l2.visible = false;
            this.Ins_Item_Explain.Ins_Exp_l2.x = 0;
            this.Ins_Item_Explain.Ins_Exp_l2.y = 0;
            this.Ins_Item_Control.Ins_Start_Btn.visible = true;
            this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
            this.setStartBtn(false);
            this.setStopBtn(false);
            return;
        }// end function

        public function controlExplain() : int
        {
            var _loc_1:* = 0;
            if (this.pause_flag == true)
            {
                if (this.getStartBtn() == true)
                {
                    if (this.explain_index == 30)
                    {
                        this.pauseCirclePie(this.pie_status[this.circle_mode_id].ins1, false);
                        this.pauseCirclePie(this.pie_status[this.circle_mode_id].ins2, false);
                    }
                    this.Ins_Item_Control.Ins_Start_Btn.visible = false;
                    this.Ins_Item_Control.Ins_Stop_Btn.visible = true;
                    this.setStartBtn(false);
                    this.setStopBtn(false);
                    this.pause_flag = false;
                }
                return _loc_1;
            }
            else if (this.getStopBtn() == true)
            {
                if (this.explain_index == 30)
                {
                    this.pauseCirclePie(this.pie_status[this.circle_mode_id].ins1, true);
                    this.pauseCirclePie(this.pie_status[this.circle_mode_id].ins2, true);
                }
                this.Ins_Item_Control.Ins_Start_Btn.visible = true;
                this.Ins_Item_Control.Ins_Stop_Btn.visible = false;
                this.setStartBtn(false);
                this.setStopBtn(false);
                this.pause_flag = true;
                return _loc_1;
            }
            switch(this.explain_index)
            {
                case 0:
                {
                    this.Ins_Item_Explain.Ins_Exp_r1.visible = false;
                    this.Ins_Item_Explain.Ins_Exp_l1.visible = false;
                    this.Ins_Item_Explain.Ins_Circle_Back.visible = false;
                    this.dispOpenPieBtn(false, 50);
                    this.circle_r_dx = 0;
                    this.circle_r_dy = 0;
                    this.circle_r_dir = 0;
                    this.circle_b_dx = 0;
                    this.circle_b_dy = 0;
                    this.circle_b_dir = 0;
                    this.explain_timer = 0;
                    this.explain_index = 20;
                    break;
                }
                case 20:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.explain_timer + 1;
                    _loc_2.explain_timer = _loc_3;
                    if (this.explain_timer > 15)
                    {
                        this.dispCirclePie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins1, true, true, int(this._CIRCLE_DISP_X), int(this._CIRCLE_DISP_Y + this.circle_r_dy));
                        this.dispCirclePie(this.Ins_Item_Explain, this.pie_status[this.circle_mode_id].ins2, true, true, int(this._CIRCLE_DISP_X), int(this._CIRCLE_DISP_Y + this.circle_b_dy));
                        this.explain_timer = 0;
                        this.explain_index = 30;
                    }
                    break;
                }
                case 30:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.explain_timer + 1;
                    _loc_2.explain_timer = _loc_3;
                    if (this.explain_timer <= 30)
                    {
                        this.scaleCirclePie(this.pie_status[this.circle_mode_id].ins1, 1 - (1 - this.pie_status[this.circle_mode_id].scale_x) / 30 * this.explain_timer, this.pie_status[this.circle_mode_id].scale_y);
                        this.scaleCirclePie(this.pie_status[this.circle_mode_id].ins2, 1 - (1 - this.pie_status[this.circle_mode_id].scale_x) / 30 * this.explain_timer, this.pie_status[this.circle_mode_id].scale_y);
                    }
                    else
                    {
                        this.explain_timer = 0;
                        this.explain_index = 31;
                    }
                    break;
                }
                case 31:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.explain_timer + 1;
                    _loc_2.explain_timer = _loc_3;
                    if (this.explain_timer > 30)
                    {
                        this.explain_timer = 0;
                        this.explain_index = 40;
                    }
                    break;
                }
                case 40:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.explain_timer + 1;
                    _loc_2.explain_timer = _loc_3;
                    if (this.explain_timer <= 30)
                    {
                        (this.circle_r_dy + 1);
                        this.moveCirclePie(this.pie_status[this.circle_mode_id].ins1, int(this._CIRCLE_DISP_X), int(this._CIRCLE_DISP_Y - this.circle_r_dy));
                        this.circle_r_dir = this.circle_r_dir - 180 / 30;
                        this.rotationCirclePie(this.pie_status[this.circle_mode_id].ins1, this.circle_r_dir);
                    }
                    else if (this.explain_timer > 45)
                    {
                        this.circle_r_dx = 0;
                        this.circle_r_dy = 0;
                        this.circle_r_dir = 0;
                        this.circle_b_dx = 0;
                        this.circle_b_dy = 0;
                        this.circle_b_dir = 0;
                        this.explain_timer = 0;
                        this.explain_index = 50;
                    }
                    break;
                }
                case 50:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.explain_timer + 1;
                    _loc_2.explain_timer = _loc_3;
                    if (this.explain_timer <= 30)
                    {
                        this.circle_r_dx = this.circle_r_dx + this.pie_status[this.circle_mode_id].w_size / 2 / 30;
                        this.circle_r_dy = this.circle_r_dy + (this.pie_status[this.circle_mode_id].h_size / 4 + 60) / 30;
                        this.moveCirclePie(this.pie_status[this.circle_mode_id].ins1, int(this._CIRCLE_DISP_X + this.circle_r_dx), int(this._CIRCLE_DISP_Y + this.circle_r_dy));
                        this.circle_b_dy = this.circle_b_dy - (this.pie_status[this.circle_mode_id].h_size / 4 + 60) / 30;
                        this.moveCirclePie(this.pie_status[this.circle_mode_id].ins2, int(this._CIRCLE_DISP_X + this.circle_b_dx), int(this._CIRCLE_DISP_Y + this.circle_b_dy));
                    }
                    else
                    {
                        this.Ins_Item_Sample.visible = true;
                        this.Ins_Item_Explain.Ins_Exp_r2.visible = true;
                        this.Ins_Item_Explain.Ins_Exp_r2.x = 65;
                        this.Ins_Item_Explain.Ins_Exp_r2.y = 1;
                        this.Ins_Item_Explain.Ins_Exp_l2.visible = true;
                        this.Ins_Item_Explain.Ins_Exp_l2.x = -this.pie_open_id * this.pie_status[this.circle_mode_id].w_size / 2;
                        this.Ins_Item_Explain.Ins_Exp_l2.y = 180;
                        this.explain_timer = 0;
                        this.explain_index = 90;
                    }
                    break;
                }
                case 90:
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

        public function initCircleBtn(param1:String, param2:Boolean, param3:int, param4:int, param5:int, param6:Number) : void
        {
            var wk_rock_flag:Boolean;
            var wk_pie:DisplayObject;
            var wk_pie_mc:MovieClip;
            var wk_base_dir:Number;
            var wk_move_dir:Number;
            var wk_work_dir:Number;
            var downPie:Function;
            var outPie:Function;
            var movePie:Function;
            var ins:* = param1;
            var fg:* = param2;
            var lr_id:* = param3;
            var dx:* = param4;
            var dy:* = param5;
            var scale:* = param6;
            downPie = function (event:MouseEvent) : void
            {
                wk_base_dir = getDirPtoP(0, 0, wk_pie.mouseX, wk_pie.mouseY);
                wk_base_dir = changeDir180(wk_base_dir, lr_id);
                if (getPieDirHit(wk_base_dir, pie_open_id, pie_status[circle_mode_id].dir_piece, pie_status[circle_mode_id].touch_dir) > 0)
                {
                    wk_rock_flag = true;
                }
                return;
            }// end function
            ;
            outPie = function (event:MouseEvent) : void
            {
                wk_rock_flag = false;
                return;
            }// end function
            ;
            movePie = function (event:MouseEvent) : void
            {
                if (wk_rock_flag == true)
                {
                    wk_move_dir = getDirPtoP(0, 0, wk_pie.mouseX, wk_pie.mouseY);
                    wk_move_dir = changeDir180(wk_move_dir, lr_id);
                    wk_work_dir = wk_base_dir - wk_move_dir;
                    if (wk_work_dir >= 0)
                    {
                        if (Math.abs(wk_work_dir) >= pie_status[circle_mode_id].dir)
                        {
                            wk_base_dir = wk_move_dir;
                            var _loc_3:* = pie_open_id + 1;
                            pie_open_id = _loc_3;
                            if (pie_open_id > pie_status[circle_mode_id].num_max)
                            {
                                pie_open_id = pie_status[circle_mode_id].num_max;
                            }
                            refresh_flag = true;
                        }
                    }
                    else if (Math.abs(wk_work_dir) >= pie_status[circle_mode_id].dir)
                    {
                        wk_base_dir = wk_move_dir;
                        var _loc_3:* = pie_open_id - 1;
                        pie_open_id = _loc_3;
                        if (pie_open_id < pie_status[circle_mode_id].num_min)
                        {
                            pie_open_id = pie_status[circle_mode_id].num_min;
                        }
                        refresh_flag = true;
                    }
                }
                return;
            }// end function
            ;
            wk_rock_flag;
            wk_base_dir;
            wk_move_dir;
            wk_work_dir;
            wk_pie = this.Ins_Item_Control.getChildByName(ins);
            wk_pie.x = dx * scale;
            wk_pie.y = dy * scale;
            wk_pie_mc = wk_pie as MovieClip;
            wk_pie.visible = fg;
            wk_pie.scaleX = scale;
            wk_pie.scaleY = wk_pie.scaleX;
            wk_pie_mc.addEventListener(MouseEvent.MOUSE_DOWN, downPie);
            wk_pie_mc.addEventListener(MouseEvent.MOUSE_OUT, outPie);
            wk_pie_mc.addEventListener(MouseEvent.MOUSE_UP, outPie);
            wk_pie_mc.addEventListener(MouseEvent.MOUSE_MOVE, movePie);
            wk_pie_mc.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                wk_pie_mc.removeEventListener(MouseEvent.MOUSE_DOWN, downPie);
                wk_pie_mc.removeEventListener(MouseEvent.MOUSE_OUT, outPie);
                wk_pie_mc.removeEventListener(MouseEvent.MOUSE_UP, outPie);
                wk_pie_mc.removeEventListener(MouseEvent.MOUSE_MOVE, movePie);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function dispOpenPie(param1:MovieClip, param2:String, param3:int, param4:int) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = "";
            if (param3 > param4)
            {
                return;
            }
            _loc_7 = param1.getChildByName(param2);
            _loc_8 = _loc_7 as MovieClip;
            _loc_5 = 0;
            while (_loc_5 < param3)
            {
                
                _loc_6 = "Ins_Pie" + (_loc_5 + 1);
                _loc_9 = _loc_8.getChildByName(_loc_6);
                _loc_9.visible = true;
                _loc_5++;
            }
            _loc_5 = param3;
            while (_loc_5 < param4)
            {
                
                _loc_6 = "Ins_Pie" + (_loc_5 + 1);
                _loc_9 = _loc_8.getChildByName(_loc_6);
                _loc_9.visible = false;
                _loc_5++;
            }
            return;
        }// end function

        public function dispCirclePie(param1:MovieClip, param2:String, param3:Boolean, param4:Boolean, param5:int, param6:int) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            _loc_7 = param1.getChildByName(param2);
            _loc_8 = _loc_7 as MovieClip;
            _loc_7.visible = param3;
            _loc_7.x = param5;
            _loc_7.y = param6;
            if (param4 == true)
            {
                _loc_8.gotoAndPlay(1);
            }
            else
            {
                _loc_8.gotoAndStop(1);
            }
            return;
        }// end function

        public function dispCirclePieTarget(param1:MovieClip, param2:String, param3:Boolean, param4:Boolean, param5:int, param6:int, param7:uint) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            _loc_8 = param1.getChildByName(param2);
            _loc_9 = _loc_8 as MovieClip;
            _loc_8.visible = param3;
            _loc_8.x = param5;
            _loc_8.y = param6;
            _loc_9.gotoAndStop(param7);
            return;
        }// end function

        public function pauseCirclePie(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = this.Ins_Item_Explain.getChildByName(param1);
            _loc_4 = _loc_3 as MovieClip;
            if (param2 == true)
            {
                _loc_4.stop();
            }
            else
            {
                _loc_4.play();
            }
            return;
        }// end function

        public function moveCirclePie(param1:String, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_4 = this.Ins_Item_Explain.getChildByName(param1);
            _loc_5 = _loc_4 as MovieClip;
            _loc_4.x = param2;
            _loc_4.y = param3;
            return;
        }// end function

        public function rotationCirclePie(param1:String, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = this.Ins_Item_Explain.getChildByName(param1);
            _loc_4 = _loc_3 as MovieClip;
            _loc_3.rotation = param2;
            return;
        }// end function

        public function scaleCirclePie(param1:String, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_4 = this.Ins_Item_Explain.getChildByName(param1);
            _loc_5 = _loc_4 as MovieClip;
            _loc_4.scaleX = param2;
            _loc_4.scaleY = param3;
            return;
        }// end function

        public function dispCircleMode(param1:MovieClip, param2:int) : void
        {
            switch(param2)
            {
                case -1:
                {
                    this.dispCirclePie(param1, this.pie_status[0].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[0].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    break;
                }
                case 0:
                {
                    this.dispCirclePie(param1, this.pie_status[0].ins1, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[0].ins2, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    break;
                }
                case 1:
                {
                    this.dispCirclePie(param1, this.pie_status[0].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[0].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins1, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins2, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    break;
                }
                case 2:
                {
                    this.dispCirclePie(param1, this.pie_status[0].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[0].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins1, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins2, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    break;
                }
                case 3:
                {
                    this.dispCirclePie(param1, this.pie_status[0].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[0].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[1].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins1, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[2].ins2, false, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins1, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    this.dispCirclePie(param1, this.pie_status[3].ins2, true, false, this._CIRCLE_DISP_X, this._CIRCLE_DISP_Y);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispExplainR(param1:MovieClip, param2:int, param3:int, param4:uint, param5:uint, param6:Boolean) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            _loc_7 = param1.getChildByName("Ins_Exp_r1");
            _loc_8 = _loc_7 as MovieClip;
            _loc_7.x = param2;
            _loc_7.y = param3;
            _loc_9 = _loc_8.getChildByName("Ins_r");
            _loc_10 = _loc_9 as MovieClip;
            _loc_7.visible = param6;
            _loc_7.rotation = this.pie_status[param4].dir * param5 - 40;
            _loc_9.rotation = -(this.pie_status[param4].dir * param5 - 40);
            return;
        }// end function

        public function dispExplainL(param1:MovieClip, param2:int, param3:int, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = param1.getChildByName("Ins_Exp_l1");
            _loc_6 = _loc_5 as MovieClip;
            _loc_5.x = param2;
            _loc_5.y = param3;
            _loc_5.visible = param4;
            return;
        }// end function

        public function getPieDirHit(param1:Number, param2:uint, param3:uint, param4:int) : uint
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = 180 - param4 * (param2 / param3 - 0);
            _loc_7 = 180 - param4 * (param2 / param3 - 1) + 15;
            if (param1 >= _loc_6 && param1 <= _loc_7)
            {
                _loc_5 = 1;
            }
            return _loc_5;
        }// end function

        public function getDirPtoP(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_5 = Math.atan2(param4 - param2, param3 - param1);
            _loc_6 = _loc_5 * 180 / Math.PI;
            return _loc_6;
        }// end function

        public function changeDir360(param1:Number) : Number
        {
            if (param1 < 0)
            {
                param1 = param1 + 360;
            }
            return param1;
        }// end function

        public function changeDir180(param1:Number, param2:int) : Number
        {
            if (param2 > 0)
            {
                param1 = param1 + 90;
            }
            else
            {
                if (param1 < 0)
                {
                    param1 = param1 + 360;
                }
                param1 = 360 - (param1 + 90);
            }
            return param1;
        }// end function

        public function getLengthPtoP(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_5 = (param3 - param1) * (param3 - param1);
            _loc_6 = (param4 - param2) * (param4 - param2);
            _loc_7 = Math.sqrt(_loc_5 + _loc_6);
            return Number(_loc_7);
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

        public function dispStartBtn(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Start_Btn.visible = param1;
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

        public function dispStopBtn(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Stop_Btn.visible = param1;
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

        public function entryPieceBtn() : void
        {
            this.Ins_Item_Control.Ins_Piece_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downPieceBtn);
            return;
        }// end function

        public function releasePieceBtn() : void
        {
            this.Ins_Item_Control.Ins_Piece_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downPieceBtn);
            return;
        }// end function

        public function downPieceBtn(event:MouseEvent) : void
        {
            this.piece_btn_flag = true;
            return;
        }// end function

        public function getPieceBtn() : Boolean
        {
            return this.piece_btn_flag;
        }// end function

        public function setPieceBtn(param1:Boolean) : void
        {
            this.piece_btn_flag = param1;
            return;
        }// end function

        public function dispPieceBtn(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Piece_Btn.visible = param1;
            return;
        }// end function

        public function entryOpenPieBtn() : void
        {
            var _loc_1:* = 0;
            this.Ins_Item_Control.Ins_HitPie.addEventListener(MouseEvent.MOUSE_DOWN, this.downOpenPieBtn);
            this.Ins_Item_Control.Ins_HitPie.addEventListener(MouseEvent.MOUSE_UP, this.outOpenPieBtn);
            this.Ins_Item_Control.Ins_HitPie.addEventListener(MouseEvent.MOUSE_OUT, this.outOpenPieBtn);
            this.Ins_Item_Control.Ins_HitPie.addEventListener(MouseEvent.MOUSE_MOVE, this.moveOpenPieBtn);
            this.Ins_Item_Control.Ins_HitPie.scaleX = this._CIRCLE_SCALE;
            this.Ins_Item_Control.Ins_HitPie.scaleY = this.Ins_Item_Control.Ins_HitPie.scaleX;
            _loc_1 = 90 - this.pie_status[this.circle_mode_id].dir * this.pie_open_id;
            this.dispOpenPieBtn(true, _loc_1);
            this.hitpie_rock_flag = false;
            return;
        }// end function

        public function releaseOpenPieBtn() : void
        {
            this.Ins_Item_Control.Ins_HitPie.removeEventListener(MouseEvent.MOUSE_UP, this.downOpenPieBtn);
            return;
        }// end function

        public function downOpenPieBtn(event:MouseEvent) : void
        {
            this.hitpie_rock_flag = true;
            return;
        }// end function

        public function outOpenPieBtn(event:MouseEvent) : void
        {
            this.hitpie_rock_flag = false;
            return;
        }// end function

        public function moveOpenPieBtn(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.hitpie_rock_flag == true)
            {
                _loc_2 = this.getDirPtoP(this._DISPLAY_W / 2, this._DISPLAY_H / 2, this.mouseX, this.mouseY);
                _loc_3 = this.changeDir180(_loc_2, 1);
                this.pie_open_id = Math.round((180 - _loc_3) / this.pie_status[this.circle_mode_id].dir);
                if (this.pie_open_id > this.pie_status[this.circle_mode_id].num_max)
                {
                    this.pie_open_id = this.pie_status[this.circle_mode_id].num_max;
                }
                else if (this.pie_open_id < this.pie_status[this.circle_mode_id].num_min)
                {
                    this.pie_open_id = this.pie_status[this.circle_mode_id].num_min;
                }
                this.refresh_flag = true;
                if (_loc_2 > 0 && _loc_2 >= 90)
                {
                    _loc_2 = 90;
                }
                else if (_loc_2 < 0 && _loc_2 <= -90)
                {
                    _loc_2 = -90;
                }
                this.dispOpenPieBtn(true, _loc_2);
            }
            return;
        }// end function

        public function dispOpenPieBtn(param1:Boolean, param2:Number) : void
        {
            this.Ins_Item_Control.Ins_HitPie.visible = param1;
            this.Ins_Item_Control.Ins_HitPie.x = Math.cos(param2 * Math.PI / 180) * 235 * this._CIRCLE_SCALE;
            this.Ins_Item_Control.Ins_HitPie.y = Math.sin(param2 * Math.PI / 180) * 235 * this._CIRCLE_SCALE;
            return;
        }// end function

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.circle_mode_id = 0;
            this.pie_open_id = 0;
            this.pause_flag = false;
            this.start_btn_flag = false;
            this.stop_btn_flag = false;
            this.reset_btn_flag = false;
            this.piece_btn_flag = false;
            this.explain_flag = false;
            this.refresh_flag = false;
            this.pie_status = [{no:0, dir:20, touch_dir:20, dir_piece:1, w_size:80, h_size:235 - 5, w_ofs:0.25, ins1:"Ins_Circle_R1", ins2:"Ins_Circle_B1", num_min:2, num_max:9, scale_x:1, scale_y:1}, {no:1, dir:10, touch_dir:20, dir_piece:2, w_size:40, h_size:235 - 5, w_ofs:0.25, ins1:"Ins_Circle_R2", ins2:"Ins_Circle_B2", num_min:4, num_max:18, scale_x:0.975, scale_y:1}, {no:2, dir:5, touch_dir:20, dir_piece:4, w_size:20, h_size:235 - 5, w_ofs:0.5, ins1:"Ins_Circle_R3", ins2:"Ins_Circle_B3", num_min:8, num_max:36, scale_x:0.95, scale_y:1}, {no:3, dir:2.5, touch_dir:20, dir_piece:8, w_size:10, h_size:235 - 5, w_ofs:0.5, ins1:"Ins_Circle_R4", ins2:"Ins_Circle_B4", num_min:16, num_max:72, scale_x:0.909, scale_y:1}];
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
            this.explain_index = 0;
            this.explain_timer = 0;
            this.circle_r_dx = 0;
            this.circle_r_dy = 0;
            this.circle_r_dir = 0;
            this.circle_b_dx = 0;
            this.circle_b_dy = 0;
            this.circle_b_dir = 0;
            return;
        }// end function

    }
}
