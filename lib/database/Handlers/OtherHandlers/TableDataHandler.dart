 import 'package:happsales_crm/database/AppTables/ColumnsBase.dart';

import '../../Globals.dart';
import '../DataBaseHandler.dart';

class TableDataHandler {

     static Future<void> SoftDeleteRecord(DatabaseHandler databaseHandler, String tableName, String id) async{
        try {
            final db = await databaseHandler.database;
            db.execute("UPDATE " + tableName + " SET " + ColumnsBase.KEY_ISDELETED + " = 'true' WHERE " + ColumnsBase.KEY_ID + " = " + id);
        } catch ( ex) {
            Globals.handleException( "TableDataHandler:SoftDeleteRecord()", ex);
            throw ex;
        }
    }

	/*-------------------HAPPSALES-------------------*/

}