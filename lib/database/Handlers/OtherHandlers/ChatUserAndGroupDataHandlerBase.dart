
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ChatUserAndGroup.dart';
import '../DataBaseHandler.dart';

class ChatUserAndGroupDataHandlerBase {

     static Future<List<ChatUserAndGroup>> GetChatUserAndGroupRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ChatUserAndGroup> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID},0) AS Integer) <> ${Globals.AppUserID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ChatUserAndGroup_Columns.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                 ChatUserAndGroup   dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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

            //db.close();
        } catch ( ex) {
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ChatUserAndGroup>> GetChatUserAndGroupRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<ChatUserAndGroup> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON} COLLATE NOCASE ASC ";

   final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                 ChatUserAndGroup   dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecord(DatabaseHandler databaseHandler,  String id) async{
        ChatUserAndGroup? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";


   final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                    dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatUserAndGroup?> GetMasterChatUserAndGroupRecord(DatabaseHandler databaseHandler,  String id)async {
        ChatUserAndGroup? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                 ChatUserAndGroup   dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetMasterChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddChatUserAndGroupRecord(DatabaseHandler databaseHandler,  ChatUserAndGroup dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.chatUserAndGroupID != null && dataItem.chatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID] = dataItem.chatUserAndGroupID;
}
if (dataItem.chatUserAndGroupCode != null && dataItem.chatUserAndGroupCode != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE] = dataItem.chatUserAndGroupCode;
}
if (dataItem.chatUserAndGroupName != null && dataItem.chatUserAndGroupName != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME] = dataItem.chatUserAndGroupName;
}
if (dataItem.chatUserAndGroupLogo != null && dataItem.chatUserAndGroupLogo != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO] = dataItem.chatUserAndGroupLogo;
}
if (dataItem.chatUserAndGroupDescription != null && dataItem.chatUserAndGroupDescription != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION] = dataItem.chatUserAndGroupDescription;
}
if (dataItem.phoneNumber != null && dataItem.phoneNumber != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER] = dataItem.phoneNumber;
}
if (dataItem.email != null && dataItem.email != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL] = dataItem.email;
}
if (dataItem.targetAppUserID != null && dataItem.targetAppUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID] = dataItem.targetAppUserID;
}
if (dataItem.isGroup != null && dataItem.isGroup != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP] = dataItem.isGroup;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED] = dataItem.isArchived;
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

 id = await db.insert(TablesBase.TABLE_CHATUSERANDGROUP, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateChatUserAndGroupRecord(DatabaseHandler databaseHandler,  String id1, ChatUserAndGroup dataItem) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.chatUserAndGroupID != null && dataItem.chatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID] = dataItem.chatUserAndGroupID;
}
if (dataItem.chatUserAndGroupCode != null && dataItem.chatUserAndGroupCode != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE] = dataItem.chatUserAndGroupCode;
}
if (dataItem.chatUserAndGroupName != null && dataItem.chatUserAndGroupName != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME] = dataItem.chatUserAndGroupName;
}
if (dataItem.chatUserAndGroupLogo != null && dataItem.chatUserAndGroupLogo != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO] = dataItem.chatUserAndGroupLogo;
}
if (dataItem.chatUserAndGroupDescription != null && dataItem.chatUserAndGroupDescription != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION] = dataItem.chatUserAndGroupDescription;
}
if (dataItem.phoneNumber != null && dataItem.phoneNumber != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER] = dataItem.phoneNumber;
}
if (dataItem.email != null && dataItem.email != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL] = dataItem.email;
}
if (dataItem.targetAppUserID != null && dataItem.targetAppUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID] = dataItem.targetAppUserID;
}
if (dataItem.isGroup != null && dataItem.isGroup != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP] = dataItem.isGroup;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED] = dataItem.isArchived;
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

            id = await db.update(TablesBase.TABLE_CHATUSERANDGROUP, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteChatUserAndGroupRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_CHATUSERANDGROUP,  where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID}";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;

            

            List<Map> result = await db.rawQuery(selectQuery, null);



            
            if (result != null && result.length > 0) {
                serverId = result[0].toString();
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID} = $id";

           final db =  await databaseHandler.database;

            

            List<Map> result = await db.rawQuery(selectQuery, null);



            
            if (result != null && result.length > 0) {
                localId = result[0].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ChatUserAndGroup>> GetChatUserAndGroupUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ChatUserAndGroup> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_CHATUSERANDGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CHATUSERANDGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CHATUSERANDGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
   final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                   ChatUserAndGroup dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        ChatUserAndGroup ?dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

        
   final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                


                    dataItem = new ChatUserAndGroup();

                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID];
                    dataItem.chatUserAndGroupCode = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];
                    dataItem.chatUserAndGroupLogo = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO];
                    dataItem.chatUserAndGroupDescription = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION];
                    dataItem.phoneNumber = element[ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER];
                    dataItem.email = element[ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL];
                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID];
                    dataItem.isGroup = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERANDGROUP_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED];


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
	    Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}