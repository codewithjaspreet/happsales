
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountType.dart';
import '../DataBaseHandler.dart';

class AccountTypeDataHandlerBase {

     static Future<List<AccountType>> GetAccountTypeRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<AccountType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME} LIKE '%${searchString.replaceAll("'","''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountType_ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();


            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
            Globals.handleException( "AccountTypeDataHandlerBase:GetAccountTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountType>> GetAccountTypeRecords(DatabaseHandler databaseHandler, String searchString)async {
        List<AccountType> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
			selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A." + ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME + " LIKE '" + searchString.replaceAll("'","''")}%'";
            }
            //selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME + " COLLATE NOCASE ASC ";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID}";

              final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
            Globals.handleException( "AccountTypeDataHandlerBase:GetAccountTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AccountType?> GetAccountTypeRecord(DatabaseHandler databaseHandler, String id)async {
        AccountType? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = " + id;
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
            Globals.handleException( "AccountTypeDataHandlerBase:GetAccountTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AccountType?> GetMasterAccountTypeRecord(DatabaseHandler databaseHandler, String id)async {
        AccountType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
            Globals.handleException( "AccountTypeDataHandlerBase:GetMasterAccountTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAccountTypeRecord(DatabaseHandler databaseHandler, AccountType dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.accountTypeID != null && dataItem.accountTypeID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID] = dataItem.accountTypeID;
}

if (dataItem.accountTypeCode != null && dataItem.accountTypeCode != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE] = dataItem.accountTypeCode;
}

if (dataItem.accountTypeName != null && dataItem.accountTypeName != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME] = dataItem.accountTypeName;
}

if (dataItem.createdOn != null && dataItem.createdOn != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isArchived != null && dataItem.isArchived != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED] = dataItem.isArchived;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED] = dataItem.isDeleted;
}

if (dataItem.id != null && dataItem.id != 'null') {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}

if (dataItem.isDirty != null && dataItem.isDirty != 'null') {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}

if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != 'null') {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}

if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != 'null') {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}

if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != 'null') {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}

if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != 'null') {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}

if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != 'null') {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}

if (dataItem.createdByUser != null && dataItem.createdByUser != 'null') {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}

if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != 'null') {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}

if (dataItem.ownerUserID != null && dataItem.ownerUserID != 'null') {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}

values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = 'true';
values[ColumnsBase.KEY_ISDELETED] = 'false';


            id = await db.insert(TablesBase.TABLE_ACCOUNTTYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAccountTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAccountTypeRecord(DatabaseHandler databaseHandler, String id1, AccountType dataItem) async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.accountTypeID != null && dataItem.accountTypeID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID] = dataItem.accountTypeID;
}

if (dataItem.accountTypeCode != null && dataItem.accountTypeCode != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE] = dataItem.accountTypeCode;
}

if (dataItem.accountTypeName != null && dataItem.accountTypeName != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME] = dataItem.accountTypeName;
}

if (dataItem.createdOn != null && dataItem.createdOn != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isArchived != null && dataItem.isArchived != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED] = dataItem.isArchived;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != 'null') {
  values[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED] = dataItem.isDeleted;
}

if (dataItem.id != null && dataItem.id != 'null') {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}

if (dataItem.isDirty != null && dataItem.isDirty != 'null') {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}

if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != 'null') {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}

if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != 'null') {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}

if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != 'null') {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}

if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != 'null') {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}

if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != 'null') {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}

if (dataItem.createdByUser != null && dataItem.createdByUser != 'null') {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}

if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != 'null') {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}

if (dataItem.ownerUserID != null && dataItem.ownerUserID != 'null') {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}

            id = await db.update(TablesBase.TABLE_ACCOUNTTYPE, values, where: "${ColumnsBase.KEY_ID} = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAccountTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAccountTypeRecord(DatabaseHandler databaseHandler, String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACCOUNTTYPE, where: "${ColumnsBase.KEY_ID} = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAccountTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler, String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = " + id;

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID].toString();
            }
          
        } catch ( ex) {
            Globals.handleException( "AccountTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler, String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID} = " + id;

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }


          
        } catch ( ex) {
            Globals.handleException( "AccountTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AccountType>> GetAccountTypeUpSyncRecords(DatabaseHandler databaseHandler, String changeType)async {
        List<AccountType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTTYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTTYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
            Globals.handleException( "AccountTypeDataHandlerBase:GetAccountTypeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AccountType?> GetAccountTypeRecordByUid(DatabaseHandler databaseHandler  ,String uid) async{
        AccountType? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTTYPE} A "; 
			selectQuery += "${" WHERE A."  + ColumnsBase.KEY_ACCOUNTTYPE_UID + " = '" + uid}'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AccountType dataItem = new AccountType();
                    dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID];
                    dataItem.accountTypeCode = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE];
                    dataItem.accountTypeName = element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED];
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
	    Globals.handleException( "AccountTypeDataHandlerBase:GetAccountTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}