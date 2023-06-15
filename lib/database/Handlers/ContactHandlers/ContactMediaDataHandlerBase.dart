

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ContactModels.dart/ContactMedia.dart';
import '../DataBaseHandler.dart';

class ContactMediaDataHandlerBase {

     static Future<List<ContactMedia>> GetContactMediaRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<ContactMedia> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ContactMedia_Columns.KEY_CONTACTMEDIA_CONTACTMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataList.add(dataItem);
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);
            }
          
        } catch ( ex) {
          //  Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ContactMedia>> GetContactMediaRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<ContactMedia> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataList.add(dataItem);
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);
            }
        } catch ( ex) {
         //   Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ContactMedia?> GetContactMediaRecord(DatabaseHandler databaseHandler,  String id) async{
        ContactMedia? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
  final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

            }
        } catch ( ex) {
          //  Globals.HandleException(context, "ContactMediaDataHandlerBase:GetContactMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ContactMedia?> GetMasterContactMediaRecord(DatabaseHandler databaseHandler,  String id) async{
        ContactMedia? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_CONTACT_CONTACTNAME},E.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} E ON A.${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            //db.close();
              final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){
                   
                   
                    ContactMedia dataItem = new ContactMedia();

                    dataItem.contactMediaID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
                    dataItem.contactMediaCode = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE];
                    dataItem.contactMediaName = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME];
                    dataItem.contactID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTACTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID];
                    dataItem.mediaPath = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH];
                    dataItem.mediaContent = ele[ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION];
                    dataItem.tags = ele[ColumnsBase.KEY_CONTACTMEDIA_TAGS];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_CONTACTMEDIA_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED];
                    dataItem.createdBy = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_CONTACTMEDIA_CREATEDON];

                    dataItem.contactName = ele[ColumnsBase.KEY_CONTACT_CONTACTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];

            }
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetMasterContactMediaRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> DeleteContactMediaRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
          
                      id = await db.delete(TablesBase.TABLE_CONTACTMEDIA, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
         //   Globals.HandleException(context, "DatabaseHandler:DeleteContactMediaRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

          final db = await databaseHandler.database;

          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
            }
            //db.close();
           
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACTMEDIA} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID} = $id";
final db = await databaseHandler.database;

          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID];
            }
        } catch ( ex) {
           // Globals.HandleException(context, "ContactMediaDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

    
	/*-------------------HAPPSALES-------------------*/

}