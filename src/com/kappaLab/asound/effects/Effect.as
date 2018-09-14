package com.kappaLab.asound.effects
{
    import com.kappaLab.asound.generators.Master;
    import com.kappaLab.asound.SignalProcessor;
    import flash.utils.getQualifiedClassName;
    
    public class Effect extends SignalProcessor
    {
        protected var _master:Master;
        protected var _signal:SignalProcessor;
        
        public function Effect(signal:SignalProcessor)  
        {
            if (getQualifiedClassName(this) == getQualifiedClassName(Effect))
                throw new ArgumentError(getQualifiedClassName(Effect)+"is abstruct Class");
            
            this.signal = signal
        }
        public override function process():void 
        {
            _signal.process()
            _process()
        }
        public function processInstrument():void 
        {
            _process();
        }
        protected function _process():void
        {
            throw new ArgumentError("_process() is abstruct method. you must implements! ")
        }
        
        public function get signal():SignalProcessor { return _signal; }
        public function set signal(value:SignalProcessor):void 
        {
            _signal = value;
            _sample = value.sample
        }

        
        
    }
    
}