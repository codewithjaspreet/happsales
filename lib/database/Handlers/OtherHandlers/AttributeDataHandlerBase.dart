

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Attribute.dart';
import '../DataBaseHandler.dart';

class AttributeDataHandlerBase {

     static Future<List<Attribute>> GetAttributeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<Attribute> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} AS ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Attribute_Columns.KEY_ATTRIBUTE_ATTRIBUTENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetAttributeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Attribute>> GetAttributeRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<Attribute> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} AS ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ATTRIBUTE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} COLLATE NOCASE ASC ";

            
           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetAttributeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Attribute?> GetAttributeRecord(DatabaseHandler databaseHandler,  String id) async{
        Attribute? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} AS ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetAttributeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Attribute?> GetAttributeRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        Attribute? dataItem ;
        try {

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} AS ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ATTRIBUTE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

          
           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetAttributeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Attribute?> GetMasterAttributeRecord(DatabaseHandler databaseHandler,  String id)async {
        Attribute? dataItem;
        try {
            id = await Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} AS ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetMasterAttributeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAttributeRecord(DatabaseHandler databaseHandler,  Attribute dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.attributeID != null && dataItem.attributeID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID] = dataItem.attributeID;
}
if (dataItem.attributeCode != null && dataItem.attributeCode != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE] = dataItem.attributeCode;
}
if (dataItem.attributeName != null && dataItem.attributeName != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME] = dataItem.attributeName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION] = dataItem.description;
}
if (dataItem.applyToAllProducts != null && dataItem.applyToAllProducts != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS] = dataItem.applyToAllProducts;
}
if (dataItem.parentAttributeID != null && dataItem.parentAttributeID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID] = dataItem.parentAttributeID;
}
if (dataItem.parentAttributeName != null && dataItem.parentAttributeName != "null") {
  values[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME] = dataItem.parentAttributeName;
}
if (dataItem.isSelfReferencing != null && dataItem.isSelfReferencing != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING] = dataItem.isSelfReferencing;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_ATTRIBUTE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAttributeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAttributeRecord(DatabaseHandler databaseHandler,  String id1, Attribute dataItem) async{
        int id = 0;
        try {
             final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.attributeID != null && dataItem.attributeID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID] = dataItem.attributeID;
}
if (dataItem.attributeCode != null && dataItem.attributeCode != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE] = dataItem.attributeCode;
}
if (dataItem.attributeName != null && dataItem.attributeName != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME] = dataItem.attributeName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION] = dataItem.description;
}
if (dataItem.applyToAllProducts != null && dataItem.applyToAllProducts != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS] = dataItem.applyToAllProducts;
}
if (dataItem.parentAttributeID != null && dataItem.parentAttributeID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID] = dataItem.parentAttributeID;
}
if (dataItem.parentAttributeName != null && dataItem.parentAttributeName != "null") {
  values[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME] = dataItem.parentAttributeName;
}
if (dataItem.isSelfReferencing != null && dataItem.isSelfReferencing != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING] = dataItem.isSelfReferencing;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ATTRIBUTE_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_ATTRIBUTE, values,  where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAttributeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAttributeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_ATTRIBUTE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAttributeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
           
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AttributeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ATTRIBUTE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID} = $id";

           final db = await databaseHandler.database;
           
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
            }
        } catch ( ex) {
            Globals.handleException( "AttributeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Attribute>> GetAttributeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<Attribute> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            //selectQuery += " AND " + ColumnsBase.KEY_ATTRIBUTE_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

          final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
                    Attribute dataItem = new Attribute();
                    dataItem.attributeID = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID];
                    dataItem.attributeCode = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE];
                    dataItem.attributeName = element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
                    dataItem.description = element[ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION];
                    dataItem.applyToAllProducts = element[ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS];
                    dataItem.parentAttributeID = element[ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID];  
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];
                    dataItem.isSelfReferencing = element[ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ATTRIBUTE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ATTRIBUTE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ATTRIBUTE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ATTRIBUTE_ISDELETED];
                    dataItem.parentAttributeName = element[Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME];



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
            Globals.handleException( "AttributeDataHandlerBase:GetAttributeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}