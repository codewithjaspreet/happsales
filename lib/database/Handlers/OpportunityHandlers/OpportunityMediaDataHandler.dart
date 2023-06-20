

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityMedia.dart';
import '../DataBaseHandler.dart';
import 'OpportunityMediaDataHandlerBase.dart';

class OpportunityMediaDataHandler extends OpportunityMediaDataHandlerBase {


     static Future<List<OpportunityMedia>> GetOpportunityMediaRecordsOfTypeImage(DatabaseHandler databaseHandler,  String id) async{
        List<OpportunityMedia> dataList = [];
        try
        {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = 	"SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = $id";
            selectQuery += " AND D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} IN ('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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

        }
        catch( ex)
        {
            Globals.handleException( "OpportunityMediaDataHandlerBase:GetMasterOpportunityMediaRecord()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<OpportunityMedia>> GetOpportunityMediaRecordsOfTypeDocument(DatabaseHandler databaseHandler,  String id) async{
        List<OpportunityMedia> dataList = [];
        try
        {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = 	"SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = $id";
            selectQuery += " AND D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} NOT IN ('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

         final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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

        }
        catch( ex)
        {
            Globals.handleException( "OpportunityMediaDataHandlerBase:GetMasterOpportunityMediaRecord()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<OpportunityMedia>> GetOpportunityMediaUploadRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<OpportunityMedia> dataList = [];
        try
        {
            String selectQuery = 	"SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED} = 'false' AND A.${ColumnsBase.KEY_ISDELETED} = 'false' AND A.${ColumnsBase.KEY_ISDIRTY} = 'false'";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE},'') <> ''";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE coalesce(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'') <> '')";
final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
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

        }
        catch( ex)
        {
            Globals.handleException( "OpportunityMediaDataHandlerBase:GetOpportunityMediaUploadRecords()", ex);
            throw ex;
        }
        return dataList;
    }

/*

     static List<OpportunityMedia> GetMasterOpportunityMediaRecordsOfTypeImage(DatabaseHandler databaseHandler,  String opportunityId) {
        List<OpportunityMedia> dataList = new ArrayList<OpportunityMedia>();
        try
        {
            opportunityId = Globals.TryParseLongForDBId(opportunityId);

            String selectQuery = 	"SELECT A.* "  + ",E." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + ",D." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYMEDIA + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTENTTYPE + " D ON A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " E ON A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID + " = " + opportunityId;
            selectQuery += " AND D." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME + " IN ('Image') " ;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    OpportunityMedia dataItem = new OpportunityMedia();
                    dataItem.setOpportunityMediaID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID)));
                    dataItem.setOpportunityMediaCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE)));
                    dataItem.setOpportunityMediaName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME)));
                    dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID)));
                    dataItem.setContentTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID)));
                    dataItem.setMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH)));
                    dataItem.setMediaContent(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT)));
                    dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION)));
                    dataItem.setTags(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS)));
                    dataItem.setLocalMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH)));
                    dataItem.setIsUploaded(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED)));
                    dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY)));
                    dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON)));
                    dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY)));
                    dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON)));
                    dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE)));
                    dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_UID)));
                    dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID)));
                    dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID)));
                    dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED)));
                    dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED)));

                    dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));
                    dataItem.setContentTypeName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME)));

                    dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
                    dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
                    dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
                    dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
                    dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
                    dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
                    dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
                    dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
                    dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
                    dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));
                    dataList.add(dataItem);
                } while (cursor.moveToNext());
            }
            cursor.close();
            //db.close();
        }
        catch( ex)
        {
            Globals.Handle( "OpportunityMediaDataHandlerBase:GetMasterOpportunityMediaRecord()", ex);
            throw ex;
        }
        return dataList;
    }


     static List<OpportunityMedia> GetMasterOpportunityMediaRecordsOfTypeDocument(DatabaseHandler databaseHandler,  String opportunityId) {
        List<OpportunityMedia> dataList = new ArrayList<OpportunityMedia>();
        try
        {
            opportunityId = Globals.TryParseLongForDBId(opportunityId);

            String selectQuery = 	"SELECT A.* "  + ",E." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + ",D." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYMEDIA + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTENTTYPE + " D ON A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " E ON A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID + " = " + opportunityId;
            selectQuery += " AND D." + ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME + " NOT IN ('Image') " ;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    OpportunityMedia dataItem = new OpportunityMedia();
                    dataItem.setOpportunityMediaID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID)));
                    dataItem.setOpportunityMediaCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE)));
                    dataItem.setOpportunityMediaName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME)));
                    dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID)));
                    dataItem.setContentTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID)));
                    dataItem.setMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH)));
                    dataItem.setMediaContent(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT)));
                    dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION)));
                    dataItem.setTags(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS)));
                    dataItem.setLocalMediaPath(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH)));
                    dataItem.setIsUploaded(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED)));
                    dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY)));
                    dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON)));
                    dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY)));
                    dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON)));
                    dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE)));
                    dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_UID)));
                    dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID)));
                    dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID)));
                    dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED)));
                    dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED)));

                    dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));
                    dataItem.setContentTypeName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME)));

                    dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
                    dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
                    dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
                    dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
                    dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
                    dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
                    dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
                    dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
                    dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
                    dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));
                    dataList.add(dataItem);
                } while (cursor.moveToNext());
            }
            cursor.close();
            //db.close();
        }
        catch( ex)
        {
            Globals.Handle( "OpportunityMediaDataHandlerBase:GetMasterOpportunityMediaRecord()", ex);
            throw ex;
        }
        return dataList;
    }
*/

	/*-------------------HAPPSALES-------------------*/

}