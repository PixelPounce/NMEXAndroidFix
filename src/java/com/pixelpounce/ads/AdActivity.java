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



package ::APP_PACKAGE::;


import android.os.Bundle;
import com.adwhirl.AdWhirlLayout;
import com.adwhirl.AdWhirlTargeting;
import org.haxe.nme.GameActivity;
import com.google.ads.*;
import android.widget.RelativeLayout;
import android.view.ViewGroup;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.FrameLayout;
import org.haxe.nme.MainView;
import android.util.Log;


public class AdActivity extends org.haxe.nme.GameActivity implements AdListener {
	
	public static AdActivity myActivity;
	
	protected void onCreate(Bundle state)
	{
		super.onCreate(state);
		myActivity=this;
		FrameLayout rootLayout = new FrameLayout(this);
        mAdLayout = new RelativeLayout(this);
        RelativeLayout.LayoutParams adWhirlLayoutParams = new RelativeLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT); 
        
		//Make sure haxe\lib\nme\3,4,3\templates\default\android\template\src\org\haxe\nme\MainView has been changed to a public class
		((ViewGroup)mView.getParent()).removeView(mView);
		
        rootLayout.addView(mView);
        rootLayout.addView(mAdLayout, adWhirlLayoutParams);

        setContentView(rootLayout);	
	}
	
	public static AdActivity getInstance()
	{
		return myActivity;
	}

	
	//admob
	static RelativeLayout mAdLayout;
	static AdView adView;
	static Boolean adInited = false;
	//static Boolean adReceived = false;
	static Boolean adHidden = true;
	
	static RelativeLayout.LayoutParams adWhirlLayoutParams;
	
	static public void initAd(final String id, final int x, final int y,final int size){
		
		AdActivity.getInstance().runOnUiThread(new Runnable() {
		
			public void run() {
				
			String adID = id;
			adView = new AdView(activity, AdSize.BANNER, adID);
			adView.setAdListener(getInstance());

			AdRequest request = new AdRequest();
			
			//You can find your device ID by running logcat and examining the output.
			//So, open a command prompt and change to your AndroidSDK platform tools directory and run
			//"adb logcat > logcat.txt". When you close the command prompt you will find the txt file containing the device ID in the same directory
			request.addTestDevice("INSERT_DEVICE_ID");

			adView.loadAd(request);	

			adWhirlLayoutParams = new RelativeLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT); 
				 
			if(x == 0 && y == 0){
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			}else if(x == 0 && y == -1){
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
			}else if(x == -1 && y == 0){
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			}else if(x == -1 && y == 0){
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
			}else{
				adWhirlLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP);
			}
				
				adInited = true;
				mAdLayout.addView(adView, adWhirlLayoutParams);
			}
			
			
		});
	
	}
	
	static public void showAd(final String id, final int x, final int y,final int size, final int preLoad) {
	
		AdActivity.getInstance().runOnUiThread(new Runnable() {
	
			public void run() {
				
				if(preLoad != 0 || adInited==false){
					initAd(id, x, y, size);
				}else{
					mAdLayout.removeAllViews();
					mAdLayout.addView(adView, adWhirlLayoutParams);
					adHidden = false;

				}
			}
		});
	}
	
	static public void hideAd() {
		
		AdActivity.getInstance().runOnUiThread(new Runnable() {
			public void run() {
				
				if(null != adView && adHidden == false){
					mAdLayout.removeAllViews(); 
					adView.loadAd(new AdRequest());
				}
			}
		});

	}

	public void onReceiveAd(Ad ad){}
	public void onFailedToReceiveAd(Ad ad, AdRequest.ErrorCode error){}
	public void onPresentScreen(Ad ad){}
	public void onDismissScreen(Ad ad){}
	public void onLeaveApplication(Ad ad){}
}

