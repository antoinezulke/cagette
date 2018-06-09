package db;
import sys.db.Object;
import sys.db.Types;
import sugoi.form.Form;

/**
 * Vendor (producteur)
 */
class Vendor extends Object
{
	public var id : SId;
	public var name : SString<32>;
	
	public var email : STinyText;
	public var phone:SNull<SString<19>>;
		
	public var address1:SNull<SString<64>>;
	public var address2:SNull<SString<64>>;
	public var zipCode:SString<32>;
	public var city:SString<25>;
	
	public var desc : SNull<SText>;
	
	public var isConfirmed : SInt;
	
	public var linkText:SNull<SString<256>>;
	public var linkUrl:SNull<SString<256>>;
	
	@hideInForms @:relation(imageId) public var image : SNull<sugoi.db.File>;
	
	@:relation(amapId) public var amap : SNull<Amap>;
	
	public function new() 
	{
		super();
		var t = sugoi.i18n.Locale.texts;
		name = t._("Supplier");
	}
	
	override function toString() {
		return name;
	}
	
	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"name" 				=> t._("Supplier name"),
			"desc" 				=> t._("Description"),
			"email" 			=> t._("Email"),
			"phone" 			=> t._("Phone"),
			"address1" 			=> t._("Address 1"),
			"address2" 			=> t._("Address 2"),
			"zipCode" 	=> t._("Zip code"),
			"city" 	=> t._("City"),			
			"linkText" 			=> t._("Link text"),			
			"linkUrl" 			=> t._("Link URL"),			
		];
	}
	
	override public function insert(){
		super.insert();
		sendConfirmation();
	}

	public function sendConfirmation() {
		
		var t = sugoi.i18n.Locale.texts;
		
		var c = new db.Confirmation();
		c.object_id = this.id;
		c.what = "Vendor confirmation";
		c.insert();

		var e = new sugoi.mail.Mail();
		e.setSubject(t._("Confirmation"));	
		
		e.addRecipient(this.email,this.name);
		e.setSender(App.config.get("default_email"),t._("Cagette.net"));			

		var html = App.current.processTemplate("mail/confirmation.mtt", { 
			email:email,
			name:name,
			k:c.hash,
			appName:App.config.get("name")
		} );

		e.setHtmlBody(html);
		
		App.sendMail(e);	
	}

  /*
    Returns the object for the confirmation Hash,
    also writes that the record was confirmed.
    */
    public static function forId(id: Int) {
        var c = db.Vendor.manager.select($id == id, true);	
        return c;
    }
	
	
}