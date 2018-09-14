/*
 *http://www.musicdsp.org/showArchiveComment.php?ArchiveID=29 
 *参考)
 *http://sazameki.org/ 
 * 
 */

package com.kappaLab.asound.filters
{
    import com.kappaLab.asound.SignalProcessor
    
    public class ResonatFilter extends Filter
    {
        private var buf0:Number = 0 ;
        private var buf1:Number = 0 ;
        private var _cutoff:Number;    
        private var _q:Number;    
        private var _type:int;
        
        static public const LPF:uint = 0;
        static public const BPF:uint = 1;
        static public const HPF:uint = 2;
        
        public function ResonatFilter(signal:SignalProcessor,type:int=1,cutoff:Number=440,q:Number=0.9) 
        {
            super(signal)
            this.type = type;
            this.cutoff = cutoff
            this.q = q
        }
        
        
        override protected function _process():void
        {
            // f and fb calculation
            var f:Number = 2.0 * Math.sin(PI * _cutoff / SAMPLE_RATE);
            var fb:Number = _q + _q/(1.0 - f);

            var n:int = LATENCY;
            var hp:Number;
            var bp:Number;
            
            for (var i:int = 0; i < n; i++) 
            {
                hp = _sample[i] - buf0;
                bp = buf0 - buf1;
                buf0 = buf0 + f * (hp + fb * bp);
                buf1 = buf1 + f * (buf0 - buf1);
                _sample[i] = (type == 0)?buf1:(type == 1)?bp:hp;
            }
        }
        
        public function get cutoff():Number { return _cutoff; }
        public function set cutoff(value:Number):void 
        {
            _cutoff = value;
        }
        
        public function get q():Number { return _q; }
        public function set q(value:Number):void 
        {
            _q = value;
        }
        
        public function get type():int { return _type; }
        public function set type(value:int):void 
        {
            _type = value;
        }
        
    }
        
}
    
