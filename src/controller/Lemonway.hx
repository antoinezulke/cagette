package controller;
import sugoi.form.Form;

class Lemonway extends Controller
{
    public var hop:String = "hop";

	public function new()
	{
		super();
		
        //view.form = new Form();
        //view.form.addElement();
	}

    @tpl("lemonway/default.mtt")
	function doCharge() {
		var lw=new lemonway.Lemonway();
		var wallet="1551";
		var result = lw.moneyIn(wallet,10,2);
		trace("cuequintosh");
		throw Ok(result);
    }

    @tpl("lemonway/default.mtt")
	function doWallet() {
		var lw=new lemonway.Lemonway();
		var result = lw.createWallet("1551");
		trace("cuequintosh");
		throw Ok(result);
    }


	function doCancel() {
		var cg = new db.Notification();
		cg.wktoken = "a";
		cg.status = "b";
		cg.parameters = "c";
		cg.insert();
		trace("cuec");
	}
	
    
}