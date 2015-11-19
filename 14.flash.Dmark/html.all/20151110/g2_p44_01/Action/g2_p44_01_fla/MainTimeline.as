package g2_p44_01_fla
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
        public var explain_start_flag:Boolean;
        public var weight_touch_flag:Boolean;
        public var weight_refresh_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _FRUIT1_NUM:uint = 40;
        public const _FRUIT2_NUM:uint = 40;
        public const _FRUIT3_NUM:uint = 20;
        public const _FRUIT1_MAX:uint = 20;
        public const _FRUIT2_MAX:uint = 20;
        public const _FRUIT3_MAX:uint = 5;
        public const _BALANCE_POSX:int = -176;
        public const _BALANCE_POSY:int = 127;
        public const _PLATE1_POSY:Number = -105;
        public const _PLATE2_POSY:Number = -105;
        public const _PLATE_SCALE:Number = 0.6;
        public const _FRUIT1_OFSX:int = -5;
        public const _FRUIT2_OFSX:int = 530;
        public const _FRUIT_OFSY:int = 65;
        public const _DRAG_AREA_1:uint = 1;
        public const _DRAG_AREA_2:uint = 2;
        public const _DRAG_AREA_3:uint = 3;
        public const _DRAG_AREA_4:uint = 4;
        public const _DRAG_AREA_5:uint = 5;
        public const _DRAG_AREA_6:uint = 6;
        public var weight_status:Array;
        public var weight1_pos1_tbl:Array;
        public var weight1_pos2_tbl:Array;
        public var weight2_pos1_tbl:Array;
        public var weight2_pos2_tbl:Array;
        public var fruit_box_num:Array;
        public var fruit_num_tbl:Array;
        public var deb_mc:MovieClip;
        public var deb_text:TextField;
        public var quest_list_no:int;
        public var weight_num:int;
        public var weight1_counter:int;
        public var weight2_counter:int;
        public var weight3_counter:int;
        public var area_weight_num:Array;
        public var balance1_id:uint;
        public var balance2_id:uint;
        public var game_index:int;
        public var game_timer:int;

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
                    this.entryInfoInBtn();
                    this.entryInfoOutBtn();
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
                    this.controlGame();
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
            this.releasInfoInBtn();
            this.releasInfoOutBtn();
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
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.explain_start_flag = false;
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT1_NUM)
            {
                
                _loc_2 = "Ins_Weight1_" + (_loc_1 + 1);
                this.initWeight1((_loc_1 + 1), _loc_2);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT2_NUM)
            {
                
                _loc_2 = "Ins_Weight2_" + (_loc_1 + 1);
                this.initWeight2((_loc_1 + 1), _loc_2);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT3_NUM)
            {
                
                _loc_2 = "Ins_Weight3_" + (_loc_1 + 1);
                this.initWeight3((_loc_1 + 1), _loc_2);
                _loc_1++;
            }
            this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num1.visible = false;
            this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num2.visible = false;
            this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num3.visible = false;
            this.Ins_Item_Control.Ins_Info_In.visible = false;
            this.Ins_Item_Control.Ins_Info_Out.visible = true;
            this.Ins_Item_Explain.Ins_Info.gotoAndStop("disp");
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
            this.Ins_Item_Control.visible = true;
            this.Ins_Item_Explain.visible = true;
            this.weight_touch_flag = false;
            this.weight_refresh_flag = false;
            this.game_index = 0;
            this.weight_num = 0;
            this.weight1_counter = 0;
            this.weight2_counter = 0;
            this.weight3_counter = 0;
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT1_NUM)
            {
                
                _loc_3 = "Ins_Weight1_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT2_NUM)
            {
                
                _loc_3 = "Ins_Weight2_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._FRUIT3_NUM)
            {
                
                _loc_3 = "Ins_Weight3_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, 0, 0, false);
                _loc_1++;
            }
            this.balance1_id = 0;
            this.balance2_id = 0;
            this.dispBalance1("base", this._BALANCE_POSX, this._BALANCE_POSY);
            this.dispDish1OnWeightL(this.fruit_num_tbl[0].num[0], this.fruit_num_tbl[0].num[1], this.fruit_num_tbl[0].num[2], 1, 1, 7);
            this.dispDish1OnWeightR(this.fruit_num_tbl[0].num[3], this.fruit_num_tbl[0].num[4], this.fruit_num_tbl[0].num[5], 1, 1, 7);
            this.dispDish2OnWeightL(this.fruit_num_tbl[1].num[0], this.fruit_num_tbl[1].num[1], this.fruit_num_tbl[1].num[2], 1, 1, 7);
            this.dispDish2OnWeightR(this.fruit_num_tbl[1].num[3], this.fruit_num_tbl[1].num[4], this.fruit_num_tbl[1].num[5], 1, 1, 7);
            this.area_weight_num[0] = 0;
            this.area_weight_num[1] = this.fruit_num_tbl[0].num[0] + this.fruit_num_tbl[0].num[1] + this.fruit_num_tbl[0].num[2];
            this.area_weight_num[2] = this.fruit_num_tbl[0].num[3] + this.fruit_num_tbl[0].num[4] + this.fruit_num_tbl[0].num[5];
            this.area_weight_num[3] = 0;
            this.area_weight_num[4] = this.fruit_num_tbl[1].num[0] + this.fruit_num_tbl[1].num[1] + this.fruit_num_tbl[1].num[2];
            this.area_weight_num[5] = this.fruit_num_tbl[1].num[3] + this.fruit_num_tbl[1].num[4] + this.fruit_num_tbl[1].num[5];
            this.fruit_box_num[1] = this._FRUIT1_NUM - (this.fruit_num_tbl[0].num[0] + this.fruit_num_tbl[0].num[3] + this.fruit_num_tbl[1].num[0] + this.fruit_num_tbl[1].num[3]);
            this.fruit_box_num[2] = this._FRUIT2_NUM - (this.fruit_num_tbl[0].num[1] + this.fruit_num_tbl[0].num[4] + this.fruit_num_tbl[1].num[1] + this.fruit_num_tbl[1].num[4]);
            this.fruit_box_num[3] = this._FRUIT3_NUM - (this.fruit_num_tbl[0].num[2] + this.fruit_num_tbl[0].num[5] + this.fruit_num_tbl[1].num[2] + this.fruit_num_tbl[1].num[5]);
            this.fruit_box_num[0] = this.fruit_box_num[1] + this.fruit_box_num[2] + this.fruit_box_num[3];
            this.dispFruit1Box(this.fruit_box_num[1]);
            this.dispFruit2Box(this.fruit_box_num[2]);
            this.dispFruit3Box(this.fruit_box_num[3]);
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[0].num[0])
            {
                
                _loc_3 = "Ins_Weight1_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, this.weight1_pos1_tbl[_loc_1].dx, this.weight1_pos1_tbl[_loc_1].dy, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[0].num[4])
            {
                
                _loc_3 = "Ins_Weight2_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, this.weight1_pos2_tbl[_loc_1 + this._FRUIT1_MAX].dx, this.weight1_pos2_tbl[_loc_1 + this._FRUIT1_MAX].dy, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[0].num[5])
            {
                
                _loc_3 = "Ins_Weight3_" + (_loc_1 + 1);
                this.dispWeight(_loc_3, this.weight1_pos2_tbl[_loc_1 + this._FRUIT1_MAX + this._FRUIT2_MAX].dx, this.weight1_pos2_tbl[_loc_1 + this._FRUIT1_MAX + this._FRUIT2_MAX].dy, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[1].num[0])
            {
                
                _loc_3 = "Ins_Weight1_" + ((_loc_1 + 1) + this.fruit_num_tbl[0].num[0]);
                this.dispWeight(_loc_3, this.weight2_pos1_tbl[_loc_1].dx, this.weight2_pos1_tbl[_loc_1].dy, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[1].num[1])
            {
                
                _loc_3 = "Ins_Weight2_" + ((_loc_1 + 1) + this.fruit_num_tbl[0].num[4]);
                this.dispWeight(_loc_3, this.weight2_pos1_tbl[_loc_1 + this._FRUIT1_MAX].dx, this.weight2_pos1_tbl[_loc_1 + this._FRUIT1_MAX].dy, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.fruit_num_tbl[1].num[5])
            {
                
                _loc_3 = "Ins_Weight3_" + ((_loc_1 + 1) + this.fruit_num_tbl[0].num[5]);
                this.dispWeight(_loc_3, this.weight2_pos2_tbl[_loc_1 + this._FRUIT1_MAX + this._FRUIT2_MAX].dx, this.weight2_pos2_tbl[_loc_1 + this._FRUIT1_MAX + this._FRUIT2_MAX].dy, true);
                _loc_1++;
            }
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
                        if (this.explain_start_flag == false)
                        {
                            this.explain_start_flag = true;
                        }
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
                        this.balance1Plate();
                        this.balance2Plate();
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
                        this.movePlate1Weight(this.weight_num);
                        this.movePlate2Weight(this.weight_num);
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

        public function dispDish1OnWeightL(param1:uint, param2:uint, param3, param4:uint, param5:uint, param6:uint) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = this._FRUIT1_MAX;
            var _loc_10:* = this._FRUIT1_MAX + this._FRUIT2_MAX;
            var _loc_11:* = "";
            if (param1 > this._FRUIT1_MAX || param2 > this._FRUIT2_MAX || param3 > this._FRUIT3_MAX)
            {
                return;
            }
            _loc_7 = 0;
            while (_loc_7 < param1)
            {
                
                _loc_11 = "Ins_Weight1_" + (this.weight1_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos1_tbl[_loc_8].dx, this.weight1_pos1_tbl[_loc_8].dy, true);
                this.weight_status[this.weight_num].type = 1;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param4;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight1_counter + 1;
                _loc_12.weight1_counter = _loc_13;
                _loc_8++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param2)
            {
                
                _loc_11 = "Ins_Weight2_" + (this.weight2_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos1_tbl[_loc_9].dx, this.weight1_pos1_tbl[_loc_9].dy, true);
                this.weight_status[this.weight_num].type = 2;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param5;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight2_counter + 1;
                _loc_12.weight2_counter = _loc_13;
                _loc_9++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param3)
            {
                
                _loc_11 = "Ins_Weight3_" + (this.weight3_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos1_tbl[_loc_10].dx, this.weight1_pos1_tbl[_loc_10].dy, true);
                this.weight_status[this.weight_num].type = 3;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_1;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param6;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight3_counter + 1;
                _loc_12.weight3_counter = _loc_13;
                _loc_10++;
                _loc_7++;
            }
            return;
        }// end function

        public function dispDish1OnWeightR(param1:uint, param2:uint, param3, param4:uint, param5:uint, param6:uint) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = this._FRUIT1_MAX;
            var _loc_10:* = this._FRUIT1_MAX + this._FRUIT2_MAX;
            var _loc_11:* = "";
            if (param1 > this._FRUIT1_MAX || param2 > this._FRUIT2_MAX || param3 > this._FRUIT3_MAX)
            {
                return;
            }
            _loc_7 = 0;
            while (_loc_7 < param1)
            {
                
                _loc_11 = "Ins_Weight1_" + (this.weight1_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos2_tbl[_loc_8].dx, this.weight1_pos2_tbl[_loc_8].dy, true);
                this.weight_status[this.weight_num].type = 1;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param4;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight1_counter + 1;
                _loc_12.weight1_counter = _loc_13;
                _loc_8++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param2)
            {
                
                _loc_11 = "Ins_Weight2_" + (this.weight2_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos2_tbl[_loc_9].dx, this.weight1_pos2_tbl[_loc_9].dy, true);
                this.weight_status[this.weight_num].type = 2;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param5;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight2_counter + 1;
                _loc_12.weight2_counter = _loc_13;
                _loc_9++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param3)
            {
                
                _loc_11 = "Ins_Weight3_" + (this.weight3_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos2_tbl[_loc_10].dx, this.weight1_pos2_tbl[_loc_10].dy, true);
                this.weight_status[this.weight_num].type = 3;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_2;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param6;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight3_counter + 1;
                _loc_12.weight3_counter = _loc_13;
                _loc_10++;
                _loc_7++;
            }
            return;
        }// end function

        public function dispDish2OnWeightL(param1:uint, param2:uint, param3, param4:uint, param5:uint, param6:uint) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = this._FRUIT1_MAX;
            var _loc_10:* = this._FRUIT1_MAX + this._FRUIT2_MAX;
            var _loc_11:* = "";
            if (param1 > this._FRUIT1_MAX || param2 > this._FRUIT2_MAX || param3 > this._FRUIT3_MAX)
            {
                return;
            }
            _loc_7 = 0;
            while (_loc_7 < param1)
            {
                
                _loc_11 = "Ins_Weight1_" + (this.weight1_counter + 1);
                this.dispWeight(_loc_11, this.weight2_pos1_tbl[_loc_8].dx, this.weight2_pos1_tbl[_loc_8].dy, true);
                this.weight_status[this.weight_num].type = 1;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_5;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param4;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight1_counter + 1;
                _loc_12.weight1_counter = _loc_13;
                _loc_8++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param2)
            {
                
                _loc_11 = "Ins_Weight2_" + (this.weight2_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos2_tbl[_loc_9].dx, this.weight1_pos2_tbl[_loc_9].dy, true);
                this.weight_status[this.weight_num].type = 2;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_5;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param5;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight2_counter + 1;
                _loc_12.weight2_counter = _loc_13;
                _loc_9++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param3)
            {
                
                _loc_11 = "Ins_Weight3_" + (this.weight3_counter + 1);
                this.dispWeight(_loc_11, this.weight1_pos2_tbl[_loc_10].dx, this.weight2_pos1_tbl[_loc_10].dy, true);
                this.weight_status[this.weight_num].type = 3;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_5;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param6;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight3_counter + 1;
                _loc_12.weight3_counter = _loc_13;
                _loc_10++;
                _loc_7++;
            }
            return;
        }// end function

        public function dispDish2OnWeightR(param1:uint, param2:uint, param3, param4:uint, param5:uint, param6:uint) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = this._FRUIT1_MAX;
            var _loc_10:* = this._FRUIT1_MAX + this._FRUIT2_MAX;
            var _loc_11:* = "";
            if (param1 > this._FRUIT1_MAX || param2 > this._FRUIT2_MAX || param3 > this._FRUIT3_MAX)
            {
                return;
            }
            _loc_7 = 0;
            while (_loc_7 < param1)
            {
                
                _loc_11 = "Ins_Weight1_" + (this.weight1_counter + 1);
                this.dispWeight(_loc_11, this.weight2_pos2_tbl[_loc_8].dx, this.weight2_pos2_tbl[_loc_8].dy, true);
                this.weight_status[this.weight_num].type = 1;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_6;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param4;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight1_counter + 1;
                _loc_12.weight1_counter = _loc_13;
                _loc_8++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param2)
            {
                
                _loc_11 = "Ins_Weight2_" + (this.weight2_counter + 1);
                this.dispWeight(_loc_11, this.weight2_pos2_tbl[_loc_9].dx, this.weight2_pos2_tbl[_loc_9].dy, true);
                this.weight_status[this.weight_num].type = 2;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_6;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param5;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight2_counter + 1;
                _loc_12.weight2_counter = _loc_13;
                _loc_9++;
                _loc_7++;
            }
            _loc_7 = 0;
            while (_loc_7 < param3)
            {
                
                _loc_11 = "Ins_Weight3_" + (this.weight3_counter + 1);
                this.dispWeight(_loc_11, this.weight2_pos2_tbl[_loc_10].dx, this.weight2_pos2_tbl[_loc_10].dy, true);
                this.weight_status[this.weight_num].type = 3;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_6;
                this.weight_status[this.weight_num].ins = _loc_11;
                this.weight_status[this.weight_num].num = param6;
                var _loc_12:* = this;
                var _loc_13:* = this.weight_num + 1;
                _loc_12.weight_num = _loc_13;
                var _loc_12:* = this;
                var _loc_13:* = this.weight3_counter + 1;
                _loc_12.weight3_counter = _loc_13;
                _loc_10++;
                _loc_7++;
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
                else if (checkFruitDragArea(wk_weight) == true)
                {
                    wk_area_id = 4;
                }
                else if (checkPlate3DragArea(wk_weight) == true)
                {
                    wk_area_id = 5;
                }
                else if (checkPlate4DragArea(wk_weight) == true)
                {
                    wk_area_id = 6;
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
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (checkPlate1DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                else if (checkPlate2DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 1) < _FRUIT1_MAX)
                            {
                            }
                            else
                            {
                            }
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
                        case 4:
                        {
                            break;
                        }
                        case 5:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (checkPlate3DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                            case 6:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    else if (checkPlate4DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 1) < _FRUIT1_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 6:
                            {
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
                else if (checkFruitDragArea(wk_weight) == true)
                {
                    wk_area_id = 4;
                }
                else if (checkPlate3DragArea(wk_weight) == true)
                {
                    wk_area_id = 5;
                }
                else if (checkPlate4DragArea(wk_weight) == true)
                {
                    wk_area_id = 6;
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
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (checkPlate1DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                else if (checkPlate2DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 2) < _FRUIT2_MAX)
                            {
                            }
                            else
                            {
                            }
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
                        case 4:
                        {
                            break;
                        }
                        case 5:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (checkPlate3DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                            case 6:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    else if (checkPlate4DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 2) < _FRUIT2_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 6:
                            {
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

        public function initWeight3(param1:int, param2:String) : void
        {
            var wk_rock_flag:Boolean;
            var wk_weight:Weight3;
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
                wk_weight.Ins_Hit.scaleX = 1.5;
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
                else if (checkFruitDragArea(wk_weight) == true)
                {
                    wk_area_id = 4;
                }
                else if (checkPlate3DragArea(wk_weight) == true)
                {
                    wk_area_id = 5;
                }
                else if (checkPlate4DragArea(wk_weight) == true)
                {
                    wk_area_id = 6;
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
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (checkPlate1DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_1, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                else if (checkPlate2DragArea(wk_weight) == true)
                {
                    switch(wk_area_id)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 2:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                        case 4:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 5:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
                            break;
                        }
                        case 6:
                        {
                            if (getWeightNum(weight_num, _DRAG_AREA_2, 3) < _FRUIT3_MAX)
                            {
                            }
                            else
                            {
                            }
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
                        case 4:
                        {
                            break;
                        }
                        case 5:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (checkPlate3DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                            case 6:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_5, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    else if (checkPlate4DragArea(wk_weight) == true)
                    {
                        switch(wk_area_id)
                        {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 2:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 3:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 4:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 5:
                            {
                                if (getWeightNum(weight_num, _DRAG_AREA_6, 3) < _FRUIT3_MAX)
                                {
                                }
                                else
                                {
                                }
                                break;
                            }
                            case 6:
                            {
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
            wk_weight = new Weight3();
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

        public function dispFruit1Box(param1:int) : void
        {
            var _loc_2:* = "";
            if (param1 > 0)
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num1.text = "×" + param1;
                _loc_2 = "Ins_Weight1_" + (this.weight1_counter + 1);
                this.dispWeight(_loc_2, 227, 252, true);
                this.weight_status[this.weight_num].type = 1;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_4;
                this.weight_status[this.weight_num].ins = _loc_2;
                this.weight_status[this.weight_num].num = 1;
                var _loc_3:* = this;
                var _loc_4:* = this.weight_num + 1;
                _loc_3.weight_num = _loc_4;
                var _loc_3:* = this;
                var _loc_4:* = this.weight1_counter + 1;
                _loc_3.weight1_counter = _loc_4;
            }
            else
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num1.text = "×0";
            }
            return;
        }// end function

        public function dispFruit2Box(param1:int) : void
        {
            var _loc_2:* = "";
            if (param1 > 0)
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num2.text = "×" + param1;
                _loc_2 = "Ins_Weight2_" + (this.weight2_counter + 1);
                this.dispWeight(_loc_2, 440, 252, true);
                this.weight_status[this.weight_num].type = 2;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_4;
                this.weight_status[this.weight_num].ins = _loc_2;
                this.weight_status[this.weight_num].num = 1;
                var _loc_3:* = this;
                var _loc_4:* = this.weight_num + 1;
                _loc_3.weight_num = _loc_4;
                var _loc_3:* = this;
                var _loc_4:* = this.weight2_counter + 1;
                _loc_3.weight2_counter = _loc_4;
            }
            else
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num2.text = "×0";
            }
            return;
        }// end function

        public function dispFruit3Box(param1:int) : void
        {
            var _loc_2:* = "";
            if (param1 > 0)
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num3.text = "×" + param1;
                _loc_2 = "Ins_Weight3_" + (this.weight3_counter + 1);
                this.dispWeight(_loc_2, 339, 249, true);
                this.weight_status[this.weight_num].type = 3;
                this.weight_status[this.weight_num].area = this._DRAG_AREA_4;
                this.weight_status[this.weight_num].ins = _loc_2;
                this.weight_status[this.weight_num].num = 7;
                var _loc_3:* = this;
                var _loc_4:* = this.weight_num + 1;
                _loc_3.weight_num = _loc_4;
                var _loc_3:* = this;
                var _loc_4:* = this.weight3_counter + 1;
                _loc_3.weight3_counter = _loc_4;
            }
            else
            {
                this.Ins_Item_Control.Ins_Fruit_DragArea.Ins_Fruit_Num3.text = "×0";
            }
            return;
        }// end function

        public function dispWeight(param1:String, param2:int, param3:int, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = this.Ins_Item_Control.Ins_WeightMc.getChildByName(param1);
            _loc_6 = _loc_5 as MovieClip;
            _loc_5.visible = param4;
            _loc_5.x = param2;
            _loc_5.y = param3;
            return;
        }// end function

        public function changeWeightStatus(param1:String, param2:int, param3:uint) : void
        {
            var _loc_4:* = 0;
            _loc_4 = 0;
            while (_loc_4 < param2)
            {
                
                if (this.weight_status[_loc_4].ins == param1)
                {
                    this.weight_status[_loc_4].area = param3;
                    break;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function getWeightNum(param1:int, param2:uint, param3:uint) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = 0;
            while (_loc_4 < param1)
            {
                
                if (this.weight_status[_loc_4].area == param2 && this.weight_status[_loc_4].type == param3)
                {
                    _loc_5++;
                }
                _loc_4++;
            }
            return _loc_5;
        }// end function

        public function standPlate1Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = [0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX, 0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX];
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance1.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance1.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[0]].dx, this.weight1_pos1_tbl[_loc_3[0]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 0;
                                var _loc_8:* = _loc_3[0] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[1]].dx, this.weight1_pos1_tbl[_loc_3[1]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 1;
                                var _loc_8:* = _loc_3[1] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[2]].dx, this.weight1_pos1_tbl[_loc_3[2]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 2;
                                var _loc_8:* = _loc_3[2] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[3]].dx, this.weight1_pos2_tbl[_loc_3[3]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 3;
                                var _loc_8:* = _loc_3[3] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[4]].dx, this.weight1_pos2_tbl[_loc_3[4]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 4;
                                var _loc_8:* = _loc_3[4] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[5]].dx, this.weight1_pos2_tbl[_loc_3[5]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 5;
                                var _loc_8:* = _loc_3[5] + 1;
                                _loc_6[_loc_7] = _loc_8;
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
                _loc_2++;
            }
            return;
        }// end function

        public function standPlate2Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = [0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX, 0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX];
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance2.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance2.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_5:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[0]].dx, this.weight2_pos1_tbl[_loc_3[0]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 0;
                                var _loc_8:* = _loc_3[0] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[1]].dx, this.weight2_pos1_tbl[_loc_3[1]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 1;
                                var _loc_8:* = _loc_3[1] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[2]].dx, this.weight2_pos1_tbl[_loc_3[2]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 2;
                                var _loc_8:* = _loc_3[2] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case this._DRAG_AREA_6:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[3]].dx, this.weight2_pos2_tbl[_loc_3[3]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 3;
                                var _loc_8:* = _loc_3[3] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[4]].dx, this.weight2_pos2_tbl[_loc_3[4]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 4;
                                var _loc_8:* = _loc_3[4] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[5]].dx, this.weight2_pos2_tbl[_loc_3[5]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 5;
                                var _loc_8:* = _loc_3[5] + 1;
                                _loc_6[_loc_7] = _loc_8;
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
                _loc_2++;
            }
            return;
        }// end function

        public function balance1Plate() : void
        {
            var _loc_1:* = 0;
            _loc_1 = this.balance1PlateWeight(this.weight_num);
            switch(this.balance1_id)
            {
                case 0:
                {
                    if (_loc_1 == 1)
                    {
                        this.dispBalance1("left_down", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 2)
                    {
                        this.dispBalance1("right_down", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                case 1:
                {
                    if (_loc_1 == 0)
                    {
                        this.dispBalance1("left_base", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 2)
                    {
                        this.dispBalance1("left_right", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                case 2:
                {
                    if (_loc_1 == 0)
                    {
                        this.dispBalance1("right_base", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 1)
                    {
                        this.dispBalance1("right_left", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.balance1_id = _loc_1;
            return;
        }// end function

        public function balance2Plate() : void
        {
            var _loc_1:* = 0;
            _loc_1 = this.balance2PlateWeight(this.weight_num);
            switch(this.balance2_id)
            {
                case 0:
                {
                    if (_loc_1 == 1)
                    {
                        this.dispBalance2("left_down", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 2)
                    {
                        this.dispBalance2("right_down", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                case 1:
                {
                    if (_loc_1 == 0)
                    {
                        this.dispBalance2("left_base", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 2)
                    {
                        this.dispBalance2("left_right", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                case 2:
                {
                    if (_loc_1 == 0)
                    {
                        this.dispBalance2("right_base", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    else if (_loc_1 == 1)
                    {
                        this.dispBalance2("right_left", this._BALANCE_POSX, this._BALANCE_POSY);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.balance2_id = _loc_1;
            return;
        }// end function

        public function balance1PlateWeight(param1:int) : uint
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

        public function balance2PlateWeight(param1:int) : uint
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
                    case this._DRAG_AREA_5:
                    {
                        _loc_4 = _loc_4 + this.weight_status[_loc_3].num;
                        break;
                    }
                    case this._DRAG_AREA_6:
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

        public function dispBalance1(param1:String, param2:int, param3:int) : void
        {
            switch(param1)
            {
                case "base":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndStop("base");
                    break;
                }
                case "left_down":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("left_down");
                    break;
                }
                case "left_base":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("left_base");
                    break;
                }
                case "left_right":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("left_right");
                    break;
                }
                case "right_down":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("right_down");
                    break;
                }
                case "right_base":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("right_base");
                    break;
                }
                case "right_left":
                {
                    this.Ins_Item_Control.Ins_Balance1.gotoAndPlay("right_left");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function dispBalance2(param1:String, param2:int, param3:int) : void
        {
            switch(param1)
            {
                case "base":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndStop("base");
                    break;
                }
                case "left_down":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("left_down");
                    break;
                }
                case "left_base":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("left_base");
                    break;
                }
                case "left_right":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("left_right");
                    break;
                }
                case "right_down":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("right_down");
                    break;
                }
                case "right_base":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("right_base");
                    break;
                }
                case "right_left":
                {
                    this.Ins_Item_Control.Ins_Balance2.gotoAndPlay("right_left");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function movePlate1Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = [0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX, 0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX];
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance1.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance1.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_1:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[0]].dx, this.weight1_pos1_tbl[_loc_3[0]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 0;
                                var _loc_8:* = _loc_3[0] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[1]].dx, this.weight1_pos1_tbl[_loc_3[1]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 1;
                                var _loc_8:* = _loc_3[1] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos1_tbl[_loc_3[2]].dx, this.weight1_pos1_tbl[_loc_3[2]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 2;
                                var _loc_8:* = _loc_3[2] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case this._DRAG_AREA_2:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[3]].dx, this.weight1_pos2_tbl[_loc_3[3]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 3;
                                var _loc_8:* = _loc_3[3] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[4]].dx, this.weight1_pos2_tbl[_loc_3[4]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 4;
                                var _loc_8:* = _loc_3[4] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight1_pos2_tbl[_loc_3[5]].dx, this.weight1_pos2_tbl[_loc_3[5]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 5;
                                var _loc_8:* = _loc_3[5] + 1;
                                _loc_6[_loc_7] = _loc_8;
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
                _loc_2++;
            }
            return;
        }// end function

        public function movePlate2Weight(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = [0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX, 0, this._FRUIT1_MAX, this._FRUIT1_MAX + this._FRUIT2_MAX];
            var _loc_4:* = (this.Ins_Item_Control.Ins_Balance2.Ins_Plate1.y - this._PLATE1_POSY) * this._PLATE_SCALE;
            var _loc_5:* = (this.Ins_Item_Control.Ins_Balance2.Ins_Plate2.y - this._PLATE2_POSY) * this._PLATE_SCALE;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                switch(this.weight_status[_loc_2].area)
                {
                    case this._DRAG_AREA_5:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[0]].dx, this.weight2_pos1_tbl[_loc_3[0]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 0;
                                var _loc_8:* = _loc_3[0] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[1]].dx, this.weight2_pos1_tbl[_loc_3[1]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 1;
                                var _loc_8:* = _loc_3[1] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos1_tbl[_loc_3[2]].dx, this.weight2_pos1_tbl[_loc_3[2]].dy + _loc_4, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 2;
                                var _loc_8:* = _loc_3[2] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case this._DRAG_AREA_6:
                    {
                        switch(this.weight_status[_loc_2].type)
                        {
                            case 1:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[3]].dx, this.weight2_pos2_tbl[_loc_3[3]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 3;
                                var _loc_8:* = _loc_3[3] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 2:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[4]].dx, this.weight2_pos2_tbl[_loc_3[4]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 4;
                                var _loc_8:* = _loc_3[4] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                break;
                            }
                            case 3:
                            {
                                this.dispWeight(this.weight_status[_loc_2].ins, this.weight2_pos2_tbl[_loc_3[5]].dx, this.weight2_pos2_tbl[_loc_3[5]].dy + _loc_5, true);
                                var _loc_6:* = _loc_3;
                                var _loc_7:* = 5;
                                var _loc_8:* = _loc_3[5] + 1;
                                _loc_6[_loc_7] = _loc_8;
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
                _loc_2++;
            }
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

        public function checkPlate3DragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_Plate3_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function checkPlate4DragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_Plate4_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function checkFruitDragArea(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = false;
            _loc_2 = this.Ins_Item_Control.Ins_Fruit_DragArea.hitTestObject(param1);
            return _loc_2;
        }// end function

        public function entryInfoInBtn() : void
        {
            this.Ins_Item_Control.Ins_Info_In.addEventListener(MouseEvent.MOUSE_UP, this.downInfoInBtn);
            return;
        }// end function

        public function releasInfoInBtn() : void
        {
            this.Ins_Item_Control.Ins_Info_In.removeEventListener(MouseEvent.MOUSE_UP, this.downInfoInBtn);
            return;
        }// end function

        public function downInfoInBtn(event:MouseEvent) : void
        {
            this.Ins_Item_Explain.Ins_Info.gotoAndPlay("open");
            this.Ins_Item_Control.Ins_Info_In.visible = false;
            this.Ins_Item_Control.Ins_Info_Out.visible = true;
            return;
        }// end function

        public function getInfoInBtn() : Boolean
        {
            return false;
        }// end function

        public function setInfoInBtn(param1:Boolean) : void
        {
            return;
        }// end function

        public function entryInfoOutBtn() : void
        {
            this.Ins_Item_Control.Ins_Info_Out.addEventListener(MouseEvent.MOUSE_UP, this.downInfoOutBtn);
            return;
        }// end function

        public function releasInfoOutBtn() : void
        {
            this.Ins_Item_Control.Ins_Info_Out.removeEventListener(MouseEvent.MOUSE_UP, this.downInfoOutBtn);
            return;
        }// end function

        public function downInfoOutBtn(event:MouseEvent) : void
        {
            this.Ins_Item_Explain.Ins_Info.gotoAndPlay("out");
            this.Ins_Item_Control.Ins_Info_In.visible = true;
            this.Ins_Item_Control.Ins_Info_Out.visible = false;
            return;
        }// end function

        public function getInfoOutBtn() : Boolean
        {
            return false;
        }// end function

        public function setInfoOutBtn(param1:Boolean) : void
        {
            return;
        }// end function

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.explain_start_flag = false;
            this.weight_touch_flag = false;
            this.weight_refresh_flag = false;
            this.weight_status = [{no:1, type:0, area:0, ins:"", num:1}, {no:2, type:0, area:0, ins:"", num:1}, {no:3, type:0, area:0, ins:"", num:1}, {no:4, type:0, area:0, ins:"", num:1}, {no:5, type:0, area:0, ins:"", num:1}, {no:6, type:0, area:0, ins:"", num:1}, {no:7, type:0, area:0, ins:"", num:1}, {no:8, type:0, area:0, ins:"", num:1}, {no:9, type:0, area:0, ins:"", num:1}, {no:10, type:0, area:0, ins:"", num:1}, {no:11, type:0, area:0, ins:"", num:1}, {no:12, type:0, area:0, ins:"", num:1}, {no:13, type:0, area:0, ins:"", num:1}, {no:14, type:0, area:0, ins:"", num:1}, {no:15, type:0, area:0, ins:"", num:1}, {no:16, type:0, area:0, ins:"", num:1}, {no:17, type:0, area:0, ins:"", num:1}, {no:18, type:0, area:0, ins:"", num:1}, {no:19, type:0, area:0, ins:"", num:1}, {no:20, type:0, area:0, ins:"", num:1}, {no:21, type:0, area:0, ins:"", num:1}, {no:22, type:0, area:0, ins:"", num:1}, {no:23, type:0, area:0, ins:"", num:1}, {no:24, type:0, area:0, ins:"", num:1}, {no:25, type:0, area:0, ins:"", num:1}, {no:26, type:0, area:0, ins:"", num:1}, {no:27, type:0, area:0, ins:"", num:1}, {no:28, type:0, area:0, ins:"", num:1}, {no:29, type:0, area:0, ins:"", num:1}, {no:30, type:0, area:0, ins:"", num:1}, {no:31, type:0, area:0, ins:"", num:1}, {no:32, type:0, area:0, ins:"", num:1}, {no:33, type:0, area:0, ins:"", num:1}, {no:34, type:0, area:0, ins:"", num:1}, {no:35, type:0, area:0, ins:"", num:1}, {no:36, type:0, area:0, ins:"", num:1}, {no:37, type:0, area:0, ins:"", num:1}, {no:38, type:0, area:0, ins:"", num:1}, {no:39, type:0, area:0, ins:"", num:1}, {no:40, type:0, area:0, ins:"", num:1}, {no:41, type:0, area:0, ins:"", num:1}, {no:42, type:0, area:0, ins:"", num:1}, {no:43, type:0, area:0, ins:"", num:1}, {no:44, type:0, area:0, ins:"", num:1}, {no:45, type:0, area:0, ins:"", num:1}, {no:46, type:0, area:0, ins:"", num:1}, {no:47, type:0, area:0, ins:"", num:1}, {no:48, type:0, area:0, ins:"", num:1}, {no:49, type:0, area:0, ins:"", num:1}, {no:50, type:0, area:0, ins:"", num:1}, {no:51, type:0, area:0, ins:"", num:1}, {no:52, type:0, area:0, ins:"", num:1}, {no:53, type:0, area:0, ins:"", num:1}, {no:54, type:0, area:0, ins:"", num:1}, {no:55, type:0, area:0, ins:"", num:1}, {no:56, type:0, area:0, ins:"", num:1}, {no:57, type:0, area:0, ins:"", num:1}, {no:58, type:0, area:0, ins:"", num:1}, {no:59, type:0, area:0, ins:"", num:1}, {no:60, type:0, area:0, ins:"", num:1}, {no:61, type:0, area:0, ins:"", num:1}, {no:62, type:0, area:0, ins:"", num:1}, {no:63, type:0, area:0, ins:"", num:1}, {no:64, type:0, area:0, ins:"", num:1}, {no:65, type:0, area:0, ins:"", num:1}, {no:66, type:0, area:0, ins:"", num:1}, {no:67, type:0, area:0, ins:"", num:1}, {no:68, type:0, area:0, ins:"", num:1}, {no:69, type:0, area:0, ins:"", num:1}, {no:70, type:0, area:0, ins:"", num:1}, {no:71, type:0, area:0, ins:"", num:1}, {no:72, type:0, area:0, ins:"", num:1}, {no:73, type:0, area:0, ins:"", num:1}, {no:74, type:0, area:0, ins:"", num:1}, {no:75, type:0, area:0, ins:"", num:1}, {no:76, type:0, area:0, ins:"", num:1}, {no:77, type:0, area:0, ins:"", num:1}, {no:78, type:0, area:0, ins:"", num:1}, {no:79, type:0, area:0, ins:"", num:1}, {no:80, type:0, area:0, ins:"", num:1}, {no:81, type:0, area:0, ins:"", num:1}, {no:82, type:0, area:0, ins:"", num:1}, {no:83, type:0, area:0, ins:"", num:1}, {no:84, type:0, area:0, ins:"", num:1}, {no:85, type:0, area:0, ins:"", num:1}, {no:86, type:0, area:0, ins:"", num:1}, {no:87, type:0, area:0, ins:"", num:1}, {no:88, type:0, area:0, ins:"", num:1}, {no:89, type:0, area:0, ins:"", num:1}, {no:90, type:0, area:0, ins:"", num:1}, {no:91, type:0, area:0, ins:"", num:1}, {no:92, type:0, area:0, ins:"", num:1}, {no:93, type:0, area:0, ins:"", num:1}, {no:94, type:0, area:0, ins:"", num:1}, {no:95, type:0, area:0, ins:"", num:1}, {no:96, type:0, area:0, ins:"", num:1}, {no:97, type:0, area:0, ins:"", num:1}, {no:98, type:0, area:0, ins:"", num:1}, {no:99, type:0, area:0, ins:"", num:1}, {no:100, type:0, area:0, ins:"", num:1}];
            this.weight1_pos1_tbl = [{no:1, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:2, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:3, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:4, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:5, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:6, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:7, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:8, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:9, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:10, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:11, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:12, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:13, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:14, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:15, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:16, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:17, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:18, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:19, dx:-465 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:20, dx:-500 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:21, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:22, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:23, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:24, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:25, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:26, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:27, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:28, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:29, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:30, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:31, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:32, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:33, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:34, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:35, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:36, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:37, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:38, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:39, dx:-295 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:40, dx:-335 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:41, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 0}, {no:42, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 1}, {no:43, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 2}, {no:44, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 3}, {no:45, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 4}, {no:46, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 0}, {no:47, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 1}, {no:48, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 2}, {no:49, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 3}, {no:50, dx:-400 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 4}];
            this.weight1_pos2_tbl = [{no:1, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:2, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:3, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:4, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:5, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:6, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:7, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:8, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:9, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:10, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:11, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:12, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:13, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:14, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:15, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:16, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:17, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:18, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:19, dx:-195 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:20, dx:-230 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:21, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:22, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:23, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:24, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:25, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:26, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:27, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:28, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:29, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:30, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:31, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:32, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:33, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:34, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:35, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:36, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:37, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:38, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:39, dx:-25 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:40, dx:-65 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:41, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 0}, {no:42, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 1}, {no:43, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 2}, {no:44, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 3}, {no:45, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 4}, {no:46, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 0}, {no:47, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 1}, {no:48, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 2}, {no:49, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 3}, {no:50, dx:-130 + this._FRUIT1_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 4}];
            this.weight2_pos1_tbl = [{no:1, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:2, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:3, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:4, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:5, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:6, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:7, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:8, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:9, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:10, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:11, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:12, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:13, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:14, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:15, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:16, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:17, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:18, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:19, dx:-465 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:20, dx:-500 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:21, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:22, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:23, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:24, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:25, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:26, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:27, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:28, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:29, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:30, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:31, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:32, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:33, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:34, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:35, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:36, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:37, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:38, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:39, dx:-295 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:40, dx:-335 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:41, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 0}, {no:42, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 1}, {no:43, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 2}, {no:44, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 3}, {no:45, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 4}, {no:46, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 0}, {no:47, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 1}, {no:48, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 2}, {no:49, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 3}, {no:50, dx:-400 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 4}];
            this.weight2_pos2_tbl = [{no:1, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:2, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 0}, {no:3, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:4, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 1}, {no:5, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:6, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 2}, {no:7, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:8, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 3}, {no:9, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:10, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 4}, {no:11, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:12, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 5}, {no:13, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:14, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 6}, {no:15, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:16, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 7}, {no:17, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:18, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 8}, {no:19, dx:-195 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:20, dx:-230 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY + 0 + -30 * 9}, {no:21, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:22, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 0}, {no:23, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:24, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 1}, {no:25, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:26, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 2}, {no:27, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:28, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 3}, {no:29, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:30, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 4}, {no:31, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:32, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 5}, {no:33, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:34, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 6}, {no:35, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:36, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 7}, {no:37, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:38, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 8}, {no:39, dx:-25 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:40, dx:-65 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 2 + -34 * 9}, {no:41, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 0}, {no:42, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 1}, {no:43, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 2}, {no:44, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 3}, {no:45, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 25 + -60 * 4}, {no:46, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 0}, {no:47, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 1}, {no:48, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 2}, {no:49, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 3}, {no:50, dx:-130 + this._FRUIT2_OFSX, dy:this._FRUIT_OFSY - 100 + -60 * 4}];
            this.fruit_box_num = [this._FRUIT1_NUM + this._FRUIT2_NUM + this._FRUIT3_NUM, this._FRUIT1_NUM, this._FRUIT2_NUM, this._FRUIT3_NUM];
            this.fruit_num_tbl = [{num:[10, 0, 0, 0, 3, 1]}, {num:[6, 1, 0, 0, 0, 1]}];
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
            this.weight3_counter = 0;
            this.area_weight_num = [0, 0, 0, 0, 0, 0];
            this.balance1_id = 0;
            this.balance2_id = 0;
            this.game_index = 0;
            this.game_timer = 0;
            return;
        }// end function

    }
}
