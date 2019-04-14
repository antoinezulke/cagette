package mangopay;

typedef LW = {
  var ClientId:String;
  var Name:String;
  var RegisteredName:String;
}

typedef LW2 = {
  var MONEYINWEB:LW3;
}

typedef LW3 = {
  var TOKEN:String;
}

typedef MPUser = {
  var FirstName: String;
}

typedef UserAnswer = {
  var Id: String;
}

typedef MPWallet = {
  var Tag: String;
  var Owners: Array<String>;
  var Description: String;
  var Currency: String;
}

// curl -H "Authorization:Basic bGVtaWxvYm94Ok11R3NRMTdMYUZmNDhyNUZpNFRZMXlPVjJoMkhZTmJjYkJXc3o1dGIycTdldTczeXcz" https://api.sandbox.mangopay.com/v2.01/lemilobox/clients

class Mangopay 
{
    private var params:Map<String, String>;
 
    private var httpRequest:haxe.Http;
 
    private var token:String;
 
    public function new() {
        httpRequest = new haxe.Http("");
        httpRequest.setHeader("Content-Type", "application/json");
        params = new Map<String, String>();
        var clientId="lemilobox";
        var apiKey="MuGsQ17LaFf48r5Fi4TY1yOV2h2HYNbcbBWsz5tb2q7eu73yw3";
        var base64="bGVtaWxvYm94Ok11R3NRMTdMYUZmNDhyNUZpNFRZMXlPVjJoMkhZTmJjYkJXc3o1dGIycTdldTczeXcz";
        var authHeader="Basic "+base64;
        httpRequest.setHeader("Authorization", authHeader);
        trace("kk");
  }

    public function moneyIn()
    {
        httpRequest.url = "https://api.sandbox.mangopay.com/v2.01/lemilobox/clients";
        get();
        return token;
    }

    public function createUserExample() {
      createUser("Pedro","Perez",1463496101, "GB", "FR", "support@mangopay.com");
    }

    public function createUser(firstName: String, lastName: String, birthday: Int, nationality: String,
    countryOfResidence: String, email: String) {
        httpRequest.url = "https://api.sandbox.mangopay.com/v2.01/lemilobox/users/natural";
        var mpUser = {
          FirstName : firstName,
          "LastName" : lastName, 
          "Birthday": birthday,
          "Nationality": nationality,
          "CountryOfResidence": countryOfResidence,
          "Email": email
        };
        var myJson = haxe.Json.stringify(mpUser);
        httpRequest.setPostData(myJson);
 
        httpRequest.onData = function(data) {
            var json:UserAnswer = haxe.Json.parse(data);
            trace("//");
            trace(json.Id);
        }

        httpRequest.onError = function(msg) { 
        trace("<hr>"); 
        trace(msg);
        trace("<hr>"); 
        }

        httpRequest.request(true);
    }

  // wallet

    public function createWalletExample() {
      createWallet("tag0", "64037462", "Lemilo wallet", "EUR");
    }

    public function createWallet(tag: String, owner: String, description: String, currency: String) {
        httpRequest.url = "https://api.sandbox.mangopay.com/v2.01/lemilobox/wallets";
        var mpWallet = {
          "Tag": tag,
          "Owners": [ owner ],
          "Description": description,
          "Currency": currency
        };

        httpRequest.setPostData(haxe.Json.stringify(mpWallet));
        httpRequest.onData = function(data) {
            var json:UserAnswer = haxe.Json.parse(data);
            trace("//");
            trace(json.Id);
        }

        httpRequest.onError = function(msg) { 
          trace("<hr>ERROR</hr>"); 
          trace(msg);
          trace("<hr>"); 
        }

        httpRequest.request(true);
    }


    private function get() {
      trace("zz");
        httpRequest.onData = function(data) {
          trace("mm");
            var json:LW = haxe.Json.parse(data);
            trace(json.ClientId);
            trace(json.Name);
            trace(json.RegisteredName);
        }
        httpRequest.request();
    }

    private function call()
    {
        var myMap:Map<String,Map<String,String>> = ["p" => params];
        trace(params);
        var myJson = haxe.Json.stringify(myMap);
        httpRequest.setPostData(myJson);
 
        httpRequest.onData = function(data) {
            var json:LW = haxe.Json.parse(data);
            trace(json);
        }
        httpRequest.request(true);
    }
}
            //log the success of the transaction in the database
 
            //Redirect to Webkit
            // neko.Web.redirect("https://sandbox-webkit.lemonway.fr/lemilo/dev/?moneyintoken=" + json.d.MONEYINWEB.TOKEN + "&lang=de");
            //https://sandbox-webkit.lemonway.fr/YOUR_COMPANY/dev/?moneyintoken=1wGaBwkdOmOxWT0s4t1Z1364815