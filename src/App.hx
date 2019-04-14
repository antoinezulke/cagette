import db.User;
import thx.semver.Version;
import Common;
 
class App extends sugoi.BaseApp {

	public static var current : App = null;
	public static var t : sugoi.i18n.translator.ITranslator;
	public static var config = sugoi.BaseApp.config;
	
	public var eventDispatcher :hxevents.Dispatcher<Event>;	
	public var plugins : Array<sugoi.plugin.IPlugIn>;
	
	/**
	 * Version management
	 * @doc https://github.com/fponticelli/thx.semver
	 */ 
	//public static var VERSION = ([0,9,2]  : Version).withPre("july");
	public static var VERSION = ([0,9,2]  : Version).withPre(MyMacros.getGitShortSHA(), MyMacros.getGitCommitDate());
	
	public function new(){
		super();
	}
	
	public static function main() {
		
		App.t = sugoi.form.Form.translator = new sugoi.i18n.translator.TMap(getTranslationArray(), "fr");
		sugoi.BaseApp.main();
	}
	
	/**
	 * Init plugins and event dispatcher just before launching the app
	 */
	override public function mainLoop() {
		eventDispatcher = new hxevents.Dispatcher<Event>();
		plugins = [];
		//internal plugins
		plugins.push(new plugin.Tutorial());
		
		//optionnal plugins
		#if plugins
		plugins.push( new hosted.HostedPlugIn() );				
		plugins.push( new pro.ProPlugIn() );		
		plugins.push( new connector.ConnectorPlugIn() );				
		plugins.push( new pro.LemonwayEC() );
		plugins.push( new who.WhoPlugIn() );
		#end
	
		super.mainLoop();
	}
	
	public function getCurrentGroup(){		
		if (session == null) return null;
		if (session.data == null ) return null;
		var a = session.data.amapId;
		if (a == null) {
			return null;
		}else {			
			return db.Amap.manager.get(a,false);
		}
	}
	
	override function beforeDispatch() {
		
		//send "current page" event
		event( Page(this.uri) );
		
		super.beforeDispatch();
	}
	
	public function getPlugin(name:String):sugoi.plugin.IPlugIn {
		for (p in plugins) {
			if (p.getName() == name) return p;
		}
		return null;
	}
	
	public static function log(t:Dynamic) {
		if(App.config.DEBUG) {
			neko.Web.logMessage(Std.string(t)); //write in Apache error log
			#if weblog
			Weblog.log(t); //write en Weblog console (https://lib.haxe.org/p/weblog/)
			#end
		}
	}
	
	public function event(e:Event) {
		this.eventDispatcher.dispatch(e);
		return e;
	}
	
