

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountMedia.dart';
import '../DataBaseHandler.dart';
import 'AccountMediaDataHandlerBase.dart';

class AccountMediaDataHandler extends AccountMediaDataHandlerBase {

     static Future<List<AccountMedia>> GetAccountMediaRecords(DatabaseHandler databaseHandler,  String accountId, String searchString) async {
        List<AccountMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} IN ('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = ${accountId != ("") ? accountId : "-1"}" ;
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} LIKE '${searchString.replaceAll("'","''")}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} COLLATE NOCASE ASC ";
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

              AccountMedia dataItem = new AccountMedia();

              dataItem.accountMediaID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID];
              dataItem.accountMediaCode = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE];
              dataItem.accountMediaName = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME];
              dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID];
              dataItem.contentTypeID = element[ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID];
              dataItem.mediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH];
              dataItem.mediaContent = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT];
              dataItem.description = element[ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION];
              dataItem.tags = element[ColumnsBase.KEY_ACCOUNTMEDIA_TAGS];
              dataItem.LocalMediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH];
              dataItem.IsUploaded = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED];
              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY];
              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON];
              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY];
              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON];
              dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER];
              dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER];
              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE];
              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTMEDIA_UID];
              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID];
              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID];
              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED];
              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED];
              dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
              dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
         //   Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountMedia>> GetAccountMediaUploadRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AccountMedia> dataList =[];
        try {

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED} = 'false' AND A.${ColumnsBase.KEY_ISDELETED} = 'false' AND A.${ColumnsBase.KEY_ISDIRTY} = 'false'";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE},'') <> ''";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

              AccountMedia dataItem = new AccountMedia();

              dataItem.accountMediaID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID];
              dataItem.accountMediaCode = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE];
              dataItem.accountMediaName = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME];
              dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID];
              dataItem.contentTypeID = element[ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID];
              dataItem.mediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH];
              dataItem.mediaContent = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT];
              dataItem.description = element[ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION];
              dataItem.tags = element[ColumnsBase.KEY_ACCOUNTMEDIA_TAGS];
              dataItem.LocalMediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH];
              dataItem.IsUploaded = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED];
              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY];
              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON];
              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY];
              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON];
              dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER];
              dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER];
              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE];
              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTMEDIA_UID];
              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID];
              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID];
              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED];
              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED];
              dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
              dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
           // Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountMedia>> GetAccountMediaRecordsOfTypeDocument(DatabaseHandler databaseHandler,  String accountId, String searchString) async{
        List<AccountMedia> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} NOT IN ('Image') " ;
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = ${accountId != ("") ? accountId : "-1"}" ;
            if (searchString.trim().isNotEmpty) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} LIKE '${searchString.replaceAll("'","''")}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

              AccountMedia dataItem = new AccountMedia();

              dataItem.accountMediaID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID];
              dataItem.accountMediaCode = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE];
              dataItem.accountMediaName = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME];
              dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID];
              dataItem.contentTypeID = element[ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID];
              dataItem.mediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH];
              dataItem.mediaContent = element[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT];
              dataItem.description = element[ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION];
              dataItem.tags = element[ColumnsBase.KEY_ACCOUNTMEDIA_TAGS];
              dataItem.LocalMediaPath = element[ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH];
              dataItem.IsUploaded = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED];
              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY];
              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON];
              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY];
              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON];
              dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER];
              dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER];
              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE];
              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTMEDIA_UID];
              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID];
              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID];
              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED];
              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED];
              dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
              dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);
              
            }
            
            //db.close();
        } catch ( ex) {
        //    Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }


    /*-------------------HAPPSALES-------------------*/

}