package g2_p9_01_fla
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
        public var step1_btn_flag:Boolean;
        public var step2_btn_flag:Boolean;
        public var step3_btn_flag:Boolean;
        public var step4_btn_flag:Boolean;
        public var reset_btn_flag:Boolean;
        public var pause_flag:Boolean;
        public var straight_line_flag:Boolean;
        public const _BASE_FRAME:uint = 30;
        public const _DISPLAY_W:uint = 1086;
        public const _DISPLAY_H:uint = 670;
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
                    this.entryStep1Btn();
                    this.entryStep2Btn();
                    this.entryStep3Btn();
                    this.entryStep4Btn();
                    this.entryResetBtn();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 10;
                    break;
                }
                case 10:
                {
                    this.initExplain();
                    this.Main_timer = 0;
                    this.Main_action = 0;
                    this.Main_index = 20;
                    break;
                }
                case 20:
                {
                    if (this.getStep1Btn() == true)
                    {
                        this.dispExplainCourse("lane1");
                        this.setStep1Btn(false);
                    }
                    else if (this.getStep2Btn() == true)
                    {
                        this.dispExplainCourse("lane2");
                        this.setStep2Btn(false);
                    }
                    else if (this.getStep3Btn() == true)
                    {
                        this.dispExplainCourse("straight");
                        this.Ins_Item_Explain.Ins_LaneExp.visible = false;
                        this.straight_line_flag = true;
                        this.setStep3Btn(false);
                    }
                    else if (this.getStep4Btn() == true)
                    {
                        this.dispExplainCourse("move");
                        this.Ins_Item_Explain.Ins_LaneExp.visible = false;
                        this.straight_line_flag = true;
                        this.setStep4Btn(false);
                        this.Main_timer = 0;
                        this.Main_action = 0;
                        this.Main_index = 30;
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
                    if (this.getStep1Btn() == true)
                    {
                        this.dispExplainCourse("lane1");
                        this.setStep1Btn(false);
                    }
                    else if (this.getStep2Btn() == true)
                    {
                        this.dispExplainCourse("lane2");
                        this.setStep2Btn(false);
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
            this.releaseStep1Btn();
            this.releaseStep2Btn();
            this.releaseStep3Btn();
            this.releaseStep4Btn();
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
            this.dispExplainCourse("off");
            this.Ins_Item_Explain.Ins_LaneExp.visible = true;
            this.Ins_Item_Explain.Ins_LaneExp.Ins_Lane1.gotoAndStop("on");
            this.Ins_Item_Explain.Ins_LaneExp.Ins_Lane2.gotoAndStop("on");
            this.setStep1Btn(false);
            this.setStep2Btn(false);
            this.setStep3Btn(false);
            this.setStep4Btn(false);
            this.straight_line_flag = false;
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
            this.dispExplainCourse("off");
            this.Ins_Item_Explain.Ins_LaneExp.visible = true;
            this.Ins_Item_Explain.Ins_LaneExp.Ins_Lane1.gotoAndStop("on");
            this.Ins_Item_Explain.Ins_LaneExp.Ins_Lane2.gotoAndStop("on");
            this.setStep1Btn(false);
            this.setStep2Btn(false);
            this.setStep3Btn(false);
            this.setStep4Btn(false);
            this.straight_line_flag = false;
            return;
        }// end function

        public function dispExplainCourse(param1:String) : void
        {
            switch(param1)
            {
                case "off":
                {
                    this.Ins_Item_Explain.Ins_Course.gotoAndStop("off");
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_l.gotoAndStop("off");
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_r.gotoAndStop("off");
                    this.Ins_Item_Explain.Ins_Course.Ins_Line.gotoAndStop("off");
                    break;
                }
                case "lane1":
                {
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_l.gotoAndPlay("lane1");
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_r.gotoAndPlay("lane1");
                    if (this.straight_line_flag == false)
                    {
                        this.Ins_Item_Explain.Ins_Course.Ins_Line.gotoAndPlay("lane1");
                    }
                    break;
                }
                case "lane2":
                {
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_l.gotoAndPlay("lane2");
                    this.Ins_Item_Explain.Ins_Course.Ins_lane_r.gotoAndPlay("lane2");
                    if (this.straight_line_flag == false)
                    {
                        this.Ins_Item_Explain.Ins_Course.Ins_Line.gotoAndPlay("lane2");
                    }
                    break;
                }
                case "straight":
                {
                    this.Ins_Item_Explain.Ins_Course.gotoAndPlay("straight");
                    this.Ins_Item_Explain.Ins_Course.Ins_Line.gotoAndPlay("move");
                    break;
                }
                case "move":
                {
                    this.Ins_Item_Explain.Ins_Course.gotoAndPlay("move");
                    break;
                }
                default:
                {
                    break;
                }
            }
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

        public function entryStep4Btn() : void
        {
            this.Ins_Item_Control.Ins_Step4_Btn.addEventListener(MouseEvent.MOUSE_UP, this.downStep4Btn);
            return;
        }// end function

        public function releaseStep4Btn() : void
        {
            this.Ins_Item_Control.Ins_Step4_Btn.removeEventListener(MouseEvent.MOUSE_UP, this.downStep4Btn);
            return;
        }// end function

        public function downStep4Btn(event:MouseEvent) : void
        {
            this.step4_btn_flag = true;
            return;
        }// end function

        public function getStep4Btn() : Boolean
        {
            return this.step4_btn_flag;
        }// end function

        public function setStep4Btn(param1:Boolean) : void
        {
            this.step4_btn_flag = param1;
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

        function frame1()
        {
            this.Main_mode = 0;
            this.Main_index = 0;
            this.Main_timer = 0;
            this.Main_action = 0;
            this.step1_btn_flag = false;
            this.step2_btn_flag = false;
            this.step3_btn_flag = false;
            this.step4_btn_flag = false;
            this.reset_btn_flag = false;
            this.pause_flag = false;
            this.straight_line_flag = false;
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
