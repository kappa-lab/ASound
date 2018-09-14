package com.kappaLab.asound.generators
{
    import flash.events.SampleDataEvent;
    
    public class TriangleOSC extends OSC
    {
        public function TriangleOSC(frequency:Number = 440):void
        {
            super(frequency);
        }
        
        override public function process():void
        {
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                _phase = (_phase + _phasePerByte) % PI2;
                
                var s:Number = (_phase / PI - 1)
                
                if (s > 0) _sample[i] = (s * 2 -1);
                else       _sample[i] = (s * -2 -1);
            }
        }
        
    }
    
}