

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ChatMessage.dart';
import '../DataBaseHandler.dart';
import 'ChatMessageDataHandlerBase.dart';

class ChatMessageDataHandler extends ChatMessageDataHandlerBase {

     static Future<int> GetNewChatCount(DatabaseHandler databaseHandler, )async {
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) <> ${Globals.AppUserID}";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_ISREAD},'false') = 'false' ";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                itemCount = result[0].values.first;
            }
            
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetChatMessageRecordsToAndFromChatUserAndGroupID()", ex);
            throw ex;
        }
        return itemCount;
    }

     static Future<int> GetNewChatCountFromAppUserID(DatabaseHandler databaseHandler,String appUserId)async {
        int itemCount = 0;
        try {
            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = $appUserId";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = ${Globals.AppUserID}";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_ISREAD},'false') = 'false' ";

            final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                itemCount = result[0].values.first;
            }
           
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetNewChatCountFromAppUserID()", ex);
            throw ex;
        }
        return itemCount;
    }

     static Future<int> GetNewChatCountFromGroup(DatabaseHandler databaseHandler,String groupUid) async{
        int itemCount = 0;
        try {
            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID},'') = '$groupUid'";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) <> ${Globals.AppUserID}";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_ISREAD},'false') = 'false' ";

            final db = await databaseHandler.database;


            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                itemCount = result[0].values.first;
            }
           
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetNewChatCountFromGroup()", ex);
            throw ex;
        }
        return itemCount;
    }

     static Future<List<ChatMessage>> GetChatMessageRecordsToAndFromAppUserID(DatabaseHandler databaseHandler,String appUserId, int lastId)async {
        List<ChatMessage> dataList = [];
        try {
            //String selectQuery = "SELECT O.* FROM (SELECT A.* " ;
            String selectQuery = "SELECT A.* " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND CAST(A.${ColumnsBase.KEY_ID} AS INTEGER) < $lastId";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND ( (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = ${Globals.AppUserID} AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = $appUserId)";
            selectQuery += " OR  (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = $appUserId AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = ${Globals.AppUserID}))";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID} DESC ";
            selectQuery += " LIMIT 10 ";
            //selectQuery += " LIMIT 10) O ORDER BY O." + ColumnsBase.KEY_ID + " ASC ";

       final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ChatMessage dataItem = new ChatMessage();

                    dataItem.chatMessageID = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID];
                    dataItem.chatMessageCode = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECODE];
                    dataItem.chatMessageContent = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECONTENT];
                    dataItem.contentType = element[ColumnsBase.KEY_CHATMESSAGE_CONTENTTYPE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPID];
                    dataItem.toChatUserAndGroupID = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPID];
                    dataItem.localMediaPath = element[ColumnsBase.KEY_CHATMESSAGE_LOCALMEDIAPATH];
                    dataItem.isUploaded = element[ColumnsBase.KEY_CHATMESSAGE_ISUPLOADED];
                    dataItem.mediaPath  = element[ColumnsBase.KEY_CHATMESSAGE_MEDIAPATH];
                    dataItem.isRead = element[ColumnsBase.KEY_CHATMESSAGE_ISREAD];
                    dataItem.readStatus = element[ColumnsBase.KEY_CHATMESSAGE_READSTATUS];
                    dataItem.objectName = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTNAME];
                    dataItem.objectID = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTID];
                    dataItem.objectCode = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTCODE];
                    dataItem.objectAction = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTACTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATMESSAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATMESSAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATMESSAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATMESSAGE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATMESSAGE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED];
                    dataItem.appUserName = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERNAME];
                    dataItem.toAppUserID = element[ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID];
                    dataItem.toChatUserAndGroupUid = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPNAME];
                    dataItem.toChatUserAndGroupName = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPNAME];



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
            Globals.handleException( "ChatMessageDataHandler:GetChatMessageRecordsToAndFromChatUserAndGroupID()", ex);
            throw ex;
        }
        return dataList;
    }

       static Future<List<ChatMessage>> GetChatMessageRecordsToAndFromGroup(DatabaseHandler databaseHandler,String groupUid, int lastId)async {
        List<ChatMessage> dataList = [];
        try {
            //String selectQuery = "SELECT O.* FROM (SELECT A.* " ;
            String selectQuery = "SELECT A.* " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND CAST(A.${ColumnsBase.KEY_ID} AS INTEGER) < $lastId";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID},'') = '$groupUid'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID} DESC ";
            selectQuery += " LIMIT 10 ";
            //selectQuery += " LIMIT 10) O ORDER BY O." + ColumnsBase.KEY_ID + " ASC ";
 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ChatMessage dataItem = new ChatMessage();

                    dataItem.chatMessageID = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID];
                    dataItem.chatMessageCode = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECODE];
                    dataItem.chatMessageContent = element[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECONTENT];
                    dataItem.contentType = element[ColumnsBase.KEY_CHATMESSAGE_CONTENTTYPE];
                    dataItem.chatUserAndGroupID = element[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPID];
                    dataItem.toChatUserAndGroupID = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPID];
                    dataItem.localMediaPath = element[ColumnsBase.KEY_CHATMESSAGE_LOCALMEDIAPATH];
                    dataItem.isUploaded = element[ColumnsBase.KEY_CHATMESSAGE_ISUPLOADED];
                    dataItem.mediaPath  = element[ColumnsBase.KEY_CHATMESSAGE_MEDIAPATH];
                    dataItem.isRead = element[ColumnsBase.KEY_CHATMESSAGE_ISREAD];
                    dataItem.readStatus = element[ColumnsBase.KEY_CHATMESSAGE_READSTATUS];
                    dataItem.objectName = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTNAME];
                    dataItem.objectID = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTID];
                    dataItem.objectCode = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTCODE];
                    dataItem.objectAction = element[ColumnsBase.KEY_CHATMESSAGE_OBJECTACTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CHATMESSAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CHATMESSAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CHATMESSAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CHATMESSAGE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CHATMESSAGE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED];
                    dataItem.appUserName = element[ColumnsBase.KEY_CHATMESSAGE_APPUSERNAME];
                    dataItem.toAppUserID = element[ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID];
                    dataItem.toChatUserAndGroupUid = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID];
                    dataItem.chatUserAndGroupName = element[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPNAME];
                    dataItem.toChatUserAndGroupName = element[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPNAME];



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
            Globals.handleException( "ChatMessageDataHandler:GetChatMessageRecordsToAndFromChatUserAndGroupID()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<void> UpdateUserMessageReadStatus(DatabaseHandler databaseHandler,int id)async {
        try {
            final db = await  databaseHandler.database;
            String sqlString = "UPDATE ${TablesBase.TABLE_CHATMESSAGE} SET ${ColumnsBase.KEY_CHATMESSAGE_ISREAD} = 'true'";
            sqlString += " ,${ColumnsBase.KEY_ISDIRTY} = 'true'";
            sqlString += " WHERE ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_APPUSERID} = $id";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID} = ${Globals.AppUserID}";
            db.execute(sqlString);
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:UpdateUserMessageReadStatus()", ex);
            throw ex;
        }
    }

     static void UpdateGroupMessageReadStatus(DatabaseHandler databaseHandler,String Uid)async {
        try {
            final db = await databaseHandler.database;
            String sqlString = "UPDATE ${TablesBase.TABLE_CHATMESSAGE} SET ${ColumnsBase.KEY_CHATMESSAGE_ISREAD} = 'true'";
            sqlString += " ,${ColumnsBase.KEY_ISDIRTY} = 'true'";
            sqlString += " WHERE ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID} = '$Uid'";
            db.execute(sqlString);
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:UpdateGroupMessageReadStatus()", ex);
            throw ex;
        }
    }

     static Future<int> UpdateChatMessageRecordUsingMasterID(DatabaseHandler databaseHandler,String id1, ChatMessage dataItem)async {
        int id = 0;
        try
        {final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.chatMessageID != null && dataItem.chatMessageID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID] = dataItem.chatMessageID;
}
if (dataItem.chatMessageCode != null && dataItem.chatMessageCode != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECODE] = dataItem.chatMessageCode;
}
if (dataItem.chatMessageContent != null && dataItem.chatMessageContent != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECONTENT] = dataItem.chatMessageContent;
}
if (dataItem.contentType != null && dataItem.contentType != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CONTENTTYPE] = dataItem.contentType;
}
if (dataItem.chatUserAndGroupID != null && dataItem.chatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPID] = dataItem.chatUserAndGroupID;
}
if (dataItem.toChatUserAndGroupID != null && dataItem.toChatUserAndGroupID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPID] = dataItem.toChatUserAndGroupID;
}
if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_LOCALMEDIAPATH] = dataItem.localMediaPath;
}
if (dataItem.isUploaded != null && dataItem.isUploaded != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_ISUPLOADED] = dataItem.isUploaded;
}
if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_MEDIAPATH] = dataItem.mediaPath;
}
if (dataItem.isRead != null && dataItem.isRead != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_ISREAD] = dataItem.isRead;
}
if (dataItem.readStatus != null && dataItem.readStatus != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_READSTATUS] = dataItem.readStatus;
}
if (dataItem.objectName != null && dataItem.objectName != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_OBJECTNAME] = dataItem.objectName;
}
if (dataItem.objectID != null && dataItem.objectID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_OBJECTID] = dataItem.objectID;
}
if (dataItem.objectCode != null && dataItem.objectCode != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_OBJECTCODE] = dataItem.objectCode;
}
if (dataItem.objectAction != null && dataItem.objectAction != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_OBJECTACTION] = dataItem.objectAction;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.appUserName != null && dataItem.appUserName != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_APPUSERNAME] = dataItem.appUserName;
}
if (dataItem.toAppUserID != null && dataItem.toAppUserID != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID] = dataItem.toAppUserID;
}
if (dataItem.toChatUserAndGroupUid != null && dataItem.toChatUserAndGroupUid != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID] = dataItem.toChatUserAndGroupUid;
}
if (dataItem.chatUserAndGroupName != null && dataItem.chatUserAndGroupName != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPNAME] = dataItem.chatUserAndGroupName;
}
if (dataItem.toChatUserAndGroupName != null && dataItem.toChatUserAndGroupName != "null") {
  values[ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPNAME] = dataItem.toChatUserAndGroupName;
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


            id = await db.update(TablesBase.TABLE_CHATMESSAGE, values, where: "${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID} = $id1", whereArgs: null);
            //db.close();
        }
        catch( ex)
        {
            Globals.handleException( "DatabaseHandler:UpdateChatMessageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> GetMaxChatMessageIDToAndFromAppUserID(DatabaseHandler databaseHandler,  String appUserId) async{
        int id = 0;
        try {
            String selectQuery = "SELECT MAX(CAST(A. ${ColumnsBase.KEY_ID} AS INTEGER)) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND ( (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = ${Globals.AppUserID} AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = $appUserId)";
            selectQuery += " OR  (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = $appUserId AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = ${Globals.AppUserID}))";
            selectQuery += " ORDER BY CAST(A.${ColumnsBase.KEY_ID} AS INTEGER) ASC ";

            final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            if (list.length > 0) {
                id = list[0].values.first;
            }
            
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetMaxChatMessageIDToAndFromAppUserID()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> GetMaxChatMessageIDToAndFromGroup(DatabaseHandler databaseHandler,  String groupUid)async {
        int id = 0;
        try {
            String selectQuery = "SELECT MAX(CAST(A. ${ColumnsBase.KEY_ID} AS INTEGER)) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPUID},'') = '$groupUid'";
            selectQuery += " ORDER BY CAST(A.${ColumnsBase.KEY_ID} AS INTEGER) ASC ";

            final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            if (list.length > 0) {
                id = list[0].values.first;
            }
           
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetChatMessageIDToAndFromGroup()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> GetRecommendationNewCount(DatabaseHandler databaseHandler,String appUserId) async{
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            //selectQuery += " AND CAST(A." + ColumnsBase.KEY_ID + " AS INTEGER) < " + lastId;
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISREAD},'false')) = 'false' ";
            selectQuery += " AND ( (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = ${Globals.AppUserID} AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = $appUserId)";
            selectQuery += " OR  (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = $appUserId AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = ${Globals.AppUserID}))";

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            if (list.length > 0) {
                itemCount = list[0].values.first;
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:GetRecommendationNewCount()", ex);
            throw ex;
        }
        return itemCount;
    }

     static Future<void> UpdateRecommandationReadStatus(DatabaseHandler databaseHandler,String objectId)async {
        try {
            final db =  await databaseHandler.database;
            String sqlString = "UPDATE ${TablesBase.TABLE_CHATMESSAGE} SET ${ColumnsBase.KEY_CHATMESSAGE_ISREAD} = 'true'";
            sqlString += " ,${ColumnsBase.KEY_ISDIRTY} = 'true'";
            sqlString += " ,${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY} = '${Globals.AppUserLoginName}'";
            sqlString += "${" ,${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON} = '${Globals.getDateTimeNowDBFormat()}"}'";
            sqlString += " WHERE ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_OBJECTID} = $objectId";
            sqlString += " AND ${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID} = ${Globals.AppUserID}";
            db.execute(sqlString);
        } catch ( ex) {
            Globals.handleException( "ChatMessageDataHandler:UpdateUserMessageReadStatus()", ex);
            throw ex;
        }
    }


    /*-------------------HAPPSALES-------------------*/

}