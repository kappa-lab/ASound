package com.kappaLab.asound.generators
{
    public class NoiseOSC extends OSC
    {
        override public function process():void
        {
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                sample[i] = (Math.random() * 2 - 1)
            }
        }
    }
}