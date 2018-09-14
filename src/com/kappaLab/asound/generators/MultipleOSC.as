package com.kappaLab.asound.generators
{
    
    public class MultipleOSC extends OSC
    {
        public var oscs:Vector.<OSC>
        
        public function MultipleOSC(...oscs) 
        {
            this.oscs = new Vector.<OSC>()
            for each(var osc:OSC in oscs) { this.oscs.push(osc)}
        }
        override public function process():void
        {
            var osc:OSC
            
            for each(osc in oscs) { osc.process() };
            
            var n:int = LATENCY
            
            for (var i:int = 0; i < n; i++) 
            {
                var s:Number = 0;
                for each(osc in oscs) { s += osc._sample[i] };
                _sample[i] = s;
            }
        }
        
    }
    
}