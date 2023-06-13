import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountForm.dart';
import '../DataBaseHandler.dart';
import 'AccountFormDataHandlerBase.dart';

class AccountFormDataHandler extends AccountFormDataHandlerBase {


     static Future<List<AccountForm>> GetAccountFormRecordsByActivityId(DatabaseHandler databaseHandler,  String activityId) async {
        List<AccountForm> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = $activityId";

           final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
            //db.close();
        } catch ( ex) {
          //  Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountForm>> GetAccountFormRecordsByOpportunityId(DatabaseHandler databaseHandler,  String opportunityId) async{
        List<AccountForm> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = $opportunityId";

          final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
           // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountForm>> GetAccountFormRecordsByAccountId(DatabaseHandler databaseHandler,  String accountId) async{
        List<AccountForm> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = $accountId";

            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          //  Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<AccountForm>> GetMasterAccountFormRecordsForValuesUpSync(DatabaseHandler databaseHandler) async{
        List<AccountForm> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID} IS NOT NULL ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID},-1) > -1 ";
            selectQuery += " AND A.${ColumnsBase.KEY_ID} IN (";
            selectQuery += " SELECT DISTINCT IQ.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} IQ WHERE IQ.${ColumnsBase.KEY_ISDIRTY} = 'true' ";
            selectQuery += " AND IQ.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} IS NOT NULL AND IQ.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} <> '' ";
            selectQuery += " ) LIMIT 1";

          final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          //  Globals.HandleException(context, "AccountFormDataHandler:GetAccountFormRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	/*-------------------HAPPSALES-------------------*/

}