
import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ChatUserGroupMember.dart';
import '../DataBaseHandler.dart';
import 'ChatUserGroupMemberDataHandlerBase.dart';

 class ChatUserGroupMemberDataHandler extends ChatUserGroupMemberDataHandlerBase {

     static Future<List<ChatUserGroupMember>> GetChatUserGroupMemberRecordsByChatUserAndGroupID(DatabaseHandler databaseHandler, String chatUserAndGroupId) async{
        List<ChatUserGroupMember> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_CHATUSERGROUPMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_CHATUSERANDGROUP}"} D ON A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND CAST(COALESCE(A.${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID},0) AS INTEGER) = $chatUserAndGroupId" ;
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID}";

          
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
            Globals.handleException( "ChatUserGroupMemberDataHandler:GetChatUserGroupMemberRecordsByChatUserAndGroupID()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}