
 import 'package:happsales_crm/database/AppTables/TablesBase.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FinancialYear.dart';
import '../DataBaseHandler.dart';
import 'FinancialYearDataHandlerBase.dart';

class FinancialYearDataHandler extends FinancialYearDataHandlerBase {

     static Future<FinancialYear?> GetFinancialYearOfDate(DatabaseHandler databaseHandler, String date)async {
        FinancialYear? dataItem = null;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_FINANCIALYEAR + " A ";
            selectQuery += " WHERE (date(A." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ") <= date('" + date + "') AND date(A." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE + ") >= date('" + date + "')) ";
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

             final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
            Globals.handleException( "FinancialYearDataHandler:GetFinancialYearOfDate()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}