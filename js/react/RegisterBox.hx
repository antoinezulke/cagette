package react;
import react.ReactDOM;
import react.ReactComponent;
import react.ReactMacro.jsx;

typedef RegisterBoxState = {firstName:String, lastName:String, email:String, password:String, error:String, phone:String};
typedef RegisterBoxProps = {redirectUrl:String, phoneRequired:Bool};


/**
 * Registration box ( sign up )
 * @author fbarbut
 */
class RegisterBox extends react.ReactComponentOfPropsAndState<RegisterBoxProps,RegisterBoxState>
{

	
	public function new(props:RegisterBoxProps) 
	{
		if (props.redirectUrl == null) props.redirectUrl = "/";	
		super(props);		
		this.state = {firstName:"",lastName:"",email:"",password:"",error:null,phone:""};
	}
	
	
	override public function render(){
		
		//tips for conditionnal rendering : https://github.com/massiveinteractive/haxe-react#gotchas
		var phone = null;
		if (props.phoneRequired){
			phone = jsx('<div className="form-group">
				<label htmlFor="phone" className="col-sm-4 control-label">Téléphone : </label>
				<div className="col-sm-8">
					<input id="phone"  type="text" className="form-control" name="phone" value="${state.phone}" onChange={onChange} />			
				</div>
			</div>');
		}

		return jsx('
			<div>
				<$Error error="${state.error}" />
				<form action="" method="post" className="form-horizontal">
					<div className="form-group">
						<label htmlFor="firstName" className="col-sm-4 control-label">Vorname: </label>
						<div className="col-sm-8">
							<input id="firstName" type="text" name="firstName" value="${state.firstName}" className="form-control" onChange={onChange}/>					
						</div>					
					</div>
					<div className="form-group">
						<label htmlFor="lastName" className="col-sm-4 control-label">Name: </label>
						<div className="col-sm-8">
							<input id="lastName" type="text" name="lastName" value="${state.lastName}" className="form-control" onChange={onChange}/>					
						</div>					
					</div>
					<div className="form-group">
						<label htmlFor="email" className="col-sm-4 control-label">Email: </label>
						<div className="col-sm-8">
							<input id="email"  type="text" className="form-control" name="email" value="${state.email}" onChange={onChange} />			
						</div>
					</div>
					
					${phone}
					
					<div className="form-group">
						<label htmlFor="password" className="col-sm-4 control-label">Passwort: </label>
						<div className="col-sm-8">
							<input id="password" type="password" name="password" value="${state.password}" className="form-control" onChange={onChange}/>					
						</div>					
					</div>
					<p className="text-center">
						<a onClick={submit} className="btn btn-primary btn-lg" ><span className="glyphicon glyphicon-chevron-right"></span> Konto erstellen</a>
					</p>
				</form>
				<hr/>
				<p className="text-center">
					<b>Haben Sie schon einen Konto?  </b>
					<a onClick={loginBox} className="btn btn-default"><span className="glyphicon glyphicon-user"></span> Anmelden</a>
				</p>
			</div>
			
		');
	}
	
	/**
	 * @doc https://facebook.github.io/react/docs/forms.html
	 */
	function onChange(e:js.html.Event){
		
		e.preventDefault();
		var name :String = untyped e.target.name;
		var value :String = untyped e.target.value;
		//trace('onChange : $name = $value');
		Reflect.setField(state, name, value);
		this.setState(this.state);
	}
	
	/**
	 * displays a login box
	 */
	public function loginBox(){
		
		var body = js.Browser.document.querySelector('#myModal .modal-body');
		ReactDOM.unmountComponentAtNode( body );
	
		js.Browser.document.querySelector("#myModal .modal-title").innerHTML = "anmelden";
		ReactDOM.render(jsx('<$LoginBox redirectUrl="${props.redirectUrl}" />'),  body );
	}

	
	public function submit(e:js.html.Event ){
		
		if (state.email == ""){
			setError("Bitte Ihre Email eintippen");
			return;
		}
		
		if (state.password == ""){
			setError("Bitte Ihre Passwort eintippen");
			return;
		}
		
		if (state.firstName == ""){
			setError("Bitte Ihre Vorname eintippen");
			return;
		}
		
		if (state.lastName == ""){
			setError("Bitte Ihre Name eintippen");
			return;
		}
		
		if (state.phone == "" && props.phoneRequired){
			setError("Bitte Ihre Telefonnummer eintippen");
			return;
		}
		
		//lock button
		var el : js.html.Element = cast e.target;
		el.classList.add("disabled");
		
		var req = new haxe.Http("/api/user/register");
		req.addParameter("firstName", state.firstName);
		req.addParameter("lastName", state.lastName);
		req.addParameter("email", state.email);
		req.addParameter("password", state.password);
		req.addParameter("redirecturl", props.redirectUrl);
		if(props.phoneRequired) req.addParameter("phone", state.phone);
		
		req.onData = req.onError = function(d){
			var d =  req.responseData;
			el.classList.remove("disabled");			
			var d = haxe.Json.parse(d);
			if (Reflect.hasField(d, "error"))	setError(d.error.message);
			if (Reflect.hasField(d, "success")) js.Browser.window.location.href = props.redirectUrl;
		}
		
		req.request(true);
	}
	
	function setError(err:String){
		this.setState(cast {error:err});
	}
	
}