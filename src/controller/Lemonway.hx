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
        var now = Date.now();

		//correct the time to get the local time, by using the correction in the config file
		//var now2 = DateTools.delta(now, DateTools.hours(Std.parseFloat(App.config.get("nowdate_correction"))));

		throw Ok('/messages', "Server date now: " + now.toString());




        // var req = new haxe.Http("http://api.coindesk.com/v1/bpi/currentprice.json");
        // req.onData = function(data) {
        //     this.hop += " - data: " + data;
        //     var json = haxe.Json.parse(data);
        //     throw Ok('/', "Data recues:"+data);
        // }
        // req.onError = function(error) {
        //     this.hop += " - error: " + error;
        //     throw Ok('/', "Error:"+error);
        // }
        // // req.onStatus = function(status) {
        // //     this.hop += " - status: " + status;
        // //     throw Ok('/', "Status:"+status);
        // // }
        // req.request(false);
    }
    
}