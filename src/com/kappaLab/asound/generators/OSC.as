package com.kappaLab.asound.generators
{
    import com.kappaLab.asound.SignalProcessor;
    import flash.utils.getQualifiedClassName;
    
    /**
     * Abstract Class
     */
    public class OSC extends SignalProcessor
    {
        
        protected var _frequency:Number;
        protected var _phase:Number;
        protected var _phasePerByte:Number;
        
        public function OSC(frequency:Number = 440)
        {
            if (getQualifiedClassName(this) == getQualifiedClassName(OSC))
                throw new ArgumentError(getQualifiedClassName(OSC) + " is abstruct Class");
                
            this.frequency = frequency;
            _phase = 0;
            _sample = new Vector.<Number>(LATENCY);
        }
        
        public function get frequency():Number { return _frequency; }
        public function set frequency(value:Number):void 
        {
            _frequency = value;
            _phasePerByte  = PI2 * _frequency / SAMPLE_RATE;
        }
        
        public function get phase():Number { return _phase; }

        public function get phasePerByte():Number { return _phasePerByte; }
        
        /*Abstract method*/
        public override function process():void 
        {
            throw new ArgumentError("process() is abstruct method. you must implements! ");
        }
        
    }
    
}