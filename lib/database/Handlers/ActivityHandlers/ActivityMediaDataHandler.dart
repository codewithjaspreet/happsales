
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityMedia.dart';
import '../DataBaseHandler.dart';
import 'ActivityMediaDataHandlerBase.dart';

class ActivityMediaDataHandler extends ActivityMediaDataHandlerBase {

     static Future<List<ActivityMedia>> GetActivityMediaUploadRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ActivityMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",E." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYMEDIA + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTENTTYPE + " E ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED + " = 'false' AND A." + ColumnsBase.KEY_ISDELETED + " = 'false'  AND A." + ColumnsBase.KEY_ISDIRTY + " = 'false'";
            selectQuery += " AND COALESCE(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE +  ",'') <> ''";
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " IN (SELECT  " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACTIVITY + " WHERE coalesce(" + ColumnsBase.KEY_ACTIVITY_ACTIVITYID + ",'') <> '')";

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
            Globals.handleException( "ActivityMediaDataHandlerBase:GetActivityMediaUploadRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityMedia>> GetActivityMediaRecordsOfTypeImage(DatabaseHandler databaseHandler,  String activityId)async {
        List<ActivityMedia> dataList =[];
        try {

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",E." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYMEDIA + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTENTTYPE + " E ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " = " + activityId;
            selectQuery += " AND E." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME + " IN('Image') " ;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
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

     static Future<List<ActivityMedia>> GetActivityMediaRecordsOfTypeDocument(DatabaseHandler databaseHandler,  String activityId) async {
        List<ActivityMedia> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",E." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYMEDIA + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTENTTYPE + " E ON A." + ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID + " = " + activityId;
            selectQuery += " AND E." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME + " NOT IN('Image') " ;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

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

	/*-------------------HAPPSALES-------------------*/

}