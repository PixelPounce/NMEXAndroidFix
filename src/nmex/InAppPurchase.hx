/**
 *  2011-3-3 Yann
 *  please purchase a product every time.
 */
package nmex; 


class InAppPurchase extends NXObject{
	
	private static var instance:InAppPurchase;
	
	private function new(){
        super();
		nmex_system_in_app_purchase_init();
	}
	
	public static function getInstance():InAppPurchase{
		if(instance == null){
			instance = new InAppPurchase();
		}	
		return instance;
	}
	
	public function canPurchase():Bool{
		return nmex_system_in_app_purchase_can_purchase();
	}
	
	public function purchase(productID:String):Void{
		nmex_system_in_app_purchase_purchase(productID);
	}
	
	public function destroy():Void{
		instance = null;
		nmex_system_in_app_purchase_release();
	}
	
	static var nmex_system_in_app_purchase_init = nme.Loader.load("nmex_system_in_app_purchase_init",0);
	static var nmex_system_in_app_purchase_purchase = nme.Loader.load("nmex_system_in_app_purchase_purchase",1);
	static var nmex_system_in_app_purchase_can_purchase = nme.Loader.load("nmex_system_in_app_purchase_can_purchase",0);
	static var nmex_system_in_app_purchase_release = nme.Loader.load("nmex_system_in_app_purchase_release",0);
}
