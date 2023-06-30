

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserProduct.dart';
import '../DataBaseHandler.dart';

class AppUserProductDataHandlerBase {

     static Future<List<AppUserProduct>> GetAppUserProductRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async{
        List<AppUserProduct> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE} LIKE '%${searchString.replaceAll("'","''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserProduct_Columns.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";


            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
            Globals.handleException( "AppUserProductDataHandlerBase:GetAppUserProductRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserProduct>> GetAppUserProductRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<AppUserProduct> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE} LIKE '" + searchString.replaceAll("'","''")}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
            Globals.handleException( "AppUserProductDataHandlerBase:GetAppUserProductRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserProduct?> GetAppUserProductRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUserProduct? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
            Globals.handleException( "AppUserProductDataHandlerBase:GetAppUserProductRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserProduct?> GetMasterAppUserProductRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUserProduct? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
            Globals.handleException( "AppUserProductDataHandlerBase:GetMasterAppUserProductRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserProductRecord(DatabaseHandler databaseHandler,  AppUserProduct dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserProductID != null && dataItem.appUserProductID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID] = dataItem.appUserProductID;
}
if (dataItem.appUserProductCode != null && dataItem.appUserProductCode != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE] = dataItem.appUserProductCode;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID] = dataItem.productID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED] = dataItem.isDeleted;
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


            id = await  db.insert(TablesBase.TABLE_APPUSERPRODUCT, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserProductRecord(DatabaseHandler databaseHandler,  String id1, AppUserProduct dataItem)async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserProductID != null && dataItem.appUserProductID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID] = dataItem.appUserProductID;
}
if (dataItem.appUserProductCode != null && dataItem.appUserProductCode != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE] = dataItem.appUserProductCode;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID] = dataItem.productID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_APPUSERPRODUCT, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserProductRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPUSERPRODUCT, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID].toString();
            }
           ;
        } catch ( ex) {
            Globals.handleException( "AppUserProductDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID} = $id";

            final db = await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
            
            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AppUserProductDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserProduct>> GetAppUserProductUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<AppUserProduct> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
            Globals.handleException( "AppUserProductDataHandlerBase:GetAppUserProductUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUserProduct?> GetAppUserProductRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AppUserProduct? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME;
		selectQuery += " FROM ${TablesBase.TABLE_APPUSERPRODUCT} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERPRODUCT_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    AppUserProduct dataItem = new AppUserProduct();

dataItem.appUserProductID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID];
dataItem.appUserProductCode = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE];
dataItem.appUserID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID];
dataItem.productID = element[ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID];
dataItem.createdBy = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON];
dataItem.isActive = element[ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_APPUSERPRODUCT_UID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED];
dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

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
        }
        catch( ex)
        {
	    Globals.handleException( "AppUserProductDataHandlerBase:GetAppUserProductRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}