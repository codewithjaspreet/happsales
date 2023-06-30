

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserMessage.dart';
import '../DataBaseHandler.dart';

class AppUserMessageDataHandlerBase {

     static Future<List<AppUserMessage>> GetAppUserMessageRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppUserMessage> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} AS ${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERMESSAGE} D ON A.${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().isNotEmpty) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserMessage_Columns.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


            final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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


dataList.add( dataItem);



            }


          
        } catch ( ex) {
            Globals.handleException( "AppUserMessageDataHandlerBase:GetAppUserMessageRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserMessage>> GetAppUserMessageRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<AppUserMessage> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} AS ${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERMESSAGE} D ON A.${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} COLLATE NOCASE ASC ";

           
            final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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


dataList.add( dataItem);



            }
        } catch ( ex) {
            Globals.handleException( "AppUserMessageDataHandlerBase:GetAppUserMessageRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserMessage?> GetAppUserMessageRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUserMessage? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} AS ${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERMESSAGE} D ON A.${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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
            Globals.handleException( "AppUserMessageDataHandlerBase:GetAppUserMessageRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserMessage?> GetMasterAppUserMessageRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUserMessage? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} AS ${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERMESSAGE} D ON A.${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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
            Globals.handleException( "AppUserMessageDataHandlerBase:GetMasterAppUserMessageRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserMessageRecord(DatabaseHandler databaseHandler,  AppUserMessage dataItem) async{
        int id = 0;
        try {
               final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserMessageID != null && dataItem.appUserMessageID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID] = dataItem.appUserMessageID;
}
if (dataItem.appUserMessageCode != null && dataItem.appUserMessageCode != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE] = dataItem.appUserMessageCode;
}
if (dataItem.appUserMessageText != null && dataItem.appUserMessageText != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT] = dataItem.appUserMessageText;
}
if (dataItem.objectType != null && dataItem.objectType != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE] = dataItem.objectType;
}
if (dataItem.objectID != null && dataItem.objectID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID] = dataItem.objectID;
}
if (dataItem.isAttachment != null && dataItem.isAttachment != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT] = dataItem.isAttachment;
}
if (dataItem.parentAppUserMessageID != null && dataItem.parentAppUserMessageID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID] = dataItem.parentAppUserMessageID;
}
// if (dataItem.parentAppUserMessageCode != null && dataItem.parentAppUserMessageCode != "null") {
//     values[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE] = dataItem.parentAppUserMessageCode;
// }
if (dataItem.appUserMessageTo != null && dataItem.appUserMessageTo != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO] = dataItem.appUserMessageTo;
}
if (dataItem.appUserMessageReadBy != null && dataItem.appUserMessageReadBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY] = dataItem.appUserMessageReadBy;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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
            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE] = "true";
            values[ColumnsBase.KEY_ISDELETED]  = "false";

            id = await  db.insert(TablesBase.TABLE_APPUSERMESSAGE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserMessageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserMessageRecord(DatabaseHandler databaseHandler,  String id1, AppUserMessage dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserMessageID != null && dataItem.appUserMessageID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID] = dataItem.appUserMessageID;
}
if (dataItem.appUserMessageCode != null && dataItem.appUserMessageCode != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE] = dataItem.appUserMessageCode;
}
if (dataItem.appUserMessageText != null && dataItem.appUserMessageText != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT] = dataItem.appUserMessageText;
}
if (dataItem.objectType != null && dataItem.objectType != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE] = dataItem.objectType;
}
if (dataItem.objectID != null && dataItem.objectID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID] = dataItem.objectID;
}
if (dataItem.isAttachment != null && dataItem.isAttachment != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT] = dataItem.isAttachment;
}
if (dataItem.parentAppUserMessageID != null && dataItem.parentAppUserMessageID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID] = dataItem.parentAppUserMessageID;
}
// if (dataItem.parentAppUserMessageCode != null && dataItem.parentAppUserMessageCode != "null") {
//     values[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE] = dataItem.parentAppUserMessageCode;
// }
if (dataItem.appUserMessageTo != null && dataItem.appUserMessageTo != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO] = dataItem.appUserMessageTo;
}
if (dataItem.appUserMessageReadBy != null && dataItem.appUserMessageReadBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY] = dataItem.appUserMessageReadBy;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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

            id = await  db.update(TablesBase.TABLE_APPUSERMESSAGE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserMessageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserMessageRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPUSERMESSAGE, where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserMessageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "AppUserMessageDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AppUserMessageDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserMessage>> GetAppUserMessageUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppUserMessage> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERMESSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERMESSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERMESSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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


dataList.add( dataItem);



            }
        } catch ( ex) {
            Globals.handleException( "AppUserMessageDataHandlerBase:GetAppUserMessageUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUserMessage?> GetAppUserMessageRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        AppUserMessage? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,D.${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} AS ${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE}";
		selectQuery += " FROM ${TablesBase.TABLE_APPUSERMESSAGE} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERMESSAGE} D ON A.${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERMESSAGE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

           
            final db = await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    AppUserMessage dataItem = new AppUserMessage();

                    dataItem.appUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID];

                    dataItem.appUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE];

                    dataItem.appUserMessageText = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT];

                    dataItem.objectType = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE];

                    dataItem.objectID = element[ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID];

                    dataItem.isAttachment = element[ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT];

                    dataItem.parentAppUserMessageID = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID];

                    dataItem.parentAppUserMessageCode = element[ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGECODE];

                    dataItem.appUserMessageTo = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO];

                    dataItem.appUserMessageReadBy = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE];

dataItem.uid = element[ColumnsBase.KEY_APPUSERMESSAGE_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER];

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
	    Globals.handleException( "AppUserMessageDataHandlerBase:GetAppUserMessageRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}