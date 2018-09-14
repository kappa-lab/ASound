package exsample.exsample4 
{
    import com.kappaLab.asound.*;
    import com.kappaLab.asound.generators.SinOSC;
    import com.kappaLab.asound.instruments.Instrument;
    import com.kappaLab.asound.utils.Note;
    import flash.events.*;
    public class RandomHarmonics extends Instrument 
    {
        private var sin:SinOSC;
        private var freqs:Vector.<Number>;
        public function RandomHarmonics(octarb:Number = 5,type:uint = 1) 
        {
            
            freqs = new Vector.<Number>()
            var baseNote:uint = 12 * octarb;
            if (type == 1)
            {
                freqs.push(Note.note2Frequency(baseNote));
                freqs.push(Note.note2Frequency(baseNote));
                freqs.push(Note.note2Frequency(baseNote + 2));
                freqs.push(Note.note2Frequency(baseNote + 4));
                freqs.push(Note.note2Frequency(baseNote + 7));
                freqs.push(Note.note2Frequency(baseNote + 9));
                freqs.push(Note.note2Frequency(baseNote + 12));
            }
            else
            {
                freqs.push(Note.note2Frequency(baseNote + 1));
                freqs.push(Note.note2Frequency(baseNote + 3));
                freqs.push(Note.note2Frequency(baseNote + 5));
                freqs.push(Note.note2Frequency(baseNote + 8));
                freqs.push(Note.note2Frequency(baseNote + 10));
            }
            sin = new SinOSC()
            signals.push(
                sin
            )    
            generateEnvelop(0, [1, 50, .5, 25, .5, 100, 0, 200]);
        }
        override public function play():void
        {
            super.play()
            sin.frequency = freqs[int(Math.random()*freqs.length)]
        }
    }
}
