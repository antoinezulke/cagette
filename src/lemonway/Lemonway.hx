package lemonway;
 
class Lemonway extends controller.Controller
{
    private var params:Map<String, String>;
 
    private var httpRequest:haxe.Http;
 
    public function new()
  {
        super();
        httpRequest = new haxe.Http("");
        httpRequest.setHeader("Content-Type", "application/json");
        params = new Map<String, String>();
        params.set("wlLogin", "lemilo");
        params.set("wlPass", "lemilo1234");
        params.set("language", "ge");
        params.set("walletIp", "172.94.15.7");
        //params.set("walletUa", "");
  }
 
    public function MoneyIn(wallet:String, amountTot:Float, amountPerc:Float)
    {
        httpRequest.url = "https://sandbox-api.lemonway.fr/mb/lemilo/dev/directkitjson2/service.asmx/MoneyInWebInit";
        params.set("version", "1.3");
        params.set("amountCom", Std.string(round2decimals(amountTot*amountPerc/100)));
        params.set("returnUrl", "http://app.lemilo.eu/lemonwayreturnurl");
        params.set("errorUrl", "http://app.lemilo.eu/lemonwayerrorurl");
        params.set("cancelUrl", "http://app.lemilo.eu/lemonwaycancelurl");
        params.set("wallet", wallet);
        params.set("amountTot", Std.string(round2decimals(amountTot)));
        
        //Enregistrer la transaction dans mySQL et returner l'identifiant pour wkToken
        params.set("wkToken", "99999999998");
 
        Call();
    }
 
    private function Call()
    {
        var myMap:Map<String,Map<String,String>> = ["p" => params];
        var myJson = haxe.Json.stringify(myMap);
        //throw Ok('/', myJson);
        httpRequest.setPostData(myJson);
 
        httpRequest.onData = function(data) {
            var json = haxe.Json.parse(data);
            //throw Ok('/', "Data recues:"+data);
 
            //log the success of the transaction in the database
 
            //Redirect to Webkit
            neko.Web.redirect("https://sandbox-webkit.lemonway.fr/lemilo/dev/?moneyintoken=" + json.d.MONEYINWEB.TOKEN + "&lang=de");