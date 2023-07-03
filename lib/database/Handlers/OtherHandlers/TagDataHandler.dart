
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Tag.dart';
import '../DataBaseHandler.dart';
import 'TagDataHandlerBase.dart';

class TagDataHandler extends TagDataHandlerBase {


     static Future<List<Tag>> GetTagRecordsLinkedTo(DatabaseHandler databaseHandler, String linkedTo, String businessFeatureId)async {
        List<Tag> dataList = [];
        try {

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE E.${ColumnsBase.KEY_TAGGROUP_LINKTO} ='$linkedTo'";
            //selectQuery += " AND E." + ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID + " = " + businessFeatureId;
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";

 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
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
            Globals.handleException( "DatabaseHandler:GetTagRecords()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}