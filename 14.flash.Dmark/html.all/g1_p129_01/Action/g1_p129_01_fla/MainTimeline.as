package g1_p129_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Main_mode:uint;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var point_counter:Number;
        public var point_loop_max:Number;
        public var point_step_x:Number;
        public var point_step_g:Number;
        public var plot_step1_flag:Boolean;
        public var plot_step2_flag:Boolean;
        public var step1_btn_flag:Boolean;
        public var step2_btn_flag:Boolean;
        public var step3_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var pause_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _SURFASE_BASE_W:uint = 35;
        public const _SURFASE_BASE_H:uint = 35;
        public const _FUNC_START_DX:Number = -8;
        public const _FUNC_END_DX:Number = 8;
        public const _POINT_SIZE:uint = 3;
        public const _PLOT_NUM1:uint = 16;
        public const _PLOT_NUM2:uint = 30;
        public var point_shape:Object;
        public var point_mc:Graphics;
        public var disp_point_tbl:Array;
        public var random_point_num:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;

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
                    this.entryStep1Btn();
                    this.entryStep2Btn();
                    this.entryStep3Btn();
                    this.entryResetBtn();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    this.initExplain();
                    this.setStep1Btn(false);
                    this.setStep2Btn(false);
                    this.setStep3Btn(false);
                    this.setResetBtn(false);
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getStep1Btn() == true)
                    {
                        this.setStep1Btn(false);
                        if (this.point_counter < this._PLOT_NUM1)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 30;
                        }
                    }
                    else if (this.getStep2Btn() == true)
                    {
                        this.setStep2Btn(false);
                        if (this.point_counter < this._PLOT_NUM2)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 31;
                        }
                    }
                    else if (this.getStep3Btn() == true)
                    {
                        this.setStep3Btn(false);
                        this.point_step_g = 0;
                        this.point_step_x = this._FUNC_START_DX;
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 40;
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    break;
                }
                case 30:
                {
                    if (this.getStep2Btn() == true)
                    {
                        this.setStep2Btn(false);
                        if (this.point_counter < this._PLOT_NUM2)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 31;
                        }
                    }
                    else if (this.getStep3Btn() == true)
                    {
                        this.setStep3Btn(false);
                        this.point_step_g = 0;
                        this.point_step_x = this._FUNC_START_DX;
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 40;
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        if (this.Main_timer > 2)
                        {
                            _loc_2 = this.point_step_x;
                            (this.point_step_x + 1);
                            if (_loc_2 <= this._FUNC_END_DX)
                            {
                                if (_loc_2 != 0 && (_loc_2 > 0.5 || _loc_2 < -0.5))
                                {
                                    this.dispLinePoint(_loc_2, this.point_step_x, 1, this._POINT_SIZE);
                                    var _loc_3:* = this;
                                    var _loc_4:* = this.point_counter + 1;
                                    _loc_3.point_counter = _loc_4;
                                    if (this.point_counter > this._PLOT_NUM1)
                                    {
                                        this.point_counter = this._PLOT_NUM1;
                                    }
                                }
                                this.Main_timer = 0;
                            }
                            else
                            {
                                this.plot_step1_flag = true;
                                this.Main_timer = 0;
                                this.Main_action = 0;
                                this.Main_index = 20;
                            }
                        }
                    }
                    break;
                }
                case 31:
                {
                    if (this.getStep1Btn() == true)
                    {
                        this.setStep1Btn(false);
                        if (this.point_counter < this._PLOT_NUM1)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 30;
                        }
                    }
                    else if (this.getStep3Btn() == true)
                    {
                        this.setStep3Btn(false);
                        this.point_step_g = 0;
                        this.point_step_x = this._FUNC_START_DX;
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 40;
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        if (this.Main_timer > 2)
                        {
                            _loc_2 = this.point_step_x;
                            this.point_step_x = this.point_step_x + 0.5;
                            if (_loc_2 <= this._FUNC_END_DX)
                            {
                                if (_loc_2 != 0 && (_loc_2 > 0.5 || _loc_2 < -0.5))
                                {
                                    this.dispLinePoint(_loc_2, this.point_step_x, 0.5, this._POINT_SIZE);
                                    if (this.plot_step1_flag == false)
                                    {
                                        var _loc_3:* = this;
                                        var _loc_4:* = this.point_counter + 1;
                                        _loc_3.point_counter = _loc_4;
                                        if (this.point_counter > this._PLOT_NUM2)
                                        {
                                            this.point_counter = this._PLOT_NUM2;
                                        }
                                    }
                                    else
                                    {
                                        this.point_counter = this.point_counter + 0.5;
                                        if (this.point_counter > this._PLOT_NUM2)
                                        {
                                            this.point_counter = this._PLOT_NUM2;
                                        }
                                    }
                                }
                                this.Main_timer = 0;
                            }
                            else
                            {
                                this.plot_step2_flag = true;
                                this.Main_timer = 0;
                                this.Main_action = 0;
                                this.Main_index = 20;
                            }
                        }
                    }
                    break;
                }
                case 40:
                {
                    if (this.plot_step1_flag == true || this.plot_step2_flag == true)
                    {
                        this.point_loop_max = this.disp_point_tbl[0].p_max - this.point_counter;
                    }
                    else
                    {
                        this.point_loop_max = this.disp_point_tbl[0].p_max;
                    }
                    this.point_step_g = 0;
                    this.point_step_x = 0;
                    this.Main_timer = 0;
                    this.Main_action = 1;
                    this.Main_index = 41;
                    break;
                }
                case 41:
                {
                    if (this.getStep1Btn() == true)
                    {
                        this.setStep1Btn(false);
                        if (this.point_counter < this._PLOT_NUM1)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 30;
                        }
                    }
                    else if (this.getStep2Btn() == true)
                    {
                        this.setStep2Btn(false);
                        if (this.point_counter < this._PLOT_NUM2)
                        {
                            this.point_step_g = 0;
                            this.point_step_x = this._FUNC_START_DX;
                            this.Main_timer = 0;
                            this.Main_action = 0;
                            this.Main_index = 31;
                        }
                    }
                    else if (this.getStep3Btn() == true)
                    {
                        this.setStep3Btn(false);
                        this.point_loop_max = this.disp_point_tbl[this.point_step_g].p_max;
                        this.point_step_x = 0;
                        this.Main_timer = 0;
                        this.Main_action = 1;
                    }
                    else if (this.getResetBtn() == true)
                    {
                        this.setResetBtn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 10;
                    }
                    else if (this.Main_action != 0)
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this.Main_timer + 1;
                        _loc_3.Main_timer = _loc_4;
                        if (this.Main_timer > this.disp_point_tbl[this.point_step_g].frame)
                        {
                            this.dispLinePointRandom(this.disp_point_tbl[this.point_step_g].p_num, this._POINT_SIZE);
                            this.point_counter = this.point_counter + this.disp_point_tbl[this.point_step_g].p_num * 2;
                            this.point_step_x = this.point_step_x + this.disp_point_tbl[this.point_step_g].p_num * 2;
                            this.Main_timer = 0;
                            if (this.point_step_x > (this.point_loop_max - 1))
                            {
                                var _loc_3:* = this;
                                var _loc_4:* = this.point_step_g + 1;
                                _loc_3.point_step_g = _loc_4;
                                this.Main_action = 0;
                                if (this.point_step_g > (this.disp_point_tbl.length - 1))
                                {
                                    this.Main_timer = 0;
                                    this.Main_action = 0;
                                    this.Main_index = 20;
                                }
                            }
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
            this.dispPointNum(int(this.point_counter));
            return;
        }// end function

        public function clearMainEvent() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.controlMain);
            this.Ins_Item_Explain.Ins_PointMc.removeChild(this.point_shape);
            this.releaseStep1Btn();
            this.releaseStep2Btn();
            this.releaseStep3Btn();
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
            return;
        }// end function

        public function resetMainItem() : void
        {
            return;
        }// end function

        public function initExplain() : void
        {
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.point_mc.clear();
            this.point_counter = 0;
            this.dispPointNum(this.point_counter);
            this.plot_step1_flag = false;
            this.plot_step2_flag = false;
            return;
        }// end function

        public function dispLinePoint(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = param1;
            this.point_mc.lineStyle(0, 0);
            this.point_mc.beginFill(0);
            while (_loc_5 < param2)
            {
                
                this.point_mc.drawCircle(_loc_5 * this._SURFASE_BASE_W, this.getLinePointY(_loc_5) * this._SURFASE_BASE_H, param4);
                _loc_5 = _loc_5 + param3;
            }
            this.point_mc.endFill();
            return;
        }// end function

        public function dispLinePointRandom(param1:int, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.point_mc.lineStyle(0, 0);
            this.point_mc.beginFill(0);
            _loc_3 = 0;
            while (_loc_3 < param1)
            {
                
                _loc_4 = Math.random() * 16 + this._FUNC_START_DX;
                if (_loc_4 > -0.75 && _loc_4 <= 0)
                {
                    _loc_4 = _loc_4 - 0.75;
                }
                else if (_loc_4 >= 0 && _loc_4 < 0.75)
                {
                    _loc_4 = _loc_4 + 0.75;
                }
                _loc_5 = this.getLinePointY(_loc_4);
                this.point_mc.drawCircle(_loc_4 * this._SURFASE_BASE_W, _loc_5 * this._SURFASE_BASE_H, param2);
                if (_loc_4 < 0)
                {
                    _loc_4 = Math.random() * 2;
                    if (_loc_4 >= 0 && _loc_4 < 0.75)
                    {
                        _loc_4 = _loc_4 + 0.75;
                    }
                    _loc_5 = this.getLinePointY(_loc_4);
                    this.point_mc.drawCircle(_loc_4 * this._SURFASE_BASE_W, _loc_5 * this._SURFASE_BASE_H, param2);
                }
                else
                {
                    _loc_4 = Math.random() * 2 * -1;
                    if (_loc_4 > -0.75 && _loc_4 <= 0)
                    {
                        _loc_4 = _loc_4 - 0.75;
                    }
                    _loc_5 = this.getLinePointY(_loc_4);
                    this.point_mc.drawCircle(_loc_4 * this._SURFASE_BASE_W, _loc_5 * this._SURFASE_BASE_H, param2);
                }
                _loc_3++;
            }
            this.point_mc.endFill();
            return;
        }// end function

        public function getLinePointY(param1:Number) : Number
        {
            return -6 / param1;
        }// end function

        public function dispPointNum(param1:Number) : void
        {
            this.Ins_Item_Control.Ins_PointNum.text = String(param1);
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

        public function entryStep1Btn() : void
        {
            this.Ins_Item_Control.Ins_Step1_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStep1Btn);
            return;
        }// end function

        public function releaseStep1Btn() : void
        {
            this.Ins_Item_Control.Ins_Step1_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStep1Btn);
            return;
        }// end function

        public function downStep1Btn(event:MouseEvent) : void
        {
            this.step1_btn_flag = true;
            return;
        }// end function

        public function getStep1Btn() : Boolean
        {
            return this.step1_btn_flag;
        }// end function

        public function setStep1Btn(param1:Boolean) : void
        {
            this.step1_btn_flag = param1;
            return;
        }// end function

        public function entryStep2Btn() : void
        {
            this.Ins_Item_Control.Ins_Step2_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStep2Btn);
            return;
        }// end function

        public function releaseStep2Btn() : void
        {
            this.Ins_Item_Control.Ins_Step2_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStep2Btn);
            return;
        }// end function

        public function downStep2Btn(event:MouseEvent) : void
        {
            this.step2_btn_flag = true;
            return;
        }// end function

        public function getStep2Btn() : Boolean
        {
            return this.step2_btn_flag;
        }// end function

        public function setStep2Btn(param1:Boolean) : void
        {
            this.step2_btn_flag = param1;
            return;
        }// end function

        public function entryStep3Btn() : void
        {
            this.Ins_Item_Control.Ins_Step3_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStep3Btn);
            return;
        }// end function

        public function releaseStep3Btn() : void
        {
            this.Ins_Item_Control.Ins_Step3_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStep3Btn);
            return;
        }// end function

        public function downStep3Btn(event:MouseEvent) : void
        {
            this.step3_btn_flag = true;
            return;
        }// end function

        public function getStep3Btn() : Boolean
        {
            return this.step3_btn_flag;
        }// end function

        public function setStep3Btn(param1:Boolean) : void
        {
            this.step3_btn_flag = param1;
            return;
        }// end function

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.point_counter = 0;
            this.point_loop_max = 0;
            this.point_step_x = 0;
            this.point_step_g = 0;
            this.plot_step1_flag = false;
            this.plot_step2_flag = false;
            this.step1_btn_flag = false;
            this.step2_btn_flag = false;
            this.step3_btn_flag = false;
            this.reset_btn_flag = false;
            this.pause_flag = false;
            this.point_shape = new Shape();
            this.Ins_Item_Explain.Ins_PointMc.addChild(this.point_shape);
            this.point_mc = this.point_shape.graphics;
            this.disp_point_tbl = [{no:1, frame:0, p_num:1, p_max:50, dlt_x:0.25 / 1, speed:0.02, p_size:this._POINT_SIZE}, {no:2, frame:0, p_num:1, p_max:100, dlt_x:0.25 / 2, speed:0.02, p_size:this._POINT_SIZE}, {no:3, frame:0, p_num:1, p_max:150, dlt_x:0.25 / 4, speed:0.02, p_size:this._POINT_SIZE}, {no:4, frame:0, p_num:1, p_max:1200, dlt_x:0.25 / 8, speed:0.02, p_size:this._POINT_SIZE}, {no:5, frame:0, p_num:1, p_max:500, dlt_x:0.25 / 16, speed:0.02, p_size:this._POINT_SIZE}];
            this.random_point_num = [1, 2, 3, 4, 5, 6, 7, 8];
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
