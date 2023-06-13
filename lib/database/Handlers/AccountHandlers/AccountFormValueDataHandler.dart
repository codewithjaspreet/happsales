

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountFormValue.dart';
import '../DataBaseHandler.dart';
import 'AccountFormValueDataHandlerBase.dart';

class AccountFormValueDataHandler extends AccountFormValueDataHandlerBase {

     static Future<List<AccountFormValue>> GetAccountFormValueRecordsByAccountFormId(DatabaseHandler databaseHandler,  String accountFormId) async{
        List<AccountFormValue> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
            selectQuery += " ,E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID},F.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELL} F ON E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = $accountFormId";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                        AccountFormValue     dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
           // Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountFormValue>> GetAccountFormValueUpSyncRecordsByAccountFormId(DatabaseHandler databaseHandler,  String accountFormId) async{
        List<AccountFormValue> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = $accountFormId";
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

                final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                         AccountFormValue    dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
           // Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	/*-------------------HAPPSALES-------------------*/

}