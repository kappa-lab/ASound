package com.kappaLab.asound.generators
{
    import flash.events.SampleDataEvent;
    
    public class SquareOSC extends OSC
    {
        public function SquareOSC(frequency:Number = 440):void
        {
            super(frequency);
        }
        
        override public function process():void
        {
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                _phase = (_phase + _phasePerByte) % PI2;
                _sample[i] = ((_phase > PI)?1: -1);
            }
        }        
    }
    
}