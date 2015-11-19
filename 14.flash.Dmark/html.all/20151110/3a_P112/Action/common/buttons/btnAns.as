package common.buttons
{

    public class btnAns extends buttonBase
    {

        public function btnAns()
        {
            alpha = 0;
            _brightnessChange = false;
            return;
        }// end function

        public function reset() : void
        {
            try
            {
                if (_targetMC != null)
                {
                    _targetMC.visible = false;
                }
            }
            catch (e:Error)
            {
                trace("reset:" + e.message);
            }
            return;
        }// end function

    }
}
