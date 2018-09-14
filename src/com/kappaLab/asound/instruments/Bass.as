package com.kappaLab.asound.instruments
{
    import com.kappaLab.asound.generators.BassOSC;
    import com.kappaLab.asound.generators.SinOSC;
    import com.kappaLab.asound.instruments.Instrument;
    import flash.events.*;
    
    public class Bass extends Instrument 
    {
        private var sin:SinOSC;
        private var initFreq:Number
        private var endFreq:Number
        private var time:Number;
        public function Bass(
            initFreq:Number = 300,
            endFreq:Number = 40,
            time:uint = 50) 
        {
            this.initFreq = initFreq
            this.endFreq = endFreq
            this.time = time;
            signals[0] = new BassOSC(initFreq,endFreq,time)
            generateEnvelop(0, [1,1,0, 200]);
        }
        override public function play():void
        {
            super.play()
            BassOSC(signals[0]).frequency = initFreq
        }
    }
}
