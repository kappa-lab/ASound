# ASound
ASoundはActionScript3のディスプレイオブジェクトライクなAPIを提供しつつ、簡単にFlash上で音を鳴らせるライブラリを目指しています。 

# 使い方

```
//220Hzのサイン波を鳴らす
//http://www.libspark.org/browser/as3/ASound/branches/gamiken/src/example/Example.as 
//視聴　http://memo.kappa-lab.com/samples/Exsample.swf 

var ins:Instrument = new Instrument();
ins.signals.push(new SinOSC(220));
ins.play();
```

```
//220Hzのサイン波と880Hzのサイン波と900Hzのサイン波とノイズを音響合成し、
//レゾナントフィルター（sazameki謹製）をかけ、
//音圧0からスタートし、1秒後に音圧1まで増加してさらに1秒後消音する
//http://www.libspark.org/browser/as3/ASound/branches/gamiken/src/example/Example2.as 
//視聴　http://memo.kappa-lab.com/samples/Exsample2.swf 

var ins:Instrument = new Instrument();
ins.signals.push(new SinOSC(220));
ins.signals.push(new SinOSC(800));
ins.signals.push(new SawOSC(900));
ins.signals.push(new NoiseOSC());
ins.generateEnvelop(0, [1, 1000, 0, 1000]);
ins.filters.push(new ResonatFilter?(ins))
ins.play();
```

# 参考
sazamekiライブラリ
http://www.libspark.org/wiki/zk33/sazameki フィルター系、オシレータ系を参考にさせていただきました。

# Licensed under the MIT License
```
Licensed under the MIT License

Copyright (c) 2009 kappa-lab (www.kappa-lab.com) All rights reserved. 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
