package nmex;

class NativeUI{
	
	private static var alertTitle:String;
	private static var alertMSG:String;
    private static var appID;
	public static function showAlert(title:String,message:String):Void{
		alertTitle = title;
		alertMSG = message;
		//nmex_system_ui_show_alert(alertTitle,alertMSG);
		haxe.Timer.delay(delayAlert,30);
	}
	public static function showSystemLoadingView():Void{
		nmex_system_ui_show_system_loading_view();
	}	
	public static function hideSystemLoadingView():Void{
		nmex_system_ui_hide_system_loading_view();
	}
	public static function rate(ID:Int):Void{
        appID = ID;
		haxe.Timer.delay(delayRate,30);
	}
	/*
	public static function enableKeyBoard(enable:Bool):Void{
		nmex_system_ui_enable_key_board(enable);
	}*/
	
	private static function delayRate():Void{
		nmex_system_ui_rate(appID);
	}
	private static function delayAlert():Void{
		nmex_system_ui_show_alert(alertTitle,alertMSG);
	}
	
	static var nmex_system_ui_show_alert               = nme.Loader.load("nmex_system_ui_show_alert",2);
	static var nmex_system_ui_show_system_loading_view = nme.Loader.load("nmex_system_ui_show_system_loading_view",0);
	static var nmex_system_ui_hide_system_loading_view = nme.Loader.load("nmex_system_ui_hide_system_loading_view",0);
	static var nmex_system_ui_rate                     = nme.Loader.load("nmex_system_ui_rate",1);
	//static var nmex_system_ui_enable_key_board         = nme.Loader.load("nmex_system_ui_enable_key_board",1);
}
