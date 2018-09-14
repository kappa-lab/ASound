package com.kappaLab.asound.filters
{
    import com.kappaLab.asound.SignalProcessor;
    import flash.utils.getQualifiedClassName;
    
    public class Filter extends SignalProcessor
    {
        protected var _signal:SignalProcessor;
        public function Filter(signal:SignalProcessor) 
        {
            
            if (getQualifiedClassName(this) == getQualifiedClassName(Filter))
                throw new ArgumentError(getQualifiedClassName(Filter) + "is abstruct Class");
            
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
        /*Abstract method*/
        protected function _process():void
        {
            throw new ArgumentError("process() is abstruct method. you must implements! ")
        }
        
        public function get signal():SignalProcessor { return _signal; }
        public function set signal(value:SignalProcessor):void 
        {
            _signal = value;
            _sample = value.sample
        }

        
    }
    
}