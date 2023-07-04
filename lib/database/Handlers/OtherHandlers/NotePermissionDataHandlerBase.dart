

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/NotePermission.dart';
import '../DataBaseHandler.dart';

class NotePermissionDataHandlerBase {

     static Future<List<NotePermission>> GetNotePermissionRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<NotePermission> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_NOTE_NOTECODE;
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} D ON A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE} LIKE '%${searchString.replaceAll("'","''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_NotePermission_Columns.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";



      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
            Globals.handleException( "NotePermissionDataHandlerBase:GetNotePermissionRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<NotePermission>> GetNotePermissionRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<NotePermission> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_NOTE_NOTECODE;
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} D ON A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE} LIKE '${searchString.replaceAll("'","''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE} COLLATE NOCASE ASC ";
    final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
            Globals.handleException( "NotePermissionDataHandlerBase:GetNotePermissionRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<NotePermission?> GetNotePermissionRecord(DatabaseHandler databaseHandler,  String id) async{
        NotePermission ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_NOTE_NOTECODE;
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} D ON A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

               final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
            Globals.handleException( "NotePermissionDataHandlerBase:GetNotePermissionRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<NotePermission?> GetMasterNotePermissionRecord(DatabaseHandler databaseHandler,  String id) async{
        NotePermission? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_NOTE_NOTECODE;
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} D ON A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

                final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
            Globals.handleException( "NotePermissionDataHandlerBase:GetMasterNotePermissionRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddNotePermissionRecord(DatabaseHandler databaseHandler,  NotePermission dataItem)async {
        int id = 0;
        try {

          final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.notePermissionID != null && dataItem.notePermissionID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID] = dataItem.notePermissionID;
}
if (dataItem.notePermissionCode != null && dataItem.notePermissionCode != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE] = dataItem.notePermissionCode;
}
if (dataItem.noteID != null && dataItem.noteID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEID] = dataItem.noteID;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID] = dataItem.appUserID;
}
if (dataItem.permissionLevel != null && dataItem.permissionLevel != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL] = dataItem.permissionLevel;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED] = dataItem.isDeleted;
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

values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";

 id = await db.insert(TablesBase.TABLE_NOTEPERMISSION, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddNotePermissionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateNotePermissionRecord(DatabaseHandler databaseHandler,  String id1, NotePermission dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.notePermissionID != null && dataItem.notePermissionID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID] = dataItem.notePermissionID;
}
if (dataItem.notePermissionCode != null && dataItem.notePermissionCode != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE] = dataItem.notePermissionCode;
}
if (dataItem.noteID != null && dataItem.noteID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_NOTEID] = dataItem.noteID;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID] = dataItem.appUserID;
}
if (dataItem.permissionLevel != null && dataItem.permissionLevel != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL] = dataItem.permissionLevel;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED] = dataItem.isDeleted;
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
          
    if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {

      values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

    }

            id = await db.update(TablesBase.TABLE_NOTEPERMISSION, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateNotePermissionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteNotePermissionRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id =await db.delete(TablesBase.TABLE_NOTEPERMISSION, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteNotePermissionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID}";
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "NotePermissionDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }

            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "NotePermissionDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<NotePermission>> GetNotePermissionUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<NotePermission> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_NOTEPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_NOTEPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_NOTEPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
            Globals.handleException( "NotePermissionDataHandlerBase:GetNotePermissionUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<NotePermission?> GetNotePermissionRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        NotePermission? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_NOTE_NOTECODE;
		selectQuery += " FROM ${TablesBase.TABLE_NOTEPERMISSION} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} D ON A.${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEPERMISSION_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

        final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    NotePermission dataItem = new NotePermission();
                    dataItem.notePermissionID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID];
                    dataItem.notePermissionCode = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE];
                    dataItem.noteID = element[ColumnsBase.KEY_NOTEPERMISSION_NOTEID];
                    dataItem.appUserID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERID];
                    dataItem.permissionLevel = element[ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL];
                    dataItem.createdOn = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_NOTEPERMISSION_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED];
                    dataItem.isDeleted  = element[ColumnsBase.KEY_NOTEPERMISSION_ISDELETED];
                    dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
                    
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
        }
        catch( ex)
        {
	    Globals.handleException( "NotePermissionDataHandlerBase:GetNotePermissionRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}