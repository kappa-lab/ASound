package com.kappaLab.asound.instruments
{
    import com.kappaLab.asound.envelops.Envelop;
    import com.kappaLab.asound.filters.Filter;
    import com.kappaLab.asound.effects.Effect;
    import com.kappaLab.asound.generators.Master;
    import com.kappaLab.asound.namespaces.asound_internal;
    import com.kappaLab.asound.SignalProcessor;
    
    public class Instrument extends SignalProcessor
    {
        
        protected var _envelop:Envelop;
        protected var _filters:Vector.<Filter>;
        protected var _effects:Vector.<Effect>;

        protected var _volume:Number;
        
        public var signals:Vector.<SignalProcessor>
        private var _master:Master;
        private var _listen:Boolean;
        
        use namespace asound_internal;
        
        public function Instrument() 
        {
            
            signals  = new Vector.<SignalProcessor>()
            _master  = Master.getInstance();
            _sample  = new Vector.<Number>(LATENCY);
            _filters = new Vector.<Filter>();
            _effects = new Vector.<Effect>()
            _envelop = new Envelop(this,1)
            _volume  = .05;
            listen   = true
        }
        
        override public function process():void
        {   
            var n:uint = LATENCY
            var i:int = 0
            var sp:SignalProcessor;
            
            for each(sp in signals) { sp.process() };
            
            for (i = 0; i < n; i++) 
            {
                var s:Number = 0;
                for each(sp in signals) { s += sp._sample[i] };
                _sample[i] = s;
            }
            for each(var filter:Filter in _filters) 
            {
                filter.processInstrument()
            }
            
            for each(var effect:Effect in _effects) 
            {
                effect.processInstrument()
            }
            
            _envelop.processInstrument();
            
            for (i = 0; i < n; i++) { _sample[i] *= _volume };
            
        }
        /**
         * Max/MSP の　line~　に似た記述方法。
         * @param	init
         * @param	envelops 発音時の音圧,[n番目の音圧,n番目のまでの経過時間]
         * 
         * @example generateEnvelop(0,[1,1000,0,1000])
         * 音圧0からスタートして、1000ミリ秒後に音圧1、1000ミリ秒後に音圧0と変化
         **/
        public function generateEnvelop(init:Number,envelops:Array = null):void
        {
            _envelop.generateEnvelop(init,envelops)
        }
        
        public function play():void
        {
            for each(var sp:SignalProcessor in signals) 
            {
                if (sp is Instrument) Instrument(sp).play();
                else if (sp is Envelop) Envelop(sp).start();
            }
            //trace("play")
            _envelop.start()
        }
        
        public function get volume():Number { return _volume; }
        public function set volume(value:Number):void 
        {
            _volume = value;
        }
                
        public function get filters():Vector.<Filter> { return _filters; }
        public function set filters(value:Vector.<Filter>):void 
        {
            _filters = value;
        }
        
        
        public function get listen():Boolean { return _listen; }
        public function set listen(value:Boolean):void 
        {
            if (_listen == value) return;
            
            _listen = value;
            if (value) 
                _master.asound_internal::addInstrument(this);
            else
                _master.asound_internal::removeInstrument(this);
        }
        /*
        public function get envelop():Envelop { return _envelop; }
        public function set envelop(value:Envelop):void 
        {
            _envelop = value;
        }*/
        
        public function get master():Master { return _master; }
        
        public function get effects():Vector.<Effect> { return _effects; }
        public function set effects(value:Vector.<Effect>):void 
        {
            _effects = value;
        }
        
        
    }
    
}