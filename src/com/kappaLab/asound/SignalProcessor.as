package com.kappaLab.asound
{
    import flash.events.EventDispatcher;
    import flash.utils.getQualifiedClassName;
    import com.kappaLab.asound.utils.AudioConfig
    
    /*Abstract class*/
    public class SignalProcessor extends EventDispatcher
    {
        protected const PI:Number   = Math.PI;
        protected const PI2:Number  = Math.PI * 2;
        protected const LATENCY:int = AudioConfig.LATENCY;
        protected const SAMPLE_RATE:uint = AudioConfig.SAMPLE_RATE;

        public var _sample:Vector.<Number>;

        public function SignalProcessor() 
        {
            if (getQualifiedClassName(this) == getQualifiedClassName(SignalProcessor))
            {
                throw new ArgumentError(getQualifiedClassName(SignalProcessor) + " is abstruct Class");
            }
        }
        
        /*Abstract method*/
        public function process():void 
        {
            throw new ArgumentError("process() is abstruct method. you must implements! ");
        }
        
        public function get sample():Vector.<Number> { return _sample; }
        public function set sample(value:Vector.<Number>):void 
        {
            _sample = value;
        }
        
    }
    
}