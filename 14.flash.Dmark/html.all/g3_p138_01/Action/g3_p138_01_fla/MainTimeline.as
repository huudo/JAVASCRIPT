package g3_p138_01_fla
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var Ins_Item_Control:MovieClip;
        public var Ins_Item_Explain:MovieClip;
        public var Ins_Item_Graph:MovieClip;
        public var Main_index:uint;
        public var Main_timer:int;
        public var Main_action:uint;
        public var refresh_flag:Boolean;
        public var notes_disp_flag:Boolean;
        public var line_ac_flag:Boolean;
        public var line_bd_flag:Boolean;
        public var check_box3_flag:Boolean;
        public var point_abcd_flag:Boolean;
        public var point_efgh_flag:Boolean;
        public var stick_flag:Boolean;
        public var P_A:Point;
        public var P_B:Point;
        public var P_C:Point;
        public var P_D:Point;
        public var P_E:Point;
        public var P_F:Point;
        public var P_G:Point;
        public var P_H:Point;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
        public const _MOVE_RECT_X1:int = -450;
        public const _MOVE_RECT_Y1:int = -250;
        public const _MOVE_RECT_X2:int = 450;
        public const _MOVE_RECT_Y2:int = 250;
        public const _GRAPH_SIZE:uint = 50;
        public const _GRAPH_OFS_X:int = 0;
        public const _GRAPH_OFS_Y:int = -25;
        public const _RECT_COLOR:Number = 16641512;
        public var point_status:Array;
        public var line_status:Array;
        public var area_shape:Object;
        public var area_panel:Object;
        public var line_shape:Object;
        public var line_panel:Object;
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
                    this.entryCheckBox3(this.point_efgh_flag);
                    this.Main_timer = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    if (this.getCheckBox3() == true)
                    {
                        if (this.point_efgh_flag == true)
                        {
                            this.Ins_Item_Explain.Ins_Area_Mc.visible = false;
                            this.point_efgh_flag = false;
                            this.refresh_flag = true;
                        }
                        else
                        {
                            this.Ins_Item_Explain.Ins_Area_Mc.visible = true;
                            this.point_efgh_flag = true;
                            this.refresh_flag = true;
                        }
                        this.setCheckBox3(false);
                    }
                    if (this.refresh_flag == true)
                    {
                        this.dispSquareABCD(this.line_panel);
                        this.dispSquareEFGH(this.area_panel);
                        this.dispEqualMark(false);
                        this.refresh_flag = false;
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
            this.Ins_Item_Explain.Ins_Area_Mc.removeChild(this.area_shape);
            this.Ins_Item_Explain.Ins_Line_Mc.removeChild(this.line_shape);
            this.releaseCheckBox3();
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
            this.Ins_Item_Graph.visible = true;
            this.initPoint(this.point_status[0].ins, this.point_status[0].dx, this.point_status[0].dy);
            this.initPoint(this.point_status[1].ins, this.point_status[1].dx, this.point_status[1].dy);
            this.initPoint(this.point_status[2].ins, this.point_status[2].dx, this.point_status[2].dy);
            this.initPoint(this.point_status[3].ins, this.point_status[3].dx, this.point_status[3].dy);
            if (this.point_efgh_flag == true)
            {
                this.dispSquareABCD(this.line_panel);
                this.dispSquareEFGH(this.area_panel);
                this.Ins_Item_Explain.Ins_Area_Mc.visible = true;
                this.Ins_Item_Explain.Ins_Point_Text1.visible = true;
                this.Ins_Item_Explain.Ins_Point_Text2.visible = true;
            }
            else
            {
                this.dispSquareABCD(this.line_panel);
                this.dispSquareEFGH(this.area_panel);
                this.Ins_Item_Explain.Ins_Area_Mc.visible = false;
                this.Ins_Item_Explain.Ins_Point_Text1.visible = true;
                this.Ins_Item_Explain.Ins_Point_Text2.visible = false;
            }
            this.dispEqualMark(false);
            return;
        }// end function

        public function resetMainItem() : void
        {
            return;
        }// end function

        public function dispLinePtoP(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
        {
            param1.lineStyle(param2, param3, 1);
            param1.moveTo(param4, param5);
            param1.lineTo(param6, param7);
            return;
        }// end function

        public function dispSquareABCD(param1:Graphics) : void
        {
            this.P_A = this.getPointABCD(this.point_status[0].ins);
            this.P_B = this.getPointABCD(this.point_status[1].ins);
            this.P_C = this.getPointABCD(this.point_status[2].ins);
            this.P_D = this.getPointABCD(this.point_status[3].ins);
            param1.clear();
            this.dispLinePtoP(param1, this.line_status[0].size, this.line_status[0].color, this.P_A.x + this._GRAPH_OFS_X, this.P_A.y + this._GRAPH_OFS_Y, this.P_B.x + this._GRAPH_OFS_X, this.P_B.y + this._GRAPH_OFS_Y);
            this.dispLinePtoP(param1, this.line_status[0].size, this.line_status[0].color, this.P_B.x + this._GRAPH_OFS_X, this.P_B.y + this._GRAPH_OFS_Y, this.P_C.x + this._GRAPH_OFS_X, this.P_C.y + this._GRAPH_OFS_Y);
            this.dispLinePtoP(param1, this.line_status[0].size, this.line_status[0].color, this.P_C.x + this._GRAPH_OFS_X, this.P_C.y + this._GRAPH_OFS_Y, this.P_D.x + this._GRAPH_OFS_X, this.P_D.y + this._GRAPH_OFS_Y);
            this.dispLinePtoP(param1, this.line_status[0].size, this.line_status[0].color, this.P_D.x + this._GRAPH_OFS_X, this.P_D.y + this._GRAPH_OFS_Y, this.P_A.x + this._GRAPH_OFS_X, this.P_A.y + this._GRAPH_OFS_Y);
            if (this.point_abcd_flag == true)
            {
                this.Ins_Item_Explain.Ins_Point_Text1.visible = true;
            }
            else
            {
                this.Ins_Item_Explain.Ins_Point_Text1.visible = false;
            }
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_A.x = this.P_A.x + this.point_status[0].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_A.y = this.P_A.y + this.point_status[0].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_B.x = this.P_B.x + this.point_status[1].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_B.y = this.P_B.y + this.point_status[1].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_C.x = this.P_C.x + this.point_status[2].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_C.y = this.P_C.y + this.point_status[2].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_D.x = this.P_D.x + this.point_status[3].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text1.Ins_D.y = this.P_D.y + this.point_status[3].ofsy;
            return;
        }// end function

        public function dispSquareEFGH(param1:Graphics) : void
        {
            this.P_A = this.getPointABCD(this.point_status[0].ins);
            this.P_B = this.getPointABCD(this.point_status[1].ins);
            this.P_C = this.getPointABCD(this.point_status[2].ins);
            this.P_D = this.getPointABCD(this.point_status[3].ins);
            this.P_E.x = (this.P_A.x + this.P_B.x) / 2;
            this.P_E.y = (this.P_A.y + this.P_B.y) / 2;
            this.P_F.x = (this.P_B.x + this.P_C.x) / 2;
            this.P_F.y = (this.P_B.y + this.P_C.y) / 2;
            this.P_G.x = (this.P_C.x + this.P_D.x) / 2;
            this.P_G.y = (this.P_C.y + this.P_D.y) / 2;
            this.P_H.x = (this.P_D.x + this.P_A.x) / 2;
            this.P_H.y = (this.P_D.y + this.P_A.y) / 2;
            if (this.point_efgh_flag == true)
            {
                this.Ins_Item_Explain.Ins_Point_Text2.visible = true;
            }
            else
            {
                this.Ins_Item_Explain.Ins_Point_Text2.visible = false;
            }
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_E.x = this.P_E.x + this.point_status[4].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_E.y = this.P_E.y + this.point_status[4].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_F.x = this.P_F.x + this.point_status[5].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_F.y = this.P_F.y + this.point_status[5].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_G.x = this.P_G.x + this.point_status[6].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_G.y = this.P_G.y + this.point_status[6].ofsy;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_H.x = this.P_H.x + this.point_status[7].ofsx;
            this.Ins_Item_Explain.Ins_Point_Text2.Ins_H.y = this.P_H.y + this.point_status[7].ofsy;
            param1.clear();
            param1.lineStyle(this.line_status[1].size, this.line_status[1].color, 1);
            param1.beginFill(this._RECT_COLOR, 1);
            param1.moveTo(this.P_E.x + this._GRAPH_OFS_X, this.P_E.y + this._GRAPH_OFS_Y);
            param1.lineTo(this.P_F.x + this._GRAPH_OFS_X, this.P_F.y + this._GRAPH_OFS_Y);
            param1.lineTo(this.P_G.x + this._GRAPH_OFS_X, this.P_G.y + this._GRAPH_OFS_Y);
            param1.lineTo(this.P_H.x + this._GRAPH_OFS_X, this.P_H.y + this._GRAPH_OFS_Y);
            param1.endFill();
            return;
        }// end function

        public function dispEqualMark(param1:Boolean) : void
        {
            var _loc_2:* = this.changeDir360(this.getDirPtoP(this.P_A.x, this.P_A.y, this.P_B.x, this.P_B.y) - 90);
            var _loc_3:* = this.changeDir360(this.getDirPtoP(this.P_B.x, this.P_B.y, this.P_C.x, this.P_C.y) - 90);
            this.Ins_Item_Explain.Ins_Eq_Mark1.visible = param1;
            this.Ins_Item_Explain.Ins_Eq_Mark1.x = (this.P_A.x + this.P_E.x) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark1.y = (this.P_A.y + this.P_E.y) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark1.rotation = _loc_2;
            this.Ins_Item_Explain.Ins_Eq_Mark2.visible = param1;
            this.Ins_Item_Explain.Ins_Eq_Mark2.x = (this.P_E.x + this.P_B.x) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark2.y = (this.P_E.y + this.P_B.y) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark2.rotation = _loc_2;
            this.Ins_Item_Explain.Ins_Eq_Mark3.visible = param1;
            this.Ins_Item_Explain.Ins_Eq_Mark3.x = (this.P_B.x + this.P_F.x) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark3.y = (this.P_B.y + this.P_F.y) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark3.rotation = _loc_3;
            this.Ins_Item_Explain.Ins_Eq_Mark4.visible = param1;
            this.Ins_Item_Explain.Ins_Eq_Mark4.x = (this.P_F.x + this.P_C.x) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark4.y = (this.P_F.y + this.P_C.y) / 2;
            this.Ins_Item_Explain.Ins_Eq_Mark4.rotation = _loc_3;
            return;
        }// end function

        public function initPoint(param1:String, param2:int, param3:int) : void
        {
            var wk_rock_flag:Boolean;
            var wk_old_pos:Point;
            var wk_now_pos:Point;
            var wk_stick_x:Number;
            var wk_stick_y:Number;
            var wk_last_no:int;
            var wk_swap:DisplayObject;
            var wk_point:DisplayObject;
            var wk_point_mc:MovieClip;
            var downPoint:Function;
            var outPoint:Function;
            var movePoint:Function;
            var ins:* = param1;
            var dx:* = param2;
            var dy:* = param3;
            downPoint = function (event:MouseEvent) : void
            {
                wk_last_no = Ins_Item_Control.Ins_PointABCD.numChildren - 1;
                wk_swap = Ins_Item_Control.Ins_PointABCD.getChildAt(wk_last_no);
                Ins_Item_Control.Ins_PointABCD.swapChildren(wk_point, wk_swap);
                wk_old_pos.x = wk_point.x;
                wk_old_pos.y = wk_point.y;
                wk_now_pos.x = stage.mouseX;
                wk_now_pos.y = stage.mouseY;
                wk_rock_flag = true;
                return;
            }// end function
            ;
            outPoint = function (event:MouseEvent) : void
            {
                if (stick_flag == true)
                {
                    wk_stick_x = wk_point.x / _GRAPH_SIZE;
                    wk_stick_y = wk_point.y / _GRAPH_SIZE;
                    wk_point.x = Math.round(wk_stick_x) * _GRAPH_SIZE;
                    wk_point.y = Math.round(wk_stick_y) * _GRAPH_SIZE;
                }
                refresh_flag = true;
                wk_rock_flag = false;
                return;
            }// end function
            ;
            movePoint = function (event:MouseEvent) : void
            {
                if (wk_rock_flag == true)
                {
                    wk_old_pos.x = wk_now_pos.x;
                    wk_old_pos.y = wk_now_pos.y;
                    wk_now_pos.x = stage.mouseX;
                    wk_now_pos.y = stage.mouseY;
                    wk_point.x = wk_point.x + (wk_now_pos.x - wk_old_pos.x);
                    wk_point.y = wk_point.y + (wk_now_pos.y - wk_old_pos.y);
                    if (wk_point.x < _MOVE_RECT_X1)
                    {
                        wk_point.x = _MOVE_RECT_X1;
                    }
                    else if (wk_point.x > _MOVE_RECT_X2)
                    {
                        wk_point.x = _MOVE_RECT_X2;
                    }
                    if (wk_point.y < _MOVE_RECT_Y1)
                    {
                        wk_point.y = _MOVE_RECT_Y1;
                    }
                    else if (wk_point.y > _MOVE_RECT_Y2)
                    {
                        wk_point.y = _MOVE_RECT_Y2;
                    }
                    refresh_flag = true;
                }
                return;
            }// end function
            ;
            wk_rock_flag;
            wk_old_pos = new Point();
            wk_now_pos = new Point();
            wk_stick_x;
            wk_stick_y;
            wk_point = this.Ins_Item_Control.Ins_PointABCD.getChildByName(ins);
            wk_point_mc = wk_point as MovieClip;
            wk_point.x = dx;
            wk_point.y = dy;
            wk_point_mc.addEventListener(MouseEvent.MOUSE_DOWN, downPoint);
            wk_point_mc.addEventListener(MouseEvent.MOUSE_OUT, outPoint);
            wk_point_mc.addEventListener(MouseEvent.MOUSE_UP, outPoint);
            wk_point_mc.addEventListener(MouseEvent.MOUSE_MOVE, movePoint);
            wk_point_mc.addEventListener(Event.REMOVED_FROM_STAGE, function (event:Event) : void
            {
                wk_point_mc.removeEventListener(MouseEvent.MOUSE_DOWN, downPoint);
                wk_point_mc.removeEventListener(MouseEvent.MOUSE_OUT, outPoint);
                wk_point_mc.removeEventListener(MouseEvent.MOUSE_UP, outPoint);
                wk_point_mc.removeEventListener(MouseEvent.MOUSE_MOVE, movePoint);
                removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            return;
        }// end function

        public function getPointABCD(param1:String) : Point
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = new Point();
            _loc_3 = this.Ins_Item_Control.Ins_PointABCD.getChildByName(param1);
            _loc_4 = _loc_3 as MovieClip;
            _loc_2.x = _loc_3.x;
            _loc_2.y = _loc_3.y;
            return _loc_2;
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

        public function entryCheckBox3(param1:Boolean) : void
        {
            this.Ins_Item_Control.Ins_Check_Box3_On.addEventListener(MouseEvent.MOUSE_UP, this.clickBox3On);
            this.Ins_Item_Control.Ins_Check_Box3_Off.addEventListener(MouseEvent.MOUSE_UP, this.clickBox3Off);
            if (param1 == true)
            {
                this.Ins_Item_Control.Ins_Check_Box3_On.visible = true;
                this.Ins_Item_Control.Ins_Check_Box3_Off.visible = false;
                this.check_box3_flag = false;
            }
            else
            {
                this.Ins_Item_Control.Ins_Check_Box3_On.visible = false;
                this.Ins_Item_Control.Ins_Check_Box3_Off.visible = true;
                this.check_box3_flag = false;
            }
            return;
        }// end function

        public function releaseCheckBox3() : void
        {
            this.Ins_Item_Control.Ins_Check_Box3_On.removeEventListener(MouseEvent.MOUSE_UP, this.clickBox3On);
            this.Ins_Item_Control.Ins_Check_Box3_Off.removeEventListener(MouseEvent.MOUSE_UP, this.clickBox3Off);
            return;
        }// end function

        public function clickBox3On(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Check_Box3_On.visible = false;
            this.Ins_Item_Control.Ins_Check_Box3_Off.visible = true;
            this.check_box3_flag = true;
            return;
        }// end function

        public function clickBox3Off(event:MouseEvent) : void
        {
            this.Ins_Item_Control.Ins_Check_Box3_On.visible = true;
            this.Ins_Item_Control.Ins_Check_Box3_Off.visible = false;
            this.check_box3_flag = true;
            return;
        }// end function

        public function getCheckBox3() : Boolean
        {
            return this.check_box3_flag;
        }// end function

        public function setCheckBox3(param1:Boolean) : void
        {
            this.check_box3_flag = param1;
            return;
        }// end function

        function frame1()
        {
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.refresh_flag = false;
            this.notes_disp_flag = false;
            this.line_ac_flag = false;
            this.line_bd_flag = false;
            this.check_box3_flag = false;
            this.point_abcd_flag = true;
            this.point_efgh_flag = false;
            this.stick_flag = true;
            this.P_A = new Point();
            this.P_B = new Point();
            this.P_C = new Point();
            this.P_D = new Point();
            this.P_E = new Point();
            this.P_F = new Point();
            this.P_G = new Point();
            this.P_H = new Point();
            this.point_status = [{no:0, disp:false, ins:"Ins_A", txt:"A", dx:-150, dy:0, ofsx:-25 + this._GRAPH_OFS_X, ofsy:-25 + this._GRAPH_OFS_Y}, {no:1, disp:false, ins:"Ins_B", txt:"B", dx:-200, dy:200, ofsx:-25 + this._GRAPH_OFS_X, ofsy:25 + this._GRAPH_OFS_Y}, {no:2, disp:false, ins:"Ins_C", txt:"C", dx:200, dy:200, ofsx:25 + this._GRAPH_OFS_X, ofsy:25 + this._GRAPH_OFS_Y}, {no:3, disp:false, ins:"Ins_D", txt:"D", dx:150, dy:-150, ofsx:25 + this._GRAPH_OFS_X, ofsy:-25 + this._GRAPH_OFS_Y}, {no:4, disp:false, ins:"Ins_E", txt:"E", dx:0, dy:0, ofsx:-30 + this._GRAPH_OFS_X, ofsy:0 + this._GRAPH_OFS_Y}, {no:5, disp:false, ins:"Ins_F", txt:"F", dx:0, dy:0, ofsx:0 + this._GRAPH_OFS_X, ofsy:30 + this._GRAPH_OFS_Y}, {no:6, disp:false, ins:"Ins_G", txt:"G", dx:0, dy:0, ofsx:30 + this._GRAPH_OFS_X, ofsy:0 + this._GRAPH_OFS_Y}, {no:7, disp:false, ins:"Ins_H", txt:"H", dx:0, dy:0, ofsx:0 + this._GRAPH_OFS_X, ofsy:-30 + this._GRAPH_OFS_Y}];
            this.line_status = [{size:4, color:0, sx:0, sy:0, ex:0, ey:0}, {size:2.5, color:0, sx:0, sy:0, ex:0, ey:0}, {size:4, color:39423, sx:0, sy:0, ex:0, ey:0}, {size:4, color:65433, sx:0, sy:0, ex:0, ey:0}];
            this.area_shape = new Shape();
            this.Ins_Item_Explain.Ins_Area_Mc.addChild(this.area_shape);
            this.area_panel = this.area_shape.graphics;
            this.line_shape = new Shape();
            this.Ins_Item_Explain.Ins_Line_Mc.addChild(this.line_shape);
            this.line_panel = this.line_shape.graphics;
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
