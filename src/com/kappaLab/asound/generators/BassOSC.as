package com.kappaLab.asound.generators
{
    
    public class BassOSC extends OSC
    {
        private var initFreq:Number;
        private var endFreq:Number;
        private var time:Number;
        private var per:Number;
        public function BassOSC(initFreq:Number,endFreq:Number,time:uint = 50):void
        {
            super(initFreq);
            this.initFreq = initFreq
            this.endFreq  = endFreq;
            this.time = time
            this.per = 1000/time
        }
        
        override public function process():void
        {   
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                _frequency += (endFreq -_frequency) / (SAMPLE_RATE / per)
                 _phasePerByte  = PI2 * (_frequency) / SAMPLE_RATE;
                _phase = (_phase + _phasePerByte) % PI2;
                _sample[i] = Math.sin(_phase);
            }
        }
    }
}