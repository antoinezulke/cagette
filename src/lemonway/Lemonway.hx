package lemonway;
 
class Lemonway 
{
    private var params:Map<String, String>;
 
    private var httpRequest:haxe.Http;
 
    public function new()
  {
        httpRequest = new haxe.Http("");
        httpRequest.setHeader("Content-Type", "application/json");
        params = new Map<String, String>();
        params.set("wlLogin", "lemilo");
        params.set("wlPass", "lemilo1234");
       // params.set("language", "ge");
        params.set("walletIp", "172.94.15.7");
  }
 
   public function createWallet(wallet: String) 
   {
        httpRequest.url = "https://sandbox-api.lemonway.fr/mb/lemilo/dev/directkitjson2/service.asmx/RegisterWallet";
        params.set("version", "1.3");
        params.set("wallet", wallet);
        params.set("clientMail", "juanito@per.pop");
        params.set("clientFirstName", "Juan");
        params.set("clientLastName", "Gonzalez");

        params.set("ctry", "FRA");
        
        params.set("birthdate", "21/03/1985");
        params.set("isCompany", "0");
        params.set("nationality", "FRA");

        Call();
        return "KK";
    }

    public function moneyIn(wallet:String, amountTot:Float, amountPerc:Float)
    {
        httpRequest.url = "https://sandbox-api.lemonway.fr/mb/lemilo/dev/directkitjson2/service.asmx/MoneyInWebInit";
        params.set("version", "1.3");
        params.set("wallet", wallet);
            params.set("amountTot", "15.00");
//        params.set("returnUrl", "http://www.lemilo.de/lemonwayreturnurl");
//        params.set("errorUrl", "http://www.lemilo.de/lemonwayerrorurl");
//        params.set("cancelUrl", "http://www.lemilo.de/lemonwaycancelurl");
        
        //Enregistrer la transaction dans mySQL et returner l'identifiant pour wkToken
//        params.set("wkToken", "5652773");
 
        Call();
        return "HEY";
    }
 
    private function Call()
    {
        var myMap:Map<String,Map<String,String>> = ["p" => params];
        var myJson = haxe.Json.stringify(myMap);
        httpRequest.setPostData(myJson);
 
        httpRequest.onData = function(data) {
            var json = haxe.Json.parse(data);
            trace("<hr>");
            trace(myJson);
            trace("<hr>");
            trace(json.d);
            trace("<hr>");
        }
            trace("B<br>");
            httpRequest.request(true);
    }
}
            //log the success of the transaction in the database
 
            //Redirect to Webkit
            // neko.Web.redirect("https://sandbox-webkit.lemonway.fr/lemilo/dev/?moneyintoken=" + json.d.MONEYINWEB.TOKEN + "&lang=de");