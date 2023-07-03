
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ContentType.dart';
import '../DataBaseHandler.dart';
import 'ContentTypeDataHandlerBase.dart';

class ContentTypeDataHandler extends ContentTypeDataHandlerBase {

     static Future<ContentType?> GetContentTypeRecordByContentTypeName(DatabaseHandler databaseHandler, String contentTypeName) async {
        ContentType? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM " + TablesBase.TABLE_CONTENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} = '$contentTypeName'";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CONTENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " LIMIT 1 ";


 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ContentType dataItem = new ContentType();

                    dataItem.contentTypeID = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPEID];
                    dataItem.contentTypeCode = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPECODE];
                    dataItem.contentTypeName = element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_CONTENTTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CONTENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CONTENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CONTENTTYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CONTENTTYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CONTENTTYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CONTENTTYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_CONTENTTYPE_ISARCHIVED];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CONTENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CONTENTTYPE_APPUSERID];

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
            Globals.handleException( "ContentTypeDataHandlerBase:GetContentTypeRecordByContentTypeName()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}