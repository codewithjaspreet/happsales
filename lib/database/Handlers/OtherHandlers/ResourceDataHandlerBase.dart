

 import '../../AppConstants.dart';
import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Resource.dart';
import '../DataBaseHandler.dart';

class ResourceDataHandlerBase {

     static Future<List<Resource>> GetResourceRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<Resource> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_RESOURCE_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND date(IFNULL(${ColumnsBase.KEY_RESOURCE_VALIDUPTO},'2100-12-31')) >= datetime('now') ";

            if (searchString.trim().length > 0) {
                selectQuery += " AND (A.${ColumnsBase.KEY_RESOURCE_RESOURCENAME} LIKE '%$searchString%'";
                selectQuery += " OR A.${Columns.KEY_RESOURCE_RESOURCECATEGORYNAME} LIKE '%$searchString%'";
                selectQuery += " OR A.${ColumnsBase.KEY_RESOURCE_DESCRIPTION} LIKE '%$searchString%'";
                selectQuery += " OR E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} LIKE '%$searchString%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Resource_Columns.KEY_RESOURCE_RESOURCENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex" + "," + pageSize.toString()}";


 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
                    
                    
                           }
           
            //db.close();
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetResourceRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Resource>> GetResourceRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<Resource> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_RESOURCE_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_RESOURCE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
                selectQuery += "${" AND (A.${ColumnsBase.KEY_RESOURCE_RESOURCENAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
                selectQuery += "${" OR A.${Columns.KEY_RESOURCE_RESOURCECATEGORYNAME} LIKE '%${searchString.replaceAll("'", "''")}"}%')";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_RESOURCE_RESOURCENAME} COLLATE NOCASE ASC ";

           
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
                    
                    
                           }
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetResourceRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Resource?> GetResourceRecord(DatabaseHandler databaseHandler,  String id) async{
        Resource? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_RESOURCE_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

                    
                    
                           }
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetResourceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Resource?> GetMasterResourceRecord(DatabaseHandler databaseHandler,  String id) async{
        Resource? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_RESOURCE_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_RESOURCE_RESOURCEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

                    
                    
                           }
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetMasterResourceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddResourceRecord(DatabaseHandler databaseHandler,  Resource dataItem) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.resourceID != null && dataItem.resourceID != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCEID] = dataItem.resourceID;
}
if (dataItem.resourceCode != null && dataItem.resourceCode != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCECODE] = dataItem.resourceCode;
}
if (dataItem.resourceName != null && dataItem.resourceName != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCENAME] = dataItem.resourceName;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_RESOURCE_PRODUCTID] = dataItem.productID;
}
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
  values[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID] = dataItem.contentTypeID;
}
if (dataItem.resourcePath != null && dataItem.resourcePath != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCEPATH] = dataItem.resourcePath;
}
if (dataItem.resourceContent != null && dataItem.resourceContent != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT] = dataItem.resourceContent;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_RESOURCE_DESCRIPTION] = dataItem.description;
}
if (dataItem.resourceCategoryName != null && dataItem.resourceCategoryName != "null") {
  values[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME] = dataItem.resourceCategoryName;
}
if (dataItem.isSharable != null && dataItem.isSharable != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISSHARABLE] = dataItem.isSharable;
}
if (dataItem.validUpTo != null && dataItem.validUpTo != "null") {
  values[ColumnsBase.KEY_RESOURCE_VALIDUPTO] = dataItem.validUpTo;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_RESOURCE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_RESOURCE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_RESOURCE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_RESOURCE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_RESOURCE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_RESOURCE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_RESOURCE, values);
            //db.close();
        } catch ( ex) {
           Globals.handleException( "DatabaseHandler:AddResourceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateResourceRecord(DatabaseHandler databaseHandler,  String id1, Resource dataItem)async {
        int id = 0;
        try {
              final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.resourceID != null && dataItem.resourceID != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCEID] = dataItem.resourceID;
}
if (dataItem.resourceCode != null && dataItem.resourceCode != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCECODE] = dataItem.resourceCode;
}
if (dataItem.resourceName != null && dataItem.resourceName != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCENAME] = dataItem.resourceName;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_RESOURCE_PRODUCTID] = dataItem.productID;
}
if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
  values[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID] = dataItem.contentTypeID;
}
if (dataItem.resourcePath != null && dataItem.resourcePath != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCEPATH] = dataItem.resourcePath;
}
if (dataItem.resourceContent != null && dataItem.resourceContent != "null") {
  values[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT] = dataItem.resourceContent;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_RESOURCE_DESCRIPTION] = dataItem.description;
}
if (dataItem.resourceCategoryName != null && dataItem.resourceCategoryName != "null") {
  values[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME] = dataItem.resourceCategoryName;
}
if (dataItem.isSharable != null && dataItem.isSharable != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISSHARABLE] = dataItem.isSharable;
}
if (dataItem.validUpTo != null && dataItem.validUpTo != "null") {
  values[ColumnsBase.KEY_RESOURCE_VALIDUPTO] = dataItem.validUpTo;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_RESOURCE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_RESOURCE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_RESOURCE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_RESOURCE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_RESOURCE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_RESOURCE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_RESOURCE_ISDELETED] = dataItem.isDeleted;
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

  if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null"){

    values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
  }

            id = await db.update(TablesBase.TABLE_RESOURCE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
           Globals.handleException( "DatabaseHandler:UpdateResourceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteResourceRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_RESOURCE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
           Globals.handleException( "DatabaseHandler:DeleteResourceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_RESOURCE_RESOURCEID}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

              final db = await databaseHandler.database;

              List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

              
              if(result.length > 0){
                serverId = result[0][ColumnsBase.KEY_RESOURCE_RESOURCEID];
              }
            
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_RESOURCE_RESOURCEID} = $id";

              final db = await databaseHandler.database;

              List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

              if(result.length > 0){
                localId = result[0][ColumnsBase.KEY_ID];
              }
            
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Resource>> GetResourceUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<Resource> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_RESOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_RESOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_RESOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

                    
                    
                           }
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetResourceUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<Resource?> GetResourceRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        Resource? dataItem ;
        try {

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_RESOURCE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_RESOURCE_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_RESOURCE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_RESOURCE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

         
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Resource dataItem = new Resource();
                    dataItem.resourceID = ele[ColumnsBase.KEY_RESOURCE_RESOURCEID];
                    dataItem.resourceCode = ele[ColumnsBase.KEY_RESOURCE_RESOURCECODE];
                    dataItem.resourceName = ele[ColumnsBase.KEY_RESOURCE_RESOURCENAME];
                    dataItem.productID = ele[ColumnsBase.KEY_RESOURCE_PRODUCTID];
                    dataItem.contentTypeID = ele[ColumnsBase.KEY_RESOURCE_CONTENTTYPEID];
                    dataItem.resourcePath = ele[ColumnsBase.KEY_RESOURCE_RESOURCEPATH];
                    dataItem.resourceContent = ele[ColumnsBase.KEY_RESOURCE_RESOURCECONTENT];
                    dataItem.description = ele[ColumnsBase.KEY_RESOURCE_DESCRIPTION];
                    dataItem.resourceCategoryName = ele[Columns.KEY_RESOURCE_RESOURCECATEGORYNAME];
                    dataItem.isSharable = ele[ColumnsBase.KEY_RESOURCE_ISSHARABLE];
                    
                    dataItem.validUpTo = ele[ColumnsBase.KEY_RESOURCE_VALIDUPTO];

                    dataItem.createdBy = ele[ColumnsBase.KEY_RESOURCE_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_RESOURCE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_RESOURCE_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_RESOURCE_ISACTIVE];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_RESOURCE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_RESOURCE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_RESOURCE_UID];

                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.contentTypeName = ele[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_RESOURCE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_RESOURCE_APPUSERID];
                    
                                   dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

                    
                    
                           }
            //db.close();
        } catch ( ex) {
           Globals.handleException( "ResourceDataHandlerBase:GetResourceRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}