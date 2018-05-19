package db;
import sys.db.Types;
import Common;

class Notification extends sys.db.Object
{
	public var id : SId;
	public var wktoken :SString<128>;
	public var status :SString<128>;
	public var parameters :SString<128>;
}