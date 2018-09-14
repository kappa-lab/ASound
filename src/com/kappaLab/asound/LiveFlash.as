package com.kappaLab.asound
{
    import caurina.transitions.Tweener;
    import flash.display.DisplayObject;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.display.StageQuality;
    import flash.events.ErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
    import flash.net.URLRequest;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize
    import flash.ui.Keyboard
    import flash.utils.getTimer;
    import flash.utils.getQualifiedClassName
    import jp.progression.commands.display.DoTweenFrame;
    import jp.progression.commands.Wait;
    import jp.progression.core.commands.Command;
    
    import com.kappaLab.asound.*

    import jp.progression.commands.SerialList
    import jp.progression.commands.LoadChild
    import jp.progression.commands.Func;
    import jp.progression.commands.LoadURL;
    import jp.progression.commands.DoTweener;
    
	
    [SWF (framerate="20",backgroundColor="#000000",width=1440,height=900)]
	public class LiveFlash extends Sprite 
	{
		private var instruments:Vector.<Instrument>
		public var instrumentContainer:Sprite
        
        private var currentList:Array;
        private var loadList:Array;
        private var count:int
        private var reloadIcon:Sprite
        
        public var blur:BlurFilter;
        private var blurX:Number = 0;
        private var blurY:Number = 0;
        private var blurX1:Number = 0;
        private var blurY1:Number = 0;
        
        public var glow:GlowFilter;
        private var glowColor:uint   = 0;
        private var glowAlpha:Number = 0;
        private var glowBlurX:Number = 0;
        private var glowBlurY:Number = 0;
        private var glowColor1:uint  = 0;
        private var glowAlpha1:Number= 0;
        private var glowBlurX1:Number= 0;
        private var glowBlurY1:Number= 0;
        private var glowPhase:Number = 0;
        //private var glowAddPhase:Number = .1;
        private var textFieldContainer:Sprite
        private var textField:TextField
        
		public function LiveFlash():void 
		{
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign.TOP_LEFT;
            stage.doubleClickEnabled = true
            stage.quality = StageQuality.LOW
            //stage.frameRate = .5
			init();
		}
		
        
		private function init(e:Event = null):void 
		{
            currentList = [[], [], []]//filename timestmp oscsprite
            loadList    = [[], []]//filename timestmp
            count = 0
            
            instruments = new Vector.<Instrument>();
            instrumentContainer = new Sprite()
            addChild(instrumentContainer)
            addEventListener(Event.ENTER_FRAME,onEnterFrame)
            stage.addEventListener(MouseEvent.CLICK,onClick)
            stage.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick)
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp)
            
            reloadIcon = new Sprite()
            reloadIcon.graphics.beginFill(0X550000)
            reloadIcon.graphics.drawCircle(0, 0, 10)
            reloadIcon.x = 10
            reloadIcon.y = 10
            addChild(reloadIcon)
            
            blur = new BlurFilter()
            glow = new GlowFilter();
            //instrumentContainer.alpha = .5
            //this.filters = [blur]
            
            textField = new TextField()
            textField.width = 600
            textField.x     = -200;
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.wordWrap = false
            textField.textColor = 0XFFFFFF;
            textField.cacheAsBitmap = true;
            textField.text = "Live Flash";
            textField.setTextFormat(new TextFormat("Monaco",12,0xFF0000))
            textFieldContainer = new Sprite()
            textFieldContainer.addChild(textField)
            addChild(textFieldContainer)
            //for (var i:int = 0; i < 100; i++) 
            //{
                //textField.appendText(String(i)+"kneodnopfjosjfkldsjgsan\n")
            //}
            loadSwfList()
        }
        
        private function onDoubleClick(e:MouseEvent):void 
        {
            stage.displayState = "fullScreen"; 
        }
        
        private function onKeyUp(e:KeyboardEvent):void 
        {
            if (e.keyCode == 82){ loadSwfList() };
        }
        
        private function onClick(e:MouseEvent):void 
        {
            trace("stage click")
            loadSwfList()
        }
        
        private function onEnterFrame(e:Event):void 
        {
            count++;
            if (count % 30 == 0)
            {
                //trace(getTimer())
                if (Math.random() > .2)
                {
                    blurX1 = Math.random() * 10 + 0; 
                    blurY1 = Math.random() * 10 + 0;
                    //glowAlpha1 = Math.random() 
                    glowBlurX1 = 
                    glowBlurY1 = Math.random() * 30 + 10;
                }
                else
                {
                    blurX1 = Math.random() * 10 + 20; 
                    blurY1 = Math.random() * 10 + 20;
                    //glowAlpha1 = Math.random()
                    if (Math.random() > .8) 
                    {
                        glowColor1 = Math.random() * 0x222222 + 0xDDDDDD;
                        glowBlurX1 = 
                        glowBlurY1 = Math.random() * 10 + 60;
                    }
                }
            }
            
            blurX += (blurX1 - blurX) * .1;
            blurY += (blurY1 - blurY) * .1;
            blur.blurX = blurX;
            blur.blurY = blurY;
            
            glowAlpha += (glowAlpha1 - glowAlpha) * .1;
            glowColor += (glowColor1 - glowColor) * .1;
            //glowBlurX += (glowBlurX1 - glowBlurX) * .1;
            //glowBlurY += (glowBlurY1 - glowBlurY) * .1;
            glowPhase += .1
            glowBlurX = Math.sin(glowPhase)*10
            //glow.alpha = glowAlpha;
            glow.color = glowColor;
            glow.blurX = glowBlurX
            //glow.blurY = glowBlurY
            
            instrumentContainer.filters = [blur,glow]
        }
        
        private function loadSwfList():void
        {
            trace("loadSwfList", getTimer())
            reloadIcon.visible = true;
            var swfListLoader:LoadURL = new LoadURL(
                new URLRequest("http://localhost/cgi-bin/test.cgi"));
            var sl:SerialList = new SerialList()
            sl.addCommand(
                swfListLoader, 
                new Func(detectNewSwf,[swfListLoader]),
                loadSwfs
            )
            sl.execute()
        
        }
        
        private function detectNewSwf(...arg):void
        {
            trace("detectNewSwf")
            var data:String = arg[0].data
            //fileList = [[],[]]
            loadList = [[],[]]
            var list:Array = String(data).split(/\n/);
            var n:uint = list.length - 1;
            for (var i:int = 0; i < n; i++) 
            {
                var filePath:String = list[i].split(/,/)[0];
                var timeStmp:int = int(list[i].split(/,/)[1]);
                
                var index:int = currentList[0].indexOf(filePath)
                if (index == -1) 
                {   
                    trace("new File")
                    loadList[0].push(filePath)
                    loadList[1].push(timeStmp)
                }else {
                    trace(currentList[0][index],currentList[1][index],timeStmp)
                    trace("vcheck",timeStmp > currentList[1][index])
                    if (timeStmp != currentList[1][index]) 
                    {
                        trace("new version")
                        loadList[0].push(filePath)
                        loadList[1].push(timeStmp)
                    }
                }
            }
            //fileList[0] = newFileList[0].slice(0)
            //fileList[1] = newFileList[1].slice(0)
            //trace(fileList)
            
        }
        
        private function loadSwfs():void
        {
            reloadIcon.visible = false;
            //trace("loadSwfs")
            //trace(loadList[0])
            var sl:SerialList = new SerialList()
            var m:Sprite = new Sprite()
            var swfList:Array = []
            var target:Sprite = instrumentContainer
            var n:uint = loadList[0].length
            for (var i:int = 0; i < n; i++) {
                //trace(loadList[0][i])
                var com:LoadChild = new LoadChild(target, new URLRequest(loadList[0][i]))
                com.loader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,trace)
                com.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,trace)
                com.error( function( e:Error ):void {
                    this.executeComplete();
                } );
                swfList.push(com);
            }
            
            sl.addCommand(
                swfList,
                completeSwfs
            )
            sl.execute()
            
            function completeSwfs():void 
            {
                //trace("completeSwfs")
                for (var i:int = 0; i < n; i++) 
                {
                    //trace(swfList[i].loader.content is OSCSprite)
                    var inst:InstrumentSprite = swfList[i].loader.content as InstrumentSprite;
                    if (inst) {
                        trace(loadList[0][i])
                        var index:int = currentList[0].indexOf(loadList[0][i])
                        if (index > -1) {
                           if (currentList[2][index].parent.parent)
                            removeInstrumentSprite(currentList[2][index])
                           currentList[0][index] = loadList[0][i];
                           currentList[1][index] = loadList[1][i];
                           currentList[2][index] = inst 
                        }else {
                            currentList[0].push(loadList[0][i])//path
                            currentList[1].push(loadList[1][i])//time
                            currentList[2].push(inst)//instance
                        }
                        inst.addEventListener(MouseEvent.CLICK, onClickInstrumentSprite)
                        loadSource()
                    }
                }
            }
        }
        private function loadSource():void
        {
            var packageName:String = getQualifiedClassName(currentList[2][0]);
            packageName = packageName.substr(0, packageName.indexOf("::"));
            trace(packageName)
            var filePath:String = currentList[0][0];
            filePath = "./src/" + packageName+"/" + filePath.substr(filePath.lastIndexOf("/") + 1);
            filePath = filePath.replace(/swf/, "as")
            
            textField.text = filePath;
            var com:LoadURL = new LoadURL(new URLRequest(filePath));
            com.addEventListener(IOErrorEvent.IO_ERROR,trace)
                
            var sl:SerialList = new SerialList()
            sl.addCommand(
                com,
                showText
            )
            
            function showText():void
            {
                textField.text = com.data.toString();
                textFieldContainer.x = Math.random() * 200 + 200;
                textFieldContainer.y = Math.random() * 100 + 300
                textField.setTextFormat(new TextFormat("Monaco", 14, 0x777777+Math.random()*0x999999), 0, textField.length);
                textField.cacheAsBitmap = true;
                textFieldContainer.cacheAsBitmap = true;
                textFieldContainer.alpha = 0;
                moveSource()
            }
            sl.execute()
        }
        private function moveSource():void
        {
            Tweener.addTween(textFieldContainer,{alpha:1,y:textFieldContainer.y-100, time:1, transition:"easeOutSine", rotationY:720})
            Tweener.addTween(textFieldContainer,{delay:3,time:1,y:-textFieldContainer.height, transition:"easeOutSine", rotationY:1085})
        }
        public function removeInstrumentSprite(instrumentSprite:InstrumentSprite):void
        {
            instrumentContainer.removeChild(instrumentSprite.parent)
            instrumentSprite.listen = false; 
            instrumentSprite.removeEventListener(MouseEvent.CLICK, onClickInstrumentSprite);
            var com:DoTweener = new DoTweener(instrumentSprite, { volume:0, time:.1 } );
            var sl:SerialList = new SerialList()
            sl.addCommand(
                com,
                function():void { 
                    instrumentSprite.listen = false; 
                    instrumentSprite.removeEventListener(MouseEvent.CLICK, onClickInstrumentSprite);
                    //Loader(instrumentSprite.parent).unloadAndStop();
                }
            )
            sl.execute()
            
        }
        
        private function onClickInstrumentSprite(e:Event):void
        {
            var inst:InstrumentSprite = DisplayObject(e.target).parent as InstrumentSprite
            trace(inst)
            if (!inst) return;
            removeInstrumentSprite(inst)
            
        }
        public function clearFilter():void
        {
            filters = []
        }
        public function setBlur(blurX:Number=4.0, blurY:Number=4.0, quality:int=1):void
        {
            filters = [new BlurFilter(blurX,blurY,quality)]
        }
	}
}