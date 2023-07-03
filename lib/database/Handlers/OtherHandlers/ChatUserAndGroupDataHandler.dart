

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ChatMessage.dart';
import '../../models/OtherModels/ChatUserAndGroup.dart';
import '../DataBaseHandler.dart';
import 'ChatUserAndGroupDataHandlerBase.dart';

class ChatUserAndGroupDataHandler extends ChatUserAndGroupDataHandlerBase {

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordForSelf(DatabaseHandler databaseHandler,)async {
        ChatUserAndGroup ?dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} = ${Globals.AppUserID}";
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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordForAmi(DatabaseHandler databaseHandler,) async{
        ChatUserAndGroup ?dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME} = 'Ami'";
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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordByName(DatabaseHandler databaseHandler,  String chatUserAndGroupName) async{
        ChatUserAndGroup? dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += "${" WHERE A." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME + " = '" + chatUserAndGroupName.replaceAll("'","''")}'";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

        } catch ( ex) {
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordByName()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordByAppUserID(DatabaseHandler databaseHandler,  String id)async {
        ChatUserAndGroup? dataItem ;
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} = $id";
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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordByName()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ChatMessage?> GetChatUserAndGroupRecordByTargetID(DatabaseHandler databaseHandler,  String id)async {
        ChatMessage? dataItem ;
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " ;
            selectQuery += " FROM ${TablesBase.TABLE_CHATMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
          //  selectQuery += " AND CAST(A." + ColumnsBase.KEY_ID + " AS INTEGER) < " + lastId;
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND ( (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = ${Globals.AppUserID} AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = $id)";
            selectQuery += " OR  (CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_APPUSERID},0) AS INTEGER) = $id AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATMESSAGE_TOAPPUSERID},0) AS INTEGER) = ${Globals.AppUserID}))";


         
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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordByName()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<String> GetLocalIdByTargetUserId(DatabaseHandler databaseHandler,  String targetId)async {
        String localId = "";
        try {

            targetId = Globals.tryParseLongForDBId(targetId);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} = $targetId";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                localId = element[ColumnsBase.KEY_ID];
            }
           
        } catch ( ex) {
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<ChatUserAndGroup?> GetChatUserAndGroupRecordByAppUserIDAndIsDirty(DatabaseHandler databaseHandler,  String id) async{
        ChatUserAndGroup? dataItem ;
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CHATUSERANDGROUP} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ISDELETED} = 'true'";
            selectQuery += " AND A.${ColumnsBase.KEY_ISDIRTY} = 'true'";

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
            Globals.handleException( "ChatUserAndGroupDataHandlerBase:GetChatUserAndGroupRecordByName()", ex);
            throw ex;
        }
        return dataItem;
    }


    /*-------------------HAPPSALES-------------------*/

}