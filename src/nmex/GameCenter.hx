package nmex;

#if android
class GameCenter extends NXObject{


private static var instance:GameCenter;

private function new(){
	super();
}

public static function getInstance():GameCenter{
	if(instance == null){
		instance = new GameCenter();
	}
	
	return instance;
}

public function authenticateLocalUser():Void{
	
}

private static var _showAchievements_func:Dynamic;
public function showAchievements():Void{
	if (_showAchievements_func == null)
		_showAchievements_func = nme.JNI.createStaticMethod("org.haxe.nme.GameActivity", "showAchievements", "()V", true);
	var a = new Array<Dynamic>();
	_showAchievements_func(a);
}

private static var _showLeaderboardForCategory_func:Dynamic;
public function showLeaderboardForCategory(category:String):Void{
	if (_showLeaderboardForCategory_func == null)
		_showLeaderboardForCategory_func = nme.JNI.createStaticMethod("org.haxe.nme.GameActivity", "showLeaderboardForCategory", "(Ljava/lang/String;)V", true);
	var a = new Array<Dynamic>();
	a.push(category);
	_showLeaderboardForCategory_func(a);
}

private static var _reportScoreForCategory_func:Dynamic;
public function reportScoreForCategory(score:Int, category:String):Void{
	if (_reportScoreForCategory_func == null)
		_reportScoreForCategory_func = nme.JNI.createStaticMethod("org.haxe.nme.GameActivity", "reportScoreForCategory", "(ILjava/lang/String;)V", true);
	var a = new Array<Dynamic>();
	a.push(score);
	a.push(category);
	_reportScoreForCategory_func(a);
}

private static var _reportAchievement_func:Dynamic;
public function reportAchievement(achievementId:String):Void{
	
	if (_reportAchievement_func == null)
		_reportAchievement_func = nme.JNI.createStaticMethod("org.haxe.nme.GameActivity", "reportAchievement", "(Ljava/lang/String;)V", true);
	var a = new Array<Dynamic>();
	a.push(achievementId);
	_reportAchievement_func(a);
}

public function resetAchievements():Void{
}
}
#else

class GameCenter extends NXObject{


private static var instance:GameCenter;

private function new(){
	super();
	var result:Bool=untyped nmex_init_game_kit();
	if(!result){
		throw "GameCenter init error.";
	}
}

public static function getInstance():GameCenter{
	if(instance == null){
		instance = new GameCenter();
	}
	
	return instance;
}

public function authenticateLocalUser():Void{
	untyped nmex_authenticate_local_user();		
}

public function showAchievements():Void{
	untyped nmex_show_achievements();
}

public function showLeaderboardForCategory(category:String):Void{
	untyped nmex_show_leaderboard_for_category(category);
}

public function reportScoreForCategory(score:Int,category:String):Void{
	untyped nmex_report_score_for_category(score,category);
}

public function reportAchievement(achievementId:String,completion:Float):Void{
	untyped nmex_report_achievement(achievementId,completion);
}

public function resetAchievements():Void{
	untyped nmex_reset_achievements();
}

// CFFI
private static var nmex_is_game_center_available = nme.Loader.load("is_game_center_available",0);
private static var nmex_authenticate_local_user = nme.Loader.load("authenticate_local_user",0);
private static var nmex_init_game_kit = nme.Loader.load("init_game_kit",0);
private static var nmex_show_achievements = nme.Loader.load("show_achievements",0);
private static var nmex_show_leaderboard_for_category = nme.Loader.load("show_leaderboard_for_category",1);
private static var nmex_report_score_for_category = nme.Loader.load("report_score_for_category",2);
private static var nmex_report_achievement = nme.Loader.load("report_achievement",2);
private static var nmex_reset_achievements = nme.Loader.load("reset_achievements",0);

}
#end