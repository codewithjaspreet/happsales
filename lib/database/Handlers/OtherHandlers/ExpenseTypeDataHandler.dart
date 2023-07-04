import 'package:happsales_crm/database/AppTables/ColumnsBase.dart';
import 'package:happsales_crm/database/AppTables/TablesBase.dart';

import '../../Globals.dart';
import '../../models/OtherModels/ExpenseType.dart';
import '../DataBaseHandler.dart';
import 'ExpenseTypeDataHandlerBase.dart';

class ExpenseTypeDataHandler extends ExpenseTypeDataHandlerBase{

  static Future<ExpenseType?> GetExpenseTypeRecordByName(DatabaseHandler databaseHandler, String expenseName) async{
        ExpenseType? dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_EXPENSETYPE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME + " = '" + expenseName + "'";
            //selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + Columns.KEY_EXPENSETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
  final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ExpenseType dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

      }
        } catch ( ex) {
            Globals.handleException( "ExpenseTypeDataHandlerBase:GetExpenseTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }
}