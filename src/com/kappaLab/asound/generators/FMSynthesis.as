package com.kappaLab.asound.generators
{
    
    public class FMSynthesis extends OSC
    {
        private var _modulerPhase:Number;
        private var _modulerPhasePerByte:Number
        private var _modulerGain:Number;
        private var _modulerFrequency:Number;
        private var _baseFrequency:Number;
        
        public function FMSynthesis(
            baseFrequency:Number = 96, 
            modulerFrequency:Number = 60,
            modulerGain:Number = 1000) 
        {
            super(baseFrequency)
            _baseFrequency = baseFrequency
            this.modulerFrequency = modulerFrequency
            this.modulerGain      = modulerGain
            _modulerPhase         = 0
        }
        
        override public function process():void
        {
            var n:int = LATENCY
            for (var i:int = 0; i < n; i++) 
            {
                
                _modulerPhase = (_modulerPhase + _modulerPhasePerByte) % PI2;
                _frequency = _baseFrequency +  (Math.sin(_modulerPhase) * _modulerGain)
                _phase = (_phase + (PI2 * _frequency / SAMPLE_RATE)) % PI2;
                
                /*same process
                modulerPhase = (modulerPhase + modulerPhasePerByte) % PI2;
                _frequency   = _baseFrequency +  Math.sin(modulerPhase) * _modulerGain;;
                phasePerByte = PI2 * _frequency / SAMPLE_RATE;
                phase = (phase + phasePerByte) % PI2;
                */
                _sample[i] = Math.sin(_phase);
            }
        }
        public function resetPhase():void
        {
            _modulerPhase = 0
            _phase = 0
        }
        override public function get frequency():Number { return _frequency; }
        override public function set frequency(value:Number):void 
        {
            _frequency = value;
        }
        
        public function get modulerGain():Number { return _modulerGain; }
        public function set modulerGain(value:Number):void 
        {
            _modulerGain = value;
        }
        
        public function get modulerFrequency():Number { return _modulerFrequency; }
        public function set modulerFrequency(value:Number):void 
        {
            _modulerFrequency = value;
            _modulerPhasePerByte  = PI2 * value / SAMPLE_RATE;
        }
        
        public function get baseFrequency():Number { return _baseFrequency; }
        public function set baseFrequency(value:Number):void 
        {
            _baseFrequency = value;
        }
        
        public function get modulerPhase():Number { return _modulerPhase; }
        
        public function get modulerPhasePerByte():Number { return _modulerPhasePerByte; }
        
    }
    
}