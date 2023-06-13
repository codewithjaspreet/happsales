import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ContactModels.dart/ContactTitle.dart';
import '../DataBaseHandler.dart';

class ContactTitleDataHandlerBase {
  static Future<List<ContactTitle>> GetContactTitleRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ContactTitle> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ContactTitle_Columns.KEY_CONTACTTITLE_CONTACTTITLENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      //  Globals.HandleException(context, "ContactTitleDataHandlerBase:GetContactTitleRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ContactTitle>> GetContactTitleRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ContactTitle> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME} LIKE '$searchString%'";
      //selectQuery += " ORDER BY A." + ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME + " COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      // Globals.HandleException(context, "ContactTitleDataHandlerBase:GetContactTitleRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ContactTitle?> GetContactTitleRecord(
      DatabaseHandler databaseHandler, String id) async {
    ContactTitle? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      //  Globals.HandleException(context, "ContactTitleDataHandlerBase:GetContactTitleRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ContactTitle?> GetMasterContactTitleRecord(
      DatabaseHandler databaseHandler, String id) async {
    ContactTitle? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      // Globals.HandleException(context, "ContactTitleDataHandlerBase:GetMasterContactTitleRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  Future<int> addContactTitleRecord(
      DatabaseHandler databaseHandler, ContactTitle dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();
      if (dataItem.contactTitleID != null && dataItem.contactTitleID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID] =
            dataItem.contactTitleID;
      if (dataItem.contactTitleCode != null &&
          dataItem.contactTitleCode != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE] =
            dataItem.contactTitleCode;
      if (dataItem.contactTitleName != null &&
          dataItem.contactTitleName != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME] =
            dataItem.contactTitleName;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CREATEDON] = dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY] = dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISDELETED] = dataItem.isDeleted;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_CONTACTTITLE, values);
      //db.close();
    } catch (ex) {
      //Globals.handleException(context, "DatabaseHandler:AddContactTitleRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateContactTitleRecord(DatabaseHandler databaseHandler,
      String id1, ContactTitle dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();
      if (dataItem.contactTitleID != null && dataItem.contactTitleID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID] =
            dataItem.contactTitleID;
      if (dataItem.contactTitleCode != null &&
          dataItem.contactTitleCode != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE] =
            dataItem.contactTitleCode;
      if (dataItem.contactTitleName != null &&
          dataItem.contactTitleName != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME] =
            dataItem.contactTitleName;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CREATEDON] = dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY] = dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_CONTACTTITLE_ISDELETED] = dataItem.isDeleted;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

      id = await db.update(TablesBase.TABLE_CONTACTTITLE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "DatabaseHandler:UpdateContactTitleRecord()", ex);
      throw ex;
    }
    return id;
  }

  Future<int> deleteContactTitleRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_CONTACTTITLE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      // Globals.handleException(context, "DatabaseHandler:DeleteContactTitleRecord()", ex);
      throw ex;
    }
    return id;
  }

  Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.isNotEmpty) {
        serverId =
            result[0][ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID].toString();
      }
      //db.close();
    } catch (ex) {
      //Globals.handleException(context, "ContactTitleDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.isNotEmpty) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }
      //db.close();
    } catch (ex) {
      //  Globals.handleException(context, "ContactTitleDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ContactTitle>> GetContactTitleUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<ContactTitle> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_CONTACTTITLE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACTTITLE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACTTITLE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      //  Globals.HandleException(context, "ContactTitleDataHandlerBase:GetContactTitleUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ContactTitle?> GetContactTitleRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ContactTitle? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACTTITLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTTITLE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ContactTitle dataItem = new ContactTitle();

        dataItem.contactTitleID =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID];
        dataItem.contactTitleCode =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE];
        dataItem.contactTitleName =
            element[ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_CONTACTTITLE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACTTITLE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACTTITLE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACTTITLE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACTTITLE_ISDELETED];
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
    } catch (ex) {
      //Globals.HandleException(context, "ContactTitleDataHandlerBase:GetContactTitleRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
