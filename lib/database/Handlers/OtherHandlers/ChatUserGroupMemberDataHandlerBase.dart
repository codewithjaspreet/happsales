

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ChatUserGroupMember.dart';
import '../DataBaseHandler.dart';

class ChatUserGroupMemberDataHandlerBase {

     static Future<List<ChatUserGroupMember>> GetChatUserGroupMemberRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ChatUserGroupMember> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ChatUserGroupMember_Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";



        
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
            Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetChatUserGroupMemberRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ChatUserGroupMember>> GetChatUserGroupMemberRecords(DatabaseHandler databaseHandler, String searchString)async {
        List<ChatUserGroupMember> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += "${" AND A.${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME}"} LIKE '$searchString%'";
            }
            selectQuery += "${" ORDER BY A." + Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME} COLLATE NOCASE ASC ";

                 
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
            Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetChatUserGroupMemberRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ChatUserGroupMember?> GetChatUserGroupMemberRecord(DatabaseHandler databaseHandler, String id) async {
        ChatUserGroupMember? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

               
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
            Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetChatUserGroupMemberRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatUserGroupMember?> GetMasterChatUserGroupMemberRecord(DatabaseHandler databaseHandler, String id) async{
        ChatUserGroupMember? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
            Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetMasterChatUserGroupMemberRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddChatUserGroupMemberRecord(DatabaseHandler databaseHandler, ChatUserGroupMember dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.chatUserGroupMemberID != null && dataItem.chatUserGroupMemberID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID] = dataItem.chatUserGroupMemberID;
}
if (dataItem.chatUserGroupMemberCode != null && dataItem.chatUserGroupMemberCode != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE] = dataItem.chatUserGroupMemberCode;
}
if (dataItem.chatUserAndGroupID != null && dataItem.chatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID] = dataItem.chatUserAndGroupID;
}
if (dataItem.targetAppUserID != null && dataItem.targetAppUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID] = dataItem.targetAppUserID;
}
if (dataItem.memberName != null && dataItem.memberName != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME] = dataItem.memberName;
}
if (dataItem.memberDescription != null && dataItem.memberDescription != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION] = dataItem.memberDescription;
}
if (dataItem.phoneNumber != null && dataItem.phoneNumber != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER] = dataItem.phoneNumber;
}
if (dataItem.email != null && dataItem.email != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL] = dataItem.email;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED] = dataItem.isDeleted;
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


            id = await  db.insert(TablesBase.TABLE_CHATUSERGROUPMEMBER, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddChatUserGroupMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateChatUserGroupMemberRecord(DatabaseHandler databaseHandler, String id1, ChatUserGroupMember dataItem) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.chatUserGroupMemberID != null && dataItem.chatUserGroupMemberID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID] = dataItem.chatUserGroupMemberID;
}
if (dataItem.chatUserGroupMemberCode != null && dataItem.chatUserGroupMemberCode != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE] = dataItem.chatUserGroupMemberCode;
}
if (dataItem.chatUserAndGroupID != null && dataItem.chatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID] = dataItem.chatUserAndGroupID;
}
if (dataItem.targetAppUserID != null && dataItem.targetAppUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID] = dataItem.targetAppUserID;
}
if (dataItem.memberName != null && dataItem.memberName != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME] = dataItem.memberName;
}
if (dataItem.memberDescription != null && dataItem.memberDescription != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION] = dataItem.memberDescription;
}
if (dataItem.phoneNumber != null && dataItem.phoneNumber != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER] = dataItem.phoneNumber;
}
if (dataItem.email != null && dataItem.email != "null") {
  values[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL] = dataItem.email;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED] = dataItem.isDeleted;
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


            id =  await db.update(TablesBase.TABLE_CHATUSERGROUPMEMBER, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateChatUserGroupMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteChatUserGroupMemberRecord(DatabaseHandler databaseHandler, String id1) async{
        int id = 0;
        try {
    final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_CHATUSERGROUPMEMBER, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteChatUserGroupMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID}"
        " FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER} A"
        " WHERE A.${ColumnsBase.KEY_ID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      serverId = result.first[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID].toString();
    }
    // db.close();  // Not required in sqflite

  } catch (ex) {
    Globals.handleException("ChatUserGroupMemberDataHandlerBase:GetServerId()", ex);
    throw ex;
  }
  return serverId;
}


Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}"
        " FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER} A"
        " WHERE A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      localId = result.first[ColumnsBase.KEY_ID].toString();
    }
    // db.close();  // Not required in sqflite

  } catch (ex) {
    Globals.handleException("ChatUserGroupMemberDataHandlerBase:GetLocalId()", ex);
    throw ex;
  }
  return localId;
}


     static Future<List<ChatUserGroupMember>> GetChatUserGroupMemberUpSyncRecords(DatabaseHandler databaseHandler, String changeType) async{
        List<ChatUserGroupMember> dataList = [];
        try {
            String selectQuery = "${"SELECT * FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "${"SELECT * FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "${"SELECT * FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

                  
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
            Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetChatUserGroupMemberUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ChatUserGroupMember?> GetChatUserGroupMemberRecordByUid(DatabaseHandler databaseHandler, String uid) async{
        ChatUserGroupMember? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
		selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A "; 
		selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                
                    ChatUserGroupMember dataItem = new ChatUserGroupMember();
                    dataItem.chatUserGroupMemberID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID];
                    dataItem.chatUserGroupMemberCode = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID];

                    dataItem.targetAppUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID];
                    dataItem.memberName = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME];
                    dataItem.memberDescription = element[Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION];
                    dataItem.phoneNumber = element[Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER];
                    dataItem.email = element[Columns.KEY_CHATUSERGROUPMEMBER_EMAIL];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON];
                    dataItem.uid = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED];


                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME];


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
	    Globals.handleException( "ChatUserGroupMemberDataHandlerBase:GetChatUserGroupMemberRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}