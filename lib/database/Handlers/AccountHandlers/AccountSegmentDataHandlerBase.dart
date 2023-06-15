

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountSegment.dart';
import '../DataBaseHandler.dart';

class AccountSegmentDataHandlerBase {

     static Future<List<AccountSegment>> GetAccountSegmentRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<AccountSegment> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} D ON A.${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountSegment_Columns.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountSegment>> GetAccountSegmentRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<AccountSegment> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} D ON A.${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME} COLLATE NOCASE ASC ";

         final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AccountSegment?> GetAccountSegmentRecord(DatabaseHandler databaseHandler,  String id) async {
        AccountSegment? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} D ON A.${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AccountSegment?> GetMasterAccountSegmentRecord(DatabaseHandler databaseHandler,  String id) async{
        AccountSegment? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} D ON A.${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataItem;
         
    }

     Future<int> addAccountSegmentRecord(DatabaseHandler databaseHandler, AccountSegment dataItem) async {
  int id = 0;
  try {
    final db = await databaseHandler.database;
    Map<String, dynamic> values = {
      if (dataItem.accountSegmentID != null && dataItem.accountSegmentID != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID: dataItem.accountSegmentID,
      if (dataItem.accountSegmentCode != null && dataItem.accountSegmentCode != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE: dataItem.accountSegmentCode,
      if (dataItem.accountSegmentName != null && dataItem.accountSegmentName != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME: dataItem.accountSegmentName,
      if (dataItem.minimumTurnover != null && dataItem.minimumTurnover != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER: dataItem.minimumTurnover,
      if (dataItem.currencyID != null && dataItem.currencyID != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID: dataItem.currencyID,
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON: dataItem.createdOn,
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY: dataItem.createdBy,
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON: dataItem.modifiedOn,
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY: dataItem.modifiedBy,
      if (dataItem.isActive != null && dataItem.isActive != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE: dataItem.isActive,
      if (dataItem.uid != null && dataItem.uid != "null") ColumnsBase.KEY_ACCOUNTSEGMENT_UID: dataItem.uid,
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID: dataItem.appUserID,
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID: dataItem.appUserGroupID,
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED: dataItem.isArchived,
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED: dataItem.isDeleted,
      if (dataItem.id != null && dataItem.id != "null") ColumnsBase.KEY_ID: dataItem.id,
      if (dataItem.isDirty != null && dataItem.isDirty != "null") ColumnsBase.KEY_ISDIRTY: dataItem.isDirty,
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
      ColumnsBase.KEY_UPSYNCINDEX: 0,
      ColumnsBase.KEY_ISACTIVE: "true",
      ColumnsBase.KEY_ISDELETED: "false",
    };

    id = await db.insert(TablesBase.TABLE_ACCOUNTSEGMENT, values);
    // db.close();
  } catch (ex) {
    //Globals.handleException(context, "DatabaseHandler:addAccountSegmentRecord()", ex);
    rethrow;
  }
  return id;
}

     Future<int> updateAccountSegmentRecord(DatabaseHandler databaseHandler, String id1, AccountSegment dataItem) async {
  int id = 0;
  try {
    final db = await databaseHandler.database;
    Map<String, dynamic> values = {};

    if (dataItem.accountSegmentID != null && dataItem.accountSegmentID != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID] = dataItem.accountSegmentID;
    }
    if (dataItem.accountSegmentCode != null && dataItem.accountSegmentCode != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE] = dataItem.accountSegmentCode;
    }
    if (dataItem.accountSegmentName != null && dataItem.accountSegmentName != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME] = dataItem.accountSegmentName;
    }
    if (dataItem.minimumTurnover != null && dataItem.minimumTurnover != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER] = dataItem.minimumTurnover;
    }
    if (dataItem.currencyID != null && dataItem.currencyID != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID] = dataItem.currencyID;
    }
    if (dataItem.createdOn != null && dataItem.createdOn != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON] = dataItem.createdOn;
    }
    if (dataItem.createdBy != null && dataItem.createdBy != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY] = dataItem.createdBy;
    }
    if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON] = dataItem.modifiedOn;
    }
    if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY] = dataItem.modifiedBy;
    }
    if (dataItem.isActive != null && dataItem.isActive != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE] = dataItem.isActive;
    }
    if (dataItem.uid != null && dataItem.uid != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_UID] = dataItem.uid;
    }
    if (dataItem.appUserID != null && dataItem.appUserID != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID] = dataItem.appUserID;
    }
    if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID] = dataItem.appUserGroupID;
    }
    if (dataItem.isArchived != null && dataItem.isArchived != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED] = dataItem.isArchived;
    }
    if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
      values[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED] = dataItem.isDeleted;
    }
    if (dataItem.id != null && dataItem.id != "null") {
      values[ColumnsBase.KEY_ID] = dataItem.id;
    }
    if (dataItem.isDirty != null && dataItem.isDirty != "null") {
      values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
    }
    if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
      values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
    }
    if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
      values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
    }
    if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
      values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
    }
    if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
      values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
    }
    if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
      values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
    }
    if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
      values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
    }
    if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
      values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
    }
    if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
      values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
    }
    if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
      values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
    }

    id = await db.update(TablesBase.TABLE_ACCOUNTSEGMENT, values,  where:  "${ColumnsBase.KEY_ID} = ?", whereArgs : [id1]);
    // db.close();
  } catch (ex) {
    //Globals.handleException(context, "DatabaseHandler:UpdateAccountSegmentRecord()", ex);
    rethrow;
  }
  return id;
}


   Future<int> deleteAccountSegmentRecord(DatabaseHandler databaseHandler, String id1) async {
  int id = 0;
  try {
    final db = await databaseHandler.database;
    id = await db.delete(TablesBase.TABLE_ACCOUNTSEGMENT, where :  "${ColumnsBase.KEY_ID} = ?", whereArgs : [id1]);
    // db.close();
  } catch (ex) {
    //Globals.handleException(context, "DatabaseHandler:DeleteAccountSegmentRecord()", ex);
    rethrow;
  }
  return id;
}

Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      serverId = result.first[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
    }
    // db.close();
  } catch (ex) {
//Globals.handleException(context, "AccountSegmentDataHandlerBase:GetServerId()", ex);
    rethrow;
  }
  return serverId;
}

Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      localId = result.first[ColumnsBase.KEY_ID];
    }
    // db.close();
  } catch (ex) {
    ///Globals.handleException(context, "AccountSegmentDataHandlerBase:GetLocalId()", ex);
    rethrow;
  }
  return localId;
}


     static Future<List<AccountSegment>> GetAccountSegmentUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<AccountSegment> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTSEGMENT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTSEGMENT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

           
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AccountSegment?> GetAccountSegmentRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        AccountSegment? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME;
		selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTSEGMENT} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} D ON A.${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTSEGMENT_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AccountSegment dataItem = new AccountSegment();
                    dataItem.accountSegmentID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID];
                    dataItem.accountSegmentCode = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE];
                    dataItem.accountSegmentName = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
                    dataItem.minimumTurnover = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER];
                    dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACCOUNTSEGMENT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
       //     Globals.HandleException(context, "AccountSegmentDataHandlerBase:GetAccountSegmentRecordsPaged()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}