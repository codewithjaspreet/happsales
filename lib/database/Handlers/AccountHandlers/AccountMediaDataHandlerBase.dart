
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountMedia.dart';
import '../DataBaseHandler.dart';

class AccountMediaDataHandlerBase {

     static Future<List<AccountMedia>> GetAccountMediaRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<AccountMedia> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountMedia_Columns.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


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
          //  Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountMedia>> GetAccountMediaRecords(DatabaseHandler databaseHandler,  String searchString) async{
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
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} LIKE '$searchString%'";
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
           // Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AccountMedia?> GetAccountMediaRecord(DatabaseHandler databaseHandler,  String id) async {
        AccountMedia? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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

              
            }
        } catch ( ex) {
           // Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AccountMedia?> GetMasterAccountMediaRecord(DatabaseHandler databaseHandler,  String id) async{
        AccountMedia? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

        } catch ( ex) {
            //Globals.HandleException(context, "AccountMediaDataHandlerBase:GetMasterAccountMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAccountMediaRecord(DatabaseHandler databaseHandler,  AccountMedia dataItem) async {
        int id = 0;
        try {
           final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.accountMediaID != null && dataItem.accountMediaID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID] = dataItem.accountMediaID;
}
if (dataItem.accountMediaCode != null && dataItem.accountMediaCode != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE] = dataItem.accountMediaCode;
}
if (dataItem.accountMediaName != null && dataItem.accountMediaName != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME] = dataItem.accountMediaName;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID] = dataItem.contentTypeID;
}
if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH] = dataItem.mediaPath;
}
if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT] = dataItem.mediaContent;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION] = dataItem.description;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_TAGS] = dataItem.tags;
}
if (dataItem.LocalMediaPath != null && dataItem.LocalMediaPath != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH] = dataItem.LocalMediaPath;
}
if (dataItem.IsUploaded != null && dataItem.IsUploaded != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED] = dataItem.IsUploaded;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED] = dataItem.isDeleted;
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

            id = await db.insert(TablesBase.TABLE_ACCOUNTMEDIA, values);
            //db.close();
        } catch ( ex) {
         //   Globals.HandleException(context, "DatabaseHandler:AddAccountMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAccountMediaRecord(DatabaseHandler databaseHandler,  String id1, AccountMedia dataItem) async{
        int id = 0;
        try {
            final db =  await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.accountMediaID != null && dataItem.accountMediaID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID] = dataItem.accountMediaID;
}
if (dataItem.accountMediaCode != null && dataItem.accountMediaCode != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE] = dataItem.accountMediaCode;
}
if (dataItem.accountMediaName != null && dataItem.accountMediaName != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME] = dataItem.accountMediaName;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID] = dataItem.contentTypeID;
}
if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH] = dataItem.mediaPath;
}
if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT] = dataItem.mediaContent;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION] = dataItem.description;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_TAGS] = dataItem.tags;
}
if (dataItem.LocalMediaPath != null && dataItem.LocalMediaPath != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH] = dataItem.LocalMediaPath;
}
if (dataItem.IsUploaded != null && dataItem.IsUploaded != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED] = dataItem.IsUploaded;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED] = dataItem.isDeleted;
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


            id = await db.update(TablesBase.TABLE_ACCOUNTMEDIA, values, where: "${ColumnsBase.KEY_ID} = $id1",  whereArgs :null);
            //db.close();
        } catch ( ex) {
         //   Globals.HandleException(context, "DatabaseHandler:UpdateAccountMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAccountMediaRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACCOUNTMEDIA,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
          //  Globals.HandleException(context, "DatabaseHandler:DeleteAccountMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

    static Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery =
        "SELECT A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      serverId = result[0][ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID];
    }
    // db.close();
  } catch ( ex) {
    //Globals.HandleException(context, "AccountMediaDataHandlerBase:GetServerId()", ex);
    throw ex;
  }
  return serverId;
}


   static Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery =
        "SELECT A.${ColumnsBase.KEY_ID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID} = $id";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      localId = result[0][ColumnsBase.KEY_ID];
    }
    // db.close();
  } catch ( ex) {
    //Globals.HandleException(context, "AccountMediaDataHandlerBase:GetLocalId()", ex);
    throw ex;
  }
  return localId;
}


     static Future<List<AccountMedia>> GetAccountMediaUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<AccountMedia> dataList = [];
        try {
            // ignore: prefer_interpolation_to_compose_strings
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

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
            //Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AccountMedia?> GetAccountMediaRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AccountMedia? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
		selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTMEDIA} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTMEDIA_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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

              
            }
        }
        catch( ex)
        {
	  //  Globals.HandleException(context, "AccountMediaDataHandlerBase:GetAccountMediaRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}