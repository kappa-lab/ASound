package com.kappaLab.asound.generators
{
    
    public class SinOSC extends OSC
    {
        public function SinOSC(frequency:Number = 440):void
        {
            super(frequency);
        }
        
        override public function process():void
        {   
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                _phase = (_phase + _phasePerByte) % PI2;
                _sample[i] = Math.sin(_phase);
            }
        }
    }
}