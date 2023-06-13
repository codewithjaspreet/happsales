

import "../../AppTables/ColumnsBase.dart";
import "../../AppTables/TablesBase.dart";
import "../../Globals.dart";
import "../../models/AccountModels/AccountCategoryMapping.dart";
import "../DataBaseHandler.dart";
import "AccountMappingDataHandlerBase.dart";

 class AccountCategoryMappingDataHandler extends AccountCategoryMappingDataHandlerBase {

     static Future<List<AccountCategoryMapping>> GetAccountCategoryMappingRecordsForAccount(DatabaseHandler databaseHandler, String accountId) async {
        List<AccountCategoryMapping> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = $accountId" ;
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} COLLATE NOCASE ASC ";

          final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(accountCategoryMapping);
      }
            //db.close();
        } catch ( ex) {
           // Globals.HandleException(context, "AccountCategoryMappingDataHandler:GetAccountCategoryMappingRecordsForAccount()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountCategoryMapping>> GetAccountCategoryMappingRecordsAllForAccount(DatabaseHandler databaseHandler, String accountId) async{
        List<AccountCategoryMapping> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = $accountId" ;
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} COLLATE NOCASE ASC ";

        final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(accountCategoryMapping);
      }
        } catch ( ex) {
           // Globals.HandleException(context, "AccountCategoryMappingDataHandler:GetAccountCategoryMappingRecordsForAccount()", ex);
            throw ex;
        }
        return dataList;
    }

    /*-------------------HAPPSALES-------------------*/

}