
import 'package:happsales_crm/database/AppTables/ColumnsBase.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AttributeValue.dart';
import '../DataBaseHandler.dart';
import 'AttributeValueDataHandlerBase.dart';

 class AttributeValueDataHandler extends AttributeValueDataHandlerBase {

     static Future<List<AttributeValue>> GetAttributeValueRecordsByIds(DatabaseHandler databaseHandler , String Ids) async{
        List<AttributeValue> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTEVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTEVALUE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTEVALUE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUEID} IN ($Ids)";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME} COLLATE NOCASE ASC ";

            
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    AttributeValue dataItem = new AttributeValue();

                    dataItem.attributeValueID = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUEID];
                    dataItem.attributeValueCode = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUECODE];
                    dataItem.attributeValueName = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEID];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTEVALUE_DESCRIPTION];
                    dataItem.multiplier = element[ColumnsBase.KEY_ATTRIBUTEVALUE_MULTIPLIER];
                    dataItem.parentAttributeValueID = element[ColumnsBase.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUEID];
                    dataItem.parentAttributeValueName = element[Columns.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTEVALUE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ISDELETED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTEVALUE_ISDELETED];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.parentAttributeValueName = element[Columns.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUENAME];


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
            Globals.handleException( "AttributeValueDataHandlerBase:GetAttributeValueRecordsByIds()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}