package com.kappaLab.asound.envelops
{
    import com.kappaLab.asound.SignalProcessor;
    import com.kappaLab.asound.utils.AudioConfig
    public class Envelop extends SignalProcessor
    {
        protected const TIME_PER_BYTE:Number = 1000.0 / AudioConfig.SAMPLE_RATE;
        protected var timePerByte:Number = 0
        
        protected var amplifiers:Vector.<Number>; 
        protected var intervals:Vector.<Number>;
        
        protected var _signal:SignalProcessor
        protected var _amplifier:Number; 
        protected var initAmplifier:Number;
        protected var lastAmplifier:Number;
        protected var length:uint;
        protected var time:Number;
        private var started:Boolean = false;
        
        /**
         * Max/MSP の　line~　に似た記述方法。
         * @param	init
         * @param	envelops 発音時の音圧,[n番目の音圧,n番目のまでの経過時間]
         * 
         * @example new Envelop(signal,0,[1,1000,0,1000])
         * 音圧0からスタートして、1000ミリ秒後に音圧1、1000ミリ秒後に音圧0と変化
         **/
        public function Envelop(
            signal:SignalProcessor,
            initAmplifier:Number, 
            envelops:Array = null) 
        {
            this.signal = signal
            time = 0;
            generateEnvelop(initAmplifier, envelops);
        }
        
        
        /**
         * Max/MSP の　line~　に似た記述方法。
         * @param	init
         * @param	envelops 発音時の音圧,[n番目の音圧,n番目のまでの経過時間]
         * 
         * @example new Envelop(0,[1,1000,0,1000])
         * 音圧0からスタートして、1000ミリ秒後に音圧1、1000ミリ秒後に音圧0と変化
         **/
        public function generateEnvelop(
            initAmplifier:Number, 
            envelops:Array = null):void 
        {
            this.initAmplifier = initAmplifier;
            amplifiers    = new Vector.<Number>()
            intervals     = new Vector.<Number>()
            
            var n:int = (envelops)?envelops.length >> 1:0;//int(arg.length / 2)
            var previousValue:Number = initAmplifier
            var prevInterval:Number  = 0;
            
            for (var i:int = 0; i < n; i++) 
            {
                var ii:int = i << 1 // i*2
                trace(ii,envelops[ii], previousValue, envelops[ii + 1]);
                intervals[i]  = envelops[ii + 1]+prevInterval;
                amplifiers[i] = 0+(envelops[ii] - previousValue)
                              / ((envelops[ii + 1] * .001) * 44100.0);
                previousValue = envelops[ii]
                prevInterval  = intervals[i]
            }
            
            lastAmplifier = previousValue;
            length = n;
            /**
            trace("----------")
            trace(_amplifier)
            trace(initAmplifier)
            trace(lastAmplifier)
            trace(time)
            trace(length)
            trace(intervals)
            trace(amplifiers)
            /**/
        }
        
        public function start():void
        {
            //trace("start")
            time = 0
            started = true
            _amplifier = initAmplifier
        }
        override public function process():void
        {
            _signal.process()
            _process()
        }
        public function processInstrument():void
        {
            _process()
        }
        protected function _process():void
        {   
            var n:int = LATENCY;
            var i:int = 0;
            var m:int = length - 1;
            //trace(time,_amplifier)
            if (!started)
            {
                for (; i < n; i++) 
                {
                    _sample[i] = 0;
                }
            }
            else
            {
                for (; i < n; i++) 
                {
                    time += TIME_PER_BYTE;
                    for (var j:int = 0; j <= m; j++) 
                    {
                        if (time <= intervals[j]) 
                        {
                            _amplifier += amplifiers[j];
                            break; 
                        }
                        else if (time > intervals[m]) 
                        {
                            _amplifier = lastAmplifier;
                            break; 
                        }
                    };
                    _sample[i] *= (_amplifier)?_amplifier:0;
                }
            }
            
        }
        
        public function get signal():SignalProcessor { return _signal; }
        public function set signal(value:SignalProcessor):void 
        {
            _signal = value;
            _sample = value.sample
        }
        
        public function get amplifier():Number { return _amplifier; }

    }
    
}