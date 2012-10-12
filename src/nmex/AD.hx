/**
*  
*  if you want to use AD, you must change nme to set keyWindows.rootViewController
*  
*  */

/*
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * Orignal code by Yann Zhao : http://code.google.com/p/nmex/
 *
 * Fixed for Android by Allan Bishop with the help of Adrian.
 * 
 */

package nmex;

class AD{
	#if android
	//android
	private static var _showAd_func:Dynamic;
	public static function showAd(id:String, x:Int=0, y:Int=0, size:Int=0):Void{
	
		if (_showAd_func == null)
			_showAd_func = nme.JNI.createStaticMethod("com.pixelpounce.ads.MainActivity", "showAd", "(Ljava/lang/String;IIII)V", true);
		var a = new Array<Dynamic>();
		a.push(id);
		a.push(x);
		a.push(y);
		a.push(size);
		a.push(0);
		_showAd_func(a);
		
		
	}
    
	private static var _hideAd_func:Dynamic;
	public static function hideAd():Void{
		if (_hideAd_func == null)
			_hideAd_func = nme.JNI.createStaticMethod("com.pixelpounce.ads.MainActivity", "hideAd", "()V", true);
		var a = new Array<Dynamic>();
		_hideAd_func(a);
	}
	
	#else
	// iphone
	private static var running:Bool = false;

	public static function showAd(id:String = "",x:Int = 0,y:Int = 0, sizeType:Int=0):Void{
		if(!running){
			nme_ad_showad(id,x,y,sizeType);
			running = true;
		}	
	}	
	
	public static function hideAd():Void{
		if(running){
			nme_ad_hidead();
			running = false;
		}
	}
	
	static var nme_ad_showad = nme.Loader.load("nmex_ad_showad",4);
	static var nme_ad_hidead = nme.Loader.load("nmex_ad_hidead",0);
	#end
}