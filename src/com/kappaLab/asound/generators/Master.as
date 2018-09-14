package com.kappaLab.asound.generators
{
    import com.kappaLab.asound.effects.Effect;
    import com.kappaLab.asound.instruments.Instrument;
    import com.kappaLab.asound.namespaces.asound_internal
    import com.kappaLab.asound.SignalProcessor;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    public class Master extends SignalProcessor
    {
        static private var instance:Master
        
        private var sound:Sound
        
        private var _instruments:Vector.<Instrument>;
        private var _effects:Vector.<Effect>;
        private var _volume:Number
        
        use namespace asound_internal;
        
        static public function getInstance():Master
        {
            if (instance) 
            {
                return instance
            }
            else 
            {
                internal_flg = true
                instance = new Master()
                return instance
            }
        }
        
        public function Master()
        {
            if (!internal_flg) 
            throw new ArgumentError("use getInstance()");
            
            internal_flg = false
            
            _volume = 1.0
            _instruments = new Vector.<Instrument>();
            _effects = new Vector.<Effect>();
            _sample  = new Vector.<Number>(LATENCY);
            //_effects[0] = new DelayEffect(1000, 1, -0.6, -0.2)
            sound = new Sound();
            sound.addEventListener(SampleDataEvent.SAMPLE_DATA, _process)
            sound.play()
        }
        
        private function _process(e:SampleDataEvent):void
        {
            dispatchEvent(e)
            var n:int = LATENCY
            var data:ByteArray = e.data
            var volume:Number = _volume;
            var inst:Instrument;
            
            for each(inst in _instruments){ inst.process() };
            
            for (var i:int = 0; i < n; i++) 
            {
                var s:Number = 0;
                for each(inst in _instruments){ s += inst._sample[i]};
                    
                _sample[i] = s;
            }
            
            for each(var ef:Effect in _effects){ ef.processInstrument() };
            
            for (var k:int = 0; k < n; k++) 
            {
                var s2:Number = _sample[k] * volume;
                //s2 = Math.random()
                data.writeFloat(s2)
                data.writeFloat(s2)
            }
        }
        
        override public function process():void
        {
        }
        asound_internal function addInstrument(instrument:Instrument):Instrument
        {
            //log("addOSC")
            var index:int = _instruments.indexOf(instrument);
            if (index == -1) { _instruments.push(instrument) };
            return instrument
        }
        
        asound_internal function removeInstrument(instrument:Instrument):Instrument
        {
            var index:int = _instruments.indexOf(instrument);
            if (index > -1) { _instruments.splice(index, 1) };
            return instrument;
        }
        
        
        public function get effects():Vector.<Effect> { return _effects; }
        public function set effects(value:Vector.<Effect>):void 
        {
            _effects = value;
        }
        
        public function cleaAllEffect():void
        {
            _effects = new Vector.<Effect>();
        }
        
        public function get volume():Number { return _volume; }
        public function set volume(value:Number):void 
        {
            _volume = value;
        }
    }
}
internal var internal_flg:Boolean = false;