	/**
	 * Translate DB objects fields in forms
	 */
	public static function getTranslationArray() {
		//var t = sugoi.i18n.Locale.texts;
		var out = new Map<String,String>();
		//out.set("firstName", t._("First name") );
		//out.set("lastName", t._("Last name"));
		// out.set("firstName2", "Prénom du conjoint");
		// out.set("lastName2", "Nom du conjoint");
		// out.set("email2", "e-mail du conjoint");
		// //out.set("pass", t._("Password") );
		// //out.set("address1", t._("address") );
		// //out.set("address2", t._("address") );
		// out.set("zipCode", "code postal");
		// out.set("city", "commune");
		// out.set("phone", "téléphone");
		// out.set("phone2", "téléphone du conjoint");
		// out.set("select", "sélectionnez");
		// out.set("contract", "Contrat");
		 //out.set("place", "Lieu");
		//out.set("place", "Ort");
		// out.set("name", "Nom");
		// out.set("cdate", "Date d'entrée dans le groupe");
		// out.set("quantity", "Quantité");
		// out.set("paid", "Payé");
		// out.set("user2", "(facultatif) partagé avec ");
		// out.set("product", "Produit");
		// out.set("user", "Adhérent");
		// out.set("txtIntro", "Texte de présentation du groupe");
		// out.set("txtHome", "Texte en page d'accueil pour les adhérents connectés");
		// out.set("txtDistrib", "Texte à faire figurer sur les listes d'émargement lors des distributions");
		// out.set("extUrl", "URL du site du groupe.");
		
		// out.set("distributor1", "Distributeur 1");
		// out.set("distributor2", "Distributeur 2");
		// out.set("distributor3", "Distributeur 3");
		// out.set("distributor4", "Distributeur 4");
		// out.set("distributorNum", "Nbre de distributeurs nécessaires (de 0 à 4)");
		
		// out.set("startDate", "Date de début");
		 out.set("startDate", "Startdatum");
		// out.set("endDate", "Date de fin");
		out.set("endDate", "Enddatum");
		
		// out.set("orderStartDate", "Date ouverture des commandes");
		// out.set("orderEndDate", "Date fermeture des commandes");	
		// out.set("openingHour", "Heure d'ouverture");	
		// out.set("closingHour", "Heure de fermeture");	
		
		// out.set("date", "Date de distribution");	
		// out.set("active", "actif");	
		
		// out.set("contact", "Reponsable");
		// out.set("vendor", "Producteur");
		// out.set("text", "Texte");
		// out.set("flags", "Options");
		 out.set("4h", "4 Stunden vor Lieferung eine Erinnerung erhalten");
		// out.set("HasEmailNotif4h", "Recevoir des notifications par email 4h avant les distributions");
		out.set("HasEmailNotif4h", "4 Stunden vor Lieferung eine Erinnerung erhalten");
		 //out.set("24h", "Recevoir des notifications par email 24h avant les distributions");
		 out.set("24h", "24 Stunden vor Lieferung eine Erinnerung erhalten");
		 //out.set("HasEmailNotif24h", "Recevoir des notifications par email 24h avant les distributions");
		 out.set("HasEmailNotif24h", "24 Stunden vor Lieferung eine Erinnerung erhalten");
		// out.set("Ouverture", "Recevoir des notifications par email pour l'ouverture des commandes");
		 out.set("Ouverture", "Bei Eröffnung einer Bestellung eine Nachricht erhalten");
		// out.set("Tuto", "Activer tutoriels");
		 //out.set("HasMembership", "Gestion des adhésions");
		 out.set("HasMembership", "Mitgliedschaft verwalten");
		// out.set("DayOfWeek", "Jour de la semaine");
		// out.set("Monday", "Lundi");
		// out.set("Tuesday", "Mardi");
		// out.set("Wednesday", "Mercredi");
		// out.set("Thursday", "Jeudi");
		// out.set("Friday", "Vendredi");
		// out.set("Saturday", "Samedi");
		// out.set("Sunday", "Dimanche");
		// out.set("cycleType", "Récurrence");
		 //out.set("Weekly", "hebdomadaire");
		 out.set("Weekly", "wöchentlich");
		// out.set("Monthly", "mensuelle");
		out.set("Monthly", "monatlich");
		// out.set("BiWeekly", "toutes les deux semaines");
		out.set("BiWeekly", "alle 2 Wochen");
		// out.set("TriWeekly", "toutes les 3 semaines");
		out.set("TriWeekly", "alle 3 Wochen");
		// out.set("price", "prix TTC");
		// out.set("uname", "Nom");
		// out.set("pname", "Produit");
		// out.set("organic", "Agriculture biologique");
		// out.set("hasFloatQt", "Autoriser quantités \"à virgule\"");
		
		// out.set("membershipRenewalDate", "Adhésions : Date de renouvellement");
		// out.set("membershipPrice", "Adhésions : Coût de l'adhésion");
		 //out.set("UsersCanOrder", "Les adhérents peuvent saisir leur commande en ligne");
		 out.set("UsersCanOrder", "Mitglieder können ihre Bestellung online aufgeben");
		 //out.set("StockManagement", "Gestion des stocks");
		 out.set("StockManagement", "Warenwirtschaft");
		// out.set("contact", "Responsable");
		 //out.set("PercentageOnOrders", "Ajouter des frais au pourcentage de la commande");
		 out.set("PercentageOnOrders", "Kosten als Procentangabe hinzufügen");
		// out.set("percentageValue", "Pourcentage des frais");
		// out.set("percentageName", "Libellé pour ces frais");
		// out.set("fees", "frais");
		 //out.set("AmapAdmin", "Administrateur du groupe");
		 out.set("AmapAdmin", "Administrator der Gruppe");
		 //out.set("Membership", "Accès à la gestion des adhérents");
		 out.set("Membership", "Zugang zu den Mitglieder");
		 //out.set("Messages", "Accès à la messagerie");
		 out.set("Messages", "Zugang zu den Nachrichten");
		// out.set("vat", "TVA");
		// out.set("desc", "Description");
		 //out.set("ShopMode", "Mode boutique");
		 out.set("ShopMode", "Online Marktplatz");
		 //out.set("ComputeMargin", "Appliquer une marge à la place des pourcentages");
		 out.set("ComputeMargin", "Eine Marge anstelle von % anwenden");
		 //out.set("ShopCategoriesFromTaxonomy", "Catégoriser automatiquement les produits");
		 out.set("ShopCategoriesFromTaxonomy", "Produkte automatisch kategorisieren");
		 //out.set("HidePhone", "Masquer le téléphone du responsable sur la page publique");
		 out.set("HidePhone", "Tel. des Koord. auf der öffentlichen Seite ausblenden");
		 //out.set("PhoneRequired", "Saisie du numéro de téléphone obligatoire");
		 out.set("PhoneRequired", "Tel.-Nr. als Pflichtfeld angeben");
		// out.set("ref", "Référence");
		// out.set("linkText", "Intitulé du lien");
		// out.set("linkUrl", "URL du lien");
		
		 //out.set("Amap", "AMAP");
		 out.set("Amap", "Solidarische Landwirtschaft");
		 //out.set("GroupedOrders", "Groupement d'achat");
		 out.set("GroupedOrders", "Einkaufsgemeinschaft");
		 //out.set("ProducerDrive", "Collectif de producteurs");
		 out.set("ProducerDrive", "Landwirt / Bauerngemeinschaft");
		 //out.set("FarmShop", "Vente à la ferme");
		 out.set("FarmShop", "Hofladen");
		 out.set("Consultant", "RepräsentantIn");
		
		// out.set("regOption", "Inscription de nouveaux adhérents");
		 //out.set("Closed", "Fermé : Le coordinateur ajoute les nouveaux adhérents");
		 out.set("Closed", "Geschloßen: Der Organisator fügt neue Mitglieder hinzu");
		 //out.set("WaitingList", "Liste d'attente");
		 out.set("WaitingList", "Warteliste");
		 //out.set("Open", "Ouvert : tout le monde peut s'inscrire");
		 out.set("Open", "Geöffnet : Jeder der sich einträgt wird automatisch der Gruppe hinzugefügt");
		 //out.set("Full", "Complet : Le groupe n'accepte plus de nouveaux adhérents");
		 out.set("Full", "Komplett : Die Gruppe nimmt zurzeit keine neuen Mitglieder auf");
		 
		// out.set("percent", "Pourcentage");
		// out.set("pinned", "Mets en avant les produits");
		
		 out.set("CagetteNetwork", "Me lister dans l'annuaire des groupes Cagette.net");
		// out.set("unitType", "Unité");
		// out.set("qt", "Quantité");
		 //out.set("Unit", "Pièce");
		 out.set("Kilogram", "Kilogramm");
		 out.set("Gram", "Gramm");
		 out.set("Litre", "Liter");
		 out.set("Centilitre", "Zentiliter");
		 out.set("Piece", "Stückpreis");
		// out.set("htPrice", "Prix H.T");
		// out.set("amount", "Montant");
		
		 //out.set("HasPayments", "Gestion des paiements");
		 out.set("HasPayments", "Finanzen verwalten");
		
		// out.set("byMember", "Par adhérent");
		// out.set("byProduct", "Par produit");

		out.set("cash", "Bar");
		out.set("transfer", "Überweisung");

		return out;
	}
	
	
	public function populateAmapMembers() {		
		return user.amap.getMembersFormElementData();
	}
	
