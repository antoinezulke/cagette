package db;

/*
CREATE TABLE Confirmation (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     hash CHAR(80) NOT NULL,
     PRIMARY KEY (id)
);
alter table Confirmation add column object_id int not null;
alter table Confirmation add column confirmed int not null;

*/

import sys.db.Types;
import Common;
import payment.UUID;

class Confirmation extends sys.db.Object
{
	public var id : SId;
	public var hash :SString<128>;
	public var what :SString<128>;
	public var object_id :SInt;
	public var confirmed :SInt;

    public function new() {
        hash = UUID.uuid();
		super();
	}

    /*
    Returns the object for the confirmation Hash,
    also writes that the record was confirmed.
    */
    public static function confirmForHash(hash: String) {
        var c = db.Confirmation.manager.select($hash == hash, true);	
        c.confirmed = 1;
        c.update();
        return c.object_id;
    }
}