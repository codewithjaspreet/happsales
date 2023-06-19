

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityTravelExpense.dart';
import '../DataBaseHandler.dart';
import 'ActivityTravelExpenseDataHandlerBase.dart';

class ActivityTravelExpenseDataHandler extends ActivityTravelExpenseDataHandlerBase {


     static Future<List<ActivityTravelExpense>> GetActivityTravelExpenseRecordsByActivityTravelID(DatabaseHandler databaseHandler,  String id) async{
        List<ActivityTravelExpense> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE},'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityTravelExpense_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = $id";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID}";

              final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
        dataList.add(dataItem);
      }

        } catch ( ex) {
            Globals.handleException( "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseRecordsByActivityTravelID()", ex);
            throw ex;
        }
        return dataList;
    }

}