	public static function getMailer():sugoi.mail.IMailer {
		
		if (App.config.DEBUG){	
			return new sugoi.mail.DebugMailer();
		}
		
		if (sugoi.db.Variable.get("mailer") == null){
			var msg = sugoi.i18n.Locale.texts._("Please configure the email settings in a <href='/admin/emails'>this section</a>");
			throw sugoi.BaseController.ControllerAction.ErrorAction("/",msg);
		}
		
		var conf = {
			smtp_host:sugoi.db.Variable.get("smtp_host"),
			smtp_port:sugoi.db.Variable.getInt("smtp_port"),
			smtp_user:sugoi.db.Variable.get("smtp_user"),
			smtp_pass:sugoi.db.Variable.get("smtp_pass")			
		}
		
		if (sugoi.db.Variable.get("mailer") == "mandrill"){
			return new sugoi.mail.MandrillMailer().init(conf);
		}else{
			return new sugoi.mail.SmtpMailer().init(conf);
		}

	}
	
	/**
	 * Send an email and store the result in a db.Message
	 * @param	e
	 */
	public static function sendMail(m:sugoi.mail.Mail, ?group:db.Amap, ?listId:String, ?sender:db.User){
		
		if (group == null) group = App.current.user == null ? null:App.current.user.getAmap();
		
		current.event(SendEmail(m));
		
		getMailer().send(m, function(o){
	
			//store result
			var lm = new db.Message();
			lm.amap =  group;
			lm.recipients = Lambda.array(Lambda.map(m.getRecipients(), function(x) return x.email));
			lm.title = m.getSubject();
			lm.date = Date.now();
			lm.body = m.getHtmlBody();
			lm.rawStatus = Std.string(o);
			lm.status = o;
			if (listId != null) lm.recipientListId = listId;
			if (sender != null) lm.sender = sender;
			lm.insert();
		});
		
	}
	
	public static function quickMail(to:String, subject:String, html:String){
		var e = new sugoi.mail.Mail();		
		e.setSubject(subject);
		e.setRecipient(to);			
		e.setSender(App.config.get("default_email"),"Cagette Pro");				
		var html = App.current.processTemplate("mail/message.mtt", {text:html});		
		e.setHtmlBody(html);
		try{
			App.sendMail(e);
		}catch(e:Dynamic){
			App.current.logError(e);
		}
	}
	
	/**
	 * process a template and returns the generated string
	 * @param	tpl
	 * @param	ctx
	 */
	public function processTemplate(tpl:String, ctx:Dynamic):String {
		
		Reflect.setField(ctx, 'HOST', App.config.HOST);
		Reflect.setField(ctx, 'hDate', App.current.view.hDate);
		//i18n functions
		ctx._ = App.current.view._;
		ctx.__ = App.current.view.__;
		
		var tpl = loadTemplate(tpl);
		var html = tpl.execute(ctx);	
		#if php
		if ( html.substr(0, 4) == "null") html = html.substr(4);
		#end
		return html;
	}
	
	
	
}
