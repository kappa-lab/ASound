/*
 *参考)
 *http://sazameki.org/ 
 * 
 */


package com.kappaLab.asound.effects 
{
    import com.kappaLab.asound.SignalProcessor
    public class DelayEffect extends Effect
    {
        private var time:Number
        private var dry:Number
        private var wet:Number
        private var feedback:Number

        //private var buf:Array=[]
        private var buf:Vector.<Number>
        private var position:int
        private var bufSize:int;

        public function DelayEffect(
            signal:SignalProcessor,
            time:int = 1000, 
            wet:Number = 1, 
            feedback:Number = 0.3
            ):void
        {
            super(signal)
            this.time = time;
            this.wet  = wet;
            this.dry  = 1 - wet;
            this.feedback = feedback
            position = 0
            bufSize = int(time * .001 * SAMPLE_RATE);
            buf = new Vector.<Number>(bufSize);
        }
        
        override protected function _process():void 
        {
            var n:uint = _sample.length;
            for (var i:int = 0; i < n; i++) 
            {
                var delay:Number = (buf[position])?buf[position]:0;
                var input:Number = _sample[i]
                var wetSig:Number = input + delay * feedback
                buf[position] = wetSig;
                position++;
                position %= bufSize;
                _sample[i] = input * dry + wetSig * wet;
                
                /*
                inputSig = left[i];
				wetSig = inputSig + _bufferL.head * feedback;
				_bufferL.setAt(delayCount, wetSig);
				left[i] = inputSig * dry + wetSig * wet;
                */
            }
        }
    }
}