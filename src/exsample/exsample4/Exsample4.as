package exsample.exsample4 
{
    
    import com.kappaLab.asound.instruments.Bass;
    import com.kappaLab.asound.instruments.Clap;
    import com.kappaLab.asound.utils.AudioConfig;
    import com.kappaLab.asound.effects.DelayEffect;
    import com.kappaLab.asound.instruments.Instrument;
    import com.kappaLab.asound.filters.ResonatFilter;
    import com.kappaLab.asound.effects.ReverbEffect;
    
    import flash.display.Sprite;
    import flash.events.SampleDataEvent;

    public class Exsample4 extends Sprite 
    {
        
        public function Exsample4() 
        {
            var r:Instrument = new RandomHarmonics()
            var r2:Instrument = new RandomHarmonics();
            var r3:Instrument = new RandomHarmonics();
            r2.volume = .05;
            r3.volume = .05;
            var cl:Instrument = new Clap();
            var cl2:Instrument = new Clap();
            var cl3:Instrument = new Clap();
            cl2.generateEnvelop(0, [.5, 1, 0, 20]);
            cl3.generateEnvelop(0, [.5, 1, 0, 100]);
            var b:Instrument = new Bass()
            r.master.addEventListener(SampleDataEvent.SAMPLE_DATA,onSampleData)
            
            r.effects.push(new DelayEffect(r))
            r2.effects.push(new DelayEffect(r2))
            r3.effects.push(new DelayEffect(r2))
            
            function onSampleData(e:SampleDataEvent):void 
            {
                var c:int = e.position / AudioConfig.LATENCY;
                trace(c)
                var c2:int = c % 2;
                var c4:int = c % 4;
                var c8:int = c % 8;
                var c16:int = c % 16;
                var c32:int = c % 32;
                var c64:int = c % 64;
                /**/
                if (c8 == 0) r.play();
                if (c8 == 4) r2.play();
                if (c8 == 0) cl2.play();
                if (c4 == 2) { if (Math.random() > .6) cl3.play() };
                if (c4 == 0) { if (Math.random() > .6) cl2.play() };
                if (c4 == 0) { if (Math.random() > .8) r3.play() };
                if (c32 == 0) cl.play();
                /**/
            }
        }
        
    }
    
}