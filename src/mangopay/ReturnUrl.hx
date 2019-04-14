package mangopay;
 
class ReturnUrl extends controller.Controller
{
 
  public function new() 
  {
    super();
    
  }
  
  
  //@tpl("amapadmin/default.mtt")
  function doDefault() {
    //var returnData = haxe.Json.parse(app.params.get("data"));
        throw Ok('/', app.params.toString());
  }
}