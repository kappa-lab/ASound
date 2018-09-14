package com.kappaLab.asound.instruments
{
    import com.kappaLab.asound.*;
    import com.kappaLab.asound.filters.ResonatFilter;
    import com.kappaLab.asound.generators.NoiseOSC;
    import flash.events.*;
    public class Clap extends Instrument 
    {
        public function Clap(cutOff:Number = 880, q:Number =.9)
        {
            signals[0] = new ResonatFilter(new NoiseOSC(),ResonatFilter.BPF,cutOff,q)
            generateEnvelop(0, [1,1,0, 200]);
        }
        
    }
}
