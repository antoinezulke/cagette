package controller;
import sugoi.form.Form;

class Lemonway extends Controller
{
    public var hop:String = "hop";

	public function new()
	{
		super();
	}

    @tpl("lemonway/error.mtt")
	function doError() {
	}

    @tpl("lemonway/ok.mtt")
	function doOk() {
		var mp=new mangopay.Mangopay();
		mp.createWalletExample();
	}

    @tpl("lemonway/cancel.mtt")
	function doAbort() {
	}

    @tpl("lemonway/default.mtt")
	function doCharge() {
		var mp=new mangopay.Mangopay();
		mp.createUserExample();
    }
}