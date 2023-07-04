
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/NoteMedia.dart';
import '../DataBaseHandler.dart';
import 'NoteMediaDataHandlerBase.dart';

class NoteMediaDataHandler extends NoteMediaDataHandlerBase {

     static Future<List<NoteMedia>> GetNoteMediaUploadRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<NoteMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED} = 'false' AND A.${ColumnsBase.KEY_ISDELETED} = 'false'";
            //selectQuery += " AND A." + ColumnsBase.KEY_ISDIRTY + " = 'false'";
            //selectQuery += " AND COALESCE(A." + ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE +  ",'') <> ''";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_NOTE} WHERE coalesce(${ColumnsBase.KEY_NOTE_NOTEID},'') <> '')";

             final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
        } catch ( ex) {
            Globals.handleException( "NoteMediaDataHandlerBase:GetNoteMediaUploadRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<NoteMedia>> GetNoteMediaRecordsOfTypeImage(DatabaseHandler databaseHandler,  String noteId) async{
        List<NoteMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ISDELETED} = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = $noteId";
            selectQuery += " AND D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} IN('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
        } catch ( ex) {
            Globals.handleException( "NoteMediaDataHandlerBase:GetNoteMediaUploadRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<NoteMedia>> GetNoteMediaRecordsOfTypeDocument(DatabaseHandler databaseHandler,  String noteId)async {
        List<NoteMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED} = 'false' AND A.${ColumnsBase.KEY_ISDELETED} = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = $noteId";
            selectQuery += " AND D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} NOT IN('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
        } catch ( ex) {
            Globals.handleException( "NoteMediaDataHandlerBase:GetNoteMediaUploadRecords()", ex);
            throw ex;
        }
        return dataList;
    }
	/*-------------------HAPPSALES-------------------*/

}