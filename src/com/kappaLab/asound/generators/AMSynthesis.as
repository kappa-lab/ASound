package com.kappaLab.asound.generators
{
    
    public class AMSynthesis extends OSC
    {
        private var _gain:Number;
        private var _baseAmplifier:Number;
        private var _amplifier:Number;
        private var signal:SignalProcessor
        //_amplifier
        public function AMSynthesis(
            signal:SignalProcessor,
            frequency:Number = 1,
            baseAmplifier:Number = 1, 
            gain:Number = 1) 
        {
            super(frequency)
            this.signal = signal
            _baseAmplifier = baseAmplifier
            this.gain      = gain
            
        }
        override public function process():void
        {
            signal.process()
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                               
                _phase = (_phase + _phasePerByte) % PI2;
                _amplifier = _baseAmplifier +  (Math.sin(_phase) * _gain);
                _sample[i] = signal._sample[i] * _amplifier
            }
        }
        public function resetPhase():void
        {
            _phase = 0
        }
        
        public function get baseAmplifier():Number { return _baseAmplifier; }
        public function set baseAmplifier(value:Number):void 
        {
            _baseAmplifier = value;
        }
        
        public function get amplifier():Number { return _amplifier; }
        
        public function get gain():Number { return _gain; }
        public function set gain(value:Number):void 
        {
            _gain = value;
        }
    }
    
}