
 import 'dart:ffi';

import '../../AppConstants.dart';
import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityProductDetail.dart';
import '../DataBaseHandler.dart';

class ActivityProductDetailDataHandlerBase {

     static Future<List<ActivityProductDetail>> GetActivityProductDetailRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<ActivityProductDetail> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + ",E." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYPRODUCT + " B ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " E ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE + " LIKE '%" + searchString.replaceAll("'","''") + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityProductDetail_Columns.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();

            final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetActivityProductDetailRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityProductDetail>> GetActivityProductDetailRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<ActivityProductDetail> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + ",E." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYPRODUCT + " B ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " E ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE + " LIKE '" + searchString.replaceAll("'","''") + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE + " COLLATE NOCASE ASC ";

             final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetActivityProductDetailRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityProductDetail?> GetActivityProductDetailRecord(DatabaseHandler databaseHandler,  String id) async{
        ActivityProductDetail? dataItem;         try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + ",E." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYPRODUCT + " B ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " E ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
         
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetActivityProductDetailRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityProductDetail?> GetMasterActivityProductDetailRecord(DatabaseHandler databaseHandler,  String id)  async{
        ActivityProductDetail? dataItem;         try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + ",E." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYPRODUCT + " B ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " E ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetMasterActivityProductDetailRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityProductDetailRecord(DatabaseHandler databaseHandler,  ActivityProductDetail dataItem)async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
          Map<String, dynamic> values = new Map();
          if (dataItem.activityProductDetailID != null && dataItem.activityProductDetailID != "null") {
            values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID] = dataItem.activityProductDetailID;
          }
if (dataItem.activityProductDetailCode != null && dataItem.activityProductDetailCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE] = dataItem.activityProductDetailCode;
}
if (dataItem.activityProductID != null && dataItem.activityProductID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID] = dataItem.activityProductID;
}
if (dataItem.attribute != null && dataItem.attribute != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE] = dataItem.attribute;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE] = dataItem.price;
}
if (dataItem.quantity != null && dataItem.quantity != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY] = dataItem.quantity;
}
if (dataItem.amount != null && dataItem.amount != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT] = dataItem.amount;
}
if (dataItem.supplierAccountID != null && dataItem.supplierAccountID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID] = dataItem.supplierAccountID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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

id = await db.insert(TablesBase.TABLE_ACTIVITYPRODUCTDETAIL, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityProductDetailRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityProductDetailRecord(DatabaseHandler databaseHandler,  String id1, ActivityProductDetail dataItem) async{
        int id = 0;
        try {
             final db = await databaseHandler.database;
          Map<String, dynamic> values = new Map();
          if (dataItem.activityProductDetailID != null && dataItem.activityProductDetailID != "null") {
            values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID] = dataItem.activityProductDetailID;
          }
if (dataItem.activityProductDetailCode != null && dataItem.activityProductDetailCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE] = dataItem.activityProductDetailCode;
}
if (dataItem.activityProductID != null && dataItem.activityProductID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID] = dataItem.activityProductID;
}
if (dataItem.attribute != null && dataItem.attribute != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE] = dataItem.attribute;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE] = dataItem.price;
}
if (dataItem.quantity != null && dataItem.quantity != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY] = dataItem.quantity;
}
if (dataItem.amount != null && dataItem.amount != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT] = dataItem.amount;
}
if (dataItem.supplierAccountID != null && dataItem.supplierAccountID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID] = dataItem.supplierAccountID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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

            id = await db.update(TablesBase.TABLE_ACTIVITYPRODUCTDETAIL, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityProductDetailRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteActivityProductDetailRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACTIVITYPRODUCTDETAIL, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteActivityProductDetailRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

          final db = await databaseHandler.database;
          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID].toString();
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID + " = " + id;

           final db = await databaseHandler.database;
          List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ActivityProductDetail>> GetActivityProductDetailUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ActivityProductDetail> dataList =[];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetActivityProductDetailUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<ActivityProductDetail?> GetActivityProductDetailRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        ActivityProductDetail? dataItem;         try {

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + ",E." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRODUCTDETAIL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYPRODUCT + " B ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " E ON A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

             final db  = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    ActivityProductDetail dataItem = new ActivityProductDetail();

                    dataItem.activityProductDetailID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
                    dataItem.activityProductDetailCode = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
                    dataItem.activityProductID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
                    dataItem.attribute = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
                    dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
                    dataItem.quantity = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
                    dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
                    dataItem.supplierAccountID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
                    dataItem.activityProductCode = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
                    dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ActivityProductDetailDataHandlerBase:GetActivityProductDetailRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}