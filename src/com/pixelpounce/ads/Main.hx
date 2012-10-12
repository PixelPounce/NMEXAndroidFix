package com.pixelpounce.ads;

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nmex.AD;

/**
 * ...
 * @author Allan Bishop
 */

class Main extends Sprite 
{
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		//Create an Admob account, click add app to site. Then click manage after creating to see publisher id.
		AD.showAd("INSERT_PUBLISHER_ID", -1, -1, 0);
	}
	

	
}
