package dtcontent.connect
{
    import flash.events.*;

    dynamic public class ConnectEvent extends Event
    {
        public var _message:String;
        public var _data:Object;
        public static const CONNECT:String = "connect";

        public function ConnectEvent(param1:String, param2:String, param3, param4:Boolean = false, param5:Boolean = false)
        {
            super(param1, param4, param5);
            this._message = param2;
            this._data = param3;
            return;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get data()
        {
            return this._data;
        }// end function

        override public function clone() : Event
        {
            return new ConnectEvent(type, this.message, this.data, bubbles, cancelable);
        }// end function

    }
}
