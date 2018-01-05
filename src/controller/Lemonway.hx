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
	function doDefault() {
        var req = new haxe.Http("http://api.coindesk.com/v1/bpi/currentprice.json");
        req.onData = function(data) {
            this.hop += " - data: " + data;
            var json = haxe.Json.parse(data);
            throw Ok('/', "Data recues:"+data);
        }
        req.onError = function(error) {
            this.hop += " - error: " + error;
            throw Ok('/', "Error:"+error);
        }
        // req.onStatus = function(status) {
        //     this.hop += " - status: " + status;
        //     throw Ok('/', "Status:"+status);
        // }
        req.request(false);
    }
    
}