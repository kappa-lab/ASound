/*
 *参考)
 *http://sazameki.org/ 
 * 
 */

package com.kappaLab.asound.effects
{
    
    public class ReverbEffect extends Effect
    {
        private var _time:Number
        private var _dry:Number
        private var _wet:Number
        private var _feedback:Number

        //private var buf:Array=[]
        private var buf:Vector.<Number>
        private var position:int
        private var bufSize:int;
        private var _depth:uint;

        public function ReverbEffect(
            signal:SignalProcessor,
            time:int = 400, 
            dry:Number = 1, 
            wet:Number = .2, 
            feedback:Number = .2,
            depth:uint = 3
            ):void
        {
            super(signal)
            this.time = time
            this.dry = dry
            this.wet = wet
            this.feedback = feedback
            this.depth = depth
            position = 0
        }
        
        override public function process():void 
        {
            _signal.process();
            var n:uint = depth
            for (var i:int = 0; i < n; i++) 
            {
                _process()
            }
        }
        
        override protected function _process():void 
        {
            var n:uint = _sample.length;
            for (var i:int = 0; i < n; i++) 
            {
                var dSample:Number = (buf[position])?buf[position]:0;
                var input:Number = _sample[i]
                buf[position] = input * _wet + dSample * _feedback;
                position++;
                position %= bufSize;
                _sample[i] = input * _dry + dSample;
                
            }
        }
        
        public function get time():Number { return _time; }
        public function set time(value:Number):void 
        {
            _time = value;
            bufSize = int(value * .001 * SAMPLE_RATE);
            buf = new Vector.<Number>(bufSize);
        }
        
        public function get dry():Number { return _dry; }
        public function set dry(value:Number):void 
        {
            _dry = value;
        }
        
        public function get wet():Number { return _wet; }
        public function set wet(value:Number):void 
        {
            _wet = value;
        }
        
        public function get feedback():Number { return _feedback; }
        public function set feedback(value:Number):void 
        {
            _feedback = value;
        }
        
        public function get depth():uint { return _depth; }
        public function set depth(value:uint):void 
        {
            _depth = value;
        }
    }
    
}