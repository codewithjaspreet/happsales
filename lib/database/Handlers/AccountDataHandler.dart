import 'package:sqflite/sqflite.dart';
import '../ColumnsBase.dart';
import '../Globals.dart';
import '../TablesBase.dart';

class AccountDataHandlerBase{


Future<int> deleteAccountRecord(Database databaseHandler, String id1) async {

 final db = await databaseHandler.database;

  // Remove the account from the database by id.
  int id = await db.delete(
    TablesBase.TABLE_ACCOUNT,

    // Use a `where` clause to delete a specific account by id.
    where: "${ColumnsBase.KEY_ID} = $id1",


    whereArgs: [null],
  );

  return id;
}




// getting  account server id from local id

Future<String> getServerId(Database databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

    Database db = await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
    if (result.isNotEmpty) {
      serverId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
    }
    //db.close();
  } catch (ex) {
    // Globals.handleException(context, "AccountDataHandlerBase:GetServerId()", ex);
    throw ex;
  }
  return serverId;
}


}