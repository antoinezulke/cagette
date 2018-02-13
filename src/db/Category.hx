package db;
import sys.db.Types;
import Common;

class Category extends sys.db.Object
{

	public var id : SId;
	public var name :SString<128>;

	@:relation(categoryGroupId) public var categoryGroup:db.CategoryGroup;
	
	/**
	 * renvoie la couleur de la categorie en hexa
	 * @return
	 */
	public function getColor():String {
		return App.current.view.intToHex(db.CategoryGroup.COLORS[categoryGroup.color]);
	}
	
	public function infos():CategoryInfo{
		
		return {id:id, name:name, /*parent:categoryGroup.id, /*pinned:categoryGroup.pinned*/};
		
	}

	public static function getLabels(){
		var t = sugoi.i18n.Locale.texts;
		return [
			"name" => t._("Name of the category"),	
		];
	}
}