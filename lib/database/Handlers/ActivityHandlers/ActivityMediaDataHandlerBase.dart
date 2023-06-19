

 import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityMedia.dart';
import '../DataBaseHandler.dart';

class ActivityMediaDataHandlerBase {

     static Future<List<ActivityMedia>> GetActivityMediaRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<ActivityMedia> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME} LIKE '%${searchString.replaceAll("'","''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityMedia_Columns.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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
  // Use the `dataItem` object as needed
}

      }
           
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityMedia>> GetActivityMediaRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<ActivityMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME} LIKE '${searchString.replaceAll("'","''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME} COLLATE NOCASE ASC ";

           
                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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
  // Use the `dataItem` object as needed
}

      }
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityMedia?> GetActivityMediaRecord(DatabaseHandler databaseHandler,  String id)async {
        ActivityMedia? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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


  // Use the `dataItem` object as needed
}

      }
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityMedia?> GetMasterActivityMediaRecord(DatabaseHandler databaseHandler,  String id)async {
        ActivityMedia? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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


  // Use the `dataItem` object as needed
}

      }
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetMasterActivityMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityMediaRecord(DatabaseHandler databaseHandler,  ActivityMedia dataItem) async {
        int id = 0;
        try {

          final db = await databaseHandler.database;

          Map<String, dynamic> values = new Map<String, dynamic>();
            if (dataItem.activityMediaID != null && dataItem.activityMediaID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID] = dataItem.activityMediaID;
if (dataItem.activityMediaCode != null && dataItem.activityMediaCode != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE] = dataItem.activityMediaCode;
if (dataItem.activityMediaName != null && dataItem.activityMediaName != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME] = dataItem.activityMediaName;
if (dataItem.activityID != null && dataItem.activityID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID] = dataItem.activityID;
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID] = dataItem.contentTypeID;
if (dataItem.mediaPath != null && dataItem.mediaPath != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH] = dataItem.mediaPath;
if (dataItem.mediaContent != null && dataItem.mediaContent != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT] = dataItem.mediaContent;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION] = dataItem.description;
if (dataItem.tags != null && dataItem.tags != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS] = dataItem.tags;
if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH] = dataItem.localMediaPath;
if (dataItem.isUploaded != null && dataItem.isUploaded != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED] = dataItem.isUploaded;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.location != null && dataItem.location != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION] = dataItem.location;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED] = dataItem.isDeleted;
if (dataItem.id != null && dataItem.id != "null")
  values[ColumnsBase.KEY_ID] = dataItem.id;
if (dataItem.isDirty != null && dataItem.isDirty != "null")
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
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
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

   values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE] =  "true";
            values[ColumnsBase.KEY_ISDELETED]=   "false";

            id = await db.insert(TablesBase.TABLE_ACTIVITYMEDIA, values);

//db.close();

        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

        static Future<int> UpdateActivityMediaRecord(DatabaseHandler databaseHandler,  ActivityMedia dataItem,String id1) async {
        int id = 0;
        try {

          final db = await databaseHandler.database;

          Map<String, dynamic> values = new Map<String, dynamic>();
            if (dataItem.activityMediaID != null && dataItem.activityMediaID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID] = dataItem.activityMediaID;
if (dataItem.activityMediaCode != null && dataItem.activityMediaCode != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE] = dataItem.activityMediaCode;
if (dataItem.activityMediaName != null && dataItem.activityMediaName != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME] = dataItem.activityMediaName;
if (dataItem.activityID != null && dataItem.activityID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID] = dataItem.activityID;
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID] = dataItem.contentTypeID;
if (dataItem.mediaPath != null && dataItem.mediaPath != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH] = dataItem.mediaPath;
if (dataItem.mediaContent != null && dataItem.mediaContent != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT] = dataItem.mediaContent;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION] = dataItem.description;
if (dataItem.tags != null && dataItem.tags != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS] = dataItem.tags;
if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH] = dataItem.localMediaPath;
if (dataItem.isUploaded != null && dataItem.isUploaded != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED] = dataItem.isUploaded;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.location != null && dataItem.location != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION] = dataItem.location;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED] = dataItem.isDeleted;
if (dataItem.id != null && dataItem.id != "null")
  values[ColumnsBase.KEY_ID] = dataItem.id;
if (dataItem.isDirty != null && dataItem.isDirty != "null")
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
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
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
            id = await db.update(TablesBase.TABLE_ACTIVITYMEDIA, values, where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);

//db.close();

        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteActivityMediaRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACTIVITYMEDIA, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException("DatabaseHandler:DeleteActivityMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
            }
           
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID} = $id";

            final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
            }
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ActivityMedia>> GetActivityMediaUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async {
        List<ActivityMedia> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACTIVITY} WHERE coalesce(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID},'') <> '')";

                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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
  // Use the `dataItem` object as needed
}

      }
        } catch ( ex) {
            Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ActivityMedia?> GetActivityMediaRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        ActivityMedia? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
		selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYMEDIA} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYMEDIA_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

         
                final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    ActivityMedia dataItem = new ActivityMedia();

                  for (var element in result) {
  ActivityMedia dataItem = ActivityMedia();

  dataItem.activityMediaID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID];
  dataItem.activityMediaCode = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE];
  dataItem.activityMediaName = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID];
  dataItem.contentTypeID = element[ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID];
  dataItem.mediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH];
  dataItem.mediaContent = element[ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT];
  dataItem.description = element[ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION];
  dataItem.tags = element[ColumnsBase.KEY_ACTIVITYMEDIA_TAGS];
  dataItem.localMediaPath = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH];
  dataItem.isUploaded = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER];
  dataItem.location = element[ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYMEDIA_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED];
  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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


  // Use the `dataItem` object as needed
}

      }
        }
        catch( ex)
        {
	    Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}
