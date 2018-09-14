package exsample
{
    
    import com.kappaLab.asound.instruments.Instrument;
    import com.kappaLab.asound.generators.SinOSC
    import flash.display.Sprite;

    public class Exsample extends Sprite 
    {
        
        public function Exsample() 
        {
            var ins:Instrument = new Instrument();
            ins.signals.push(new SinOSC());
            ins.play();
        }
    }
}