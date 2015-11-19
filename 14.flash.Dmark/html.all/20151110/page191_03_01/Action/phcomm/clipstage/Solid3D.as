package phcomm.clipstage
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import phcomm.*;
    import phcomm.datasave.*;

    public class Solid3D extends MovieClipBasis3D
    {
        protected const COLOR_RED:uint = 16711680;
        protected const VIEW_RATE:Number = 1.5;
        protected const DEFAULT_VIEW_SIZE:Number = 450;
        protected const DEFAULT_INTERVAL:int = 60;
        protected const DEFAULT_TIMER1:int = 200;
        protected const DEFAULT_TIMER2:int = 60;
        protected const SELECT_NONE:int = 0;
        protected const SELECT_CUT:int = 1;
        protected const SELECT_TAPE:int = 2;
        protected const SELECT_OPEN:int = 3;
        protected const SELECT_CLOSE:int = 4;
        protected const SELECT_COLOR:int = 5;
        protected const SELECT_CREATE:int = 1;
        protected const SELECT_DELETE:int = 2;
        protected const PAUSE_TENKAI:int = 60;
        protected const PAUSE_IDO:int = 30;
        protected const FACE_COL_DEFAULT_R:uint = 60;
        protected const FACE_COL_DEFAULT_G:uint = 120;
        protected const FACE_COL_DEFAULT_B:uint = 196;
        protected const FACE_COL_DEFAULT_W2:uint = 11842740;
        protected const LINE_COL_CUT:uint = 15119420;
        protected const LINE_COL_PIVOT:uint = 1056800;
        protected const FS_FACE_COL_BASE_S:uint = 8372028;
        protected const FS_FACE_COL_BASE_W:uint = 8372053;
        protected const FS_FACE_COL_SIDE_S:uint = 15132220;
        protected const FS_FACE_COL_SIDE_W:uint = 14474320;
        protected const FS_LINE_COL_SELECTED:uint = 12467290;
        protected const FS_POINT_COL_SELECTED:uint = 16752688;
        private const IE_FACE_COL_DUPLICATED:uint = 11837500;
        private const PV_FACE_COL_SELECTED1:uint = 1376120;
        private const PV_FACE_COL_SELECTED2:uint = 15749260;
        private const PV_LINE_COL_SELECTED:uint = 1376120;
        private const PV_LINE_COL_STRONG:uint = 15736460;
        private const CC_FACE_COL_CUTED_S:uint = 13125220;
        private const CC_FACE_COL_CUTED_W:uint = 12467290;
        private const RS_FACE_COL_CENTER:uint = 16756985;
        private const RS_CENTER_POINT_COL:uint = 12456610;
        private const RS_INNER_LINE_COL1:uint = 16349424;
        private const RS_INNER_LINE_COL2:uint = 16349424;
        private const SS_FACE_ON_LINE_COL:uint = 15732768;
        private const MAX_VIEW_SIZE:Number = 1200;
        private const MIN_VIEW_SIZE:Number = 240;
        private const STEP_VIEW_SIZE:Number = 15;
        protected var gS3SolidNo:int;
        protected var gS3StFlg:int;
        protected var gS3SPointCnt:int;
        protected var gS3SPoint:Vector.<Vector.<Number>>;
        protected var gS3SLineCnt:int;
        protected var gS3SLine:Vector.<Vector.<int>>;
        protected var gS3SFaceCnt:int;
        protected var gS3SFace:Vector.<Vector.<int>>;
        protected var gS3SPointCom:Vector.<Vector.<int>>;
        protected var gS3SHouVec:Vector.<Vector3D>;
        protected var gS3GPoint:Vector.<Vector.<Number>>;
        protected var gS3GFaceDist:Vector.<Number>;
        protected var gS3GFaceVec:Vector.<Number>;
        protected var gS3GLightVec:Vector.<Number>;
        protected var gS3GPointColor:Vector.<uint>;
        protected var gS3GLineColor:Vector.<uint>;
        protected var gS3GFaceColor:Vector.<uint>;
        protected var gS3GLineCut:Vector.<int>;
        protected var gS3GFaceMove:Vector.<int>;
        protected var gS3RgnFace:Vector.<PolygonObject>;
        protected var gS3RgnLine:Vector.<PolygonObject>;
        protected var gS3RgnPoint:Vector.<PolygonObject>;
        protected var gS3ModelMode:int;
        protected var gS3FaceOver:Vector.<int>;
        protected var gS3TokuchoFlg:Vector.<int>;
        protected var gS3HighPoint:Vector.<Vector3D>;
        protected var gS3HighLeng:Number;
        protected var gS3CenterPoint:Vector.<Vector3D>;
        protected var gS3FOnLineFlg:Boolean;
        protected var gS3FOnLineCnt:int;
        protected var gS3FOnLine:Vector.<t3dFACEONLINE>;
        protected var gS3SlowLine:Boolean;
        protected var isTenkaiMoveFront:Boolean;
        protected var dComLine:LineObject;
        protected var dPauseFunction:Function;
        protected var dPauseEventCode:String;
        protected var dPauseValues:Array;
        protected var dPauseResult:int;
        protected var dPauseNecessary:Boolean;
        protected var dFaceColR:uint;
        protected var dFaceColG:uint;
        protected var dFaceColB:uint;
        protected var dFaceColA:Number;
        protected var dLineCol:int;
        protected var dLineWid:int;
        protected var dLineRevCol:int;
        protected var dLineRevDotLength:int;
        protected var dLineRevDotInterval:int;
        private var dSelCol:uint;
        private var dSelKbn:int;
        private var dSelNo:int;
        private var dMouseIcon:int;
        private var dFaceDrawCnt:int;
        private var dMouseButton:Boolean;

        public function Solid3D(param1:Boolean = true)
        {
            super(param1);
            this.gS3SolidNo = int.MIN_VALUE;
            this.gS3StFlg = int.MIN_VALUE;
            this.gS3SPointCnt = int.MIN_VALUE;
            this.gS3SPoint = null;
            this.gS3SLineCnt = int.MIN_VALUE;
            this.gS3SLine = null;
            this.gS3SFaceCnt = int.MIN_VALUE;
            this.gS3SFace = null;
            this.gS3SPointCom = null;
            this.gS3SHouVec = null;
            this.gS3GPoint = null;
            this.gS3GFaceDist = null;
            this.gS3GFaceVec = null;
            this.gS3GLightVec = null;
            this.gS3GPointColor = null;
            this.gS3GLineColor = null;
            this.gS3GFaceColor = null;
            this.gS3GLineCut = null;
            this.gS3GFaceMove = null;
            this.gS3RgnFace = null;
            this.gS3RgnLine = null;
            this.gS3RgnPoint = null;
            this.gS3ModelMode = int.MIN_VALUE;
            this.gS3FaceOver = null;
            this.gS3TokuchoFlg = null;
            this.gS3HighPoint = null;
            this.gS3HighLeng = Number.NaN;
            this.gS3CenterPoint = null;
            this.gS3FOnLineFlg = false;
            this.gS3FOnLineCnt = int.MIN_VALUE;
            this.gS3FOnLine = null;
            this.gS3SlowLine = false;
            this.isTenkaiMoveFront = false;
            this.gS3TokuchoFlg = new Vector.<int>(5, true);
            this.gS3HighPoint = new Vector.<Vector3D>(3, true);
            this.dFaceColR = this.FACE_COL_DEFAULT_R;
            this.dFaceColG = this.FACE_COL_DEFAULT_G;
            this.dFaceColB = this.FACE_COL_DEFAULT_B;
            this.dFaceColA = 1;
            this.dLineCol = -1;
            this.dLineWid = -1;
            this.dLineRevCol = -1;
            this.dLineRevDotLength = -1;
            this.dLineRevDotInterval = -1;
            this.dSelCol = uint.MIN_VALUE;
            this.dSelKbn = int.MIN_VALUE;
            this.dSelNo = int.MIN_VALUE;
            this.dMouseIcon = int.MIN_VALUE;
            this.dFaceDrawCnt = int.MIN_VALUE;
            this.dMouseButton = false;
            this.dComLine = new LineObject();
            this.dPauseFunction = null;
            this.dPauseEventCode = "";
            this.dPauseValues = null;
            this.dPauseResult = int.MIN_VALUE;
            this.dPauseNecessary = false;
            return;
        }// end function

        final protected function get currentFaceColor() : uint
        {
            return this.rgb(this.dFaceColR, this.dFaceColG, this.dFaceColB);
        }// end function

        final protected function get currentFaceColorR() : uint
        {
            return this.dFaceColR;
        }// end function

        final protected function get currentFaceColorG() : uint
        {
            return this.dFaceColG;
        }// end function

        final protected function get currentFaceColorB() : uint
        {
            return this.dFaceColB;
        }// end function

        final protected function get currentFaceColorA() : Number
        {
            return this.dFaceColA;
        }// end function

        final protected function get nowMove() : Boolean
        {
            return this.dPauseFunction != null;
        }// end function

        final protected function getFaceCol() : uint
        {
            return this.rgb(this.dFaceColR, this.dFaceColG, this.dFaceColB);
        }// end function

        final protected function getFaceColWirerFrame() : uint
        {
            return this.rgb(this.dFaceColR, this.dFaceColG / 2, this.dFaceColB);
        }// end function

        final protected function revY(param1:Number) : Number
        {
            return this.areaHeight - param1;
        }// end function

        final protected function revYPoint(param1:Point) : Point
        {
            return new Point(param1.x, this.revY(param1.y));
        }// end function

        override protected function eventJump(event:StageEvent) : void
        {
            super.eventJump(event);
            switch(event.type)
            {
                case StageEvent.PAUSE_END:
                case StageEvent.SLOW_LINE_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.dPauseEventCode != "")
            {
            }
            return;
        }// end function

        protected function dataLoadFromName(param1:String, param2:Boolean = false) : Boolean
        {
            switch(param1)
            {
                case "正四面体":
                {
                }
                case "正六面体":
                {
                }
                case "正八面体":
                {
                }
                case "正十二面体":
                {
                }
                case "正二十面体":
                {
                }
                case "三角柱":
                {
                }
                case "四角柱":
                {
                }
                case "五角柱":
                {
                }
                case "円柱":
                {
                }
                case "三角錐":
                {
                }
                case "四角錐":
                {
                }
                case "五角錐":
                {
                }
                case "円錐":
                {
                }
                case "直角二等辺三角柱":
                {
                }
                case "立方体六分割四角錐底面":
                {
                }
                case "立方体三分割四角錐側面":
                {
                }
                default:
                {
                    break;
                }
            }
            switch(param1)
            {
                case "直方体":
                {
                }
                case "立方体":
                {
                }
                case "四角柱":
                {
                }
                case "五角柱":
                {
                }
                case "円柱":
                {
                }
                case "三角柱":
                {
                }
                case "直角三角柱":
                {
                }
                case "細い円柱":
                {
                }
                case "正三角形柱":
                {
                }
                case "広い円柱":
                {
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        protected function dataLoad(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(param1)
            {
                case 12:
                case 16:
                {
                    this.gS3SolidNo = 6;
                    _loc_3 = new s4p9201();
                    _loc_4 = new s4p9202();
                    _loc_5 = new s4p9203();
                    break;
                }
                case 13:
                {
                    this.gS3SolidNo = 6;
                    _loc_3 = new s4p9101();
                    _loc_4 = new s4p9102();
                    _loc_5 = new s4p9103();
                    break;
                }
                case 17:
                {
                    this.gS3SolidNo = param2;
                    switch(param2)
                    {
                        case 2:
                        {
                            _loc_3 = new s6p9121();
                            _loc_4 = new s6p9122();
                            _loc_5 = new s6p9123();
                            break;
                        }
                        case 4:
                        {
                            _loc_3 = new s6p9141();
                            _loc_4 = new s6p9142();
                            _loc_5 = new s6p9143();
                            break;
                        }
                        case 6:
                        {
                            _loc_3 = new s6p9161();
                            _loc_4 = new s6p9162();
                            _loc_5 = new s6p9163();
                            break;
                        }
                        case 8:
                        {
                            _loc_3 = new s6p9181();
                            _loc_4 = new s6p9182();
                            _loc_5 = new s6p9183();
                            break;
                        }
                        default:
                        {
                            return;
                            break;
                        }
                    }
                    break;
                }
                case 23:
                {
                    this.gS3SolidNo = param2;
                    if (this.gS3SolidNo > 10)
                    {
                        this.gS3SolidNo = this.gS3SolidNo - 10;
                    }
                    switch(param2)
                    {
                        case 2:
                        {
                            _loc_3 = new s6p2321();
                            _loc_4 = new s6p2322();
                            _loc_5 = new s6p2323();
                            break;
                        }
                        case 4:
                        {
                            _loc_3 = new s6p2341();
                            _loc_4 = new s6p2342();
                            _loc_5 = new s6p2343();
                            break;
                        }
                        case 12:
                        {
                            _loc_3 = new s6p23121();
                            _loc_4 = new s6p23122();
                            _loc_5 = new s6p23123();
                            break;
                        }
                        case 14:
                        {
                            _loc_3 = new s6p23141();
                            _loc_4 = new s6p23142();
                            _loc_5 = new s6p23143();
                            break;
                        }
                        default:
                        {
                            return;
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    switch(param2)
                    {
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
                        case 7:
                        {
                            break;
                        }
                        case 8:
                        {
                            break;
                        }
                        case 11:
                        {
                            break;
                        }
                        case 12:
                        {
                            break;
                        }
                        case 13:
                        {
                            break;
                        }
                        case 14:
                        {
                            break;
                        }
                        case 15:
                        {
                            break;
                        }
                        case 16:
                        {
                            break;
                        }
                        case 17:
                        {
                            break;
                        }
                        case 18:
                        {
                            break;
                        }
                        case 19:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                    break;
                }
            }
            this.dataSet(this.gS3SolidNo, _loc_3, _loc_4, _loc_5);
            return;
        }// end function

        protected function dataSet(param1:int, param2:DataSave3D, param3:DataSave3D, param4:DataSave3D) : void
        {
            var ix1:int;
            var ix2:int;
            var idx:int;
            var idx2:int;
            var wData:Vector.<Vector.<Number>>;
            var intSolidNo:* = param1;
            var dataPoint:* = param2;
            var dataLine:* = param3;
            var dataFace:* = param4;
            this.gS3SolidNo = intSolidNo;
            try
            {
                wData = dataPoint.data;
                idx;
                this.gS3SPointCnt = int(wData[idx][0]);
                this.gS3SPoint = new Vector.<Vector.<Number>>(this.gS3SPointCnt, true);
                this.gS3SPointCom = new Vector.<Vector.<int>>(this.gS3SPointCnt, true);
                this.gS3GPoint = new Vector.<Vector.<Number>>(this.gS3SPointCnt, true);
                this.gS3GPointColor = new Vector.<uint>(this.gS3SPointCnt, true);
                this.gS3RgnPoint = new Vector.<PolygonObject>(this.gS3SPointCnt, true);
                ix1;
                while (ix1 < this.gS3SPointCnt)
                {
                    
                    this.gS3SPoint[ix1] = new Vector.<Number>(3, true);
                    this.gS3SPointCom[ix1] = new Vector.<int>(6, true);
                    this.gS3GPoint[ix1] = new Vector.<Number>(3, true);
                    ix1 = (ix1 + 1);
                }
                ix1;
                while (ix1 < this.gS3SPointCnt)
                {
                    
                    idx = (idx + 1);
                    idx2;
                    ix2;
                    while (ix2 < 3)
                    {
                        
                        this.gS3SPoint[ix1][ix2] = wData[idx][idx2];
                        idx2 = (idx2 + 1);
                        ix2 = (ix2 + 1);
                    }
                    ix2;
                    while (ix2 < 6)
                    {
                        
                        this.gS3SPointCom[ix1][ix2] = int(wData[idx][idx2]);
                        idx2 = (idx2 + 1);
                        ix2 = (ix2 + 1);
                    }
                    ix1 = (ix1 + 1);
                }
            }
            catch (err:Error)
            {
                gS3SolidNo = 0;
                trace("Solid3D.dataLoad \'" + getQualifiedClassName(dataPoint) + "\' Error:" + err.message);
                return;
                try
                {
                }
                wData = dataLine.data;
                idx;
                this.gS3SLineCnt = int(wData[idx][0]);
                this.gS3SLine = new Vector.<Vector.<int>>(this.gS3SLineCnt, true);
                this.gS3GLineColor = new Vector.<uint>(this.gS3SLineCnt, true);
                this.gS3GLineCut = new Vector.<int>(this.gS3SLineCnt, true);
                this.gS3RgnLine = new Vector.<PolygonObject>(this.gS3SLineCnt, true);
                ix1;
                while (ix1 < this.gS3SLine.length)
                {
                    
                    this.gS3SLine[ix1] = new Vector.<int>(3, true);
                    ix1 = (ix1 + 1);
                }
                ix1;
                while (ix1 < this.gS3SLineCnt)
                {
                    
                    idx = (idx + 1);
                    idx2;
                    ix2;
                    while (ix2 < 3)
                    {
                        
                        this.gS3SLine[ix1][ix2] = int(wData[idx][idx2]);
                        idx2 = (idx2 + 1);
                        ix2 = (ix2 + 1);
                    }
                    ix1 = (ix1 + 1);
                }
            }
            catch (err:Error)
            {
                gS3SolidNo = 0;
                trace("Solid3D.dataLoad \'" + getQualifiedClassName(dataLine) + "\' Error:" + err.message);
                return;
                try
                {
                }
                wData = dataFace.data;
                idx;
                this.gS3SFaceCnt = int(wData[idx][0]);
                this.gS3SFace = new Vector.<Vector.<int>>(this.gS3SFaceCnt, true);
                this.gS3SHouVec = new Vector.<Vector3D>(this.gS3SFaceCnt, true);
                this.gS3GFaceDist = new Vector.<Number>(this.gS3SFaceCnt, true);
                this.gS3GFaceVec = new Vector.<Number>(this.gS3SFaceCnt, true);
                this.gS3GLightVec = new Vector.<Number>(this.gS3SFaceCnt, true);
                this.gS3GFaceColor = new Vector.<uint>(this.gS3SFaceCnt, true);
                this.gS3GFaceMove = new Vector.<int>(this.gS3SFaceCnt, true);
                this.gS3RgnFace = new Vector.<PolygonObject>(this.gS3SFaceCnt, true);
                this.gS3FaceOver = new Vector.<int>(this.gS3SFaceCnt, true);
                this.gS3CenterPoint = new Vector.<Vector3D>(this.gS3SFaceCnt, true);
                ix1;
                while (ix1 < this.gS3SFace.length)
                {
                    
                    this.gS3SFace[ix1] = new Vector.<int>(13, true);
                    ix1 = (ix1 + 1);
                }
                ix1;
                while (ix1 < this.gS3SFaceCnt)
                {
                    
                    idx = (idx + 1);
                    idx2;
                    ix2;
                    while (ix2 < 6)
                    {
                        
                        this.gS3SFace[ix1][ix2] = int(wData[idx][idx2]);
                        idx2 = (idx2 + 1);
                        ix2 = (ix2 + 1);
                    }
                    ix2;
                    while (ix2 < 5)
                    {
                        
                        this.gS3SFace[ix1][ix2 + 7] = int(wData[idx][idx2]);
                        idx2 = (idx2 + 1);
                        ix2 = (ix2 + 1);
                    }
                    this.gS3SFace[ix1][6] = 0;
                    this.gS3SFace[ix1][12] = 0;
                    ix1 = (ix1 + 1);
                }
            }
            catch (err:Error)
            {
                gS3SolidNo = 0;
                trace("Solid3D.dataLoad \'" + getQualifiedClassName(dataFace) + "\' Error:" + err.message);
                return;
            }
            if (this.gS3SolidNo < 3)
            {
                this.cylinderZahyouSet();
            }
            return;
        }// end function

        protected function clear() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.gS3SLineCnt)
            {
                
                this.gS3GLineColor[_loc_1] = 0;
                this.gS3GLineCut[_loc_1] = 0;
                this.gS3RgnLine[_loc_1] = new PolygonObject();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SFaceCnt)
            {
                
                this.gS3GFaceDist[_loc_1] = 0;
                this.gS3GFaceVec[_loc_1] = 0;
                this.gS3GLightVec[_loc_1] = 0;
                this.gS3GFaceMove[_loc_1] = 0;
                this.gS3GFaceColor[_loc_1] = 0;
                this.gS3RgnFace[_loc_1] = new PolygonObject();
                this.gS3FaceOver[_loc_1] = 0;
                this.gS3SHouVec[_loc_1] = new Vector3D();
                this.gS3CenterPoint[_loc_1] = new Vector3D();
                _loc_1++;
            }
            this.gS3ModelMode = 0;
            this.gS3StFlg = this.SELECT_NONE;
            this.dSelCol = 0;
            this.dMouseIcon = 0;
            _loc_1 = 0;
            while (_loc_1 < 5)
            {
                
                this.gS3TokuchoFlg[_loc_1] = 0;
                _loc_1++;
            }
            if (this.gS3SolidNo < 3)
            {
                this.cylinderClear();
                return;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SPointCnt)
            {
                
                this.gS3GPoint[_loc_1][0] = 0;
                this.gS3GPoint[_loc_1][1] = 0;
                this.gS3GPoint[_loc_1][2] = 0;
                this.gS3GPointColor[_loc_1] = 0;
                this.gS3RgnPoint[_loc_1] = new PolygonObject();
                _loc_1++;
            }
            this.gS3FOnLineFlg = false;
            this.gS3SlowLine = false;
            return;
        }// end function

        protected function initialize() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            gLastMoveSnapFaceNo = int.MIN_VALUE;
            if (this.gS3SolidNo < 3)
            {
                this.cylinderInitialize();
                return;
            }
            var _loc_1:* = new Vector.<Number>(6, true);
            var _loc_2:* = new Vector.<Number>(6, true);
            var _loc_3:* = new Vector.<Number>(6, true);
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                this.gS3GPoint[_loc_4][0] = this.gS3SPoint[_loc_4][0];
                this.gS3GPoint[_loc_4][1] = this.gS3SPoint[_loc_4][1];
                this.gS3GPoint[_loc_4][2] = this.gS3SPoint[_loc_4][2];
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SFaceCnt)
            {
                
                _loc_5 = this.gS3SFace[_loc_4][0];
                _loc_6 = 1;
                while (_loc_6 <= _loc_5)
                {
                    
                    _loc_7 = this.gS3SFace[_loc_4][_loc_6];
                    _loc_1[(_loc_6 - 1)] = this.gS3SPoint[_loc_7][0];
                    _loc_2[(_loc_6 - 1)] = this.gS3SPoint[_loc_7][1];
                    _loc_3[(_loc_6 - 1)] = this.gS3SPoint[_loc_7][2];
                    _loc_6++;
                }
                gPH3D.vrtVec(_loc_5, _loc_1, _loc_2, _loc_3);
                this.gS3SHouVec[_loc_4].x = gPH3D.dX;
                this.gS3SHouVec[_loc_4].y = gPH3D.dY;
                this.gS3SHouVec[_loc_4].z = gPH3D.dZ;
                _loc_4++;
            }
            return;
        }// end function

        override protected function move(param1:int, param2:Number) : void
        {
            if (this.gS3SolidNo < 3)
            {
                this.cylinderMove(param1, param2);
                return;
            }
            this.actionMove(param1, param2, this.gS3GPoint, this.gS3SPointCnt);
            return;
        }// end function

        override protected function moveActionSnap() : int
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_1:* = 0;
            switch(this.gS3SolidNo)
            {
                case 1:
                {
                    _loc_1 = this.gS3SFaceCnt - 1;
                    break;
                }
                case 2:
                {
                    _loc_1 = this.gS3SFaceCnt - 2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_2:* = _loc_1;
            while (_loc_2 < this.gS3SFaceCnt)
            {
                
                _loc_3 = this.getVectorCrossCurrentFace(_loc_2, true);
                _loc_4 = gLastMoveSnapFaceNo != _loc_2;
                if (this.snapSurface(_loc_3, _loc_4))
                {
                    if (_loc_4)
                    {
                        gLastMoveSnapFaceNo = _loc_2;
                    }
                    else
                    {
                        gLastMoveSnapFaceNo = int.MIN_VALUE;
                    }
                    return _loc_2;
                }
                _loc_2++;
            }
            return int.MIN_VALUE;
        }// end function

        protected function getVectorCrossCurrentFace(param1:int, param2:Boolean = true) : Vector3D
        {
            return this.getVectorCross(this.gS3GPoint[this.gS3SFace[param1][1]], this.gS3GPoint[this.gS3SFace[param1][2]], this.gS3GPoint[this.gS3SFace[param1][3]], param2);
        }// end function

        override protected function display3D() : void
        {
            if (this.gS3SolidNo < 3)
            {
                this.cylinderDisplay3D();
                return;
            }
            this.canvasGraphics.clear();
            if (this.gS3TokuchoFlg[4] == 1)
            {
                this.highSet();
            }
            this.deleteRegion();
            this.display3D2();
            return;
        }// end function

        protected function highSet() : void
        {
            var _loc_1:* = new Vector.<Number>(3, true);
            var _loc_2:* = new Vector.<Number>(3, true);
            var _loc_3:* = new Vector.<Number>(3, true);
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                this.gS3HighPoint[_loc_4] = new Vector3D();
                _loc_4++;
            }
            switch(this.gS3SolidNo)
            {
                case 3:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[0][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[0][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[0][2];
                    this.gS3HighPoint[1].x = this.gS3GPoint[9][0] + this.gS3GPoint[10][0] + this.gS3GPoint[11][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[9][1] + this.gS3GPoint[10][1] + this.gS3GPoint[11][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[9][2] + this.gS3GPoint[10][2] + this.gS3GPoint[11][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 3;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 3;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 3;
                    break;
                }
                case 4:
                case 16:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[12][0] + this.gS3GPoint[13][0] + this.gS3GPoint[14][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[12][1] + this.gS3GPoint[13][1] + this.gS3GPoint[14][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[12][2] + this.gS3GPoint[13][2] + this.gS3GPoint[14][2];
                    this.gS3HighPoint[0].x = this.gS3HighPoint[0].x / 3;
                    this.gS3HighPoint[0].y = this.gS3HighPoint[0].y / 3;
                    this.gS3HighPoint[0].z = this.gS3HighPoint[0].z / 3;
                    this.gS3HighPoint[1].x = this.gS3GPoint[15][0] + this.gS3GPoint[16][0] + this.gS3GPoint[17][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[15][1] + this.gS3GPoint[16][1] + this.gS3GPoint[17][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[15][2] + this.gS3GPoint[16][2] + this.gS3GPoint[17][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 3;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 3;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 3;
                    break;
                }
                case 5:
                case 17:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[0][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[0][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[0][2];
                    this.gS3HighPoint[1].x = this.gS3GPoint[12][0] + this.gS3GPoint[13][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[12][1] + this.gS3GPoint[13][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[12][2] + this.gS3GPoint[13][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x + (this.gS3GPoint[14][0] + this.gS3GPoint[15][0]);
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y + (this.gS3GPoint[14][1] + this.gS3GPoint[15][1]);
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z + (this.gS3GPoint[14][2] + this.gS3GPoint[15][2]);
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 4;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 4;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 4;
                    break;
                }
                case 6:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[4][0] + this.gS3GPoint[5][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[4][1] + this.gS3GPoint[5][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[4][2] + this.gS3GPoint[5][2];
                    this.gS3HighPoint[0].x = this.gS3HighPoint[0].x + (this.gS3GPoint[6][0] + this.gS3GPoint[7][0]);
                    this.gS3HighPoint[0].y = this.gS3HighPoint[0].y + (this.gS3GPoint[6][1] + this.gS3GPoint[7][1]);
                    this.gS3HighPoint[0].z = this.gS3HighPoint[0].z + (this.gS3GPoint[6][2] + this.gS3GPoint[7][2]);
                    this.gS3HighPoint[0].x = this.gS3HighPoint[0].x / 4;
                    this.gS3HighPoint[0].y = this.gS3HighPoint[0].y / 4;
                    this.gS3HighPoint[0].z = this.gS3HighPoint[0].z / 4;
                    this.gS3HighPoint[1].x = this.gS3GPoint[12][0] + this.gS3GPoint[13][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[12][1] + this.gS3GPoint[13][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[12][2] + this.gS3GPoint[13][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x + (this.gS3GPoint[14][0] + this.gS3GPoint[15][0]);
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y + (this.gS3GPoint[14][1] + this.gS3GPoint[15][1]);
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z + (this.gS3GPoint[14][2] + this.gS3GPoint[15][2]);
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 4;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 4;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 4;
                    break;
                }
                case 7:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[0][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[0][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[0][2];
                    this.gS3HighPoint[1].x = this.gS3GPoint[15][0] + this.gS3GPoint[16][0] + this.gS3GPoint[17][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[15][1] + this.gS3GPoint[16][1] + this.gS3GPoint[17][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[15][2] + this.gS3GPoint[16][2] + this.gS3GPoint[17][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x + (this.gS3GPoint[18][0] + this.gS3GPoint[19][0]);
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y + (this.gS3GPoint[18][1] + this.gS3GPoint[19][1]);
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z + (this.gS3GPoint[18][2] + this.gS3GPoint[19][2]);
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 5;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 5;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 5;
                    break;
                }
                case 8:
                {
                    this.gS3HighPoint[0].x = this.gS3GPoint[20][0] + this.gS3GPoint[21][0] + this.gS3GPoint[22][0];
                    this.gS3HighPoint[0].y = this.gS3GPoint[20][1] + this.gS3GPoint[21][1] + this.gS3GPoint[22][1];
                    this.gS3HighPoint[0].z = this.gS3GPoint[20][2] + this.gS3GPoint[21][2] + this.gS3GPoint[22][2];
                    this.gS3HighPoint[0].x = this.gS3HighPoint[0].x + (this.gS3GPoint[23][0] + this.gS3GPoint[24][0]);
                    this.gS3HighPoint[0].y = this.gS3HighPoint[0].y + (this.gS3GPoint[23][1] + this.gS3GPoint[24][1]);
                    this.gS3HighPoint[0].z = this.gS3HighPoint[0].z + (this.gS3GPoint[23][2] + this.gS3GPoint[24][2]);
                    this.gS3HighPoint[0].x = this.gS3HighPoint[0].x / 5;
                    this.gS3HighPoint[0].y = this.gS3HighPoint[0].y / 5;
                    this.gS3HighPoint[0].z = this.gS3HighPoint[0].z / 5;
                    this.gS3HighPoint[1].x = this.gS3GPoint[25][0] + this.gS3GPoint[26][0] + this.gS3GPoint[27][0];
                    this.gS3HighPoint[1].y = this.gS3GPoint[25][1] + this.gS3GPoint[26][1] + this.gS3GPoint[27][1];
                    this.gS3HighPoint[1].z = this.gS3GPoint[25][2] + this.gS3GPoint[26][2] + this.gS3GPoint[27][2];
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x + (this.gS3GPoint[28][0] + this.gS3GPoint[29][0]);
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y + (this.gS3GPoint[28][1] + this.gS3GPoint[29][1]);
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z + (this.gS3GPoint[28][2] + this.gS3GPoint[29][2]);
                    this.gS3HighPoint[1].x = this.gS3HighPoint[1].x / 5;
                    this.gS3HighPoint[1].y = this.gS3HighPoint[1].y / 5;
                    this.gS3HighPoint[1].z = this.gS3HighPoint[1].z / 5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_1[0] = this.gS3HighPoint[0].x;
            _loc_2[0] = this.gS3HighPoint[0].y;
            _loc_3[0] = this.gS3HighPoint[0].z;
            _loc_1[1] = this.gS3HighPoint[1].x;
            _loc_2[1] = this.gS3HighPoint[1].y;
            _loc_3[1] = this.gS3HighPoint[1].z;
            _loc_1[2] = this.gS3HighPoint[1].x;
            _loc_2[2] = this.gS3HighPoint[1].y;
            _loc_3[2] = this.gS3HighPoint[1].z;
            if (this.gS3SolidNo == 3 || this.gS3SolidNo == 5 || this.gS3SolidNo == 7)
            {
                this.gS3HighLeng = gPH3D.getDist(3, _loc_1, _loc_2, _loc_3);
            }
            else
            {
                this.gS3HighLeng = gPH3D.getDist(2, _loc_1, _loc_2, _loc_3);
            }
            return;
        }// end function

        protected function display3D2(param1:int = -1) : void
        {
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (this.gS3SolidNo < 3)
            {
                this.cylinderDisplay3D2();
                return;
            }
            var _loc_2:* = new Vector.<Number>(this.gS3SFaceCnt, true);
            _loc_3 = 0;
            while (_loc_3 < this.gS3SFaceCnt)
            {
                
                _loc_5 = this.gS3SFace[_loc_3][0];
                _loc_6 = new Vector.<Number>(_loc_5, true);
                _loc_7 = new Vector.<Number>(_loc_5, true);
                _loc_8 = new Vector.<Number>(_loc_5, true);
                _loc_9 = 0;
                while (_loc_9 < _loc_5)
                {
                    
                    _loc_10 = this.gS3SFace[_loc_3][(_loc_9 + 1)];
                    _loc_6[_loc_9] = this.gS3GPoint[_loc_10][0];
                    _loc_7[_loc_9] = this.gS3GPoint[_loc_10][1];
                    _loc_8[_loc_9] = this.gS3GPoint[_loc_10][2];
                    _loc_9++;
                }
                this.gS3GFaceDist[_loc_3] = gPH3D.getDist(_loc_5, _loc_6, _loc_7, _loc_8);
                _loc_2[_loc_3] = this.gS3GFaceDist[_loc_3];
                gPH3D.getVec(_loc_5, _loc_6, _loc_7, _loc_8);
                this.gS3GFaceVec[_loc_3] = gPH3D.dX;
                this.gS3GLightVec[_loc_3] = gPH3D.dY;
                if (this.gS3GFaceVec[_loc_3] > 0)
                {
                    _loc_2[_loc_3] = _loc_2[_loc_3] + 100;
                }
                _loc_3++;
            }
            this.dFaceDrawCnt = 0;
            var _loc_4:* = 0;
            while (true)
            {
                
                _loc_4 = 0;
                _loc_3 = 0;
                while (_loc_3 < this.gS3SFaceCnt)
                {
                    
                    if (_loc_2[_loc_3] > _loc_4)
                    {
                        _loc_4 = _loc_2[_loc_3];
                        _loc_9 = _loc_3;
                    }
                    _loc_3++;
                }
                if (_loc_4 == 0)
                {
                    break;
                }
                _loc_2[_loc_9] = 0;
                var _loc_11:* = this;
                var _loc_12:* = this.dFaceDrawCnt + 1;
                _loc_11.dFaceDrawCnt = _loc_12;
                this.drawPlane(_loc_9, param1);
            }
            return;
        }// end function

        protected function deleteRegion() : void
        {
            var _loc_1:* = 0;
            if (this.gS3SolidNo < 3)
            {
                this.cylinderDeleteRegion();
                return;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SPointCnt)
            {
                
                if (this.gS3RgnPoint[_loc_1].getSize() != 0)
                {
                    this.gS3RgnPoint[_loc_1].clear();
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SLineCnt)
            {
                
                if (this.gS3RgnLine[_loc_1].getSize() != 0)
                {
                    this.gS3RgnLine[_loc_1].clear();
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SFaceCnt)
            {
                
                if (this.gS3RgnFace[_loc_1].getSize() != 0)
                {
                    this.gS3RgnFace[_loc_1].clear();
                }
                _loc_1++;
            }
            return;
        }// end function

        protected function drawPlane(param1:int, param2:int = -1) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            if (this.gS3TokuchoFlg[4] == 1 && this.gS3HighLeng != 0 && this.gS3GFaceDist[param1] < this.gS3HighLeng)
            {
                _loc_13 = new Vector.<Point>(2, true);
                _loc_11 = 0;
                while (_loc_11 < 2)
                {
                    
                    gPH3D.cv3d3d(this.gS3HighPoint[_loc_11].x, this.gS3HighPoint[_loc_11].y, this.gS3HighPoint[_loc_11].z);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_13[_loc_11] = new Point();
                    _loc_13[_loc_11].x = VewWinX;
                    _loc_13[_loc_11].y = VewWinY;
                    _loc_11++;
                }
                this.dComLine.setWidth(1);
                this.dComLine.setStyle(LineObject.DOT);
                this.dComLine.setColor(this.COLOR_RED);
                this.dComLine.setLocationPoint(_loc_13[0], _loc_13[1]);
                this.dComLine.draw(this.canvasGraphics);
                this.canvasGraphics.lineStyle(1, this.COLOR_RED);
                _loc_11 = 0;
                while (_loc_11 < 2)
                {
                    
                    this.canvasGraphics.beginFill(this.COLOR_RED);
                    this.canvasGraphics.drawCircle(_loc_13[_loc_11].x, _loc_13[_loc_11].y, 2.5);
                    this.canvasGraphics.endFill();
                    _loc_11++;
                }
                this.gS3HighLeng = 0;
            }
            if (this.gS3ModelMode == 0)
            {
                if ((this.gS3GFaceColor[param1] & 16777215) == 0)
                {
                    _loc_3 = gPH3D.drwplColor(this.getFaceCol(), this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    _loc_6 = this.dFaceColA;
                }
                else
                {
                    _loc_3 = gPH3D.drwplColor(this.gS3GFaceColor[param1], this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    _loc_6 = 1;
                }
            }
            else
            {
                _loc_3 = this.gS3GFaceColor[param1];
                _loc_6 = 1;
            }
            switch(this.gS3FaceOver[param1])
            {
                case 1:
                {
                    _loc_3 = gPH3D.drwplColor(this.IE_FACE_COL_DUPLICATED, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    _loc_6 = 1;
                    break;
                }
                case 2:
                {
                    _loc_3 = gPH3D.drwplColor(this.PV_FACE_COL_SELECTED1, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    _loc_6 = 1;
                    break;
                }
                case 3:
                {
                    _loc_3 = gPH3D.drwplColor(this.PV_FACE_COL_SELECTED2, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    _loc_6 = 1;
                    break;
                }
                case 5:
                {
                    if (this.gS3ModelMode == 0)
                    {
                        _loc_3 = gPH3D.drwplColor(this.FS_FACE_COL_BASE_S, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    }
                    else
                    {
                        _loc_3 = this.FS_FACE_COL_BASE_W;
                    }
                    _loc_6 = 1;
                    break;
                }
                case 6:
                {
                    if (this.gS3ModelMode == 0)
                    {
                        _loc_3 = gPH3D.drwplColor(this.FS_FACE_COL_SIDE_S, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                    }
                    else
                    {
                        _loc_3 = this.FS_FACE_COL_SIDE_W;
                    }
                    _loc_6 = 1;
                    break;
                }
                case 7:
                {
                    if ((this.gS3GFaceColor[param1] & 16777215) == 0)
                    {
                        if (this.gS3ModelMode == 0)
                        {
                            _loc_3 = gPH3D.drwplColor(this.CC_FACE_COL_CUTED_S, this.gS3GFaceVec[param1], this.gS3GLightVec[param1]);
                        }
                        else
                        {
                            _loc_3 = this.CC_FACE_COL_CUTED_W;
                        }
                    }
                    _loc_6 = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_8 = this.gS3SFace[param1][0];
            _loc_13 = new Vector.<Point>(_loc_8, true);
            _loc_11 = 0;
            while (_loc_11 < _loc_8)
            {
                
                _loc_9 = this.gS3SFace[param1][(_loc_11 + 1)];
                gPH3D.cv3d3d(this.gS3GPoint[_loc_9][0], this.gS3GPoint[_loc_9][1], this.gS3GPoint[_loc_9][2]);
                this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                _loc_13[_loc_11] = new Point();
                _loc_13[_loc_11].x = VewWinX;
                _loc_13[_loc_11].y = VewWinY;
                _loc_11++;
            }
            _loc_5 = _loc_3;
            _loc_4 = _loc_3;
            _loc_7 = 1;
            if (this.gS3ModelMode == 0)
            {
                _loc_7 = 2;
            }
            else
            {
                if (this.gS3SFaceCnt - this.dFaceDrawCnt == param2)
                {
                    _loc_3 = this.RS_FACE_COL_CENTER;
                    _loc_5 = _loc_3;
                }
                if (this.gS3GFaceVec[param1] < 0)
                {
                    _loc_4 = this.getFaceColWirerFrame();
                    if (this.gS3ModelMode == 2)
                    {
                        _loc_7 = 2;
                    }
                }
                else
                {
                    _loc_4 = this.FACE_COL_DEFAULT_W2;
                }
            }
            if (this.dLineCol >= 0)
            {
                _loc_4 = this.dLineCol;
            }
            if (this.dLineWid >= 0)
            {
                _loc_7 = this.dLineWid;
            }
            var _loc_15:* = uint.MAX_VALUE;
            if (this.gS3GFaceVec[param1] >= 0)
            {
                if (this.dLineRevCol >= 0)
                {
                    _loc_4 = this.dLineRevCol;
                }
                if (this.dLineRevDotLength > 0 && this.dLineRevDotInterval > 0 && _loc_7 > 0)
                {
                    _loc_15 = _loc_4;
                    _loc_4 = this.areaBackColor;
                    _loc_7 = _loc_7 + 1;
                }
            }
            var _loc_16:* = this.gS3ModelMode == 0 || (_loc_3 & 16777215) != 0;
            this.canvasGraphics.lineStyle(_loc_7, _loc_4);
            if (_loc_16)
            {
                this.canvasGraphics.beginFill(_loc_5, _loc_6);
            }
            this.canvasGraphics.moveTo(_loc_13[0].x, _loc_13[0].y);
            _loc_11 = 1;
            while (_loc_11 < _loc_8)
            {
                
                this.canvasGraphics.lineTo(_loc_13[_loc_11].x, _loc_13[_loc_11].y);
                _loc_11++;
            }
            this.canvasGraphics.lineTo(_loc_13[0].x, _loc_13[0].y);
            this.canvasGraphics.endFill();
            if (_loc_15 != uint.MAX_VALUE)
            {
                _loc_7 = _loc_7 - 1;
                this.setDotLineStyle(this.canvasGraphics, _loc_7, _loc_15, 1);
                this.drawDotLine(this.canvasGraphics, _loc_13, _loc_8, this.dLineRevDotLength, this.dLineRevDotInterval, true);
            }
            if (this.gS3ModelMode != 0)
            {
                if (this.gS3SFaceCnt - this.dFaceDrawCnt <= param2)
                {
                    gPH3D.cv3d3d(this.gS3CenterPoint[param1].x, this.gS3CenterPoint[param1].y, this.gS3CenterPoint[param1].z);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    if (this.gS3SlowLine == true && this.gS3SFaceCnt == this.dFaceDrawCnt)
                    {
                        this.dComLine.setColor(8421504);
                        this.dComLine.setWidth(1);
                        this.dComLine.slowLineSpecial(this.eventJump, this.areaCanvas, VewWinX, VewWinY, _loc_13, 20, 100);
                        this.gS3SlowLine = false;
                        this.dPauseValues = new Array();
                        this.dPauseValues.push(param1);
                        this.dPauseValues.push(param2);
                        this.dPauseValues.push(_loc_8);
                        this.dPauseValues.push(_loc_13);
                        this.dPauseResult = int.MIN_VALUE;
                        this.dPauseNecessary = false;
                        this.dPauseEventCode = "";
                        this.dPauseFunction = this.drawPlaneMove;
                        return;
                    }
                    _loc_3 = this.RS_CENTER_POINT_COL;
                    this.canvasGraphics.lineStyle(1, _loc_3);
                    this.canvasGraphics.beginFill(_loc_3);
                    this.canvasGraphics.drawCircle(VewWinX, VewWinY, 4.5);
                    this.canvasGraphics.endFill();
                }
            }
            this.gS3RgnFace[param1].add(_loc_13, _loc_8);
            _loc_11 = 0;
            while (_loc_11 < _loc_8)
            {
                
                if (_loc_11 == (_loc_8 - 1))
                {
                    _loc_12 = 0;
                }
                else
                {
                    _loc_12 = _loc_11 + 1;
                }
                _loc_10 = this.gS3SFace[param1][_loc_11 + 7];
                _loc_7 = 1;
                if (this.gS3GLineCut[_loc_10] == 1)
                {
                    _loc_3 = this.LINE_COL_CUT;
                    _loc_7 = 3;
                }
                else if (this.gS3GLineCut[_loc_10] == 4)
                {
                    _loc_3 = this.PV_LINE_COL_SELECTED;
                    _loc_7 = 3;
                }
                else if (this.gS3GLineCut[_loc_10] == 5)
                {
                    _loc_3 = this.PV_LINE_COL_STRONG;
                    _loc_7 = 3;
                }
                else if (this.gS3TokuchoFlg[2] == 1)
                {
                    _loc_3 = this.FS_LINE_COL_SELECTED;
                    _loc_7 = 3;
                }
                else if ((this.gS3GLineColor[_loc_10] & 16777215) > 0)
                {
                    _loc_3 = this.gS3GLineColor[_loc_10];
                    _loc_7 = 3;
                }
                else if (this.gS3GLineCut[_loc_10] == 3)
                {
                    _loc_3 = this.LINE_COL_PIVOT;
                    _loc_7 = 1;
                }
                else
                {
                    _loc_3 = 0;
                }
                if (this.dLineWid >= 0)
                {
                    _loc_7 = Math.max(_loc_7, this.dLineWid);
                }
                if ((_loc_3 & 16777215) > 0)
                {
                    this.canvasGraphics.lineStyle(_loc_7, _loc_3);
                    this.canvasGraphics.moveTo(_loc_13[_loc_11].x, _loc_13[_loc_11].y);
                    this.canvasGraphics.lineTo(_loc_13[_loc_12].x, _loc_13[_loc_12].y);
                }
                if (_loc_13[_loc_12].x == _loc_13[_loc_11].x)
                {
                    _loc_14 = 99;
                }
                else
                {
                    _loc_14 = (_loc_13[_loc_12].y - _loc_13[_loc_11].y) / (_loc_13[_loc_12].x - _loc_13[_loc_11].x);
                }
                if (_loc_14 < -1 || _loc_14 > 1)
                {
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_11].x - 5, _loc_13[_loc_11].y);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_11].x + 5, _loc_13[_loc_11].y);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_12].x + 5, _loc_13[_loc_12].y);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_12].x - 5, _loc_13[_loc_12].y);
                }
                else
                {
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_11].x, _loc_13[_loc_11].y - 5);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_11].x, _loc_13[_loc_11].y + 5);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_12].x, _loc_13[_loc_12].y + 5);
                    this.gS3RgnLine[_loc_10].addPoint(_loc_13[_loc_12].x, _loc_13[_loc_12].y - 5);
                }
                _loc_11++;
            }
            if (this.gS3FOnLineFlg)
            {
                this.faceOnLineDraw(param1, _loc_13, _loc_8);
            }
            _loc_11 = 0;
            while (_loc_11 < _loc_8)
            {
                
                _loc_3 = 0;
                _loc_9 = this.gS3SFace[param1][(_loc_11 + 1)];
                if (this.gS3TokuchoFlg[3] == 1)
                {
                    _loc_3 = this.FS_POINT_COL_SELECTED;
                }
                else if ((this.gS3GPointColor[_loc_9] & 16777215) > 0)
                {
                    _loc_3 = this.gS3GPointColor[_loc_9];
                }
                if ((_loc_3 & 16777215) > 0)
                {
                    this.canvasGraphics.lineStyle(1, _loc_3);
                    this.canvasGraphics.beginFill(_loc_3);
                    this.canvasGraphics.drawCircle(_loc_13[_loc_11].x, _loc_13[_loc_11].y, 4.5);
                    this.canvasGraphics.endFill();
                }
                this.gS3RgnPoint[_loc_9].addPoint(_loc_13[_loc_11].x - 6, _loc_13[_loc_11].y - 6);
                this.gS3RgnPoint[_loc_9].addPoint(_loc_13[_loc_11].x + 6, _loc_13[_loc_11].y - 6);
                this.gS3RgnPoint[_loc_9].addPoint(_loc_13[_loc_11].x + 6, _loc_13[_loc_11].y + 6);
                this.gS3RgnPoint[_loc_9].addPoint(_loc_13[_loc_11].x - 6, _loc_13[_loc_11].y + 6);
                _loc_11++;
            }
            return;
        }// end function

        protected function faceOnLineDraw(param1:int, param2:Vector.<Point>, param3:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_9:* = 0;
            var _loc_4:* = new Vector.<Point>(2, true);
            var _loc_8:* = 0;
            while (_loc_8 < this.gS3FOnLineCnt)
            {
                
                if (param1 == this.gS3FOnLine[_loc_8].FaceNo)
                {
                    _loc_9 = 0;
                    while (_loc_9 < 2)
                    {
                        
                        _loc_4[_loc_9] = new Point();
                        _loc_5 = this.gS3FOnLine[_loc_8].LinePos[_loc_9];
                        if (_loc_5 == (param3 - 1))
                        {
                            _loc_6 = (param2[0].x - param2[_loc_5].x) * this.gS3FOnLine[_loc_8].PosRate[_loc_9];
                            _loc_7 = (param2[0].y - param2[_loc_5].y) * this.gS3FOnLine[_loc_8].PosRate[_loc_9];
                            _loc_4[_loc_9].x = _loc_6 + param2[_loc_5].x;
                            _loc_4[_loc_9].y = _loc_7 + param2[_loc_5].y;
                        }
                        else
                        {
                            _loc_6 = (param2[(_loc_5 + 1)].x - param2[_loc_5].x) * this.gS3FOnLine[_loc_8].PosRate[_loc_9];
                            _loc_7 = (param2[(_loc_5 + 1)].y - param2[_loc_5].y) * this.gS3FOnLine[_loc_8].PosRate[_loc_9];
                            _loc_4[_loc_9].x = _loc_6 + param2[_loc_5].x;
                            _loc_4[_loc_9].y = _loc_7 + param2[_loc_5].y;
                        }
                        _loc_9++;
                    }
                    this.canvasGraphics.lineStyle(3, this.SS_FACE_ON_LINE_COL);
                    this.canvasGraphics.moveTo(_loc_4[0].x, _loc_4[0].y);
                    this.canvasGraphics.lineTo(_loc_4[1].x, _loc_4[1].y);
                }
                _loc_8++;
            }
            return;
        }// end function

        protected function selectRegion() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = false;
            if (this.gS3SolidNo < 3)
            {
                return this.cylinderSelectRegion();
            }
            var _loc_3:* = new Vector.<Number>(this.gS3SFaceCnt, true);
            var _loc_6:* = 0;
            _loc_5 = 0;
            while (_loc_5 < this.gS3SFaceCnt)
            {
                
                _loc_3[_loc_5] = this.gS3GFaceDist[_loc_5];
                if (this.gS3GFaceVec[_loc_5] > 0)
                {
                    _loc_3[_loc_5] = _loc_3[_loc_5] + 100;
                }
                _loc_5++;
            }
            while (true)
            {
                
                _loc_4 = 9999;
                _loc_5 = 0;
                while (_loc_5 < this.gS3SFaceCnt)
                {
                    
                    if (_loc_3[_loc_5] < _loc_4)
                    {
                        _loc_4 = _loc_3[_loc_5];
                        _loc_6 = _loc_5;
                    }
                    _loc_5++;
                }
                if (_loc_4 == 9999)
                {
                    return 0;
                }
                _loc_3[_loc_6] = 9999;
                _loc_7 = this.gS3SFace[_loc_6][0];
                _loc_5 = 0;
                while (_loc_5 < _loc_7)
                {
                    
                    _loc_8 = this.gS3SFace[_loc_6][(_loc_5 + 1)];
                    _loc_9 = this.gS3RgnPoint[_loc_8].contains(this.mouseX, this.mouseY);
                    if (_loc_9 == true)
                    {
                        _loc_1 = 1;
                        _loc_2 = _loc_8;
                        return (_loc_1 << 8) + _loc_2;
                    }
                    _loc_5++;
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_7)
                {
                    
                    _loc_8 = this.gS3SFace[_loc_6][_loc_5 + 7];
                    _loc_9 = this.gS3RgnLine[_loc_8].contains(this.mouseX, this.mouseY);
                    if (_loc_9 == true)
                    {
                        _loc_1 = 2;
                        _loc_2 = _loc_8;
                        return (_loc_1 << 8) + _loc_2;
                    }
                    _loc_5++;
                }
                _loc_9 = this.gS3RgnFace[_loc_6].contains(this.mouseX, this.mouseY);
                if (_loc_9 == true)
                {
                    _loc_1 = 3;
                    _loc_2 = _loc_6;
                    return (_loc_1 << 8) + _loc_2;
                }
            }
            return 0;
        }// end function

        protected function tenkaiCheck(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_4:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = new Vector.<Vector.<int>>(2, true);
            var _loc_11:* = new Vector.<Vector.<int>>(2, true);
            var _loc_12:* = new Vector.<Vector.<int>>(2, true);
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                _loc_10[_loc_3] = new Vector.<int>(31, true);
                _loc_11[_loc_3] = new Vector.<int>(31, true);
                _loc_12[_loc_3] = new Vector.<int>(21, true);
                _loc_3++;
            }
            var _loc_13:* = new Vector.<int>(3, true);
            _loc_11[0][0] = param1;
            _loc_11[1][0] = this.gS3SLine[param1][2];
            _loc_13[0] = 0;
            _loc_13[1] = 0;
            _loc_2 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            _loc_7 = 1;
            do
            {
                
                _loc_8 = this.gS3SLine[_loc_11[_loc_2][_loc_6]][2];
                _loc_6 = _loc_6 + 1;
                _loc_3 = 0;
                while (_loc_3 < this.gS3SFaceCnt)
                {
                    
                    _loc_9 = this.gS3SFace[_loc_3][0];
                    _loc_4 = 0;
                    while (_loc_4 < _loc_9)
                    {
                        
                        if (this.gS3SFace[_loc_3][_loc_4 + 7] == _loc_8)
                        {
                            _loc_4 = _loc_3;
                            _loc_3 = this.gS3SFaceCnt - 1;
                            break;
                        }
                        _loc_4++;
                    }
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 != _loc_13[_loc_2])
                {
                    
                    if (_loc_12[_loc_2][_loc_3] == _loc_4)
                    {
                        _loc_4 = -1;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_4 != -1)
                {
                    _loc_12[_loc_2][_loc_13[_loc_2]] = _loc_4;
                    (_loc_13[_loc_2] + 1);
                    _loc_3 = 0;
                    while (_loc_3 < _loc_9)
                    {
                        
                        if (this.gS3SFace[_loc_4][_loc_3 + 7] != _loc_8)
                        {
                            if (this.gS3GLineCut[this.gS3SFace[_loc_4][_loc_3 + 7]] == 1 || this.gS3GLineCut[this.gS3SFace[_loc_4][_loc_3 + 7]] == 2)
                            {
                                _loc_10[_loc_2][_loc_5] = this.gS3SFace[_loc_4][_loc_3 + 7];
                                _loc_5 = _loc_5 + 1;
                            }
                            else
                            {
                                _loc_11[_loc_2][_loc_7] = this.gS3SFace[_loc_4][_loc_3 + 7];
                                _loc_7 = _loc_7 + 1;
                            }
                        }
                        _loc_3++;
                    }
                }
            }while (_loc_6 != _loc_7)
            if (_loc_13[0] != this.gS3SFaceCnt)
            {
                return false;
            }
            return true;
        }// end function

        protected function tenkai(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_4:* = 0;
            var _loc_9:* = 0;
            var _loc_12:* = new Vector.<Vector.<int>>(2, true);
            var _loc_13:* = new Vector.<Vector.<int>>(2, true);
            var _loc_14:* = new Vector.<Vector.<int>>(2, true);
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                _loc_12[_loc_3] = new Vector.<int>(31, true);
                _loc_13[_loc_3] = new Vector.<int>(31, true);
                _loc_14[_loc_3] = new Vector.<int>(21, true);
                _loc_3++;
            }
            var _loc_15:* = new Vector.<int>(3, true);
            _loc_10 = new Vector.<Vector.<Number>>(this.gS3SPointCnt, true);
            _loc_3 = 0;
            while (_loc_3 < _loc_10.length)
            {
                
                _loc_10[_loc_3] = new Vector.<Number>(3, true);
                _loc_3++;
            }
            _loc_13[0][0] = param1;
            _loc_13[1][0] = this.gS3SLine[param1][2];
            _loc_15[0] = 0;
            _loc_15[1] = 0;
            _loc_2 = 0;
            while (_loc_2 < 2)
            {
                
                _loc_5 = 0;
                _loc_6 = 0;
                _loc_7 = 1;
                do
                {
                    
                    _loc_8 = this.gS3SLine[_loc_13[_loc_2][_loc_6]][2];
                    _loc_6 = _loc_6 + 1;
                    _loc_3 = 0;
                    while (_loc_3 < this.gS3SFaceCnt)
                    {
                        
                        _loc_9 = this.gS3SFace[_loc_3][0];
                        _loc_4 = 0;
                        while (_loc_4 < _loc_9)
                        {
                            
                            if (this.gS3SFace[_loc_3][_loc_4 + 7] == _loc_8)
                            {
                                _loc_4 = _loc_3;
                                _loc_3 = this.gS3SFaceCnt - 1;
                                break;
                            }
                            _loc_4++;
                        }
                        _loc_3++;
                    }
                    _loc_3 = 0;
                    while (_loc_3 != _loc_15[_loc_2])
                    {
                        
                        if (_loc_14[_loc_2][_loc_3] == _loc_4)
                        {
                            _loc_4 = -1;
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    if (_loc_4 != -1)
                    {
                        _loc_14[_loc_2][_loc_15[_loc_2]] = _loc_4;
                        (_loc_15[_loc_2] + 1);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_9)
                        {
                            
                            if (this.gS3SFace[_loc_4][_loc_3 + 7] != _loc_8)
                            {
                                if (this.gS3GLineCut[this.gS3SFace[_loc_4][_loc_3 + 7]] == 1 || this.gS3GLineCut[this.gS3SFace[_loc_4][_loc_3 + 7]] == 2)
                                {
                                    _loc_12[_loc_2][_loc_5] = this.gS3SFace[_loc_4][_loc_3 + 7];
                                    _loc_5 = _loc_5 + 1;
                                }
                                else
                                {
                                    _loc_13[_loc_2][_loc_7] = this.gS3SFace[_loc_4][_loc_3 + 7];
                                    _loc_7 = _loc_7 + 1;
                                }
                            }
                            _loc_3++;
                        }
                    }
                }while (_loc_6 != _loc_7)
                _loc_2++;
            }
            if (_loc_15[0] + _loc_15[1] != this.gS3SFaceCnt)
            {
                return 0;
            }
            if (_loc_15[0] + _loc_15[1] < this.gS3SFaceCnt)
            {
                _loc_9 = 0;
                _loc_3 = 0;
                while (_loc_3 < this.gS3SLineCnt)
                {
                    
                    if (this.gS3GLineCut[_loc_3] == 1)
                    {
                        _loc_9 = _loc_9 + 1;
                    }
                    _loc_3++;
                }
                if (_loc_9 < 3)
                {
                    return 0;
                }
            }
            if (_loc_15[0] == 1)
            {
                _loc_2 = 0;
            }
            else if (_loc_15[1] == 1)
            {
                _loc_2 = 1;
            }
            else if (this.gS3GFaceVec[_loc_14[0][0]] < this.gS3GFaceVec[_loc_14[1][0]])
            {
                _loc_2 = 1;
            }
            else
            {
                _loc_2 = 0;
            }
            _loc_2 = (_loc_2 + 1) % 2;
            _loc_3 = 0;
            while (_loc_3 < _loc_15[_loc_2])
            {
                
                if (this.gS3GFaceMove[_loc_14[_loc_2][_loc_3]] == 0)
                {
                    _loc_2 = (_loc_2 + 1) % 2;
                    break;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < this.gS3SPointCnt)
            {
                
                _loc_4 = 0;
                while (_loc_4 < 3)
                {
                    
                    _loc_10[_loc_3][_loc_4] = this.gS3GPoint[_loc_3][_loc_4];
                    _loc_4++;
                }
                _loc_3++;
            }
            _loc_11 = this.gS3SHouVec[_loc_14[0][0]].x * this.gS3SHouVec[_loc_14[1][0]].x;
            _loc_11 = _loc_11 + this.gS3SHouVec[_loc_14[0][0]].y * this.gS3SHouVec[_loc_14[1][0]].y;
            _loc_11 = _loc_11 + this.gS3SHouVec[_loc_14[0][0]].z * this.gS3SHouVec[_loc_14[1][0]].z;
            _loc_11 = Math.acos(_loc_11);
            _loc_3 = 1;
            this.dPauseValues = new Array();
            this.dPauseValues.push(param1);
            this.dPauseValues.push(_loc_2);
            this.dPauseValues.push(_loc_3);
            this.dPauseValues.push(_loc_10);
            this.dPauseValues.push(_loc_11);
            this.dPauseValues.push(_loc_14);
            this.dPauseValues.push(_loc_13);
            this.dPauseValues.push(_loc_15);
            this.dPauseFunction = this.tenkaiMove;
            this.dPauseNecessary = false;
            this.tenkaiMove();
            return -1;
        }// end function

        protected function turn(param1:int, param2:int, param3:Number) : Boolean
        {
            var _loc_4:* = this.lineTurn(this.gS3GPoint[this.gS3SLine[param1][0]][0], this.gS3GPoint[this.gS3SLine[param1][0]][1], this.gS3GPoint[this.gS3SLine[param1][0]][2], this.gS3GPoint[this.gS3SLine[param1][1]][0], this.gS3GPoint[this.gS3SLine[param1][1]][1], this.gS3GPoint[this.gS3SLine[param1][1]][2], this.gS3GPoint[param2][0], this.gS3GPoint[param2][1], this.gS3GPoint[param2][2], param3);
            if (this.lineTurn(this.gS3GPoint[this.gS3SLine[param1][0]][0], this.gS3GPoint[this.gS3SLine[param1][0]][1], this.gS3GPoint[this.gS3SLine[param1][0]][2], this.gS3GPoint[this.gS3SLine[param1][1]][0], this.gS3GPoint[this.gS3SLine[param1][1]][1], this.gS3GPoint[this.gS3SLine[param1][1]][2], this.gS3GPoint[param2][0], this.gS3GPoint[param2][1], this.gS3GPoint[param2][2], param3))
            {
                this.gS3GPoint[param2][0] = _loc_4.x;
                this.gS3GPoint[param2][1] = _loc_4.y;
                this.gS3GPoint[param2][2] = _loc_4.z;
                return true;
            }
            return false;
        }// end function

        protected function kumitate(param1:int, param2:Number = 0) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_16:* = NaN;
            var _loc_5:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = new Vector.<Vector.<int>>(2, true);
            var _loc_12:* = new Vector.<Vector.<int>>(2, true);
            var _loc_13:* = new Vector.<Vector.<int>>(2, true);
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_11[_loc_4] = new Vector.<int>(31, true);
                _loc_12[_loc_4] = new Vector.<int>(31, true);
                _loc_13[_loc_4] = new Vector.<int>(21, true);
                _loc_4++;
            }
            var _loc_14:* = new Vector.<int>(3, true);
            var _loc_15:* = new Vector.<Vector.<Number>>(this.gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                _loc_15[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            var _loc_17:* = new Vector.<int>(3, true);
            _loc_12[0][0] = param1;
            _loc_12[1][0] = this.gS3SLine[param1][2];
            _loc_14[0] = 0;
            _loc_14[1] = 0;
            _loc_3 = 0;
            while (_loc_3 < 2)
            {
                
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = 1;
                _loc_17[_loc_3] = 0;
                do
                {
                    
                    _loc_9 = this.gS3SLine[_loc_12[_loc_3][_loc_7]][2];
                    _loc_7 = _loc_7 + 1;
                    _loc_4 = 0;
                    while (_loc_4 < this.gS3SFaceCnt)
                    {
                        
                        _loc_10 = this.gS3SFace[_loc_4][0];
                        _loc_5 = 0;
                        while (_loc_5 < _loc_10)
                        {
                            
                            if (this.gS3SFace[_loc_4][_loc_5 + 7] == _loc_9)
                            {
                                _loc_5 = _loc_4;
                                _loc_4 = this.gS3SFaceCnt - 1;
                                break;
                            }
                            _loc_5++;
                        }
                        _loc_4++;
                    }
                    _loc_4 = 0;
                    while (_loc_4 != _loc_14[_loc_3])
                    {
                        
                        if (_loc_13[_loc_3][_loc_4] == _loc_5)
                        {
                            _loc_5 = -1;
                            break;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    if (_loc_5 != -1)
                    {
                        _loc_13[_loc_3][_loc_14[_loc_3]] = _loc_5;
                        (_loc_14[_loc_3] + 1);
                        _loc_17[_loc_3] = _loc_17[_loc_3] + this.gS3GFaceMove[_loc_5];
                        _loc_4 = 0;
                        while (_loc_4 < _loc_10)
                        {
                            
                            if (this.gS3SFace[_loc_5][_loc_4 + 7] != _loc_9)
                            {
                                if (this.gS3GLineCut[this.gS3SFace[_loc_5][_loc_4 + 7]] == 1 || this.gS3GLineCut[this.gS3SFace[_loc_5][_loc_4 + 7]] == 2)
                                {
                                    _loc_11[_loc_3][_loc_6] = this.gS3SFace[_loc_5][_loc_4 + 7];
                                    _loc_6 = _loc_6 + 1;
                                }
                                else
                                {
                                    _loc_12[_loc_3][_loc_8] = this.gS3SFace[_loc_5][_loc_4 + 7];
                                    _loc_8 = _loc_8 + 1;
                                }
                            }
                            _loc_4++;
                        }
                    }
                }while (_loc_7 != _loc_8)
                _loc_3++;
            }
            _loc_3 = -1;
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_5 = 0;
                while (_loc_5 < _loc_14[_loc_4])
                {
                    
                    if (this.gS3GFaceMove[_loc_13[_loc_4][_loc_5]] == 0)
                    {
                        _loc_3 = (_loc_4 + 1) % 2;
                        break;
                    }
                    _loc_5++;
                }
                if (_loc_3 != -1)
                {
                    break;
                }
                _loc_4++;
            }
            if (_loc_3 == -1)
            {
                if (_loc_17[0] > _loc_17[1])
                {
                    _loc_3 = 0;
                }
                else
                {
                    _loc_3 = 1;
                }
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                _loc_5 = 0;
                while (_loc_5 < 3)
                {
                    
                    _loc_15[_loc_4][_loc_5] = this.gS3GPoint[_loc_4][_loc_5];
                    _loc_5++;
                }
                _loc_4++;
            }
            if (param2 == 0)
            {
                _loc_16 = this.gS3SHouVec[_loc_13[0][0]].x * this.gS3SHouVec[_loc_13[1][0]].x;
                _loc_16 = _loc_16 + this.gS3SHouVec[_loc_13[0][0]].y * this.gS3SHouVec[_loc_13[1][0]].y;
                _loc_16 = _loc_16 + this.gS3SHouVec[_loc_13[0][0]].z * this.gS3SHouVec[_loc_13[1][0]].z;
                _loc_16 = Math.acos(_loc_16);
            }
            else
            {
                _loc_16 = param2;
            }
            _loc_4 = 1;
            this.dPauseValues = new Array();
            this.dPauseValues.push(param1);
            this.dPauseValues.push(_loc_3);
            this.dPauseValues.push(_loc_4);
            this.dPauseValues.push(_loc_12);
            this.dPauseValues.push(_loc_13);
            this.dPauseValues.push(_loc_14);
            this.dPauseValues.push(_loc_15);
            this.dPauseValues.push(_loc_16);
            this.dPauseFunction = this.kumitateMove;
            this.dPauseNecessary = false;
            this.kumitateMove();
            return true;
        }// end function

        protected function motonoichi() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            if (this.gS3SolidNo < 3)
            {
                this.cylinderMotonoichi();
                return;
            }
            var _loc_1:* = new Vector.<int>(2, true);
            var _loc_2:* = new Vector.<int>(2, true);
            var _loc_5:* = 0;
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                this.gS3GPoint[_loc_4][0] = this.gS3SPoint[_loc_4][0];
                this.gS3GPoint[_loc_4][1] = this.gS3SPoint[_loc_4][1];
                this.gS3GPoint[_loc_4][2] = this.gS3SPoint[_loc_4][2];
                _loc_4++;
            }
            _loc_9 = 0;
            _loc_8 = new Vector.<int>(this.gS3SLineCnt, true);
            _loc_4 = 0;
            while (_loc_4 < this.gS3SLineCnt)
            {
                
                if (this.gS3GLineCut[_loc_4] == 3)
                {
                    _loc_9++;
                }
                if (this.gS3GLineCut[_loc_4] == 3 && _loc_8[_loc_4] != 3)
                {
                    _loc_2[0] = _loc_4;
                    _loc_2[1] = this.gS3SLine[_loc_4][2];
                    _loc_8[_loc_2[0]] = 3;
                    _loc_8[_loc_2[1]] = 3;
                    _loc_5 = 0;
                    while (_loc_5 < 2)
                    {
                        
                        _loc_6 = 0;
                        while (_loc_6 < this.gS3SFaceCnt)
                        {
                            
                            _loc_3 = this.gS3SFace[_loc_6][0];
                            _loc_7 = 0;
                            while (_loc_7 < _loc_3)
                            {
                                
                                if (this.gS3SFace[_loc_6][_loc_7 + 7] == _loc_2[_loc_5])
                                {
                                    _loc_1[_loc_5] = _loc_6;
                                    _loc_6 = this.gS3SFaceCnt - 1;
                                    break;
                                }
                                _loc_7++;
                            }
                            _loc_6++;
                        }
                        _loc_5++;
                    }
                    _loc_10 = this.gS3SHouVec[_loc_1[0]].x * this.gS3SHouVec[_loc_1[1]].x;
                    _loc_10 = _loc_10 + this.gS3SHouVec[_loc_1[0]].y * this.gS3SHouVec[_loc_1[1]].y;
                    _loc_10 = _loc_10 + this.gS3SHouVec[_loc_1[0]].z * this.gS3SHouVec[_loc_1[1]].z;
                    _loc_10 = Math.acos(_loc_10);
                    if (this.gS3GFaceMove[_loc_1[0]] < this.gS3GFaceMove[_loc_1[1]])
                    {
                        this.saiTenkai(_loc_2[0], _loc_10);
                    }
                    else
                    {
                        this.saiTenkai(_loc_2[1], _loc_10);
                    }
                }
                _loc_4++;
            }
            if (_loc_9 != (this.gS3SFaceCnt - 1) * 2)
            {
                this.moveBasis();
            }
            else
            {
                this.idou3();
            }
            this.display3D();
            return;
        }// end function

        protected function saiTenkai(param1:int, param2:Number) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_3:* = new Vector.<int>(31, true);
            var _loc_4:* = new Vector.<int>(31, true);
            var _loc_5:* = new Vector.<int>(21, true);
            var _loc_8:* = 0;
            var _loc_14:* = 0;
            _loc_4[0] = param1;
            _loc_6 = 0;
            _loc_10 = 0;
            _loc_11 = 0;
            _loc_12 = 1;
            do
            {
                
                _loc_13 = this.gS3SLine[_loc_4[_loc_11]][2];
                _loc_11 = _loc_11 + 1;
                _loc_7 = 0;
                while (_loc_7 < this.gS3SFaceCnt)
                {
                    
                    _loc_14 = this.gS3SFace[_loc_7][0];
                    _loc_8 = 0;
                    while (_loc_8 < _loc_14)
                    {
                        
                        if (this.gS3SFace[_loc_7][_loc_8 + 7] == _loc_13)
                        {
                            _loc_8 = _loc_7;
                            _loc_7 = this.gS3SFaceCnt - 1;
                            break;
                        }
                        _loc_8++;
                    }
                    _loc_7++;
                }
                _loc_7 = 0;
                while (_loc_7 != _loc_6)
                {
                    
                    if (_loc_5[_loc_7] == _loc_8)
                    {
                        _loc_8 = -1;
                        break;
                    }
                    _loc_7 = _loc_7 + 1;
                }
                if (_loc_8 != -1)
                {
                    _loc_5[_loc_6] = _loc_8;
                    _loc_6 = _loc_6 + 1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_14)
                    {
                        
                        if (this.gS3SFace[_loc_8][_loc_7 + 7] != _loc_13)
                        {
                            if (this.gS3GLineCut[this.gS3SFace[_loc_8][_loc_7 + 7]] == 1 || this.gS3GLineCut[this.gS3SFace[_loc_8][_loc_7 + 7]] == 2)
                            {
                                _loc_3[_loc_10] = this.gS3SFace[_loc_8][_loc_7 + 7];
                                _loc_10 = _loc_10 + 1;
                            }
                            else
                            {
                                _loc_4[_loc_12] = this.gS3SFace[_loc_8][_loc_7 + 7];
                                _loc_12 = _loc_12 + 1;
                            }
                        }
                        _loc_7++;
                    }
                }
            }while (_loc_11 != _loc_12)
            _loc_8 = 0;
            while (_loc_8 < _loc_6)
            {
                
                _loc_15 = _loc_5[_loc_8];
                _loc_16 = this.gS3SFace[_loc_15][0];
                _loc_9 = 0;
                while (_loc_9 < _loc_16)
                {
                    
                    _loc_17 = this.gS3SFace[_loc_15][(_loc_9 + 1)];
                    this.turn(this.gS3SLine[param1][2], _loc_17, -param2);
                    _loc_9++;
                }
                _loc_8++;
            }
            return;
        }// end function

        protected function idou1(param1:Boolean = false, param2:Number = NaN, param3:Number = NaN) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            _loc_9 = new Vector.<Vector.<Number>>(this.gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < _loc_9.length)
            {
                
                _loc_9[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            if (isNaN(param2) || isNaN(param3))
            {
                if (this.gS3SolidNo == 12)
                {
                    _loc_7 = this.gS3GPoint[1][1] - this.gS3GPoint[0][1];
                    _loc_8 = this.gS3GPoint[1][2] - this.gS3GPoint[0][2];
                }
                else if (param1 == true)
                {
                    _loc_7 = this.gS3GPoint[1][1] - this.gS3GPoint[2][1];
                    _loc_8 = this.gS3GPoint[1][2] - this.gS3GPoint[2][2];
                }
                else
                {
                    _loc_7 = this.gS3GPoint[2][1] - this.gS3GPoint[1][1];
                    _loc_8 = this.gS3GPoint[2][2] - this.gS3GPoint[1][2];
                }
            }
            else
            {
                _loc_7 = param2;
                _loc_8 = param3;
            }
            if (_loc_7 == 0)
            {
                if (_loc_8 > 0)
                {
                    _loc_5 = Math.PI / 2;
                }
                else
                {
                    _loc_5 = (-Math.PI) / 2;
                }
            }
            else
            {
                _loc_5 = Math.atan(_loc_8 / _loc_7);
                if (_loc_5 < 0 && _loc_7 < 0)
                {
                    _loc_5 = _loc_5 + Math.PI;
                }
                else if (_loc_5 > 0 && _loc_7 < 0)
                {
                    _loc_5 = _loc_5 - Math.PI;
                }
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                _loc_9[_loc_4][0] = this.gS3GPoint[_loc_4][0];
                _loc_9[_loc_4][1] = this.gS3GPoint[_loc_4][1];
                _loc_9[_loc_4][2] = this.gS3GPoint[_loc_4][2];
                _loc_4++;
            }
            _loc_6 = 0;
            this.dPauseValues = new Array();
            if (this.dPauseEventCode != "")
            {
                this.dPauseValues.push(this.dPauseEventCode);
                this.dPauseValues.push(this.dPauseResult);
            }
            else
            {
                this.dPauseValues.push("");
                this.dPauseValues.push(int.MIN_VALUE);
            }
            this.dPauseValues.push(_loc_6);
            this.dPauseValues.push(_loc_5);
            this.dPauseValues.push(_loc_9);
            this.dPauseNecessary = true;
            this.dPauseFunction = this.idou1Move;
            this.idou1Move();
            return;
        }// end function

        protected function idou2() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_1:* = new Vector3D();
            var _loc_2:* = new Vector3D();
            var _loc_3:* = 0;
            var _loc_13:* = new Vector.<Number>(4, true);
            var _loc_14:* = new Vector.<Number>(4, true);
            var _loc_15:* = new Vector.<Number>(4, true);
            var _loc_16:* = new Vector.<Vector.<Number>>(this.gS3SPointCnt);
            _loc_4 = 0;
            while (_loc_4 < _loc_16.length)
            {
                
                _loc_16[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SFaceCnt)
            {
                
                if (this.gS3GFaceMove[_loc_4] == 0)
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 3)
            {
                
                _loc_13[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][0];
                _loc_14[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][1];
                _loc_15[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][2];
                _loc_4++;
            }
            gPH3D.vrtVec(3, _loc_13, _loc_14, _loc_15);
            _loc_1.x = gPH3D.dX;
            _loc_1.y = gPH3D.dY;
            _loc_1.z = gPH3D.dZ;
            _loc_2.x = 1;
            _loc_2.y = 0;
            _loc_2.z = 0;
            _loc_11 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y);
            if (_loc_11 == 0)
            {
                _loc_5 = 0;
            }
            else
            {
                _loc_5 = Math.acos(_loc_1.x / _loc_11);
                if (_loc_1.y < 0)
                {
                    _loc_5 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_12 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y + _loc_1.z * _loc_1.z);
            _loc_6 = Math.acos(_loc_11 / _loc_12);
            if (_loc_1.z < 0)
            {
                _loc_6 = 2 * Math.PI - _loc_6;
            }
            _loc_11 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y);
            if (_loc_11 == 0)
            {
                _loc_7 = 0;
            }
            else
            {
                _loc_7 = Math.acos(_loc_2.x / _loc_11);
                if (_loc_2.y < 0)
                {
                    _loc_7 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_12 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y + _loc_2.z * _loc_2.z);
            _loc_8 = Math.acos(_loc_11 / _loc_12);
            if (_loc_2.z < 0)
            {
                _loc_8 = 2 * Math.PI - _loc_8;
            }
            _loc_9 = _loc_5 - _loc_7;
            if (_loc_9 < -Math.PI)
            {
                _loc_9 = 2 * Math.PI + _loc_9;
            }
            else if (_loc_9 > Math.PI)
            {
                _loc_9 = _loc_9 - 2 * Math.PI;
            }
            _loc_10 = _loc_6 - _loc_8;
            if (_loc_10 < -Math.PI)
            {
                _loc_10 = 2 * Math.PI + _loc_10;
            }
            else if (_loc_10 > Math.PI)
            {
                _loc_10 = _loc_10 - 2 * Math.PI;
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                _loc_16[_loc_4][0] = this.gS3GPoint[_loc_4][0];
                _loc_16[_loc_4][1] = this.gS3GPoint[_loc_4][1];
                _loc_16[_loc_4][2] = this.gS3GPoint[_loc_4][2];
                _loc_4++;
            }
            _loc_5 = 0;
            _loc_6 = 0;
            this.dPauseValues = new Array();
            if (this.dPauseEventCode != "")
            {
                this.dPauseValues.push(this.dPauseEventCode);
                this.dPauseValues.push(this.dPauseResult);
            }
            else
            {
                this.dPauseValues.push("");
                this.dPauseValues.push(int.MIN_VALUE);
            }
            this.dPauseValues.push(_loc_5);
            this.dPauseValues.push(_loc_6);
            this.dPauseValues.push(_loc_9);
            this.dPauseValues.push(_loc_10);
            this.dPauseValues.push(_loc_16);
            this.dPauseNecessary = false;
            this.dPauseFunction = this.idou2Move;
            this.idou2Move();
            if (_loc_5 == _loc_9 && _loc_6 == _loc_10)
            {
                this.pause(this.PAUSE_IDO);
            }
            return;
        }// end function

        protected function idou3() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_1:* = new Vector3D();
            var _loc_2:* = new Vector3D();
            var _loc_3:* = 0;
            var _loc_16:* = new Vector.<Number>(4, true);
            var _loc_17:* = new Vector.<Number>(4, true);
            var _loc_18:* = new Vector.<Number>(4, true);
            _loc_4 = 0;
            while (_loc_4 < this.gS3SFaceCnt)
            {
                
                if (this.gS3GFaceMove[_loc_4] == 0)
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 3)
            {
                
                _loc_16[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][0];
                _loc_17[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][1];
                _loc_18[_loc_4] = this.gS3GPoint[this.gS3SFace[_loc_3][(_loc_4 + 1)]][2];
                _loc_4++;
            }
            gPH3D.vrtVec(3, _loc_16, _loc_17, _loc_18);
            _loc_1.x = gPH3D.dX;
            _loc_1.y = gPH3D.dY;
            _loc_1.z = gPH3D.dZ;
            _loc_2.x = 1;
            _loc_2.y = 0;
            _loc_2.z = 0;
            _loc_11 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y);
            if (_loc_11 == 0)
            {
                _loc_5 = 0;
            }
            else
            {
                _loc_5 = Math.acos(_loc_1.x / _loc_11);
                if (_loc_1.y < 0)
                {
                    _loc_5 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_12 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y + _loc_1.z * _loc_1.z);
            _loc_6 = Math.acos(_loc_11 / _loc_12);
            if (_loc_1.z < 0)
            {
                _loc_6 = 2 * Math.PI - _loc_6;
            }
            _loc_11 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y);
            if (_loc_11 == 0)
            {
                _loc_7 = 0;
            }
            else
            {
                _loc_7 = Math.acos(_loc_2.x / _loc_11);
                if (_loc_2.y < 0)
                {
                    _loc_7 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_12 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y + _loc_2.z * _loc_2.z);
            _loc_8 = Math.acos(_loc_11 / _loc_12);
            if (_loc_2.z < 0)
            {
                _loc_8 = 2 * Math.PI - _loc_8;
            }
            _loc_9 = _loc_5 - _loc_7;
            if (_loc_9 < -Math.PI)
            {
                _loc_9 = 2 * Math.PI + _loc_9;
            }
            else if (_loc_9 > Math.PI)
            {
                _loc_9 = _loc_9 - 2 * Math.PI;
            }
            _loc_10 = _loc_6 - _loc_8;
            if (_loc_10 < -Math.PI)
            {
                _loc_10 = 2 * Math.PI + _loc_10;
            }
            else if (_loc_10 > Math.PI)
            {
                _loc_10 = _loc_10 - 2 * Math.PI;
            }
            _loc_4 = 0;
            while (_loc_4 < this.gS3SPointCnt)
            {
                
                _loc_13 = this.gS3GPoint[_loc_4][0];
                _loc_14 = this.gS3GPoint[_loc_4][1];
                _loc_15 = this.gS3GPoint[_loc_4][2];
                gPH3D.zRevolv3D(_loc_13, _loc_14, _loc_15, _loc_9 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_10 * 180 / Math.PI);
                this.gS3GPoint[_loc_4][0] = gPH3D.dX;
                this.gS3GPoint[_loc_4][1] = gPH3D.dY;
                this.gS3GPoint[_loc_4][2] = gPH3D.dZ;
                _loc_4++;
            }
            return;
        }// end function

        protected function faceBasisColor(param1:uint, param2:uint, param3:uint) : void
        {
            this.dFaceColR = Math.min(param1, 255);
            this.dFaceColG = Math.min(param3, 255);
            this.dFaceColB = Math.min(param2, 255);
            return;
        }// end function

        protected function faceBasisColorB(param1:uint) : void
        {
            this.dFaceColR = Math.floor(param1 / 65536);
            this.dFaceColG = Math.floor(param1 / 256) % 256;
            this.dFaceColB = param1 % 256;
            return;
        }// end function

        protected function faceBasisColorDefault() : void
        {
            this.dFaceColR = this.FACE_COL_DEFAULT_R;
            this.dFaceColG = this.FACE_COL_DEFAULT_G;
            this.dFaceColB = this.FACE_COL_DEFAULT_B;
            return;
        }// end function

        protected function faceBasisColorAlpha(param1:Number) : void
        {
            this.dFaceColA = param1;
            return;
        }// end function

        protected function lineState(param1:uint, param2:uint) : void
        {
            this.lineStateColor(param1);
            this.lineStateWidth(param2);
            return;
        }// end function

        protected function lineStateColor(param1:uint) : void
        {
            this.dLineCol = Math.min(param1, 16777215);
            return;
        }// end function

        protected function lineStateWidth(param1:uint) : void
        {
            this.dLineWid = Math.min(param1, int.MAX_VALUE);
            return;
        }// end function

        protected function lineStateRev(param1:uint, param2:int = -1, param3:int = -1) : void
        {
            this.dLineRevCol = Math.min(param1, 16777215);
            this.dLineRevDotLength = param2;
            this.dLineRevDotInterval = param3;
            return;
        }// end function

        protected function lineStateRevColor(param1:uint) : void
        {
            this.dLineRevCol = Math.min(param1, 16777215);
            return;
        }// end function

        protected function lineStateRevDot(param1:int = -1, param2:int = -1) : void
        {
            this.dLineRevDotLength = param1;
            this.dLineRevDotInterval = param2;
            return;
        }// end function

        protected function lineStateDefault() : void
        {
            this.dLineCol = -1;
            this.dLineWid = -1;
            this.dLineRevCol = -1;
            this.dLineRevDotLength = -1;
            this.dLineRevDotInterval = -1;
            return;
        }// end function

        protected function setColor(param1:int, param2:int) : Boolean
        {
            var _loc_4:* = 0;
            if ((this.dSelCol & 16777215) == 0)
            {
                return false;
            }
            if (this.gS3SolidNo < 3)
            {
                return this.cylinderSetColor(param1, param2);
            }
            var _loc_3:* = 0;
            if ((this.dSelCol & 16777215) < 16777215)
            {
                _loc_3 = this.dSelCol;
            }
            if (param1 == 1)
            {
                this.gS3GPointColor[param2] = _loc_3;
                _loc_4 = 1;
                while (_loc_4 <= this.gS3SPointCom[param2][0])
                {
                    
                    this.gS3GPointColor[this.gS3SPointCom[param2][_loc_4]] = _loc_3;
                    _loc_4++;
                }
            }
            else if (param1 == 2)
            {
                _loc_4 = 0;
                while (_loc_4 < this.gS3SLineCnt)
                {
                    
                    if (this.gS3SPoint[this.gS3SLine[_loc_4][0]][0] == this.gS3SPoint[this.gS3SLine[param2][0]][0] && this.gS3SPoint[this.gS3SLine[_loc_4][0]][1] == this.gS3SPoint[this.gS3SLine[param2][0]][1] && this.gS3SPoint[this.gS3SLine[_loc_4][0]][2] == this.gS3SPoint[this.gS3SLine[param2][0]][2] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][0] == this.gS3SPoint[this.gS3SLine[param2][1]][0] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][1] == this.gS3SPoint[this.gS3SLine[param2][1]][1] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][2] == this.gS3SPoint[this.gS3SLine[param2][1]][2])
                    {
                        this.gS3GLineColor[_loc_4] = _loc_3;
                    }
                    if (this.gS3SPoint[this.gS3SLine[_loc_4][0]][0] == this.gS3SPoint[this.gS3SLine[param2][1]][0] && this.gS3SPoint[this.gS3SLine[_loc_4][0]][1] == this.gS3SPoint[this.gS3SLine[param2][1]][1] && this.gS3SPoint[this.gS3SLine[_loc_4][0]][2] == this.gS3SPoint[this.gS3SLine[param2][1]][2] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][0] == this.gS3SPoint[this.gS3SLine[param2][0]][0] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][1] == this.gS3SPoint[this.gS3SLine[param2][0]][1] && this.gS3SPoint[this.gS3SLine[_loc_4][1]][2] == this.gS3SPoint[this.gS3SLine[param2][0]][2])
                    {
                        this.gS3GLineColor[_loc_4] = _loc_3;
                    }
                    _loc_4++;
                }
            }
            else
            {
                this.gS3GFaceColor[param2] = _loc_3;
            }
            return true;
        }// end function

        protected function iconNo() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.gS3SolidNo < 3)
            {
                return this.cylinderIconNo();
            }
            _loc_2 = this.selectRegion();
            _loc_3 = _loc_2 >> 8;
            _loc_4 = _loc_2 & 255;
            _loc_1 = CursorOperate.SYSTEM_DEFAULT;
            if (_loc_2 != 0)
            {
                _loc_3 = _loc_2 >> 8;
                _loc_4 = _loc_2 & 255;
                switch(this.gS3StFlg)
                {
                    case this.SELECT_CUT:
                    {
                        if (_loc_3 == 2)
                        {
                            if (this.gS3GLineCut[_loc_4] == 0)
                            {
                                _loc_1 = CursorOperate.SCISSORS;
                            }
                        }
                        break;
                    }
                    case this.SELECT_TAPE:
                    {
                        if (_loc_3 == 2)
                        {
                            if (this.gS3GLineCut[_loc_4] == 1)
                            {
                                _loc_1 = CursorOperate.TAPE;
                            }
                        }
                        break;
                    }
                    case this.SELECT_OPEN:
                    {
                        if (_loc_3 == 2)
                        {
                            if (this.gS3GLineCut[_loc_4] == 0)
                            {
                                _loc_1 = CursorOperate.RIGHT_FINGER;
                            }
                        }
                        break;
                    }
                    case this.SELECT_CLOSE:
                    {
                        if (_loc_3 == 2)
                        {
                            if (this.gS3GLineCut[_loc_4] == 3)
                            {
                                _loc_1 = CursorOperate.GRIP;
                            }
                        }
                        break;
                    }
                    case this.SELECT_COLOR:
                    {
                        if ((this.dSelCol & 16777215) > 0 && (this.dSelCol & 16777215) < 16777215)
                        {
                            switch(_loc_3)
                            {
                                case 1:
                                {
                                    _loc_1 = CursorOperate.PENCIL2;
                                    break;
                                }
                                case 2:
                                {
                                    _loc_1 = CursorOperate.BRUSH2;
                                    break;
                                }
                                case 3:
                                {
                                    _loc_1 = CursorOperate.BRUSH1;
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                        }
                        if ((this.dSelCol & 16777215) == 16777215)
                        {
                            switch(_loc_3)
                            {
                                case 1:
                                {
                                    if ((this.gS3GPointColor[_loc_4] & 16777215) != 0)
                                    {
                                        _loc_1 = CursorOperate.SLIM_ERASER;
                                    }
                                    break;
                                }
                                case 2:
                                {
                                    if ((this.gS3GLineColor[_loc_4] & 16777215) != 0)
                                    {
                                        _loc_1 = CursorOperate.FAT_ERASER;
                                    }
                                    break;
                                }
                                case 3:
                                {
                                    if ((this.gS3GFaceColor[_loc_4] & 16777215) != 0)
                                    {
                                        _loc_1 = CursorOperate.ERASER1;
                                    }
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
                    default:
                    {
                        break;
                    }
                }
            }
            return _loc_1;
        }// end function

        protected function setDrawColor(param1:uint) : void
        {
            this.dSelCol = param1;
            return;
        }// end function

        protected function getDrawColor() : uint
        {
            return this.dSelCol;
        }// end function

        protected function clearDrawColor() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < this.gS3SPointCnt)
            {
                
                this.gS3GPointColor[_loc_1] = 0;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SLineCnt)
            {
                
                this.gS3GLineColor[_loc_1] = 0;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.gS3SFaceCnt)
            {
                
                this.gS3GFaceColor[_loc_1] = 0;
                _loc_1++;
            }
            this.setDrawColor(0);
            return;
        }// end function

        protected function modelChange() : int
        {
            if (this.gS3ModelMode == 0)
            {
                this.gS3ModelMode = 1;
            }
            else
            {
                this.gS3ModelMode = 0;
            }
            return this.gS3ModelMode;
        }// end function

        protected function defaultActionLarge() : Boolean
        {
            return this.actionLarge(this.STEP_VIEW_SIZE, this.MAX_VIEW_SIZE);
        }// end function

        protected function defaultActionSmall() : Boolean
        {
            return this.actionSmall(this.STEP_VIEW_SIZE, this.MIN_VIEW_SIZE);
        }// end function

        protected function defaultActionStageMouseDown(event:StageEvent) : void
        {
            if (this.isTimer())
            {
                return;
            }
            if (!event.isMouseButtonDown)
            {
                this.dMouseButton = false;
                this.setCursor(CursorOperate.ARROW);
                return;
            }
            this.actionStageMouseDown(event);
            this.dMouseButton = event.isMouseButtonDown;
            var _loc_2:* = this.selectRegion();
            this.dSelKbn = _loc_2 >> 8;
            this.dSelNo = _loc_2 & 255;
            return;
        }// end function

        protected function defaultActionStageMouseUp(event:StageEvent) : void
        {
            this.actionStageMouseUp(event);
            this.dMouseButton = false;
            if (this.dSelKbn != 0 && this.dMouseIcon == 0)
            {
                return;
            }
            var _loc_2:* = this.selectRegion();
            if (_loc_2 == 0)
            {
                return;
            }
            var _loc_3:* = _loc_2 >> 8;
            var _loc_4:* = _loc_2 & 255;
            if (this.dSelKbn == 0 && this.dSelNo == 0)
            {
                return;
            }
            if (this.dSelKbn != _loc_3 || this.dSelNo != _loc_4)
            {
                return;
            }
            this.dSelKbn = 0;
            this.dSelNo = 0;
            if (this.gS3SolidNo < 3 && (this.gS3StFlg == this.SELECT_CUT || this.gS3StFlg == this.SELECT_TAPE))
            {
                this.cylinderMouseUp(_loc_3, _loc_4, this.dSelCol);
            }
            else
            {
                switch(this.gS3StFlg)
                {
                    case this.SELECT_CUT:
                    {
                        if (_loc_3 == 2 && this.gS3GLineCut[_loc_4] == 0)
                        {
                            if (this.tenkaiCheck(_loc_4) == false)
                            {
                                return;
                            }
                            this.gS3GLineCut[_loc_4] = 1;
                            this.gS3GLineCut[this.gS3SLine[_loc_4][2]] = 1;
                        }
                        else
                        {
                            return;
                        }
                        break;
                    }
                    case this.SELECT_TAPE:
                    {
                        if (_loc_3 == 2 && this.gS3GLineCut[_loc_4] == 1)
                        {
                            this.gS3GLineCut[_loc_4] = 0;
                            this.gS3GLineCut[this.gS3SLine[_loc_4][2]] = 0;
                        }
                        else
                        {
                            return;
                        }
                        break;
                    }
                    case this.SELECT_COLOR:
                    {
                        if (this.setColor(_loc_3, _loc_4) == false)
                        {
                            return;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this.display3D();
            this.setCursor(this.dMouseIcon);
            return;
        }// end function

        protected function defaultActionStageMouseMove(event:StageEvent, param2:Boolean) : void
        {
            if (this.isTimer())
            {
                return;
            }
            this.dMouseButton = event.isMouseButtonDown;
            var _loc_3:* = this.actionStageMouseMove(event, param2);
            if (this.dMouseButton)
            {
                return;
            }
            var _loc_4:* = this.iconNo();
            if (this.iconNo() != this.dMouseIcon)
            {
                this.setCursor(_loc_4);
                this.dMouseIcon = _loc_4;
            }
            return;
        }// end function

        protected function defaultActionColorClear() : void
        {
            this.clearDrawColor();
            this.display3D();
            return;
        }// end function

        override protected function get isSelectedObject() : Boolean
        {
            return this.dSelKbn != 0 && this.dMouseIcon == 0;
        }// end function

        protected function moveBasis() : void
        {
            if (this.gS3SolidNo != int.MAX_VALUE)
            {
                if (this.gS3SolidNo >= 3)
                {
                    if (this.gS3SolidNo == 7 || this.gS3SolidNo == 8)
                    {
                        this.move(3, 36);
                    }
                    else
                    {
                        this.move(3, 15);
                    }
                }
                this.move(2, 15);
            }
            return;
        }// end function

        protected function cylinderZahyouSet() : void
        {
            return;
        }// end function

        protected function cylinderClear() : void
        {
            return;
        }// end function

        protected function cylinderInitialize() : void
        {
            return;
        }// end function

        protected function cylinderMove(param1:int, param2:Number) : void
        {
            return;
        }// end function

        protected function cylinderDisplay3D() : void
        {
            return;
        }// end function

        protected function cylinderDisplay3D2() : void
        {
            return;
        }// end function

        protected function cylinderDeleteRegion() : void
        {
            return;
        }// end function

        protected function cylinderSelectRegion() : int
        {
            return 0;
        }// end function

        protected function cylinderSelectRegionCheck(param1:int, param2:int) : int
        {
            return 0;
        }// end function

        protected function cylinderMotonoichi() : void
        {
            return;
        }// end function

        protected function cylinderSetColor(param1:int, param2:int) : Boolean
        {
            return true;
        }// end function

        protected function cylinderIconNo() : int
        {
            return 0;
        }// end function

        protected function cylinderMouseUp(param1:int, param2:int, param3:uint) : void
        {
            return;
        }// end function

        private function drawPlaneMove() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_1:* = int(this.dPauseValues.shift());
            var _loc_2:* = int(this.dPauseValues.shift());
            var _loc_3:* = int(this.dPauseValues.shift());
            var _loc_4:* = this.Vector.<Point>(this.dPauseValues.shift());
            this.dPauseEventCode = StageEvent.S3D_DRAW_PLANE_END;
            this.dPauseFunction = null;
            this.dPauseValues = null;
            this.dPauseResult = int.MIN_VALUE;
            if (this.gS3ModelMode != 0)
            {
                if (this.gS3SFaceCnt - this.dFaceDrawCnt <= _loc_2)
                {
                    _loc_5 = this.RS_CENTER_POINT_COL;
                    this.canvasGraphics.lineStyle(1, _loc_5);
                    this.canvasGraphics.beginFill(_loc_5);
                    this.canvasGraphics.drawCircle(VewWinX, VewWinY, 4.5);
                    this.canvasGraphics.endFill();
                }
            }
            this.gS3RgnFace[_loc_1].add(_loc_4, _loc_3);
            _loc_7 = 0;
            while (_loc_7 < _loc_3)
            {
                
                if (_loc_7 == (_loc_3 - 1))
                {
                    _loc_10 = 0;
                }
                else
                {
                    _loc_10 = _loc_7 + 1;
                }
                _loc_9 = this.gS3SFace[_loc_1][_loc_7 + 7];
                _loc_6 = 1;
                if (this.gS3GLineCut[_loc_9] == 1)
                {
                    _loc_5 = this.LINE_COL_CUT;
                    _loc_6 = 3;
                }
                else if (this.gS3GLineCut[_loc_9] == 4)
                {
                    _loc_5 = this.PV_LINE_COL_SELECTED;
                    _loc_6 = 3;
                }
                else if (this.gS3GLineCut[_loc_9] == 5)
                {
                    _loc_5 = this.PV_LINE_COL_STRONG;
                    _loc_6 = 3;
                }
                else if (this.gS3TokuchoFlg[2] == 1)
                {
                    _loc_5 = this.FS_LINE_COL_SELECTED;
                    _loc_6 = 3;
                }
                else if ((this.gS3GLineColor[_loc_9] & 16777215) > 0)
                {
                    _loc_5 = this.gS3GLineColor[_loc_9];
                    _loc_6 = 3;
                }
                else if (this.gS3GLineCut[_loc_9] == 3)
                {
                    _loc_5 = this.LINE_COL_PIVOT;
                    _loc_6 = 1;
                }
                else
                {
                    _loc_5 = 0;
                }
                if ((_loc_5 & 16777215) > 0)
                {
                    this.canvasGraphics.lineStyle(_loc_6, _loc_5);
                    this.canvasGraphics.moveTo(_loc_4[_loc_7].x, _loc_4[_loc_7].y);
                    this.canvasGraphics.lineTo(_loc_4[_loc_10].x, _loc_4[_loc_10].y);
                }
                if (_loc_4[_loc_10].x == _loc_4[_loc_7].x)
                {
                    _loc_11 = 99;
                }
                else
                {
                    _loc_11 = (_loc_4[_loc_10].y - _loc_4[_loc_7].y) / (_loc_4[_loc_10].x - _loc_4[_loc_7].x);
                }
                if (_loc_11 < -1 || _loc_11 > 1)
                {
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_7].x - 5, _loc_4[_loc_7].y);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_7].x + 5, _loc_4[_loc_7].y);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_10].x + 5, _loc_4[_loc_10].y);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_10].x - 5, _loc_4[_loc_10].y);
                }
                else
                {
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_7].x, _loc_4[_loc_7].y - 5);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_7].x, _loc_4[_loc_7].y + 5);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_10].x, _loc_4[_loc_10].y + 5);
                    this.gS3RgnLine[_loc_9].addPoint(_loc_4[_loc_10].x, _loc_4[_loc_10].y - 5);
                }
                _loc_7++;
            }
            if (this.gS3FOnLineFlg)
            {
                this.faceOnLineDraw(_loc_1, _loc_4, _loc_3);
            }
            _loc_7 = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_5 = 0;
                _loc_8 = this.gS3SFace[_loc_1][(_loc_7 + 1)];
                if (this.gS3TokuchoFlg[3] == 1)
                {
                    _loc_5 = this.FS_POINT_COL_SELECTED;
                }
                else if ((this.gS3GPointColor[_loc_8] & 16777215) > 0)
                {
                    _loc_5 = this.gS3GPointColor[_loc_8];
                }
                if ((_loc_5 & 16777215) > 0)
                {
                    this.canvasGraphics.lineStyle(1, _loc_5);
                    this.canvasGraphics.beginFill(_loc_5);
                    this.canvasGraphics.drawCircle(_loc_4[_loc_7].x, _loc_4[_loc_7].y, 4.5);
                    this.canvasGraphics.endFill();
                }
                this.gS3RgnPoint[_loc_8].addPoint(_loc_4[_loc_7].x - 6, _loc_4[_loc_7].y - 6);
                this.gS3RgnPoint[_loc_8].addPoint(_loc_4[_loc_7].x + 6, _loc_4[_loc_7].y - 6);
                this.gS3RgnPoint[_loc_8].addPoint(_loc_4[_loc_7].x + 6, _loc_4[_loc_7].y + 6);
                this.gS3RgnPoint[_loc_8].addPoint(_loc_4[_loc_7].x - 6, _loc_4[_loc_7].y + 6);
                _loc_7++;
            }
            return;
        }// end function

        private function tenkaiMove() : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_1:* = int(this.dPauseValues.shift());
            var _loc_2:* = int(this.dPauseValues.shift());
            var _loc_3:* = int(this.dPauseValues.shift());
            var _loc_4:* = this.Vector.<Vector.<Number>>(this.dPauseValues.shift());
            var _loc_5:* = Number(this.dPauseValues.shift());
            var _loc_6:* = this.Vector.<Vector.<int>>(this.dPauseValues.shift());
            var _loc_7:* = this.Vector.<Vector.<int>>(this.dPauseValues.shift());
            var _loc_8:* = this.Vector.<int>(this.dPauseValues.shift());
            var _loc_11:* = 0;
            if (_loc_3 < 5)
            {
                _loc_9 = 0;
                while (_loc_9 < this.gS3SPointCnt)
                {
                    
                    _loc_10 = 0;
                    while (_loc_10 < 3)
                    {
                        
                        this.gS3GPoint[_loc_9][_loc_10] = _loc_4[_loc_9][_loc_10];
                        _loc_10++;
                    }
                    _loc_9++;
                }
                _loc_9 = 0;
                while (_loc_9 < _loc_8[_loc_2])
                {
                    
                    _loc_12 = _loc_6[_loc_2][_loc_9];
                    _loc_13 = this.gS3SFace[_loc_12][0];
                    _loc_10 = 0;
                    while (_loc_10 < _loc_13)
                    {
                        
                        _loc_15 = this.gS3SFace[_loc_12][(_loc_10 + 1)];
                        this.turn(_loc_7[(_loc_2 + 1) % 2][0], _loc_15, -_loc_5 * _loc_3 / 4);
                        _loc_10++;
                    }
                    (this.gS3GFaceMove[_loc_12] + 1);
                    _loc_9++;
                }
                this.display3D();
                _loc_3++;
                this.dPauseValues = new Array();
                this.dPauseValues.push(_loc_1);
                this.dPauseValues.push(_loc_2);
                this.dPauseValues.push(_loc_3);
                this.dPauseValues.push(_loc_4);
                this.dPauseValues.push(_loc_5);
                this.dPauseValues.push(_loc_6);
                this.dPauseValues.push(_loc_7);
                this.dPauseValues.push(_loc_8);
                this.dPauseEventCode = "";
                this.pause(this.PAUSE_TENKAI);
                return;
            }
            this.dPauseEventCode = StageEvent.S3D_TENKAI_END;
            this.dPauseFunction = null;
            this.dPauseValues = null;
            this.dPauseResult = int.MIN_VALUE;
            _loc_3 = 0;
            while (_loc_3 < _loc_8[_loc_2])
            {
                
                _loc_12 = _loc_6[_loc_2][_loc_3];
                _loc_13 = this.gS3SFace[_loc_12][0];
                _loc_9 = 0;
                while (_loc_9 < _loc_13)
                {
                    
                    _loc_14 = this.gS3SFace[_loc_12][_loc_9 + 7];
                    if (this.gS3GLineCut[_loc_14] == 1)
                    {
                        _loc_15 = this.gS3SLine[_loc_14][2];
                        if (this.gS3GPoint[this.gS3SLine[_loc_14][0]][0] != this.gS3GPoint[this.gS3SLine[_loc_15][1]][0] || this.gS3GPoint[this.gS3SLine[_loc_14][0]][1] != this.gS3GPoint[this.gS3SLine[_loc_15][1]][1] || this.gS3GPoint[this.gS3SLine[_loc_14][0]][2] != this.gS3GPoint[this.gS3SLine[_loc_15][1]][2])
                        {
                            this.gS3GLineCut[_loc_14] = 2;
                            this.gS3GLineCut[_loc_15] = 2;
                        }
                        else if (this.gS3GPoint[this.gS3SLine[_loc_14][1]][0] != this.gS3GPoint[this.gS3SLine[_loc_15][0]][0] || this.gS3GPoint[this.gS3SLine[_loc_14][1]][1] != this.gS3GPoint[this.gS3SLine[_loc_15][0]][1] || this.gS3GPoint[this.gS3SLine[_loc_14][1]][2] != this.gS3GPoint[this.gS3SLine[_loc_15][0]][2])
                        {
                            this.gS3GLineCut[_loc_14] = 2;
                            this.gS3GLineCut[_loc_15] = 2;
                        }
                    }
                    _loc_9++;
                }
                _loc_3++;
            }
            this.gS3GLineCut[_loc_1] = 3;
            this.gS3GLineCut[this.gS3SLine[_loc_1][2]] = 3;
            this.display3D();
            _loc_11 = 0;
            _loc_3 = 0;
            while (_loc_3 < this.gS3SLineCnt)
            {
                
                if (this.gS3GLineCut[_loc_3] == 3)
                {
                    _loc_11 = _loc_11 + 1;
                }
                _loc_3++;
            }
            if (_loc_11 == (this.gS3SFaceCnt - 1) * 2)
            {
                this.dPauseResult = 2;
                if (this.isTenkaiMoveFront)
                {
                    this.idou2();
                }
                return;
            }
            this.dPauseResult = 1;
            return;
        }// end function

        private function kumitateMove() : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = false;
            var _loc_1:* = int(this.dPauseValues.shift());
            var _loc_2:* = int(this.dPauseValues.shift());
            var _loc_3:* = int(this.dPauseValues.shift());
            var _loc_4:* = this.Vector.<Vector.<int>>(this.dPauseValues.shift());
            var _loc_5:* = this.Vector.<Vector.<int>>(this.dPauseValues.shift());
            var _loc_6:* = this.Vector.<int>(this.dPauseValues.shift());
            var _loc_7:* = this.Vector.<Vector.<Number>>(this.dPauseValues.shift());
            var _loc_8:* = Number(this.dPauseValues.shift());
            var _loc_9:* = 0;
            if (_loc_3 < 5)
            {
                _loc_9 = 0;
                while (_loc_9 < this.gS3SPointCnt)
                {
                    
                    _loc_10 = 0;
                    while (_loc_10 < 3)
                    {
                        
                        this.gS3GPoint[_loc_9][_loc_10] = _loc_7[_loc_9][_loc_10];
                        _loc_10++;
                    }
                    _loc_9++;
                }
                _loc_9 = 0;
                while (_loc_9 < _loc_6[_loc_2])
                {
                    
                    _loc_12 = _loc_5[_loc_2][_loc_9];
                    _loc_13 = this.gS3SFace[_loc_12][0];
                    _loc_10 = 0;
                    while (_loc_10 < _loc_13)
                    {
                        
                        _loc_14 = this.gS3SFace[_loc_12][(_loc_10 + 1)];
                        this.turn(_loc_4[(_loc_2 + 1) % 2][0], _loc_14, _loc_8 * _loc_3 / 4);
                        _loc_10++;
                    }
                    (this.gS3GFaceMove[_loc_12] - 1);
                    _loc_9++;
                }
                this.display3D();
                _loc_3++;
                this.dPauseValues = new Array();
                this.dPauseValues.push(_loc_1);
                this.dPauseValues.push(_loc_2);
                this.dPauseValues.push(_loc_3);
                this.dPauseValues.push(_loc_4);
                this.dPauseValues.push(_loc_5);
                this.dPauseValues.push(_loc_6);
                this.dPauseValues.push(_loc_7);
                this.dPauseValues.push(_loc_8);
                this.dPauseEventCode = "";
                this.pause(this.PAUSE_TENKAI);
                return;
            }
            this.dPauseEventCode = StageEvent.S3D_KUMITATE_END;
            this.dPauseFunction = null;
            this.dPauseValues = null;
            this.dPauseResult = int.MIN_VALUE;
            _loc_3 = 0;
            while (_loc_3 < _loc_6[_loc_2])
            {
                
                _loc_12 = _loc_5[_loc_2][_loc_3];
                _loc_13 = this.gS3SFace[_loc_12][0];
                _loc_9 = 0;
                while (_loc_9 < _loc_13)
                {
                    
                    _loc_11 = this.gS3SFace[_loc_12][_loc_9 + 7];
                    if (this.gS3GLineCut[_loc_11] == 2 && this.gS3SLine[_loc_11][2] != 999)
                    {
                        _loc_14 = this.gS3SLine[_loc_11][2];
                        _loc_15 = Math.abs(this.gS3GPoint[this.gS3SLine[_loc_11][0]][0] - this.gS3GPoint[this.gS3SLine[_loc_14][1]][0]) < 5;
                        if (_loc_15)
                        {
                            _loc_15 = Math.abs(this.gS3GPoint[this.gS3SLine[_loc_11][0]][1] - this.gS3GPoint[this.gS3SLine[_loc_14][1]][1]) < 5;
                        }
                        if (_loc_15)
                        {
                            _loc_15 = Math.abs(this.gS3GPoint[this.gS3SLine[_loc_11][0]][2] - this.gS3GPoint[this.gS3SLine[_loc_14][1]][2]) < 5;
                        }
                        if (_loc_15)
                        {
                            _loc_15 = Math.abs(this.gS3GPoint[this.gS3SLine[_loc_11][1]][0] - this.gS3GPoint[this.gS3SLine[_loc_14][0]][0]) < 5;
                        }
                        if (_loc_15)
                        {
                            _loc_15 = Math.abs(this.gS3GPoint[this.gS3SLine[_loc_11][1]][2] - this.gS3GPoint[this.gS3SLine[_loc_14][0]][2]) < 5;
                        }
                        if (_loc_15)
                        {
                            this.gS3GLineCut[_loc_11] = 1;
                            this.gS3GLineCut[_loc_14] = 1;
                            this.gS3GPoint[this.gS3SLine[_loc_11][0]][0] = this.gS3GPoint[this.gS3SLine[_loc_14][1]][0];
                            this.gS3GPoint[this.gS3SLine[_loc_11][0]][1] = this.gS3GPoint[this.gS3SLine[_loc_14][1]][1];
                            this.gS3GPoint[this.gS3SLine[_loc_11][0]][2] = this.gS3GPoint[this.gS3SLine[_loc_14][1]][2];
                            this.gS3GPoint[this.gS3SLine[_loc_11][1]][0] = this.gS3GPoint[this.gS3SLine[_loc_14][0]][0];
                            this.gS3GPoint[this.gS3SLine[_loc_11][1]][1] = this.gS3GPoint[this.gS3SLine[_loc_14][0]][1];
                            this.gS3GPoint[this.gS3SLine[_loc_11][1]][2] = this.gS3GPoint[this.gS3SLine[_loc_14][0]][2];
                        }
                    }
                    _loc_9++;
                }
                _loc_3++;
            }
            this.gS3GLineCut[_loc_1] = 0;
            this.gS3GLineCut[this.gS3SLine[_loc_1][2]] = 0;
            this.display3D();
            this.dPauseResult = 1;
            return;
        }// end function

        private function idou1Move() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_1:* = String(this.dPauseValues.shift());
            var _loc_2:* = int(this.dPauseValues.shift());
            var _loc_3:* = Number(this.dPauseValues.shift());
            var _loc_4:* = Number(this.dPauseValues.shift());
            var _loc_5:* = this.Vector.<Vector.<Number>>(this.dPauseValues.shift());
            if (_loc_4 >= 0)
            {
                _loc_3 = _loc_3 + 15 / 180 * Math.PI;
                if (_loc_3 > _loc_4)
                {
                    _loc_3 = _loc_4;
                }
            }
            else
            {
                _loc_3 = _loc_3 - 15 / 180 * Math.PI;
                if (_loc_3 < _loc_4)
                {
                    _loc_3 = _loc_4;
                }
            }
            _loc_6 = 0;
            while (_loc_6 < this.gS3SPointCnt)
            {
                
                _loc_7 = _loc_5[_loc_6][0];
                _loc_8 = _loc_5[_loc_6][1];
                _loc_9 = _loc_5[_loc_6][2];
                gPH3D.xRevolv3D(_loc_7, _loc_8, _loc_9, _loc_3 * 180 / Math.PI);
                this.gS3GPoint[_loc_6][0] = gPH3D.dX;
                this.gS3GPoint[_loc_6][1] = gPH3D.dY;
                this.gS3GPoint[_loc_6][2] = gPH3D.dZ;
                _loc_6++;
            }
            this.display3D();
            if (_loc_3 != _loc_4 || this.dPauseNecessary)
            {
                this.dPauseValues = new Array();
                this.dPauseValues.push(_loc_1);
                this.dPauseValues.push(_loc_2);
                this.dPauseValues.push(_loc_3);
                this.dPauseValues.push(_loc_4);
                this.dPauseValues.push(_loc_5);
                this.dPauseEventCode = "";
                this.dPauseNecessary = false;
                this.pause(this.PAUSE_IDO);
                return;
            }
            if (_loc_1 != "")
            {
                this.dPauseEventCode = _loc_1;
                this.dPauseResult = _loc_2;
            }
            else
            {
                this.dPauseEventCode = StageEvent.S3D_IDO1_END;
                this.dPauseResult = int.MIN_VALUE;
            }
            this.dPauseFunction = null;
            this.dPauseValues = null;
            return;
        }// end function

        private function idou2Move() : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_1:* = String(this.dPauseValues.shift());
            var _loc_2:* = int(this.dPauseValues.shift());
            var _loc_3:* = Number(this.dPauseValues.shift());
            var _loc_4:* = Number(this.dPauseValues.shift());
            var _loc_5:* = Number(this.dPauseValues.shift());
            var _loc_6:* = Number(this.dPauseValues.shift());
            var _loc_7:* = this.Vector.<Vector.<Number>>(this.dPauseValues.shift());
            if (_loc_5 >= 0)
            {
                _loc_3 = _loc_3 + 15 / 180 * Math.PI;
                if (_loc_3 > _loc_5)
                {
                    _loc_3 = _loc_5;
                }
            }
            else
            {
                _loc_3 = _loc_3 - 15 / 180 * Math.PI;
                if (_loc_3 < _loc_5)
                {
                    _loc_3 = _loc_5;
                }
            }
            if (_loc_6 >= 0)
            {
                _loc_4 = _loc_4 + 15 / 180 * Math.PI;
                if (_loc_4 > _loc_6)
                {
                    _loc_4 = _loc_6;
                }
            }
            else
            {
                _loc_4 = _loc_4 - 15 / 180 * Math.PI;
                if (_loc_4 < _loc_6)
                {
                    _loc_4 = _loc_6;
                }
            }
            _loc_8 = 0;
            while (_loc_8 < this.gS3SPointCnt)
            {
                
                _loc_9 = _loc_7[_loc_8][0];
                _loc_10 = _loc_7[_loc_8][1];
                _loc_11 = _loc_7[_loc_8][2];
                gPH3D.zRevolv3D(_loc_9, _loc_10, _loc_11, _loc_3 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_4 * 180 / Math.PI);
                this.gS3GPoint[_loc_8][0] = gPH3D.dX;
                this.gS3GPoint[_loc_8][1] = gPH3D.dY;
                this.gS3GPoint[_loc_8][2] = gPH3D.dZ;
                _loc_8++;
            }
            this.display3D();
            if (_loc_3 != _loc_5 || _loc_4 != _loc_6 || this.dPauseNecessary)
            {
                this.dPauseValues = new Array();
                this.dPauseValues.push(_loc_1);
                this.dPauseValues.push(_loc_2);
                this.dPauseValues.push(_loc_3);
                this.dPauseValues.push(_loc_4);
                this.dPauseValues.push(_loc_5);
                this.dPauseValues.push(_loc_6);
                this.dPauseValues.push(_loc_7);
                this.dPauseEventCode = "";
                this.dPauseNecessary = false;
                this.pause(this.PAUSE_IDO);
                return;
            }
            if (_loc_1 != "")
            {
                this.dPauseEventCode = _loc_1;
                this.dPauseResult = _loc_2;
            }
            else
            {
                this.dPauseEventCode = StageEvent.S3D_IDO2_END;
                this.dPauseResult = int.MIN_VALUE;
            }
            this.dPauseFunction = null;
            this.dPauseValues = null;
            return;
        }// end function

    }
}
