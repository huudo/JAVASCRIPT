package phcomm.clipstage
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import phcomm.*;

    public class Cylinder3D extends Solid3D
    {
        protected const S3_SOKUMEN:int = 36;
        private const FS_FACE_COL_BASE_CYLINDER:uint = 8372053;
        private const FS_FACE_COL_SIDE_CYLINDER:uint = 14474320;
        private const PAUSE_IDO_C:int = 50;
        protected var gS3CutFlg:Vector.<int>;
        private var dCPoint1:Vector.<Vector.<Number>>;
        private var dCPoint2:Vector.<Vector.<Number>>;
        private var dCPointCut:Vector.<Vector.<Number>>;
        private var gS3RgnLine2:Vector.<PolygonObject>;
        private var dDrawFlg:Vector.<int>;
        private var dBaseLine:int;
        private var dTurnPoint:Vector3D;
        private var dDrawBaseDotFlag:Boolean;

        public function Cylinder3D(param1:Boolean = true)
        {
            var _loc_2:* = 0;
            super(param1);
            this.gS3CutFlg = new Vector.<int>(3, true);
            this.dCPoint1 = null;
            this.dCPoint2 = null;
            this.dCPointCut = new Vector.<Vector.<Number>>(2, true);
            _loc_2 = 0;
            while (_loc_2 < this.dCPointCut.length)
            {
                
                this.dCPointCut[_loc_2] = new Vector.<Number>(3, true);
                _loc_2++;
            }
            this.gS3RgnLine2 = null;
            this.dDrawFlg = new Vector.<int>(2, true);
            return;
        }// end function

        override protected function cylinderZahyouSet() : void
        {
            var _loc_3:* = NaN;
            var _loc_1:* = gS3SPoint[0][0];
            var _loc_2:* = 1;
            while (_loc_2 < this.S3_SOKUMEN)
            {
                
                _loc_3 = _loc_2 * Math.PI / (this.S3_SOKUMEN / 2);
                gS3SPoint[_loc_2][0] = _loc_1 * Math.cos(_loc_3);
                gS3SPoint[_loc_2][1] = _loc_1 * Math.sin(_loc_3);
                if (gS3SolidNo == 2)
                {
                    gS3SPoint[_loc_2 + this.S3_SOKUMEN][0] = _loc_1 * Math.cos(_loc_3);
                    gS3SPoint[_loc_2 + this.S3_SOKUMEN][1] = _loc_1 * Math.sin(_loc_3);
                }
                _loc_2++;
            }
            return;
        }// end function

        override protected function cylinderClear() : void
        {
            var _loc_1:* = 0;
            this.dCPoint1 = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            this.dCPoint2 = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_1 = 0;
            while (_loc_1 < gS3SPointCnt)
            {
                
                this.dCPoint1[_loc_1] = new Vector.<Number>(3, true);
                this.dCPoint2[_loc_1] = new Vector.<Number>(3, true);
                _loc_1++;
            }
            this.gS3RgnLine2 = new Vector.<PolygonObject>(gS3SLineCnt, true);
            _loc_1 = 0;
            while (_loc_1 < gS3SPointCnt)
            {
                
                this.dCPoint1[_loc_1][0] = 0;
                this.dCPoint1[_loc_1][1] = 0;
                this.dCPoint1[_loc_1][2] = 0;
                this.dCPoint2[_loc_1][0] = 0;
                this.dCPoint2[_loc_1][1] = 0;
                this.dCPoint2[_loc_1][2] = 0;
                gS3GPointColor[_loc_1] = 0;
                gS3RgnPoint[_loc_1] = new PolygonObject();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 2)
            {
                
                this.dCPointCut[_loc_1][0] = 0;
                this.dCPointCut[_loc_1][1] = 0;
                this.dCPointCut[_loc_1][2] = 0;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < gS3SLineCnt)
            {
                
                this.gS3RgnLine2[_loc_1] = new PolygonObject();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this.gS3CutFlg[_loc_1] = 0;
                _loc_1++;
            }
            this.setDrawColor(0);
            this.dTurnPoint = new Vector3D();
            return;
        }// end function

        override protected function cylinderInitialize() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = new Vector.<Number>(6, true);
            var _loc_6:* = new Vector.<Number>(6, true);
            var _loc_7:* = new Vector.<Number>(6, true);
            _loc_1 = 0;
            while (_loc_1 < gS3SPointCnt)
            {
                
                this.dCPoint1[_loc_1][0] = gS3SPoint[_loc_1][0];
                this.dCPoint1[_loc_1][1] = gS3SPoint[_loc_1][1];
                this.dCPoint1[_loc_1][2] = gS3SPoint[_loc_1][2];
                this.dCPoint2[_loc_1][0] = gS3SPoint[_loc_1][0];
                this.dCPoint2[_loc_1][1] = gS3SPoint[_loc_1][1];
                this.dCPoint2[_loc_1][2] = gS3SPoint[_loc_1][2];
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                _loc_3 = gS3SFace[_loc_1][0];
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_4 = gS3SFace[_loc_1][(_loc_2 + 1)];
                    _loc_5[_loc_2] = gS3SPoint[_loc_4][0];
                    _loc_6[_loc_2] = gS3SPoint[_loc_4][1];
                    _loc_7[_loc_2] = gS3SPoint[_loc_4][2];
                    _loc_2++;
                }
                gPH3D.vrtVec(_loc_3, _loc_5, _loc_6, _loc_7);
                gS3SHouVec[_loc_1].x = gPH3D.dX;
                gS3SHouVec[_loc_1].y = gPH3D.dY;
                gS3SHouVec[_loc_1].z = gPH3D.dZ;
                _loc_1++;
            }
            _loc_1 = this.S3_SOKUMEN;
            _loc_3 = gS3SFace[_loc_1][0] / 9;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = gS3SFace[_loc_1][1] + _loc_2 * 9;
                _loc_5[_loc_2] = gS3SPoint[_loc_4][0];
                _loc_6[_loc_2] = gS3SPoint[_loc_4][1];
                _loc_7[_loc_2] = gS3SPoint[_loc_4][2];
                _loc_2++;
            }
            gPH3D.vrtVec(_loc_3, _loc_5, _loc_6, _loc_7);
            gS3SHouVec[_loc_1].x = gPH3D.dX;
            gS3SHouVec[_loc_1].y = gPH3D.dY;
            gS3SHouVec[_loc_1].z = gPH3D.dZ;
            if (gS3SolidNo == 1)
            {
                return;
            }
            _loc_1 = this.S3_SOKUMEN + 1;
            _loc_3 = gS3SFace[_loc_1][0] / 9;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = gS3SFace[_loc_1][1] + _loc_2 * 9;
                _loc_5[(_loc_3 - 1) - _loc_2] = gS3SPoint[_loc_4][0];
                _loc_6[(_loc_3 - 1) - _loc_2] = gS3SPoint[_loc_4][1];
                _loc_7[(_loc_3 - 1) - _loc_2] = gS3SPoint[_loc_4][2];
                _loc_2++;
            }
            gPH3D.vrtVec(_loc_3, _loc_5, _loc_6, _loc_7);
            gS3SHouVec[_loc_1].x = gPH3D.dX;
            gS3SHouVec[_loc_1].y = gPH3D.dY;
            gS3SHouVec[_loc_1].z = gPH3D.dZ;
            return;
        }// end function

        override protected function cylinderMove(param1:int, param2:Number) : void
        {
            this.actionMove(param1, param2, this.dCPoint1, gS3SPointCnt);
            this.actionMove(param1, param2, this.dCPoint2, gS3SPointCnt);
            if (this.gS3CutFlg[0] == 2)
            {
                this.actionMove(param1, param2, this.dCPointCut, 2);
            }
            return;
        }// end function

        override protected function getVectorCrossCurrentFace(param1:int, param2:Boolean = true) : Vector3D
        {
            if (gS3SolidNo < 3)
            {
                if (param1 < this.S3_SOKUMEN)
                {
                    return this.getVectorCross(this.dCPoint1[gS3SFace[param1][1]], this.dCPoint1[gS3SFace[param1][2]], this.dCPoint1[gS3SFace[param1][3]], param2);
                }
                return this.getVectorCross(this.dCPoint2[gS3SFace[param1][1] + 0], this.dCPoint2[(gS3SFace[param1][1] + 1)], this.dCPoint2[gS3SFace[param1][1] + 2], param2);
            }
            return super.getVectorCrossCurrentFace(param1, param2);
        }// end function

        override protected function cylinderDisplay3D() : void
        {
            if (gS3TokuchoFlg[4] == 1)
            {
                this.cylinderHeightSet();
            }
            if (gS3RgnFace[0].getSize() != 0)
            {
                this.cylinderDeleteRegion();
            }
            this.canvasGraphics.clear();
            this.cylinderDisplay3D2();
            return;
        }// end function

        override protected function cylinderDisplay3D2() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = new Vector.<Number>((this.S3_SOKUMEN + 1), true);
            var _loc_7:* = new Vector.<Number>((this.S3_SOKUMEN + 1), true);
            var _loc_8:* = new Vector.<Number>((this.S3_SOKUMEN + 1), true);
            var _loc_9:* = new Vector.<Number>(gS3SFaceCnt, true);
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                _loc_3 = gS3SFace[_loc_1][0];
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    if (gS3GLineCut[_loc_1] == 2 && _loc_2 < 2)
                    {
                        _loc_6[_loc_2] = this.dCPointCut[_loc_2][0];
                        _loc_7[_loc_2] = this.dCPointCut[_loc_2][1];
                        _loc_8[_loc_2] = this.dCPointCut[_loc_2][2];
                    }
                    else
                    {
                        _loc_4 = gS3SFace[_loc_1][(_loc_2 + 1)];
                        _loc_6[_loc_2] = this.dCPoint1[_loc_4][0];
                        _loc_7[_loc_2] = this.dCPoint1[_loc_4][1];
                        _loc_8[_loc_2] = this.dCPoint1[_loc_4][2];
                    }
                    _loc_2++;
                }
                gS3GFaceDist[_loc_1] = gPH3D.getDist(_loc_3, _loc_6, _loc_7, _loc_8);
                _loc_9[_loc_1] = gS3GFaceDist[_loc_1];
                gPH3D.getVec(_loc_3, _loc_6, _loc_7, _loc_8);
                gS3GFaceVec[_loc_1] = gPH3D.dX;
                gS3GLightVec[_loc_1] = gPH3D.dY;
                if (gS3GFaceVec[_loc_1] > 0)
                {
                    _loc_9[_loc_1] = _loc_9[_loc_1] + 100;
                }
                _loc_1++;
            }
            _loc_1 = this.S3_SOKUMEN;
            _loc_4 = gS3SFace[_loc_1][1];
            _loc_2 = 0;
            while (_loc_2 < 4)
            {
                
                _loc_6[_loc_2] = this.dCPoint2[_loc_2 * 9 + _loc_4][0];
                _loc_7[_loc_2] = this.dCPoint2[_loc_2 * 9 + _loc_4][1];
                _loc_8[_loc_2] = this.dCPoint2[_loc_2 * 9 + _loc_4][2];
                _loc_2++;
            }
            gS3GFaceDist[_loc_1] = gPH3D.getDist(4, _loc_6, _loc_7, _loc_8);
            _loc_9[_loc_1] = gS3GFaceDist[_loc_1];
            gPH3D.getVec(4, _loc_6, _loc_7, _loc_8);
            gS3GFaceVec[_loc_1] = gPH3D.dX;
            gS3GLightVec[_loc_1] = gPH3D.dY;
            if (gS3GFaceVec[_loc_1] > 0)
            {
                _loc_9[_loc_1] = _loc_9[_loc_1] + 100;
            }
            if (gS3GFaceVec[_loc_1] < 0 && _loc_1 >= this.S3_SOKUMEN)
            {
                _loc_9[_loc_1] = _loc_9[_loc_1] - 300;
            }
            if (gS3SolidNo == 2)
            {
                _loc_1 = this.S3_SOKUMEN + 1;
                _loc_4 = gS3SFace[_loc_1][1];
                _loc_2 = 0;
                while (_loc_2 < 4)
                {
                    
                    _loc_6[_loc_2] = this.dCPoint2[(3 - _loc_2) * 9 + _loc_4][0];
                    _loc_7[_loc_2] = this.dCPoint2[(3 - _loc_2) * 9 + _loc_4][1];
                    _loc_8[_loc_2] = this.dCPoint2[(3 - _loc_2) * 9 + _loc_4][2];
                    _loc_2++;
                }
                gS3GFaceDist[_loc_1] = gPH3D.getDist(4, _loc_6, _loc_7, _loc_8);
                _loc_9[_loc_1] = gS3GFaceDist[_loc_1];
                gPH3D.getVec(4, _loc_6, _loc_7, _loc_8);
                gS3GFaceVec[_loc_1] = gPH3D.dX;
                gS3GLightVec[_loc_1] = gPH3D.dY;
                if (gS3GFaceVec[_loc_1] > 0)
                {
                    _loc_9[_loc_1] = _loc_9[_loc_1] + 100;
                }
                if (gS3GFaceVec[_loc_1] < 0 && _loc_1 >= this.S3_SOKUMEN)
                {
                    _loc_9[_loc_1] = _loc_9[_loc_1] - 300;
                }
            }
            _loc_2 = this.S3_SOKUMEN - 1;
            this.dDrawFlg[0] = -1;
            this.dDrawFlg[1] = -1;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GFaceVec[_loc_2] < 0 && gS3GFaceVec[_loc_1] > 0)
                {
                    this.dDrawFlg[1] = _loc_1;
                }
                if (gS3GFaceVec[_loc_2] > 0 && gS3GFaceVec[_loc_1] < 0)
                {
                    this.dDrawFlg[0] = _loc_1;
                }
                _loc_2 = _loc_1;
                _loc_1++;
            }
            this.dDrawBaseDotFlag = false;
            _loc_5 = -1;
            do
            {
                
                _loc_5 = 0;
                _loc_1 = 0;
                while (_loc_1 < gS3SFaceCnt)
                {
                    
                    if (_loc_9[_loc_1] > _loc_5)
                    {
                        _loc_5 = _loc_9[_loc_1];
                        _loc_2 = _loc_1;
                    }
                    _loc_1++;
                }
                if (_loc_5 == 0)
                {
                    break;
                }
                _loc_9[_loc_2] = 0;
                this.cylinderDrawPlane(_loc_2);
            }while (_loc_5 != 0)
            return;
        }// end function

        override protected function cylinderDeleteRegion() : void
        {
            var _loc_1:* = 0;
            _loc_1 = this.S3_SOKUMEN;
            while (_loc_1 < gS3SLineCnt)
            {
                
                if (gS3RgnLine[_loc_1].getSize() != 0 && this.gS3RgnLine2[_loc_1].getSize() != 0)
                {
                    gS3RgnLine[_loc_1].clear();
                    this.gS3RgnLine2[_loc_1].clear();
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < gS3SFaceCnt)
            {
                
                if (gS3RgnFace[_loc_1].getSize() != 0)
                {
                    gS3RgnFace[_loc_1].clear();
                }
                _loc_1++;
            }
            if (gS3SolidNo == 1 && gS3RgnPoint[0].getSize() != 0)
            {
                gS3RgnPoint[0].clear();
            }
            return;
        }// end function

        override protected function cylinderSelectRegion() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            var _loc_5:* = 0;
            var _loc_9:* = new Vector.<Number>(gS3SFaceCnt, true);
            _loc_1 = 0;
            _loc_4 = 0;
            while (_loc_4 < gS3SFaceCnt)
            {
                
                _loc_9[_loc_4] = gS3GFaceDist[_loc_4];
                _loc_4++;
            }
            var _loc_10:* = this.mouseX;
            var _loc_11:* = this.mouseY;
            _loc_3 = 0;
            do
            {
                
                _loc_3 = 9999;
                _loc_4 = 0;
                while (_loc_4 < gS3SFaceCnt)
                {
                    
                    if (_loc_9[_loc_4] < _loc_3)
                    {
                        _loc_3 = _loc_9[_loc_4];
                        _loc_5 = _loc_4;
                    }
                    _loc_4++;
                }
                if (_loc_3 == 9999)
                {
                    return 0;
                }
                _loc_9[_loc_5] = 9999;
                if (gS3SolidNo == 1 && _loc_5 < this.S3_SOKUMEN)
                {
                    _loc_8 = gS3RgnPoint[0].contains(_loc_10, _loc_11);
                    if (_loc_8 == true)
                    {
                        _loc_1 = 1;
                        _loc_2 = 0;
                        return (_loc_1 << 8) + _loc_2;
                    }
                }
                _loc_6 = gS3SFace[_loc_5][0];
                _loc_4 = 0;
                while (_loc_4 < _loc_6)
                {
                    
                    if (_loc_5 < this.S3_SOKUMEN)
                    {
                        _loc_7 = gS3SFace[_loc_5][_loc_4 + 7];
                    }
                    else
                    {
                        _loc_7 = gS3SFace[_loc_5][7] + _loc_4;
                    }
                    if (gS3RgnLine[_loc_7].getSize() > 0)
                    {
                        _loc_8 = gS3RgnLine[_loc_7].contains(_loc_10, _loc_11);
                        if (_loc_8 == true)
                        {
                            _loc_1 = 2;
                            _loc_2 = _loc_7;
                            return (_loc_1 << 8) + _loc_2;
                        }
                    }
                    if (this.gS3RgnLine2[_loc_7].getSize() > 0)
                    {
                        _loc_8 = this.gS3RgnLine2[_loc_7].contains(_loc_10, _loc_11);
                        if (_loc_8 == true)
                        {
                            _loc_1 = 2;
                            _loc_2 = _loc_7;
                            return (_loc_1 << 8) + _loc_2;
                        }
                    }
                    _loc_4++;
                }
                _loc_8 = gS3RgnFace[_loc_5].contains(_loc_10, _loc_11);
                if (_loc_8 == true)
                {
                    _loc_1 = 3;
                    _loc_2 = _loc_5;
                    return (_loc_1 << 8) + _loc_2;
                }
            }while (_loc_3 != 9999)
            return 0;
        }// end function

        override protected function cylinderSelectRegionCheck(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            switch(gS3StFlg)
            {
                case 1:
                {
                    if (param1 == 3 && param2 < this.S3_SOKUMEN)
                    {
                        param1 = 2;
                        if (param2 == (this.S3_SOKUMEN - 1))
                        {
                            param2 = 0;
                        }
                        else
                        {
                            param2 = param2 + 1;
                        }
                    }
                    if (param1 == 2)
                    {
                        if (param2 < this.S3_SOKUMEN && this.gS3CutFlg[0] == 0)
                        {
                            _loc_3 = 1;
                        }
                        if (param2 >= this.S3_SOKUMEN && param2 < this.S3_SOKUMEN * 2 && this.gS3CutFlg[1] == 0)
                        {
                            _loc_3 = 1;
                        }
                        if (param2 >= this.S3_SOKUMEN * 2 && this.gS3CutFlg[2] == 0)
                        {
                            _loc_3 = 1;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (param1 == 3 && param2 < this.S3_SOKUMEN)
                    {
                        param1 = 2;
                        if (param2 == (this.S3_SOKUMEN - 1))
                        {
                            param2 = 0;
                        }
                        else
                        {
                            param2 = param2 + 1;
                        }
                    }
                    if (param1 == 2)
                    {
                        if (param2 < this.S3_SOKUMEN && this.gS3CutFlg[0] == 1 && gS3GLineCut[param2] == 1)
                        {
                            _loc_3 = 1;
                        }
                        if (param2 >= this.S3_SOKUMEN && param2 < this.S3_SOKUMEN * 2 && (this.gS3CutFlg[1] == 1 && this.gS3CutFlg[0] != 2))
                        {
                            _loc_3 = 1;
                        }
                        if (param2 >= this.S3_SOKUMEN * 2 && this.gS3CutFlg[2] == 1 && this.gS3CutFlg[0] != 2)
                        {
                            _loc_3 = 1;
                        }
                    }
                    break;
                }
                case 3:
                {
                    if (param1 == 3 && param2 < this.S3_SOKUMEN && this.gS3CutFlg[0] == 1 && this.gS3CutFlg[1] != 0)
                    {
                        if (gS3SolidNo == 1)
                        {
                            _loc_3 = 1;
                        }
                        else if (gS3SolidNo == 2 && this.gS3CutFlg[2] != 0)
                        {
                            _loc_3 = 1;
                        }
                    }
                    if (param1 == 3 && param2 == this.S3_SOKUMEN && this.gS3CutFlg[1] == 1)
                    {
                        _loc_3 = 1;
                    }
                    if (param1 == 3 && param2 == (this.S3_SOKUMEN + 1) && this.gS3CutFlg[2] == 1)
                    {
                        _loc_3 = 1;
                    }
                    break;
                }
                case 4:
                {
                    if (param1 == 3 && param2 < this.S3_SOKUMEN && this.gS3CutFlg[0] == 2)
                    {
                        _loc_3 = 1;
                    }
                    if (param1 == 2 && param2 >= this.S3_SOKUMEN && param2 < this.S3_SOKUMEN * 2 && this.gS3CutFlg[1] == 2 && gS3GLineCut[param2] == 3)
                    {
                        _loc_3 = 1;
                    }
                    if (param1 == 3 && param2 == this.S3_SOKUMEN && this.gS3CutFlg[1] == 2)
                    {
                        _loc_3 = 1;
                    }
                    if (param1 == 2 && param2 >= this.S3_SOKUMEN * 2 && this.gS3CutFlg[2] == 2 && gS3GLineCut[param2] == 3)
                    {
                        _loc_3 = 1;
                    }
                    if (param1 == 3 && param2 == (this.S3_SOKUMEN + 1) && this.gS3CutFlg[2] == 2)
                    {
                        _loc_3 = 1;
                    }
                    break;
                }
                case 5:
                {
                    if ((param1 == 2 || param1 == 3) && param2 < this.S3_SOKUMEN)
                    {
                        param1 = 3;
                        param2 = 0;
                    }
                    if (param1 == 2 && param2 >= this.S3_SOKUMEN && param2 < this.S3_SOKUMEN * 2)
                    {
                        param2 = this.S3_SOKUMEN;
                    }
                    if (param1 == 2 && param2 >= this.S3_SOKUMEN * 2)
                    {
                        param2 = this.S3_SOKUMEN * 2;
                    }
                    _loc_3 = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3 == 1)
            {
                return (param1 << 8) + param2;
            }
            return 0;
        }// end function

        override protected function cylinderMotonoichi() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < gS3SPointCnt)
            {
                
                this.dCPoint1[_loc_1][0] = gS3SPoint[_loc_1][0];
                this.dCPoint1[_loc_1][1] = gS3SPoint[_loc_1][1];
                this.dCPoint1[_loc_1][2] = gS3SPoint[_loc_1][2];
                this.dCPoint2[_loc_1][0] = gS3SPoint[_loc_1][0];
                this.dCPoint2[_loc_1][1] = gS3SPoint[_loc_1][1];
                this.dCPoint2[_loc_1][2] = gS3SPoint[_loc_1][2];
                _loc_1++;
            }
            if (this.gS3CutFlg[1] == 2)
            {
                this.cylinderSaiTenkai(1);
            }
            if (this.gS3CutFlg[2] == 2)
            {
                this.cylinderSaiTenkai(2);
            }
            if (this.gS3CutFlg[0] == 2)
            {
                this.cylinderSaiTenkaiSokumen();
            }
            if (gS3SolidNo == 1 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 || gS3SolidNo == 2 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 && this.gS3CutFlg[2] == 2)
            {
                this.cylinderIdou3();
            }
            else
            {
                this.moveBasis();
            }
            this.cylinderDisplay3D();
            return;
        }// end function

        override protected function cylinderSetColor(param1:int, param2:int) : Boolean
        {
            var _loc_5:* = 0;
            var _loc_3:* = this.cylinderSelectRegionCheck(param1, param2);
            if (_loc_3 == 0)
            {
                return false;
            }
            param1 = _loc_3 >> 8;
            param2 = _loc_3 & 255;
            if ((this.getDrawColor() & 16777215) == 0)
            {
                return false;
            }
            var _loc_4:* = this.getDrawColor();
            if ((this.getDrawColor() & 16777215) == 16777215)
            {
                _loc_4 = 0;
            }
            if (param1 == 1)
            {
                gS3GPointColor[0] = _loc_4;
            }
            else if (param1 == 2)
            {
                _loc_5 = param2;
                while (_loc_5 < param2 + this.S3_SOKUMEN)
                {
                    
                    gS3GLineColor[_loc_5] = _loc_4;
                    _loc_5++;
                }
            }
            else if (param2 < this.S3_SOKUMEN)
            {
                _loc_5 = 0;
                while (_loc_5 < this.S3_SOKUMEN)
                {
                    
                    gS3GFaceColor[_loc_5] = _loc_4;
                    _loc_5++;
                }
            }
            else
            {
                gS3GFaceColor[param2] = _loc_4;
            }
            return true;
        }// end function

        override protected function cylinderIconNo() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = this.cylinderSelectRegion();
            _loc_4 = _loc_3 & 255;
            _loc_3 = _loc_3 >> 8;
            _loc_2 = this.cylinderSelectRegionCheck(_loc_3, _loc_4);
            if (_loc_2 == 0)
            {
                return 0;
            }
            _loc_3 = _loc_2 >> 8;
            _loc_4 = _loc_2 & 255;
            _loc_1 = CursorOperate.ARROW;
            switch(gS3StFlg)
            {
                case 1:
                {
                    _loc_1 = CursorOperate.SCISSORS;
                    break;
                }
                case 2:
                {
                    _loc_1 = CursorOperate.TAPE;
                    break;
                }
                case 3:
                {
                    _loc_1 = CursorOperate.RIGHT_FINGER;
                    break;
                }
                case 4:
                {
                    _loc_1 = CursorOperate.GRIP;
                    break;
                }
                case 5:
                {
                    if ((this.getDrawColor() & 16777215) > 0 && (this.getDrawColor() & 16777215) < 16777215)
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
                    if ((this.getDrawColor() & 16777215) == 16777215)
                    {
                        switch(_loc_3)
                        {
                            case 1:
                            {
                                if ((gS3GPointColor[_loc_4] & 16777215) != 0)
                                {
                                    _loc_1 = CursorOperate.SLIM_ERASER;
                                }
                                break;
                            }
                            case 2:
                            {
                                if ((gS3GLineColor[_loc_4] & 16777215) != 0)
                                {
                                    _loc_1 = CursorOperate.FAT_ERASER;
                                }
                                break;
                            }
                            case 3:
                            {
                                if ((gS3GFaceColor[_loc_4] & 16777215) != 0)
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
            return _loc_1;
        }// end function

        override protected function cylinderMouseUp(param1:int, param2:int, param3:uint) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_6 = this.cylinderSelectRegionCheck(param1, param2);
            if (_loc_6 == 0)
            {
                return;
            }
            param1 = _loc_6 >> 8;
            param2 = _loc_6 & 255;
            switch(gS3StFlg)
            {
                case 1:
                {
                    if (param2 < this.S3_SOKUMEN)
                    {
                        gS3GLineCut[param2] = 1;
                        this.gS3CutFlg[0] = 1;
                    }
                    else if (param2 < this.S3_SOKUMEN * 2)
                    {
                        _loc_4 = (param2 + 17) % 36;
                        _loc_5 = 0;
                        while (_loc_5 < this.S3_SOKUMEN)
                        {
                            
                            if (_loc_5 != _loc_4)
                            {
                                gS3GLineCut[this.S3_SOKUMEN + _loc_5] = 1;
                            }
                            _loc_5++;
                        }
                        this.gS3CutFlg[1] = 1;
                    }
                    else
                    {
                        _loc_4 = (param2 + 17) % 36;
                        _loc_5 = 0;
                        while (_loc_5 < this.S3_SOKUMEN)
                        {
                            
                            if (_loc_5 != _loc_4)
                            {
                                gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_5] = 1;
                            }
                            _loc_5++;
                        }
                        this.gS3CutFlg[2] = 1;
                    }
                    break;
                }
                case 2:
                {
                    if (param2 < this.S3_SOKUMEN)
                    {
                        gS3GLineCut[param2] = 0;
                        this.gS3CutFlg[0] = 0;
                    }
                    else if (param2 < this.S3_SOKUMEN * 2)
                    {
                        _loc_5 = 0;
                        while (_loc_5 < this.S3_SOKUMEN)
                        {
                            
                            gS3GLineCut[this.S3_SOKUMEN + _loc_5] = 0;
                            _loc_5++;
                        }
                        this.gS3CutFlg[1] = 0;
                    }
                    else
                    {
                        _loc_5 = 0;
                        while (_loc_5 < this.S3_SOKUMEN)
                        {
                            
                            gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_5] = 0;
                            _loc_5++;
                        }
                        this.gS3CutFlg[2] = 0;
                    }
                    break;
                }
                case 5:
                {
                    if (param1 == 1)
                    {
                        gS3GPointColor[0] = param3;
                    }
                    else if (param1 == 2)
                    {
                        _loc_5 = param2 / this.S3_SOKUMEN * this.S3_SOKUMEN;
                        while (_loc_5 < (param2 / this.S3_SOKUMEN + 1) * this.S3_SOKUMEN)
                        {
                            
                            gS3GLineColor[_loc_5] = param3;
                            _loc_5++;
                        }
                    }
                    else if (param2 < this.S3_SOKUMEN)
                    {
                        _loc_5 = 0;
                        while (_loc_5 < this.S3_SOKUMEN)
                        {
                            
                            gS3GFaceColor[_loc_5] = param3;
                            _loc_5++;
                        }
                    }
                    else
                    {
                        gS3GFaceColor[param2] = param3;
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

        protected function cylinderHeightSet() : void
        {
            var _loc_5:* = 0;
            var _loc_1:* = new Vector.<Number>(3, true);
            var _loc_2:* = new Vector.<Number>(3, true);
            var _loc_3:* = new Vector.<Number>(3, true);
            var _loc_4:* = 0;
            _loc_5 = 0;
            while (_loc_5 < 3)
            {
                
                gS3HighPoint[_loc_5] = new Vector3D();
                _loc_5++;
            }
            switch(gS3SolidNo)
            {
                case 1:
                {
                    gS3HighPoint[0].x = this.dCPoint1[this.S3_SOKUMEN][0];
                    gS3HighPoint[0].y = this.dCPoint1[this.S3_SOKUMEN][1];
                    gS3HighPoint[0].z = this.dCPoint1[this.S3_SOKUMEN][2];
                    gS3HighPoint[1].x = (this.dCPoint1[0][0] + this.dCPoint1[12][0] + this.dCPoint1[24][0]) / 3;
                    gS3HighPoint[1].y = (this.dCPoint1[0][1] + this.dCPoint1[12][1] + this.dCPoint1[24][1]) / 3;
                    gS3HighPoint[1].z = (this.dCPoint1[0][2] + this.dCPoint1[12][2] + this.dCPoint1[24][2]) / 3;
                    gS3HighPoint[2].x = (this.dCPoint1[0][0] + this.dCPoint1[12][0] + this.dCPoint1[24][0]) / 3;
                    gS3HighPoint[2].y = (this.dCPoint1[0][1] + this.dCPoint1[12][1] + this.dCPoint1[24][1]) / 3;
                    gS3HighPoint[2].z = (this.dCPoint1[0][2] + this.dCPoint1[12][2] + this.dCPoint1[24][2]) / 3;
                    _loc_4 = 3;
                    break;
                }
                case 2:
                {
                    gS3HighPoint[0].x = (this.dCPoint1[0][0] + this.dCPoint1[12][0] + this.dCPoint1[24][0]) / 3;
                    gS3HighPoint[0].y = (this.dCPoint1[0][1] + this.dCPoint1[12][1] + this.dCPoint1[24][1]) / 3;
                    gS3HighPoint[0].z = (this.dCPoint1[0][2] + this.dCPoint1[12][2] + this.dCPoint1[24][2]) / 3;
                    gS3HighPoint[1].x = (this.dCPoint1[36][0] + this.dCPoint1[48][0] + this.dCPoint1[60][0]) / 3;
                    gS3HighPoint[1].y = (this.dCPoint1[36][1] + this.dCPoint1[48][1] + this.dCPoint1[60][1]) / 3;
                    gS3HighPoint[1].z = (this.dCPoint1[36][2] + this.dCPoint1[48][2] + this.dCPoint1[60][2]) / 3;
                    _loc_4 = 2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_1[_loc_5] = gS3HighPoint[_loc_5].x;
                _loc_2[_loc_5] = gS3HighPoint[_loc_5].y;
                _loc_3[_loc_5] = gS3HighPoint[_loc_5].z;
                _loc_5++;
            }
            gS3HighLeng = gPH3D.getDist(_loc_4, _loc_1, _loc_2, _loc_3);
            return;
        }// end function

        protected function cylinderDrawPlane(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_11:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = false;
            var _loc_18:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = NaN;
            var _loc_10:* = new Vector.<Point>((this.S3_SOKUMEN + 1), true);
            var _loc_12:* = new Vector.<Point>(5, true);
            _loc_4 = 0;
            while (_loc_4 < (this.S3_SOKUMEN + 1))
            {
                
                _loc_10[_loc_4] = new Point(0, 0);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 5)
            {
                
                _loc_12[_loc_4] = new Point(0, 0);
                _loc_4++;
            }
            if (gS3ModelMode == 1 && gS3TokuchoFlg[4] == 1 && gS3HighLeng != 0 && gS3GFaceDist[param1] < gS3HighLeng)
            {
                _loc_4 = 0;
                while (_loc_4 < 2)
                {
                    
                    gPH3D.cv3d3d(gS3HighPoint[_loc_4].x, gS3HighPoint[_loc_4].y, gS3HighPoint[_loc_4].z);
                    changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_10[_loc_4].x = VewWinX;
                    _loc_10[_loc_4].y = VewWinY;
                    _loc_4++;
                }
                dComLine.setWidth(1);
                dComLine.setStyle(LineObject.DOT);
                dComLine.setColor(COLOR_RED);
                dComLine.setLocationPoint(_loc_10[0], _loc_10[1]);
                dComLine.draw(this.canvasGraphics);
                this.canvasGraphics.lineStyle(1, COLOR_RED);
                this.canvasGraphics.beginFill(COLOR_RED);
                this.canvasGraphics.drawCircle(_loc_10[0].x, _loc_10[0].y, 2.5);
                this.canvasGraphics.endFill();
                this.canvasGraphics.beginFill(COLOR_RED);
                this.canvasGraphics.drawCircle(_loc_10[1].x, _loc_10[1].y, 2.5);
                this.canvasGraphics.endFill();
                gS3HighLeng = 0;
            }
            if (gS3ModelMode == 0)
            {
                if ((gS3GFaceColor[param1] & 16777215) == 0)
                {
                    _loc_2 = gPH3D.drwplColor2(this.getFaceCol(), gS3GFaceVec[param1], gS3GLightVec[param1]);
                    _loc_15 = dFaceColA;
                }
                else
                {
                    _loc_2 = gPH3D.drwplColor2(gS3GFaceColor[param1], gS3GFaceVec[param1], gS3GLightVec[param1]);
                    _loc_15 = 1;
                }
            }
            else
            {
                if ((gS3GFaceColor[param1] & 16777215) == 0)
                {
                    _loc_2 = 0;
                }
                else if (param1 < this.S3_SOKUMEN)
                {
                    _loc_2 = gPH3D.drwplColor2(gS3GFaceColor[param1], gS3GFaceVec[param1], gS3GLightVec[param1]);
                }
                else
                {
                    _loc_2 = gS3GFaceColor[param1];
                }
                _loc_15 = 1;
            }
            if (gS3FaceOver[param1] == 5)
            {
                if (gS3ModelMode == 0)
                {
                    _loc_2 = gPH3D.drwplColor(this.FS_FACE_COL_BASE_CYLINDER, gS3GFaceVec[param1], gS3GLightVec[param1]);
                }
                else
                {
                    _loc_2 = this.FS_FACE_COL_BASE_CYLINDER;
                }
                _loc_15 = 1;
            }
            if (gS3FaceOver[param1] == 6)
            {
                if (gS3ModelMode == 0)
                {
                    _loc_2 = gPH3D.drwplColor(this.FS_FACE_COL_SIDE_CYLINDER, gS3GFaceVec[param1], gS3GLightVec[param1]);
                }
                else
                {
                    _loc_2 = this.FS_FACE_COL_SIDE_CYLINDER;
                }
                _loc_15 = 1;
            }
            _loc_5 = gS3SFace[param1][0];
            if (param1 < this.S3_SOKUMEN)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_5)
                {
                    
                    _loc_6 = gS3SFace[param1][(_loc_4 + 1)];
                    if (gS3GLineCut[param1] == 2 && _loc_4 < 2)
                    {
                        gPH3D.cv3d3d(this.dCPointCut[_loc_4][0], this.dCPointCut[_loc_4][1], this.dCPointCut[_loc_4][2]);
                    }
                    else
                    {
                        gPH3D.cv3d3d(this.dCPoint1[_loc_6][0], this.dCPoint1[_loc_6][1], this.dCPoint1[_loc_6][2]);
                    }
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_10[_loc_4].x = VewWinX;
                    _loc_10[_loc_4].y = VewWinY;
                    _loc_4++;
                }
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_5)
                {
                    
                    _loc_6 = gS3SFace[param1][1] + _loc_4;
                    gPH3D.cv3d3d(this.dCPoint2[_loc_6][0], this.dCPoint2[_loc_6][1], this.dCPoint2[_loc_6][2]);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    _loc_10[_loc_4].x = VewWinX;
                    _loc_10[_loc_4].y = VewWinY;
                    _loc_4++;
                }
            }
            _loc_16 = 1;
            _loc_14 = _loc_2;
            _loc_17 = false;
            if (gS3ModelMode == 0)
            {
                _loc_13 = _loc_2;
                _loc_17 = true;
            }
            else if ((_loc_2 & 16777215) != 0)
            {
                _loc_13 = _loc_2;
                _loc_17 = true;
            }
            if (_loc_17)
            {
                if (_loc_15 < 1)
                {
                    this.canvasGraphics.lineStyle();
                }
                else
                {
                    this.canvasGraphics.lineStyle(_loc_16, _loc_13);
                }
                this.canvasGraphics.beginFill(_loc_14, _loc_15);
                this.canvasGraphics.moveTo(_loc_10[0].x, _loc_10[0].y);
                _loc_4 = 1;
                while (_loc_4 < _loc_5)
                {
                    
                    this.canvasGraphics.lineTo(_loc_10[_loc_4].x, _loc_10[_loc_4].y);
                    _loc_4++;
                }
                this.canvasGraphics.lineTo(_loc_10[0].x, _loc_10[0].y);
                this.canvasGraphics.endFill();
            }
            var _loc_19:* = dLineRevDotLength > 0 && dLineRevDotInterval > 0 && dLineWid != 0;
            if (dLineRevDotLength > 0 && dLineRevDotInterval > 0 && dLineWid != 0)
            {
                if (param1 >= this.S3_SOKUMEN)
                {
                    if (gS3GFaceVec[param1] >= 0)
                    {
                        _loc_16 = 1;
                        if (dLineWid >= 0)
                        {
                            _loc_16 = dLineWid;
                        }
                        if (gS3ModelMode == 0)
                        {
                            _loc_18 = _loc_3;
                        }
                        else
                        {
                            _loc_18 = FACE_COL_DEFAULT_W2;
                        }
                        if (dLineCol >= 0)
                        {
                            _loc_18 = dLineCol;
                        }
                        if (dLineRevCol >= 0)
                        {
                            _loc_18 = dLineRevCol;
                        }
                        this.setDotLineStyle(this.canvasGraphics, _loc_16, _loc_18, 1);
                        this.drawDotLine(this.canvasGraphics, _loc_10, _loc_5, dLineRevDotLength, dLineRevDotInterval, true);
                    }
                }
            }
            if (!this.dDrawBaseDotFlag && _loc_19 && param1 < this.S3_SOKUMEN)
            {
                if (gS3GFaceVec[param1] >= 0)
                {
                    _loc_16 = 1;
                    if (dLineWid >= 0)
                    {
                        _loc_16 = dLineWid;
                    }
                    if (gS3ModelMode == 0)
                    {
                        _loc_18 = _loc_3;
                    }
                    else
                    {
                        _loc_18 = FACE_COL_DEFAULT_W2;
                    }
                    if (dLineCol >= 0)
                    {
                        _loc_18 = dLineCol;
                    }
                    if (dLineRevCol >= 0)
                    {
                        _loc_18 = dLineRevCol;
                    }
                    _loc_20 = this.S3_SOKUMEN;
                    while (_loc_20 < this.S3_SOKUMEN + gS3SolidNo)
                    {
                        
                        if (gS3GLineCut[_loc_20] >= 2)
                        {
                            _loc_21 = this.cylinderGetSokumenBaseLine(_loc_20);
                            this.canvasGraphics.lineStyle((_loc_16 + 1), this.areaBackColor);
                            this.canvasGraphics.moveTo(_loc_21[0].x, _loc_21[0].y);
                            _loc_4 = 1;
                            while (_loc_4 < _loc_21.length)
                            {
                                
                                this.canvasGraphics.lineTo(_loc_21[_loc_4].x, _loc_21[_loc_4].y);
                                _loc_4++;
                            }
                            this.setDotLineStyle(this.canvasGraphics, _loc_16, _loc_18, 1);
                            this.drawDotLine(this.canvasGraphics, _loc_21, _loc_21.length, dLineRevDotLength, dLineRevDotInterval, false);
                        }
                        _loc_20++;
                    }
                    this.dDrawBaseDotFlag = true;
                }
            }
            gS3RgnFace[param1].add(_loc_10, _loc_5);
            _loc_3 = _loc_2;
            _loc_4 = 0;
            while (_loc_4 < _loc_5)
            {
                
                _loc_9 = 0;
                _loc_2 = _loc_3;
                if (_loc_4 == (_loc_5 - 1))
                {
                    _loc_8 = 0;
                }
                else
                {
                    _loc_8 = _loc_4 + 1;
                }
                if (param1 < this.S3_SOKUMEN)
                {
                    _loc_7 = gS3SFace[param1][_loc_4 + 7];
                }
                else
                {
                    _loc_7 = gS3SFace[param1][7] + _loc_4;
                }
                if (gS3GLineCut[_loc_7] == 1)
                {
                    _loc_2 = LINE_COL_CUT;
                    _loc_16 = 3;
                    _loc_9 = 1;
                    if (dLineWid >= 0)
                    {
                        _loc_16 = Math.max(_loc_16, dLineWid);
                    }
                }
                else if ((gS3GLineColor[_loc_7] & 16777215) > 0)
                {
                    _loc_2 = gS3GLineColor[_loc_7];
                    _loc_16 = 3;
                    _loc_9 = 1;
                    if (dLineWid >= 0)
                    {
                        _loc_16 = Math.max(_loc_16, dLineWid);
                    }
                }
                else if (gS3ModelMode == 1 && _loc_7 < this.S3_SOKUMEN && gS3GLineCut[_loc_7] == 2)
                {
                    if (gS3GFaceVec[param1] < 0)
                    {
                        _loc_2 = this.getFaceColWirerFrame();
                    }
                    else
                    {
                        _loc_2 = FACE_COL_DEFAULT_W2;
                    }
                    _loc_16 = 1;
                    _loc_9 = 1;
                    if (dLineCol >= 0)
                    {
                        _loc_2 = dLineCol;
                        if (gS3GFaceVec[param1] >= 0)
                        {
                            if (dLineRevCol >= 0)
                            {
                                _loc_2 = dLineRevCol;
                            }
                        }
                    }
                    if (dLineWid >= 0)
                    {
                        _loc_16 = Math.max(_loc_16, dLineWid);
                    }
                    if (gS3GFaceVec[param1] >= 0)
                    {
                        if (_loc_19)
                        {
                            if (_loc_16 > 0)
                            {
                                _loc_22 = this.Vector.<Point>([_loc_10[_loc_4], _loc_10[_loc_8]]);
                                _loc_22.fixed = true;
                                this.canvasGraphics.lineStyle((_loc_16 + 1), this.areaBackColor);
                                this.canvasGraphics.moveTo(_loc_22[0].x, _loc_22[0].y);
                                this.canvasGraphics.lineTo(_loc_22[1].x, _loc_22[1].y);
                                this.setDotLineStyle(this.canvasGraphics, _loc_16, _loc_2, 1);
                                this.drawDotLine(this.canvasGraphics, _loc_22, _loc_22.length, dLineRevDotLength, dLineRevDotInterval, false);
                            }
                            _loc_9 = 0;
                        }
                    }
                }
                else if ((gS3ModelMode != 0 || dLineCol >= 0 && gS3GFaceVec[param1] < 0 || dLineRevCol >= 0 && gS3GFaceVec[param1] >= 0 || dLineWid >= 0) && _loc_7 >= this.S3_SOKUMEN)
                {
                    if (gS3GFaceVec[param1] < 0)
                    {
                        _loc_2 = this.getFaceColWirerFrame();
                    }
                    else
                    {
                        _loc_2 = FACE_COL_DEFAULT_W2;
                    }
                    _loc_16 = 1;
                    _loc_9 = 1;
                    if (gS3ModelMode == 0)
                    {
                        _loc_2 = _loc_3;
                    }
                    if (dLineCol >= 0)
                    {
                        _loc_2 = dLineCol;
                        if (gS3GFaceVec[param1] >= 0)
                        {
                            if (dLineRevCol >= 0)
                            {
                                _loc_2 = dLineRevCol;
                            }
                        }
                    }
                    if (dLineWid >= 0)
                    {
                        _loc_16 = dLineWid;
                        if (_loc_16 == 0)
                        {
                            _loc_9 = 0;
                        }
                    }
                    if (_loc_19)
                    {
                        if (gS3GFaceVec[param1] >= 0)
                        {
                            _loc_9 = 0;
                        }
                    }
                }
                else
                {
                    if (param1 < this.S3_SOKUMEN && gS3GFaceVec[param1] < 0 && (this.dDrawFlg[0] == _loc_7 || this.dDrawFlg[1] == _loc_7))
                    {
                        if ((_loc_2 & 16777215) == 0)
                        {
                            _loc_13 = this.getFaceColWirerFrame();
                            _loc_16 = 1;
                        }
                        else
                        {
                            _loc_13 = _loc_3;
                            if (_loc_10[_loc_4].x == _loc_10[_loc_8].x || _loc_10[_loc_4].y == _loc_10[_loc_8].y)
                            {
                                _loc_16 = 1;
                            }
                            else
                            {
                                _loc_16 = 2;
                            }
                            if (_loc_15 < 1)
                            {
                                _loc_16 = 0;
                            }
                        }
                        if (dLineCol >= 0)
                        {
                            _loc_13 = dLineCol;
                        }
                        if (dLineWid >= 0)
                        {
                            _loc_16 = dLineWid;
                        }
                        if (_loc_16 > 0)
                        {
                            this.canvasGraphics.lineStyle(_loc_16, _loc_13);
                            if (this.dDrawFlg[0] == _loc_7)
                            {
                                this.canvasGraphics.moveTo(_loc_10[_loc_4].x, _loc_10[_loc_4].y);
                                this.canvasGraphics.lineTo(_loc_10[_loc_8].x, _loc_10[_loc_8].y);
                            }
                            else
                            {
                                this.canvasGraphics.moveTo(_loc_10[_loc_8].x, _loc_10[_loc_8].y);
                                this.canvasGraphics.lineTo(_loc_10[_loc_4].x, _loc_10[_loc_4].y);
                            }
                        }
                    }
                    _loc_9 = 0;
                }
                if (_loc_9 == 1)
                {
                    this.canvasGraphics.lineStyle(_loc_16, _loc_2);
                    this.canvasGraphics.moveTo(_loc_10[_loc_4].x, _loc_10[_loc_4].y);
                    this.canvasGraphics.lineTo(_loc_10[_loc_8].x, _loc_10[_loc_8].y);
                }
                if (param1 < this.S3_SOKUMEN && _loc_7 > this.S3_SOKUMEN && gS3RgnLine[_loc_7].getSize() == 0 || param1 >= this.S3_SOKUMEN && _loc_7 > this.S3_SOKUMEN && this.gS3RgnLine2[_loc_7].getSize() == 0)
                {
                    if (_loc_10[_loc_8].x == _loc_10[_loc_4].x)
                    {
                        _loc_11 = 99;
                    }
                    else
                    {
                        _loc_11 = (_loc_10[_loc_8].y - _loc_10[_loc_4].y) / (_loc_10[_loc_8].x - _loc_10[_loc_4].x);
                    }
                    if (_loc_11 < -1 || _loc_11 > 1)
                    {
                        _loc_12[0].x = _loc_10[_loc_4].x - 5;
                        _loc_12[0].y = _loc_10[_loc_4].y;
                        _loc_12[1].x = _loc_10[_loc_4].x + 5;
                        _loc_12[1].y = _loc_10[_loc_4].y;
                        _loc_12[2].x = _loc_10[_loc_8].x + 5;
                        _loc_12[2].y = _loc_10[_loc_8].y;
                        _loc_12[3].x = _loc_10[_loc_8].x - 5;
                        _loc_12[3].y = _loc_10[_loc_8].y;
                    }
                    else
                    {
                        _loc_12[0].x = _loc_10[_loc_4].x;
                        _loc_12[0].y = _loc_10[_loc_4].y - 5;
                        _loc_12[1].x = _loc_10[_loc_4].x;
                        _loc_12[1].y = _loc_10[_loc_4].y + 5;
                        _loc_12[2].x = _loc_10[_loc_8].x;
                        _loc_12[2].y = _loc_10[_loc_8].y + 5;
                        _loc_12[3].x = _loc_10[_loc_8].x;
                        _loc_12[3].y = _loc_10[_loc_8].y - 5;
                    }
                    if (param1 < this.S3_SOKUMEN)
                    {
                        gS3RgnLine[_loc_7].add(_loc_12, 4);
                    }
                    else
                    {
                        this.gS3RgnLine2[_loc_7].add(_loc_12, 4);
                    }
                }
                _loc_4++;
            }
            if (param1 < this.S3_SOKUMEN)
            {
                if (gS3FOnLineFlg == true)
                {
                    this.faceOnLineDraw(param1, _loc_10, _loc_5);
                }
            }
            if (gS3SolidNo == 1 && param1 < this.S3_SOKUMEN)
            {
                if (gS3TokuchoFlg[3] == 1)
                {
                    _loc_2 = FS_POINT_COL_SELECTED;
                    this.canvasGraphics.lineStyle(1, _loc_2);
                    this.canvasGraphics.beginFill(_loc_2);
                    this.canvasGraphics.drawCircle(_loc_10[1].x, _loc_10[1].y, 4.5);
                    this.canvasGraphics.endFill();
                }
                else if ((gS3GPointColor[0] & 16777215) > 0)
                {
                    _loc_2 = gS3GPointColor[0];
                    this.canvasGraphics.lineStyle(1, _loc_2);
                    this.canvasGraphics.beginFill(_loc_2);
                    this.canvasGraphics.drawCircle(_loc_10[1].x, _loc_10[1].y, 4.5);
                    this.canvasGraphics.endFill();
                }
                else if (gS3ModelMode == 1 && gS3TokuchoFlg[4] != 1)
                {
                    if (this.gS3CutFlg[0] < 2 && this.dDrawFlg[0] == -1 || this.gS3CutFlg[0] == 2)
                    {
                        if (gS3GFaceVec[0] <= 0)
                        {
                            _loc_2 = 0;
                            if (dLineCol >= 0)
                            {
                                _loc_2 = dLineCol;
                            }
                        }
                        else
                        {
                            _loc_2 = 13882323;
                            if (dLineRevCol >= 0)
                            {
                                _loc_2 = dLineRevCol;
                            }
                        }
                        _loc_23 = 2.5;
                        if (dLineWid >= 0)
                        {
                            _loc_23 = dLineWid / 2;
                        }
                        this.canvasGraphics.lineStyle(1, _loc_2);
                        this.canvasGraphics.beginFill(_loc_2);
                        this.canvasGraphics.drawCircle(_loc_10[1].x, _loc_10[1].y, _loc_23);
                        this.canvasGraphics.endFill();
                    }
                }
                if (gS3RgnPoint[0].getSize() == 0)
                {
                    _loc_12[0].x = _loc_10[1].x - 5;
                    _loc_12[0].y = _loc_10[1].y - 5;
                    _loc_12[1].x = _loc_10[1].x + 5;
                    _loc_12[1].y = _loc_10[1].y - 5;
                    _loc_12[2].x = _loc_10[1].x + 5;
                    _loc_12[2].y = _loc_10[1].y + 5;
                    _loc_12[3].x = _loc_10[1].x - 5;
                    _loc_12[3].y = _loc_10[1].y + 5;
                    gS3RgnPoint[0].add(_loc_12, 4);
                }
            }
            return;
        }// end function

        private function cylinderGetSokumenBaseLine(param1:int) : Vector.<Point>
        {
            var _loc_2:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            _loc_2 = 0;
            while (_loc_2 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_2] == 2)
                {
                    _loc_4 = true;
                    _loc_3 = _loc_2;
                    break;
                }
                _loc_2++;
            }
            var _loc_5:* = new Vector.<Point>(0, false);
            var _loc_6:* = param1 - this.S3_SOKUMEN;
            if (_loc_4)
            {
                switch(gS3SolidNo)
                {
                    case 1:
                    {
                        if (_loc_6 == 0)
                        {
                            gPH3D.cv3d3d(this.dCPointCut[0][0], this.dCPointCut[0][1], this.dCPointCut[0][2]);
                            this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                            _loc_5.push(new Point(VewWinX, VewWinY));
                        }
                        break;
                    }
                    case 2:
                    {
                        if (_loc_6 == 0)
                        {
                            gPH3D.cv3d3d(this.dCPointCut[1][0], this.dCPointCut[1][1], this.dCPointCut[1][2]);
                            this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                            _loc_5.push(new Point(VewWinX, VewWinY));
                        }
                        else if (_loc_6 == 1)
                        {
                            gPH3D.cv3d3d(this.dCPointCut[0][0], this.dCPointCut[0][1], this.dCPointCut[0][2]);
                            this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                            _loc_5.push(new Point(VewWinX, VewWinY));
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_8:* = 0;
            while (_loc_8 < this.S3_SOKUMEN)
            {
                
                _loc_2 = _loc_8 + _loc_3;
                if (_loc_2 >= this.S3_SOKUMEN)
                {
                    _loc_2 = _loc_2 - this.S3_SOKUMEN;
                }
                else if (_loc_2 < 0)
                {
                    _loc_2 = _loc_2 + this.S3_SOKUMEN;
                }
                _loc_9 = gS3SFace[_loc_2][0];
                _loc_10 = 2;
                while (_loc_10 < _loc_9)
                {
                    
                    if (_loc_6 == 0 && _loc_10 == 2 || _loc_6 == 1 && _loc_10 == 3)
                    {
                        _loc_7 = gS3SFace[_loc_2][(_loc_10 + 1)];
                        gPH3D.cv3d3d(this.dCPoint1[_loc_7][0], this.dCPoint1[_loc_7][1], this.dCPoint1[_loc_7][2]);
                        this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                        _loc_5.push(new Point(VewWinX, VewWinY));
                    }
                    _loc_10++;
                }
                _loc_8++;
            }
            if (!_loc_4)
            {
                _loc_5.push(_loc_5[0].clone());
            }
            _loc_5.fixed = true;
            return _loc_5;
        }// end function

        protected function cylinderTenkai(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = NaN;
            if (param1 == 0)
            {
                this.cylinderTenkaiSokumen();
                return;
            }
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_8:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < _loc_8.length)
            {
                
                _loc_8[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            if (param1 == 1)
            {
                _loc_2 = this.S3_SOKUMEN;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN + _loc_4] == 0)
                    {
                        _loc_3 = this.S3_SOKUMEN + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            else
            {
                _loc_2 = this.S3_SOKUMEN + 1;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_4] == 0)
                    {
                        _loc_3 = this.S3_SOKUMEN * 2 + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            _loc_4 = 0;
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_5 = 0;
                while (_loc_5 < 3)
                {
                    
                    _loc_8[_loc_4][_loc_5] = this.dCPoint2[_loc_4][_loc_5];
                    _loc_5++;
                }
                _loc_4++;
            }
            _loc_7 = gS3SHouVec[_loc_6].x * gS3SHouVec[_loc_2].x;
            _loc_7 = _loc_7 + gS3SHouVec[_loc_6].y * gS3SHouVec[_loc_2].y;
            _loc_7 = _loc_7 + gS3SHouVec[_loc_6].z * gS3SHouVec[_loc_2].z;
            _loc_7 = Math.acos(_loc_7);
            _loc_4 = 1;
            dPauseValues = new Array();
            dPauseValues.push(_loc_2);
            dPauseValues.push(_loc_3);
            dPauseValues.push(_loc_4);
            dPauseValues.push(_loc_7);
            dPauseValues.push(_loc_8);
            dPauseFunction = this.cylinderTenkaiMove;
            dPauseNecessary = false;
            this.cylinderTenkaiMove();
            return;
        }// end function

        protected function cylinderTenkaiSokumen() : void
        {
            var _loc_1:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_7:* = new Vector.<Vector.<int>>(2, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_7.length)
            {
                
                _loc_7[_loc_1] = new Vector.<int>(21, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1] == 1)
                {
                    _loc_3 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            _loc_4 = 999;
            _loc_5 = 999;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 3)
                {
                    _loc_4 = _loc_1 + this.S3_SOKUMEN;
                }
                if (gS3SFaceCnt == this.S3_SOKUMEN + 2)
                {
                    if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 3)
                    {
                        _loc_5 = _loc_1 + this.S3_SOKUMEN * 2;
                    }
                }
                _loc_1++;
            }
            this.dBaseLine = (_loc_3 + this.S3_SOKUMEN / 2) % this.S3_SOKUMEN;
            _loc_1 = 0;
            while (_loc_1 <= this.S3_SOKUMEN)
            {
                
                _loc_7[0][_loc_1] = (_loc_3 + _loc_1) % this.S3_SOKUMEN;
                _loc_7[1][_loc_1] = (_loc_3 + this.S3_SOKUMEN - _loc_1) % this.S3_SOKUMEN;
                if (_loc_7[0][_loc_1] == this.dBaseLine)
                {
                    _loc_2 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            gS3GLineCut[_loc_3] = 2;
            _loc_1 = 0;
            while (_loc_1 < 2)
            {
                
                this.dCPointCut[_loc_1][0] = this.dCPoint1[gS3SLine[_loc_3][_loc_1]][0];
                this.dCPointCut[_loc_1][1] = this.dCPoint1[gS3SLine[_loc_3][_loc_1]][1];
                this.dCPointCut[_loc_1][2] = this.dCPoint1[gS3SLine[_loc_3][_loc_1]][2];
                _loc_1++;
            }
            _loc_6 = gS3SHouVec[0].x * gS3SHouVec[1].x;
            _loc_6 = _loc_6 + gS3SHouVec[0].y * gS3SHouVec[1].y;
            _loc_6 = _loc_6 + gS3SHouVec[0].z * gS3SHouVec[1].z;
            _loc_6 = Math.acos(_loc_6);
            _loc_1 = 0;
            dPauseValues = new Array();
            dPauseValues.push(_loc_1);
            dPauseValues.push(_loc_2);
            dPauseValues.push(_loc_3);
            dPauseValues.push(_loc_4);
            dPauseValues.push(_loc_5);
            dPauseValues.push(_loc_6);
            dPauseValues.push(_loc_7);
            dPauseFunction = this.cylinderTenkaiSokumenMove;
            dPauseNecessary = false;
            this.cylinderTenkaiSokumenMove();
            return;
        }// end function

        protected function cylinderTurn(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            if (param2 == 1)
            {
                _loc_7 = this.dCPoint1[gS3SLine[param1][1]][0];
                _loc_8 = this.dCPoint1[gS3SLine[param1][1]][1];
                _loc_9 = this.dCPoint1[gS3SLine[param1][1]][2];
                _loc_10 = this.dCPoint1[gS3SLine[param1][0]][0];
                _loc_11 = this.dCPoint1[gS3SLine[param1][0]][1];
                _loc_12 = this.dCPoint1[gS3SLine[param1][0]][2];
            }
            else
            {
                _loc_7 = this.dCPoint1[gS3SLine[param1][0]][0];
                _loc_8 = this.dCPoint1[gS3SLine[param1][0]][1];
                _loc_9 = this.dCPoint1[gS3SLine[param1][0]][2];
                _loc_10 = this.dCPoint1[gS3SLine[param1][1]][0];
                _loc_11 = this.dCPoint1[gS3SLine[param1][1]][1];
                _loc_12 = this.dCPoint1[gS3SLine[param1][1]][2];
            }
            if (_loc_7 == param3 && _loc_8 == param4 && _loc_9 == param5)
            {
                this.dTurnPoint.x = param3;
                this.dTurnPoint.y = param4;
                this.dTurnPoint.z = param5;
                return false;
            }
            if (_loc_10 == param3 && _loc_11 == param4 && _loc_12 == param5)
            {
                this.dTurnPoint.x = param3;
                this.dTurnPoint.y = param4;
                this.dTurnPoint.z = param5;
                return false;
            }
            _loc_13 = _loc_10 - _loc_7;
            _loc_14 = _loc_11 - _loc_8;
            _loc_15 = _loc_12 - _loc_9;
            if (_loc_13 == 0 && _loc_14 == 0 && _loc_15 == 0)
            {
                this.dTurnPoint.x = 0;
                this.dTurnPoint.y = 0;
                this.dTurnPoint.z = 0;
                return false;
            }
            _loc_21 = Math.sqrt(_loc_13 * _loc_13 + _loc_14 * _loc_14);
            if (_loc_21 == 0)
            {
                _loc_16 = 0;
            }
            else
            {
                _loc_16 = Math.acos((_loc_10 - _loc_7) / _loc_21);
                if (_loc_14 < 0)
                {
                    _loc_16 = 2 * Math.PI - _loc_16;
                }
            }
            _loc_22 = Math.sqrt(_loc_13 * _loc_13 + _loc_14 * _loc_14 + _loc_15 * _loc_15);
            _loc_17 = Math.acos(_loc_21 / _loc_22);
            if (_loc_15 < 0)
            {
                _loc_17 = 2 * Math.PI - _loc_17;
            }
            var _loc_26:* = Math.cos(_loc_16);
            var _loc_27:* = Math.sin(_loc_16);
            var _loc_28:* = Math.cos(_loc_17);
            var _loc_29:* = Math.sin(_loc_17);
            var _loc_30:* = Math.cos(param6);
            var _loc_31:* = Math.sin(param6);
            _loc_18 = ((param3 - _loc_7) * _loc_26 + (param4 - _loc_8) * _loc_27) * _loc_28 + (param5 - _loc_9) * _loc_29;
            _loc_19 = (-(param3 - _loc_7)) * _loc_27 + (param4 - _loc_8) * _loc_26;
            _loc_20 = (-((param3 - _loc_7) * _loc_26 + (param4 - _loc_8) * _loc_27)) * _loc_29 + (param5 - _loc_9) * _loc_28;
            _loc_23 = _loc_18;
            _loc_24 = _loc_19 * _loc_30 - _loc_20 * _loc_31;
            _loc_25 = _loc_19 * _loc_31 + _loc_20 * _loc_30;
            this.dTurnPoint.x = (_loc_23 * _loc_28 - _loc_25 * _loc_29) * _loc_26 - _loc_24 * _loc_27 + _loc_7;
            this.dTurnPoint.y = (_loc_23 * _loc_28 - _loc_25 * _loc_29) * _loc_27 + _loc_24 * _loc_26 + _loc_8;
            this.dTurnPoint.z = _loc_23 * _loc_29 + _loc_25 * _loc_28 + _loc_9;
            return true;
        }// end function

        protected function cylinderKumitate(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = NaN;
            if (param1 == 0)
            {
                this.cylinderKumitateSokumen();
                return;
            }
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_8:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < _loc_8.length)
            {
                
                _loc_8[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            if (param1 == 1)
            {
                _loc_2 = this.S3_SOKUMEN;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN + _loc_4] == 3)
                    {
                        _loc_3 = this.S3_SOKUMEN + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            else
            {
                _loc_2 = this.S3_SOKUMEN + 1;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_4] == 3)
                    {
                        _loc_3 = this.S3_SOKUMEN * 2 + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            _loc_4 = 0;
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_5 = 0;
                while (_loc_5 < 3)
                {
                    
                    _loc_8[_loc_4][_loc_5] = this.dCPoint2[_loc_4][_loc_5];
                    _loc_5++;
                }
                _loc_4++;
            }
            _loc_7 = gS3SHouVec[_loc_6].x * gS3SHouVec[_loc_2].x;
            _loc_7 = _loc_7 + gS3SHouVec[_loc_6].y * gS3SHouVec[_loc_2].y;
            _loc_7 = _loc_7 + gS3SHouVec[_loc_6].z * gS3SHouVec[_loc_2].z;
            _loc_7 = Math.acos(_loc_7);
            _loc_4 = 1;
            dPauseValues = new Array();
            dPauseValues.push(_loc_2);
            dPauseValues.push(_loc_3);
            dPauseValues.push(_loc_4);
            dPauseValues.push(_loc_7);
            dPauseValues.push(_loc_8);
            dPauseFunction = this.cylinderKumitateMove;
            dPauseNecessary = false;
            this.cylinderKumitateMove();
            return;
        }// end function

        protected function cylinderKumitateSokumen() : void
        {
            var _loc_1:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_7:* = new Vector.<Vector.<int>>(2, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_7.length)
            {
                
                _loc_7[_loc_1] = new Vector.<int>(21, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1] == 2)
                {
                    _loc_3 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            _loc_4 = 999;
            _loc_5 = 999;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 3)
                {
                    _loc_4 = _loc_1 + this.S3_SOKUMEN;
                }
                if (gS3SFaceCnt == this.S3_SOKUMEN + 2)
                {
                    if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 3)
                    {
                        _loc_5 = _loc_1 + this.S3_SOKUMEN * 2;
                    }
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= this.S3_SOKUMEN)
            {
                
                _loc_7[0][_loc_1] = (_loc_3 + _loc_1) % this.S3_SOKUMEN;
                _loc_7[1][_loc_1] = (_loc_3 + this.S3_SOKUMEN - _loc_1) % this.S3_SOKUMEN;
                if (_loc_7[0][_loc_1] == this.dBaseLine)
                {
                    _loc_2 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            _loc_6 = gS3SHouVec[0].x * gS3SHouVec[1].x;
            _loc_6 = _loc_6 + gS3SHouVec[0].y * gS3SHouVec[1].y;
            _loc_6 = _loc_6 + gS3SHouVec[0].z * gS3SHouVec[1].z;
            _loc_6 = Math.acos(_loc_6);
            _loc_1 = _loc_2 - 1;
            dPauseValues = new Array();
            dPauseValues.push(_loc_1);
            dPauseValues.push(_loc_2);
            dPauseValues.push(_loc_4);
            dPauseValues.push(_loc_5);
            dPauseValues.push(_loc_6);
            dPauseValues.push(_loc_7);
            dPauseFunction = this.cylinderKumitateSokumenMove;
            dPauseNecessary = false;
            this.cylinderKumitateSokumenMove();
            return;
        }// end function

        protected function cylinderSaiTenkai(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_11:* = NaN;
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            if (param1 == 1)
            {
                _loc_2 = this.S3_SOKUMEN;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN + _loc_4] == 3)
                    {
                        _loc_3 = this.S3_SOKUMEN + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            else
            {
                _loc_2 = this.S3_SOKUMEN + 1;
                _loc_4 = 0;
                while (_loc_4 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_4] == 3)
                    {
                        _loc_3 = this.S3_SOKUMEN * 2 + _loc_4;
                        _loc_6 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
            }
            _loc_11 = gS3SHouVec[_loc_6].x * gS3SHouVec[_loc_2].x;
            _loc_11 = _loc_11 + gS3SHouVec[_loc_6].y * gS3SHouVec[_loc_2].y;
            _loc_11 = _loc_11 + gS3SHouVec[_loc_6].z * gS3SHouVec[_loc_2].z;
            _loc_11 = Math.acos(_loc_11);
            _loc_7 = gS3SFace[_loc_2][0];
            _loc_8 = gS3SFace[_loc_2][1];
            _loc_5 = _loc_8;
            while (_loc_5 < _loc_8 + _loc_7)
            {
                
                if (_loc_3 > this.S3_SOKUMEN * 2 - 1)
                {
                    _loc_9 = 1;
                }
                else
                {
                    _loc_9 = 0;
                }
                _loc_10 = this.cylinderTurn(_loc_3, _loc_9, this.dCPoint2[_loc_5][0], this.dCPoint2[_loc_5][1], this.dCPoint2[_loc_5][2], -_loc_11);
                if (_loc_10 == true)
                {
                    this.dCPoint2[_loc_5][0] = this.dTurnPoint.x;
                    this.dCPoint2[_loc_5][1] = this.dTurnPoint.y;
                    this.dCPoint2[_loc_5][2] = this.dTurnPoint.z;
                }
                _loc_5++;
            }
            return;
        }// end function

        protected function cylinderSaiTenkaiSokumen() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_13:* = 0;
            var _loc_16:* = new Vector.<Vector.<int>>(2, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_16.length)
            {
                
                _loc_16[_loc_1] = new Vector.<int>(this.S3_SOKUMEN, true);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1] == 2)
                {
                    _loc_6 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            _loc_7 = 999;
            _loc_8 = 999;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 3)
                {
                    _loc_7 = _loc_1 + this.S3_SOKUMEN;
                }
                if (gS3SFaceCnt == this.S3_SOKUMEN + 2)
                {
                    if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 0 || gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 3)
                    {
                        _loc_8 = _loc_1 + this.S3_SOKUMEN * 2;
                    }
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                _loc_16[0][_loc_1] = (_loc_6 + _loc_1) % this.S3_SOKUMEN;
                _loc_16[1][_loc_1] = (_loc_6 + this.S3_SOKUMEN - _loc_1) % this.S3_SOKUMEN;
                if (_loc_16[0][_loc_1] == this.dBaseLine)
                {
                    _loc_4 = _loc_1;
                    break;
                }
                _loc_1++;
            }
            gS3GLineCut[_loc_6] = 2;
            _loc_1 = 0;
            while (_loc_1 < 2)
            {
                
                this.dCPointCut[_loc_1][0] = this.dCPoint1[gS3SLine[_loc_6][_loc_1]][0];
                this.dCPointCut[_loc_1][1] = this.dCPoint1[gS3SLine[_loc_6][_loc_1]][1];
                this.dCPointCut[_loc_1][2] = this.dCPoint1[gS3SLine[_loc_6][_loc_1]][2];
                _loc_1++;
            }
            _loc_10 = gS3SHouVec[0].x * gS3SHouVec[1].x;
            _loc_10 = _loc_10 + gS3SHouVec[0].y * gS3SHouVec[1].y;
            _loc_10 = _loc_10 + gS3SHouVec[0].z * gS3SHouVec[1].z;
            _loc_10 = Math.acos(_loc_10);
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                _loc_5 = 0;
                while (_loc_5 < 2)
                {
                    
                    if (_loc_5 == 1 && _loc_1 == (_loc_4 - 1))
                    {
                        break;
                    }
                    _loc_15 = _loc_16[_loc_5][(_loc_1 + 1)];
                    _loc_2 = 0;
                    while (_loc_2 <= _loc_1)
                    {
                        
                        _loc_3 = 0;
                        while (_loc_3 < 2)
                        {
                            
                            if (_loc_2 == 0 && _loc_5 == 0)
                            {
                                _loc_9 = this.cylinderTurn(_loc_15, _loc_5, this.dCPointCut[_loc_3][0], this.dCPointCut[_loc_3][1], this.dCPointCut[_loc_3][2], _loc_10);
                                if (_loc_9 == true)
                                {
                                    this.dCPointCut[_loc_3][0] = this.dTurnPoint.x;
                                    this.dCPointCut[_loc_3][1] = this.dTurnPoint.y;
                                    this.dCPointCut[_loc_3][2] = this.dTurnPoint.z;
                                }
                            }
                            else
                            {
                                _loc_9 = this.cylinderTurn(_loc_15, _loc_5, this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][0], this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][1], this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][2], _loc_10);
                                if (_loc_9 == true)
                                {
                                    this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][0] = this.dTurnPoint.x;
                                    this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][1] = this.dTurnPoint.y;
                                    this.dCPoint1[gS3SLine[_loc_16[_loc_5][_loc_2]][_loc_3]][2] = this.dTurnPoint.z;
                                }
                            }
                            _loc_3++;
                        }
                        if (_loc_5 == 0)
                        {
                            _loc_13 = _loc_16[_loc_5][_loc_2];
                        }
                        else
                        {
                            _loc_13 = (_loc_16[_loc_5][_loc_2] + this.S3_SOKUMEN - 1) % this.S3_SOKUMEN;
                        }
                        if (_loc_7 == _loc_13 + this.S3_SOKUMEN)
                        {
                            _loc_14 = this.S3_SOKUMEN;
                            _loc_11 = gS3SFace[_loc_14][0];
                            _loc_12 = gS3SFace[_loc_14][1];
                            _loc_3 = _loc_12;
                            while (_loc_3 < _loc_12 + _loc_11)
                            {
                                
                                _loc_9 = this.cylinderTurn(_loc_15, _loc_5, this.dCPoint2[_loc_3][0], this.dCPoint2[_loc_3][1], this.dCPoint2[_loc_3][2], _loc_10);
                                if (_loc_9 == true)
                                {
                                    this.dCPoint2[_loc_3][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_3][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_3][2] = this.dTurnPoint.z;
                                }
                                _loc_3++;
                            }
                        }
                        if (_loc_8 == _loc_13 + this.S3_SOKUMEN * 2)
                        {
                            _loc_14 = this.S3_SOKUMEN + 1;
                            _loc_11 = gS3SFace[_loc_14][0];
                            _loc_12 = gS3SFace[_loc_14][1];
                            _loc_3 = _loc_12;
                            while (_loc_3 < _loc_12 + _loc_11)
                            {
                                
                                _loc_9 = this.cylinderTurn(_loc_15, _loc_5, this.dCPoint2[_loc_3][0], this.dCPoint2[_loc_3][1], this.dCPoint2[_loc_3][2], _loc_10);
                                if (_loc_9 == true)
                                {
                                    this.dCPoint2[_loc_3][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_3][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_3][2] = this.dTurnPoint.z;
                                }
                                _loc_3++;
                            }
                        }
                        _loc_2++;
                    }
                    _loc_5++;
                }
                _loc_1++;
            }
            return;
        }// end function

        protected function cylinderIdou1() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_6.length)
            {
                
                _loc_6[_loc_1] = new Vector.<Number>(3, true);
                _loc_1++;
            }
            _loc_4 = gS3GPoint[1][1] - gS3GPoint[0][1];
            _loc_5 = gS3GPoint[1][2] - gS3GPoint[0][2];
            if (_loc_4 == 0)
            {
                if (_loc_5 > 0)
                {
                    _loc_2 = Math.PI / 2;
                }
                else
                {
                    _loc_2 = (-Math.PI) / 2;
                }
            }
            else
            {
                _loc_2 = Math.atan(_loc_5 / _loc_4);
                if (_loc_2 < 0 && _loc_4 < 0)
                {
                    _loc_2 = _loc_2 + Math.PI;
                }
                else if (_loc_2 > 0 && _loc_4 < 0)
                {
                    _loc_2 = _loc_2 - Math.PI;
                }
            }
            _loc_1 = 0;
            while (_loc_1 < gS3SPointCnt)
            {
                
                _loc_6[_loc_1][0] = gS3GPoint[_loc_1][0];
                _loc_6[_loc_1][1] = gS3GPoint[_loc_1][1];
                _loc_6[_loc_1][2] = gS3GPoint[_loc_1][2];
                _loc_1++;
            }
            _loc_3 = 0;
            dPauseValues = new Array();
            if (dPauseEventCode != "")
            {
                dPauseValues.push(dPauseEventCode);
                dPauseValues.push(dPauseResult);
            }
            else
            {
                dPauseValues.push("");
                dPauseValues.push(int.MIN_VALUE);
            }
            dPauseValues.push(_loc_2);
            dPauseValues.push(_loc_3);
            dPauseValues.push(_loc_6);
            dPauseNecessary = true;
            dPauseFunction = this.cylinderIdou1Move;
            this.cylinderIdou1Move();
            return;
        }// end function

        protected function cylinderIdou2() : void
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
            var _loc_16:* = NaN;
            var _loc_1:* = new Vector3D();
            var _loc_2:* = new Vector3D();
            var _loc_3:* = 0;
            var _loc_17:* = new Vector.<Number>(4, true);
            var _loc_18:* = new Vector.<Number>(4, true);
            var _loc_19:* = new Vector.<Number>(4, true);
            var _loc_20:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            var _loc_21:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_20[_loc_4] = new Vector.<Number>(3, true);
                _loc_21[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            var _loc_22:* = new Vector.<Vector.<Number>>(2, true);
            _loc_4 = 0;
            while (_loc_4 < _loc_22.length)
            {
                
                _loc_22[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < gS3SFaceCnt)
            {
                
                if (gS3GFaceMove[_loc_4] == 0)
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 3)
            {
                
                _loc_17[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][0];
                _loc_18[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][1];
                _loc_19[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][2];
                _loc_4++;
            }
            gPH3D.vrtVec(3, _loc_17, _loc_18, _loc_19);
            _loc_1.x = gPH3D.dX;
            _loc_1.y = gPH3D.dY;
            _loc_1.z = gPH3D.dZ;
            _loc_2.x = 1;
            _loc_2.y = 0;
            _loc_2.z = 0;
            _loc_12 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y);
            if (_loc_12 == 0)
            {
                _loc_5 = 0;
            }
            else
            {
                _loc_5 = Math.acos(_loc_1.x / _loc_12);
                if (_loc_1.y < 0)
                {
                    _loc_5 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_13 = Math.sqrt(_loc_1.x * _loc_1.x + _loc_1.y * _loc_1.y + _loc_1.z * _loc_1.z);
            _loc_6 = Math.acos(_loc_12 / _loc_13);
            if (_loc_1.z < 0)
            {
                _loc_6 = 2 * Math.PI - _loc_6;
            }
            _loc_12 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y);
            if (_loc_12 == 0)
            {
                _loc_7 = 0;
            }
            else
            {
                _loc_7 = Math.acos(_loc_2.x / _loc_12);
                if (_loc_2.y < 0)
                {
                    _loc_7 = 2 * Math.PI - _loc_5;
                }
            }
            _loc_13 = Math.sqrt(_loc_2.x * _loc_2.x + _loc_2.y * _loc_2.y + _loc_2.z * _loc_2.z);
            _loc_8 = Math.acos(_loc_12 / _loc_13);
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
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_20[_loc_4][0] = this.dCPoint1[_loc_4][0];
                _loc_20[_loc_4][1] = this.dCPoint1[_loc_4][1];
                _loc_20[_loc_4][2] = this.dCPoint1[_loc_4][2];
                _loc_21[_loc_4][0] = this.dCPoint2[_loc_4][0];
                _loc_21[_loc_4][1] = this.dCPoint2[_loc_4][1];
                _loc_21[_loc_4][2] = this.dCPoint2[_loc_4][2];
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_22[_loc_4][0] = this.dCPointCut[_loc_4][0];
                _loc_22[_loc_4][1] = this.dCPointCut[_loc_4][1];
                _loc_22[_loc_4][2] = this.dCPointCut[_loc_4][2];
                _loc_4++;
            }
            _loc_5 = 0;
            _loc_6 = 0;
            dPauseValues = new Array();
            if (dPauseEventCode != "")
            {
                dPauseValues.push(dPauseEventCode);
                dPauseValues.push(dPauseResult);
            }
            else
            {
                dPauseValues.push("");
                dPauseValues.push(int.MIN_VALUE);
            }
            dPauseValues.push(_loc_5);
            dPauseValues.push(_loc_6);
            dPauseValues.push(_loc_9);
            dPauseValues.push(_loc_10);
            dPauseValues.push(_loc_20);
            dPauseValues.push(_loc_21);
            dPauseValues.push(_loc_22);
            dPauseNecessary = true;
            dPauseFunction = this.cylinderIdou2Move;
            this.cylinderIdou2Move();
            return;
        }// end function

        protected function cylinderIdou3() : void
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
            var _loc_19:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            var _loc_20:* = new Vector.<Vector.<Number>>(gS3SPointCnt, true);
            _loc_4 = 0;
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_19[_loc_4] = new Vector.<Number>(3, true);
                _loc_20[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            var _loc_21:* = new Vector.<Vector.<Number>>(2, true);
            _loc_4 = 0;
            while (_loc_4 < _loc_21.length)
            {
                
                _loc_21[_loc_4] = new Vector.<Number>(3, true);
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < gS3SFaceCnt)
            {
                
                if (gS3GFaceMove[_loc_4] == 0)
                {
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 3)
            {
                
                _loc_16[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][0];
                _loc_17[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][1];
                _loc_18[_loc_4] = this.dCPoint1[gS3SFace[_loc_3][(_loc_4 + 1)]][2];
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
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_19[_loc_4][0] = this.dCPoint1[_loc_4][0];
                _loc_19[_loc_4][1] = this.dCPoint1[_loc_4][1];
                _loc_19[_loc_4][2] = this.dCPoint1[_loc_4][2];
                _loc_20[_loc_4][0] = this.dCPoint2[_loc_4][0];
                _loc_20[_loc_4][1] = this.dCPoint2[_loc_4][1];
                _loc_20[_loc_4][2] = this.dCPoint2[_loc_4][2];
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_21[_loc_4][0] = this.dCPointCut[_loc_4][0];
                _loc_21[_loc_4][1] = this.dCPointCut[_loc_4][1];
                _loc_21[_loc_4][2] = this.dCPointCut[_loc_4][2];
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < gS3SPointCnt)
            {
                
                _loc_13 = _loc_19[_loc_4][0];
                _loc_14 = _loc_19[_loc_4][1];
                _loc_15 = _loc_19[_loc_4][2];
                gPH3D.zRevolv3D(_loc_13, _loc_14, _loc_15, _loc_9 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_10 * 180 / Math.PI);
                this.dCPoint1[_loc_4][0] = gPH3D.dX;
                this.dCPoint1[_loc_4][1] = gPH3D.dY;
                this.dCPoint1[_loc_4][2] = gPH3D.dZ;
                _loc_13 = _loc_20[_loc_4][0];
                _loc_14 = _loc_20[_loc_4][1];
                _loc_15 = _loc_20[_loc_4][2];
                gPH3D.zRevolv3D(_loc_13, _loc_14, _loc_15, _loc_9 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_10 * 180 / Math.PI);
                this.dCPoint2[_loc_4][0] = gPH3D.dX;
                this.dCPoint2[_loc_4][1] = gPH3D.dY;
                this.dCPoint2[_loc_4][2] = gPH3D.dZ;
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 2)
            {
                
                _loc_13 = _loc_21[_loc_4][0];
                _loc_14 = _loc_21[_loc_4][1];
                _loc_15 = _loc_21[_loc_4][2];
                gPH3D.zRevolv3D(_loc_13, _loc_14, _loc_15, _loc_9 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_10 * 180 / Math.PI);
                this.dCPointCut[_loc_4][0] = gPH3D.dX;
                this.dCPointCut[_loc_4][1] = gPH3D.dY;
                this.dCPointCut[_loc_4][2] = gPH3D.dZ;
                _loc_4++;
            }
            return;
        }// end function

        protected function cylinderGetFacePosition(param1:int, param2:Vector.<Point>) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = gS3SFace[param1][0];
            if (param1 < this.S3_SOKUMEN)
            {
                _loc_4 = 0;
                while (_loc_4 <= (_loc_5 - 1))
                {
                    
                    _loc_3 = gS3SFace[param1][(_loc_4 + 1)];
                    if (gS3GLineCut[param1] == 2 && _loc_4 < 2)
                    {
                        gPH3D.cv3d3d(this.dCPointCut[_loc_4][0], this.dCPointCut[_loc_4][1], this.dCPointCut[_loc_4][2]);
                    }
                    else
                    {
                        gPH3D.cv3d3d(this.dCPoint1[_loc_3][0], this.dCPoint1[_loc_3][1], this.dCPoint1[_loc_3][2]);
                    }
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    param2[_loc_4] = new Point(VewWinX, VewWinY);
                    _loc_4++;
                }
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 <= (_loc_5 - 1))
                {
                    
                    _loc_3 = gS3SFace[param1][1] + _loc_4;
                    gPH3D.cv3d3d(this.dCPoint2[_loc_3][0], this.dCPoint2[_loc_3][1], this.dCPoint2[_loc_3][2]);
                    this.changeViewWindow(gPH3D.dY, gPH3D.dZ);
                    param2[_loc_4] = new Point(VewWinX, VewWinY);
                    _loc_4++;
                }
            }
            return _loc_5;
        }// end function

        private function cylinderTenkaiMove() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_1:* = int(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = int(dPauseValues.shift());
            var _loc_4:* = Number(dPauseValues.shift());
            var _loc_5:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
            if (_loc_3 < 5)
            {
                _loc_6 = 0;
                while (_loc_6 < gS3SPointCnt)
                {
                    
                    this.dCPoint2[_loc_6][0] = _loc_5[_loc_6][0];
                    this.dCPoint2[_loc_6][1] = _loc_5[_loc_6][1];
                    this.dCPoint2[_loc_6][2] = _loc_5[_loc_6][2];
                    _loc_6++;
                }
                _loc_7 = gS3SFace[_loc_1][0];
                _loc_8 = gS3SFace[_loc_1][1];
                _loc_6 = _loc_8;
                while (_loc_6 < _loc_8 + _loc_7)
                {
                    
                    if (_loc_2 > this.S3_SOKUMEN * 2 - 1)
                    {
                        _loc_9 = 1;
                    }
                    else
                    {
                        _loc_9 = 0;
                    }
                    _loc_10 = this.cylinderTurn(_loc_2, _loc_9, this.dCPoint2[_loc_6][0], this.dCPoint2[_loc_6][1], this.dCPoint2[_loc_6][2], -_loc_4 * _loc_3 / 4);
                    if (_loc_10 == true)
                    {
                        this.dCPoint2[_loc_6][0] = this.dTurnPoint.x;
                        this.dCPoint2[_loc_6][1] = this.dTurnPoint.y;
                        this.dCPoint2[_loc_6][2] = this.dTurnPoint.z;
                    }
                    _loc_6++;
                }
                (gS3GFaceMove[_loc_1] + 1);
                this.cylinderDisplay3D();
                this.pause(PAUSE_TENKAI);
                _loc_3++;
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseEventCode = "";
                this.pause(PAUSE_TENKAI);
                return;
            }
            dPauseEventCode = StageEvent.C3D_TENKAI_END;
            dPauseFunction = null;
            dPauseValues = null;
            dPauseResult = int.MIN_VALUE;
            if (_loc_1 == this.S3_SOKUMEN)
            {
                _loc_3 = 0;
                while (_loc_3 < this.S3_SOKUMEN)
                {
                    
                    gS3GLineCut[this.S3_SOKUMEN + _loc_3] = 2;
                    _loc_3++;
                }
                this.gS3CutFlg[1] = 2;
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.S3_SOKUMEN)
                {
                    
                    gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_3] = 2;
                    _loc_3++;
                }
                this.gS3CutFlg[2] = 2;
            }
            gS3GLineCut[_loc_2] = 3;
            this.cylinderDisplay3D();
            if (gS3SolidNo == 1 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 || gS3SolidNo == 2 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 && this.gS3CutFlg[2] == 2)
            {
                if (this.isTenkaiMoveFront)
                {
                    this.cylinderIdou2();
                }
            }
            return;
        }// end function

        private function cylinderTenkaiSokumenMove() : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_1:* = int(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = int(dPauseValues.shift());
            var _loc_4:* = int(dPauseValues.shift());
            var _loc_5:* = int(dPauseValues.shift());
            var _loc_6:* = Number(dPauseValues.shift());
            var _loc_7:* = this.Vector.<Vector.<int>>(dPauseValues.shift());
            if (_loc_1 < _loc_2)
            {
                _loc_10 = 0;
                while (_loc_10 < 2)
                {
                    
                    if (_loc_10 == 1 && _loc_1 == (_loc_2 - 1))
                    {
                        break;
                    }
                    _loc_16 = _loc_7[_loc_10][(_loc_1 + 1)];
                    _loc_8 = 0;
                    while (_loc_8 <= _loc_1)
                    {
                        
                        _loc_9 = 0;
                        while (_loc_9 < 2)
                        {
                            
                            if (_loc_8 == 0 && _loc_10 == 0)
                            {
                                _loc_11 = this.cylinderTurn(_loc_16, _loc_10, this.dCPointCut[_loc_9][0], this.dCPointCut[_loc_9][1], this.dCPointCut[_loc_9][2], _loc_6);
                                if (_loc_11 == true)
                                {
                                    this.dCPointCut[_loc_9][0] = this.dTurnPoint.x;
                                    this.dCPointCut[_loc_9][1] = this.dTurnPoint.y;
                                    this.dCPointCut[_loc_9][2] = this.dTurnPoint.z;
                                }
                            }
                            else
                            {
                                _loc_11 = this.cylinderTurn(_loc_16, _loc_10, this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][0], this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][1], this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][2], _loc_6);
                                if (_loc_11 == true)
                                {
                                    this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][0] = this.dTurnPoint.x;
                                    this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][1] = this.dTurnPoint.y;
                                    this.dCPoint1[gS3SLine[_loc_7[_loc_10][_loc_8]][_loc_9]][2] = this.dTurnPoint.z;
                                }
                            }
                            _loc_9++;
                        }
                        if (_loc_10 == 0)
                        {
                            _loc_14 = _loc_7[_loc_10][_loc_8];
                        }
                        else
                        {
                            _loc_14 = (_loc_7[_loc_10][_loc_8] + this.S3_SOKUMEN - 1) % this.S3_SOKUMEN;
                        }
                        (gS3GFaceMove[_loc_14] + 1);
                        if (_loc_4 == _loc_14 + this.S3_SOKUMEN)
                        {
                            _loc_15 = this.S3_SOKUMEN;
                            _loc_12 = gS3SFace[_loc_15][0];
                            _loc_13 = gS3SFace[_loc_15][1];
                            _loc_9 = _loc_13;
                            while (_loc_9 < _loc_13 + _loc_12)
                            {
                                
                                _loc_11 = this.cylinderTurn(_loc_16, _loc_10, this.dCPoint2[_loc_9][0], this.dCPoint2[_loc_9][1], this.dCPoint2[_loc_9][2], _loc_6);
                                if (_loc_11 == true)
                                {
                                    this.dCPoint2[_loc_9][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_9][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_9][2] = this.dTurnPoint.z;
                                }
                                _loc_9++;
                            }
                            (gS3GFaceMove[_loc_15] + 1);
                        }
                        if (_loc_5 == _loc_14 + this.S3_SOKUMEN * 2)
                        {
                            _loc_15 = this.S3_SOKUMEN + 1;
                            _loc_12 = gS3SFace[_loc_15][0];
                            _loc_13 = gS3SFace[_loc_15][1];
                            _loc_9 = _loc_13;
                            while (_loc_9 < _loc_13 + _loc_12)
                            {
                                
                                _loc_11 = this.cylinderTurn(_loc_16, _loc_10, this.dCPoint2[_loc_9][0], this.dCPoint2[_loc_9][1], this.dCPoint2[_loc_9][2], _loc_6);
                                if (_loc_11 == true)
                                {
                                    this.dCPoint2[_loc_9][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_9][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_9][2] = this.dTurnPoint.z;
                                }
                                _loc_9++;
                            }
                            (gS3GFaceMove[_loc_15] + 1);
                        }
                        _loc_8++;
                    }
                    _loc_10++;
                }
                this.cylinderDisplay3D();
                _loc_1++;
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseValues.push(_loc_6);
                dPauseValues.push(_loc_7);
                dPauseEventCode = "";
                this.pause(PAUSE_TENKAI);
                return;
            }
            dPauseEventCode = StageEvent.C3D_TENKAI_END;
            dPauseFunction = null;
            dPauseValues = null;
            dPauseResult = int.MIN_VALUE;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (_loc_1 == _loc_3)
                {
                    gS3GLineCut[_loc_1] = 2;
                }
                else
                {
                    gS3GLineCut[_loc_1] = 3;
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN] == 1)
                {
                    gS3GLineCut[_loc_1 + this.S3_SOKUMEN] = 2;
                }
                if (gS3SolidNo == 2)
                {
                    if (gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] == 1)
                    {
                        gS3GLineCut[_loc_1 + this.S3_SOKUMEN * 2] = 2;
                    }
                }
                _loc_1++;
            }
            this.gS3CutFlg[0] = 2;
            this.cylinderDisplay3D();
            if (gS3SolidNo == 1 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 || gS3SolidNo == 2 && this.gS3CutFlg[0] == 2 && this.gS3CutFlg[1] == 2 && this.gS3CutFlg[2] == 2)
            {
                if (this.isTenkaiMoveFront)
                {
                    this.cylinderIdou2();
                }
            }
            return;
        }// end function

        private function cylinderKumitateMove() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_1:* = int(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = int(dPauseValues.shift());
            var _loc_4:* = Number(dPauseValues.shift());
            var _loc_5:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
            if (_loc_3 < 5)
            {
                _loc_6 = 0;
                while (_loc_6 < gS3SPointCnt)
                {
                    
                    this.dCPoint2[_loc_6][0] = _loc_5[_loc_6][0];
                    this.dCPoint2[_loc_6][1] = _loc_5[_loc_6][1];
                    this.dCPoint2[_loc_6][2] = _loc_5[_loc_6][2];
                    _loc_6++;
                }
                _loc_7 = gS3SFace[_loc_1][0];
                _loc_8 = gS3SFace[_loc_1][1];
                _loc_6 = _loc_8;
                while (_loc_6 < _loc_8 + _loc_7)
                {
                    
                    if (_loc_2 > this.S3_SOKUMEN * 2 - 1)
                    {
                        _loc_9 = 1;
                    }
                    else
                    {
                        _loc_9 = 0;
                    }
                    _loc_10 = this.cylinderTurn(_loc_2, _loc_9, this.dCPoint2[_loc_6][0], this.dCPoint2[_loc_6][1], this.dCPoint2[_loc_6][2], _loc_4 * _loc_3 / 4);
                    if (_loc_10 == true)
                    {
                        this.dCPoint2[_loc_6][0] = this.dTurnPoint.x;
                        this.dCPoint2[_loc_6][1] = this.dTurnPoint.y;
                        this.dCPoint2[_loc_6][2] = this.dTurnPoint.z;
                    }
                    _loc_6++;
                }
                (gS3GFaceMove[_loc_1] - 1);
                this.cylinderDisplay3D();
                _loc_3++;
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseEventCode = "";
                this.pause(PAUSE_TENKAI);
                return;
            }
            dPauseEventCode = StageEvent.C3D_KUMITATE_END;
            dPauseFunction = null;
            dPauseValues = null;
            dPauseResult = int.MIN_VALUE;
            if (_loc_1 == this.S3_SOKUMEN)
            {
                if (this.gS3CutFlg[0] < 2)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this.S3_SOKUMEN)
                    {
                        
                        gS3GLineCut[this.S3_SOKUMEN + _loc_3] = 1;
                        this.dCPoint2[_loc_3][0] = this.dCPoint1[_loc_3][0];
                        this.dCPoint2[_loc_3][1] = this.dCPoint1[_loc_3][1];
                        this.dCPoint2[_loc_3][2] = this.dCPoint1[_loc_3][2];
                        _loc_3++;
                    }
                    this.gS3CutFlg[1] = 1;
                }
                else
                {
                    this.gS3CutFlg[1] = 1;
                }
            }
            else if (this.gS3CutFlg[0] < 2)
            {
                _loc_3 = 0;
                while (_loc_3 < this.S3_SOKUMEN)
                {
                    
                    gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_3] = 1;
                    this.dCPoint2[_loc_3 + this.S3_SOKUMEN][0] = this.dCPoint1[_loc_3 + this.S3_SOKUMEN][0];
                    this.dCPoint2[_loc_3 + this.S3_SOKUMEN][1] = this.dCPoint1[_loc_3 + this.S3_SOKUMEN][1];
                    this.dCPoint2[_loc_3 + this.S3_SOKUMEN][2] = this.dCPoint1[_loc_3 + this.S3_SOKUMEN][2];
                    _loc_3++;
                }
                this.gS3CutFlg[2] = 1;
            }
            else
            {
                this.gS3CutFlg[2] = 1;
            }
            gS3GLineCut[_loc_2] = 0;
            this.cylinderDisplay3D();
            return;
        }// end function

        private function cylinderKumitateSokumenMove() : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_1:* = int(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = int(dPauseValues.shift());
            var _loc_4:* = int(dPauseValues.shift());
            var _loc_5:* = Number(dPauseValues.shift());
            var _loc_6:* = this.Vector.<Vector.<int>>(dPauseValues.shift());
            if (_loc_1 >= 0)
            {
                _loc_9 = 0;
                while (_loc_9 < 2)
                {
                    
                    if (_loc_9 == 1 && _loc_1 == (_loc_2 - 1))
                    {
                        break;
                    }
                    _loc_15 = _loc_6[_loc_9][(_loc_1 + 1)];
                    _loc_7 = 0;
                    while (_loc_7 <= _loc_1)
                    {
                        
                        _loc_8 = 0;
                        while (_loc_8 < 2)
                        {
                            
                            if (_loc_7 == 0 && _loc_9 == 0)
                            {
                                _loc_10 = this.cylinderTurn(_loc_15, _loc_9, this.dCPointCut[_loc_8][0], this.dCPointCut[_loc_8][1], this.dCPointCut[_loc_8][2], -_loc_5);
                                if (_loc_10 == true)
                                {
                                    this.dCPointCut[_loc_8][0] = this.dTurnPoint.x;
                                    this.dCPointCut[_loc_8][1] = this.dTurnPoint.y;
                                    this.dCPointCut[_loc_8][2] = this.dTurnPoint.z;
                                }
                            }
                            else
                            {
                                _loc_10 = this.cylinderTurn(_loc_15, _loc_9, this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][0], this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][1], this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][2], -_loc_5);
                                if (_loc_10 == true)
                                {
                                    this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][0] = this.dTurnPoint.x;
                                    this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][1] = this.dTurnPoint.y;
                                    this.dCPoint1[gS3SLine[_loc_6[_loc_9][_loc_7]][_loc_8]][2] = this.dTurnPoint.z;
                                }
                            }
                            _loc_8++;
                        }
                        if (_loc_9 == 0)
                        {
                            _loc_13 = _loc_6[_loc_9][_loc_7];
                        }
                        else
                        {
                            _loc_13 = (_loc_6[_loc_9][_loc_7] + this.S3_SOKUMEN - 1) % this.S3_SOKUMEN;
                        }
                        (gS3GFaceMove[_loc_13] - 1);
                        if (_loc_3 == _loc_13 + this.S3_SOKUMEN)
                        {
                            _loc_14 = this.S3_SOKUMEN;
                            _loc_11 = gS3SFace[_loc_14][0];
                            _loc_12 = gS3SFace[_loc_14][1];
                            _loc_8 = _loc_12;
                            while (_loc_8 < _loc_12 + _loc_11)
                            {
                                
                                _loc_10 = this.cylinderTurn(_loc_15, _loc_9, this.dCPoint2[_loc_8][0], this.dCPoint2[_loc_8][1], this.dCPoint2[_loc_8][2], -_loc_5);
                                if (_loc_10 == true)
                                {
                                    this.dCPoint2[_loc_8][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_8][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_8][2] = this.dTurnPoint.z;
                                }
                                _loc_8++;
                            }
                            (gS3GFaceMove[_loc_14] - 1);
                        }
                        if (_loc_4 == _loc_13 + this.S3_SOKUMEN * 2)
                        {
                            _loc_14 = this.S3_SOKUMEN + 1;
                            _loc_11 = gS3SFace[_loc_14][0];
                            _loc_12 = gS3SFace[_loc_14][1];
                            _loc_8 = _loc_12;
                            while (_loc_8 < _loc_12 + _loc_11)
                            {
                                
                                _loc_10 = this.cylinderTurn(_loc_15, _loc_9, this.dCPoint2[_loc_8][0], this.dCPoint2[_loc_8][1], this.dCPoint2[_loc_8][2], -_loc_5);
                                if (_loc_10 == true)
                                {
                                    this.dCPoint2[_loc_8][0] = this.dTurnPoint.x;
                                    this.dCPoint2[_loc_8][1] = this.dTurnPoint.y;
                                    this.dCPoint2[_loc_8][2] = this.dTurnPoint.z;
                                }
                                _loc_8++;
                            }
                            (gS3GFaceMove[_loc_14] - 1);
                        }
                        _loc_7++;
                    }
                    _loc_9++;
                }
                this.cylinderDisplay3D();
                _loc_1 = _loc_1 - 1;
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseValues.push(_loc_6);
                dPauseEventCode = "";
                this.pause(PAUSE_TENKAI);
                return;
            }
            dPauseEventCode = StageEvent.C3D_KUMITATE_END;
            dPauseFunction = null;
            dPauseValues = null;
            dPauseResult = int.MIN_VALUE;
            _loc_1 = 0;
            while (_loc_1 < this.S3_SOKUMEN)
            {
                
                if (gS3GLineCut[_loc_1] == 2)
                {
                    gS3GLineCut[_loc_1] = 1;
                }
                else
                {
                    gS3GLineCut[_loc_1] = 0;
                }
                _loc_1++;
            }
            this.gS3CutFlg[0] = 1;
            if (this.gS3CutFlg[1] < 2)
            {
                _loc_1 = 0;
                while (_loc_1 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN + _loc_1] == 2)
                    {
                        gS3GLineCut[this.S3_SOKUMEN + _loc_1] = 1;
                    }
                    else
                    {
                        gS3GLineCut[this.S3_SOKUMEN + _loc_1] = 0;
                    }
                    this.dCPoint2[_loc_1][0] = this.dCPoint1[_loc_1][0];
                    this.dCPoint2[_loc_1][1] = this.dCPoint1[_loc_1][1];
                    this.dCPoint2[_loc_1][2] = this.dCPoint1[_loc_1][2];
                    _loc_1++;
                }
                this.gS3CutFlg[1] = 1;
            }
            if (gS3SolidNo == 2 && this.gS3CutFlg[2] < 2)
            {
                _loc_1 = 0;
                while (_loc_1 < this.S3_SOKUMEN)
                {
                    
                    if (gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_1] == 2)
                    {
                        gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_1] = 1;
                    }
                    else
                    {
                        gS3GLineCut[this.S3_SOKUMEN * 2 + _loc_1] = 0;
                    }
                    this.dCPoint2[_loc_1 + this.S3_SOKUMEN][0] = this.dCPoint1[_loc_1 + this.S3_SOKUMEN][0];
                    this.dCPoint2[_loc_1 + this.S3_SOKUMEN][1] = this.dCPoint1[_loc_1 + this.S3_SOKUMEN][1];
                    this.dCPoint2[_loc_1 + this.S3_SOKUMEN][2] = this.dCPoint1[_loc_1 + this.S3_SOKUMEN][2];
                    _loc_1++;
                }
                this.gS3CutFlg[2] = 1;
            }
            this.cylinderDisplay3D();
            return;
        }// end function

        private function cylinderIdou1Move() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_1:* = String(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = Number(dPauseValues.shift());
            var _loc_4:* = Number(dPauseValues.shift());
            var _loc_5:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
            if (_loc_3 >= 0)
            {
                _loc_4 = _loc_4 + 15 / 180 * Math.PI;
                if (_loc_4 > _loc_3)
                {
                    _loc_4 = _loc_3;
                }
            }
            else
            {
                _loc_4 = _loc_4 - 15 / 180 * Math.PI;
                if (_loc_4 < _loc_3)
                {
                    _loc_4 = _loc_3;
                }
            }
            _loc_6 = 0;
            while (_loc_6 < gS3SPointCnt)
            {
                
                _loc_7 = _loc_5[_loc_6][0];
                _loc_8 = _loc_5[_loc_6][1];
                _loc_9 = _loc_5[_loc_6][2];
                gPH3D.xRevolv3D(_loc_7, _loc_8, _loc_9, _loc_4 * 180 / Math.PI);
                gS3GPoint[_loc_6][0] = gPH3D.dX;
                gS3GPoint[_loc_6][1] = gPH3D.dY;
                gS3GPoint[_loc_6][2] = -gPH3D.dZ;
                _loc_6++;
            }
            this.cylinderDisplay3D();
            if (_loc_4 != _loc_3 || dPauseNecessary)
            {
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseEventCode = "";
                dPauseNecessary = false;
                this.pause(this.PAUSE_IDO_C);
                return;
            }
            if (_loc_1 != "")
            {
                dPauseEventCode = _loc_1;
                dPauseResult = _loc_2;
            }
            else
            {
                dPauseEventCode = StageEvent.C3D_IDO2_END;
                dPauseResult = int.MIN_VALUE;
            }
            dPauseFunction = null;
            dPauseValues = null;
            return;
        }// end function

        private function cylinderIdou2Move() : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_1:* = String(dPauseValues.shift());
            var _loc_2:* = int(dPauseValues.shift());
            var _loc_3:* = Number(dPauseValues.shift());
            var _loc_4:* = Number(dPauseValues.shift());
            var _loc_5:* = Number(dPauseValues.shift());
            var _loc_6:* = Number(dPauseValues.shift());
            var _loc_7:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
            var _loc_8:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
            var _loc_9:* = this.Vector.<Vector.<Number>>(dPauseValues.shift());
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
            _loc_10 = 0;
            while (_loc_10 < gS3SPointCnt)
            {
                
                _loc_11 = _loc_7[_loc_10][0];
                _loc_12 = _loc_7[_loc_10][1];
                _loc_13 = _loc_7[_loc_10][2];
                gPH3D.zRevolv3D(_loc_11, _loc_12, _loc_13, _loc_3 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_4 * 180 / Math.PI);
                this.dCPoint1[_loc_10][0] = gPH3D.dX;
                this.dCPoint1[_loc_10][1] = gPH3D.dY;
                this.dCPoint1[_loc_10][2] = gPH3D.dZ;
                _loc_11 = _loc_8[_loc_10][0];
                _loc_12 = _loc_8[_loc_10][1];
                _loc_13 = _loc_8[_loc_10][2];
                gPH3D.zRevolv3D(_loc_11, _loc_12, _loc_13, _loc_3 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_4 * 180 / Math.PI);
                this.dCPoint2[_loc_10][0] = gPH3D.dX;
                this.dCPoint2[_loc_10][1] = gPH3D.dY;
                this.dCPoint2[_loc_10][2] = gPH3D.dZ;
                _loc_10++;
            }
            _loc_10 = 0;
            while (_loc_10 < 2)
            {
                
                _loc_11 = _loc_9[_loc_10][0];
                _loc_12 = _loc_9[_loc_10][1];
                _loc_13 = _loc_9[_loc_10][2];
                gPH3D.zRevolv3D(_loc_11, _loc_12, _loc_13, _loc_3 * 180 / Math.PI);
                gPH3D.yRevolv3D(gPH3D.dX, gPH3D.dY, gPH3D.dZ, _loc_4 * 180 / Math.PI);
                this.dCPointCut[_loc_10][0] = gPH3D.dX;
                this.dCPointCut[_loc_10][1] = gPH3D.dY;
                this.dCPointCut[_loc_10][2] = gPH3D.dZ;
                _loc_10++;
            }
            this.cylinderDisplay3D();
            if (_loc_3 != _loc_5 || _loc_4 != _loc_6 || dPauseNecessary)
            {
                dPauseValues = new Array();
                dPauseValues.push(_loc_1);
                dPauseValues.push(_loc_2);
                dPauseValues.push(_loc_3);
                dPauseValues.push(_loc_4);
                dPauseValues.push(_loc_5);
                dPauseValues.push(_loc_6);
                dPauseValues.push(_loc_7);
                dPauseValues.push(_loc_8);
                dPauseValues.push(_loc_9);
                dPauseEventCode = "";
                dPauseNecessary = false;
                this.pause(this.PAUSE_IDO_C);
                return;
            }
            if (_loc_1 != "")
            {
                dPauseEventCode = _loc_1;
                dPauseResult = _loc_2;
            }
            else
            {
                dPauseEventCode = StageEvent.C3D_IDO2_END;
                dPauseResult = int.MIN_VALUE;
            }
            dPauseFunction = null;
            dPauseValues = null;
            return;
        }// end function

    }
}
