

 import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountPhone.dart';
import '../DataBaseHandler.dart';

class AccountPhoneDataHandlerBase {

     static Future<List<AccountPhone>> GetAccountPhoneRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<AccountPhone> dataList = <AccountPhone>[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${Columns.KEY_ACCOUNTADDRESS_ADDRESS}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTADDRESS} B ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME} LIKE '%${searchString.replaceAll("'","''")}"}%'";
            }

            /* FILTER */
			/*String groups = "";
			String tags = "";
			String groupitem = "";
			for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
				String key1 = entry.getKey();
				String value1 = entry.getValue();
				if (entry.getKey().equals("XXXXX")) {
					groupitem = value1;
				} else {
					groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
					tags += (tags.equals("") ? value1 : "," + value1);
				}
			}
			if (groupitem.trim().length() > 0)
				selectQuery += " AND A." + ColumnsBase.KEY_AccountPhone_Columns.KEY_ACCOUNTPHONE_PHONETYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
          //  Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountPhone>> GetAccountPhoneRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AccountPhone> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${Columns.KEY_ACCOUNTADDRESS_ADDRESS}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTADDRESS} B ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length>  0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME} LIKE '${searchString.replaceAll("'","''")}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME} COLLATE NOCASE ASC ";

           
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            //Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AccountPhone?> GetAccountPhoneRecord(DatabaseHandler databaseHandler,  String id) async{
        AccountPhone? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${Columns.KEY_ACCOUNTADDRESS_ADDRESS}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTADDRESS} B ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];


            }
        } catch ( ex) {
            //Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneRecords()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AccountPhone?> GetMasterAccountPhoneRecord(DatabaseHandler databaseHandler,  String id)async {
        AccountPhone? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${Columns.KEY_ACCOUNTADDRESS_ADDRESS}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTADDRESS} B ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID} = $id";
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];


            }
        } catch ( ex) {
            //Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneRecords()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAccountPhoneRecord(DatabaseHandler databaseHandler,  AccountPhone dataItem)async {
        int id = 0;

        final db = await databaseHandler.database;
        try {
           Map<String, dynamic> values = {
  if (dataItem.accountPhoneID != null && dataItem.accountPhoneID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID: dataItem.accountPhoneID,
  if (dataItem.accountPhoneCode != null && dataItem.accountPhoneCode != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE: dataItem.accountPhoneCode,
  if (dataItem.phone != null && dataItem.phone != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_PHONE: dataItem.phone,
  if (dataItem.phoneTypeName != null && dataItem.phoneTypeName != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME: dataItem.phoneTypeName,
  if (dataItem.accountID != null && dataItem.accountID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID: dataItem.accountID,
  if (dataItem.accountAddressID != null && dataItem.accountAddressID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID: dataItem.accountAddressID,
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY: dataItem.createdBy,
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON: dataItem.createdOn,
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY: dataItem.modifiedBy,
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON: dataItem.modifiedOn,
  if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER: dataItem.deviceIdentifier,
  if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER: dataItem.referenceIdentifier,
  if (dataItem.isActive != null && dataItem.isActive != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE: dataItem.isActive,
  if (dataItem.uid != null && dataItem.uid != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_UID: dataItem.uid,
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID: dataItem.appUserID,
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID: dataItem.appUserGroupID,
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED: dataItem.isArchived,
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED: dataItem.isDeleted,
  if (dataItem.id != null && dataItem.id != "null")
    ColumnsBase.KEY_ID: dataItem.id,
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    ColumnsBase.KEY_ISDIRTY: dataItem.isDirty,
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    ColumnsBase.KEY_ISDELETED: dataItem.isDeleted1,
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    ColumnsBase.KEY_UPSYNCMESSAGE: dataItem.upSyncMessage,
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    ColumnsBase.KEY_DOWNSYNCMESSAGE: dataItem.downSyncMessage,
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    ColumnsBase.KEY_SCREATEDON: dataItem.sCreatedOn,
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    ColumnsBase.KEY_SMODIFIEDON: dataItem.sModifiedOn,
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    ColumnsBase.KEY_CREATEDBYUSER: dataItem.createdByUser,
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    ColumnsBase.KEY_MODIFIEDBYUSER: dataItem.modifiedByUser,
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    ColumnsBase.KEY_OWNERUSERID: dataItem.ownerUserID,
};

values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";

id = await db.insert(TablesBase.TABLE_ACCOUNTPHONE, values);

            //db.close();
        } catch ( ex) {
            //Globals.HandleException(context, "DatabaseHandler:AddAccountPhoneRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAccountPhoneRecord(DatabaseHandler databaseHandler,  String id1, AccountPhone dataItem) async{
      int id = 0;

        final db = await databaseHandler.database;
        try {
           Map<String, dynamic> values = {
  if (dataItem.accountPhoneID != null && dataItem.accountPhoneID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID: dataItem.accountPhoneID,
  if (dataItem.accountPhoneCode != null && dataItem.accountPhoneCode != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE: dataItem.accountPhoneCode,
  if (dataItem.phone != null && dataItem.phone != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_PHONE: dataItem.phone,
  if (dataItem.phoneTypeName != null && dataItem.phoneTypeName != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME: dataItem.phoneTypeName,
  if (dataItem.accountID != null && dataItem.accountID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID: dataItem.accountID,
  if (dataItem.accountAddressID != null && dataItem.accountAddressID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID: dataItem.accountAddressID,
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY: dataItem.createdBy,
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON: dataItem.createdOn,
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY: dataItem.modifiedBy,
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON: dataItem.modifiedOn,
  if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER: dataItem.deviceIdentifier,
  if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER: dataItem.referenceIdentifier,
  if (dataItem.isActive != null && dataItem.isActive != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE: dataItem.isActive,
  if (dataItem.uid != null && dataItem.uid != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_UID: dataItem.uid,
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID: dataItem.appUserID,
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID: dataItem.appUserGroupID,
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED: dataItem.isArchived,
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED: dataItem.isDeleted,
  if (dataItem.id != null && dataItem.id != "null")
    ColumnsBase.KEY_ID: dataItem.id,
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    ColumnsBase.KEY_ISDIRTY: dataItem.isDirty,
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    ColumnsBase.KEY_ISDELETED: dataItem.isDeleted1,
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    ColumnsBase.KEY_UPSYNCMESSAGE: dataItem.upSyncMessage,
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    ColumnsBase.KEY_DOWNSYNCMESSAGE: dataItem.downSyncMessage,
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    ColumnsBase.KEY_SCREATEDON: dataItem.sCreatedOn,
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    ColumnsBase.KEY_SMODIFIEDON: dataItem.sModifiedOn,
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    ColumnsBase.KEY_CREATEDBYUSER: dataItem.createdByUser,
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    ColumnsBase.KEY_MODIFIEDBYUSER: dataItem.modifiedByUser,
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    ColumnsBase.KEY_OWNERUSERID: dataItem.ownerUserID,
};

            id = await db.update(TablesBase.TABLE_ACCOUNTPHONE, values, where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
//Globals.HandleException(context, "DatabaseHandler:UpdateAccountPhoneRecord()", ex);
            throw ex;
        }
        return id;
    }
static Future<int> deleteAccountPhoneRecord(DatabaseHandler databaseHandler, String id1) async {
  int id = 0;
  try {
    final db = await databaseHandler.database;
    id = await db.delete(TablesBase.TABLE_ACCOUNTPHONE, where:  "${ColumnsBase.KEY_ID} = ?",whereArgs: [id1]);
    // db.close();
  } catch ( ex) {
 //   Globals.handleException(context, "DatabaseHandler:DeleteAccountPhoneRecord()", ex);
    throw ex;
  }
  return id;
}

static Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = ?";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> results = await db.rawQuery(selectQuery, [id]);
    if (results.isNotEmpty) {
      serverId = results[0][ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
    }
    // db.close();
  } catch ( ex) {
//Globals.handleException(context, "AccountPhoneDataHandlerBase:GetServerId()", ex);
    throw ex;
  }
  return serverId;
}

static Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID} = ?";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> results = await db.rawQuery(selectQuery, [id]);
    if (results.isNotEmpty) {
      localId = results[0][ColumnsBase.KEY_ID];
    }
    // db.close();
  } catch ( ex) {
  //  Globals.handleException(context, "AccountPhoneDataHandlerBase:GetLocalId()", ex);
    throw ex;
  }
  return localId;
}


     static Future<List<AccountPhone>> GetAccountPhoneUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AccountPhone> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTPHONE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTPHONE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTPHONE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];


            }
        } catch ( ex) {
          //  Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AccountPhone?> GetAccountPhoneRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AccountPhone? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${Columns.KEY_ACCOUNTADDRESS_ADDRESS}";
		selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTPHONE} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTADDRESS} B ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTPHONE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

          final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountPhone dataItem = new AccountPhone();

                    dataItem.accountPhoneID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID];
                    dataItem.accountPhoneCode = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE];
                    dataItem.phone = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME];
                    dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID];
                    dataItem.accountAddressID = element[ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTPHONE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED];
                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.address = element[Columns.KEY_ACCOUNTADDRESS_ADDRESS];
                      dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];


            }
        }
        catch( ex)
        {
	    //Globals.HandleException(context, "AccountPhoneDataHandlerBase:GetAccountPhoneRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}