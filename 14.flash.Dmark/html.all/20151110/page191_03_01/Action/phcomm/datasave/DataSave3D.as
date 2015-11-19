package phcomm.datasave
{
    import __AS3__.vec.*;

    public class DataSave3D extends Object
    {
        protected var mData:Vector.<Vector.<Number>>;

        public function DataSave3D()
        {
            this.mData = new Vector.<Vector.<Number>>(0, false);
            return;
        }// end function

        public function get data() : Vector.<Vector.<Number>>
        {
            return this.mData;
        }// end function

    }
}
