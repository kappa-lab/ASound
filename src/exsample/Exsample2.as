package  exsample
{
    
    import com.kappaLab.asound.filters.ResonatFilter;
    import com.kappaLab.asound.generators.NoiseOSC;
    import com.kappaLab.asound.generators.SawOSC;
    import com.kappaLab.asound.generators.SinOSC;
    import com.kappaLab.asound.instruments.Instrument;
    import flash.display.Sprite;

    public class Exsample2 extends Sprite 
    {
        
        public function Exsample2() 
        {
            //dualOSC();
            //envelop();
            filter();
        }
        
        private function filter():void
        {
            var ins:Instrument = new Instrument();
            ins.signals.push(new SinOSC(220));
            ins.signals.push(new SinOSC(800));
            ins.signals.push(new SawOSC(900));
            ins.signals.push(new NoiseOSC());
            ins.generateEnvelop(0, [1, 1000, 0, 1000]);
            ins.filters.push(new ResonatFilter(ins))
            ins.play();            
        }
        
        private function envelop():void
        {
            var ins:Instrument = new Instrument();
            ins.signals.push(new SinOSC(220));
            ins.generateEnvelop(0, [1, 1000, 0, 1000]);
            ins.play();
        }
        
        private function dualOSC():void
        {
            var ins:Instrument = new Instrument();
            ins.signals.push(new SinOSC(220));
            ins.signals.push(new SinOSC(420));
            ins.play();
        }
        
    }
    
}