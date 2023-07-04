

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ProductAuxiliary.dart';
import '../DataBaseHandler.dart';

class ProductAuxiliaryDataHandlerBase {

     static Future<List<ProductAuxiliary>> GetProductAuxiliaryRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<ProductAuxiliary> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${Columns.KEY_PRODUCT_AUXILIARYPRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ProductAuxiliary_Columns.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";



      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetProductAuxiliaryRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ProductAuxiliary>> GetProductAuxiliaryRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<ProductAuxiliary> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${Columns.KEY_PRODUCT_AUXILIARYPRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE} COLLATE NOCASE ASC ";

          

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetProductAuxiliaryRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ProductAuxiliary?> GetProductAuxiliaryRecord(DatabaseHandler databaseHandler,  String id) async {
        ProductAuxiliary? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${Columns.KEY_PRODUCT_AUXILIARYPRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetProductAuxiliaryRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ProductAuxiliary?> GetMasterProductAuxiliaryRecord(DatabaseHandler databaseHandler,  String id) async{
        ProductAuxiliary? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${Columns.KEY_PRODUCT_AUXILIARYPRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetMasterProductAuxiliaryRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddProductAuxiliaryRecord(DatabaseHandler databaseHandler,  ProductAuxiliary dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.productAuxiliaryID != null && dataItem.productAuxiliaryID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID] = dataItem.productAuxiliaryID;
}
if (dataItem.productAuxiliaryCode != null && dataItem.productAuxiliaryCode != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE] = dataItem.productAuxiliaryCode;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID] = dataItem.productID;
}
if (dataItem.auxiliaryProductID != null && dataItem.auxiliaryProductID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID] = dataItem.auxiliaryProductID;
}
if (dataItem.quantity != null && dataItem.quantity != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY] = dataItem.quantity;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE] = dataItem.price;
}
if (dataItem.isPriceIncludesTax != null && dataItem.isPriceIncludesTax != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX] = dataItem.isPriceIncludesTax;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED] = dataItem.isDeleted;
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

 id = await db.insert(TablesBase.TABLE_PRODUCTAUXILIARY, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddProductAuxiliaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateProductAuxiliaryRecord(DatabaseHandler databaseHandler,  String id1, ProductAuxiliary dataItem) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.productAuxiliaryID != null && dataItem.productAuxiliaryID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID] = dataItem.productAuxiliaryID;
}
if (dataItem.productAuxiliaryCode != null && dataItem.productAuxiliaryCode != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE] = dataItem.productAuxiliaryCode;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID] = dataItem.productID;
}
if (dataItem.auxiliaryProductID != null && dataItem.auxiliaryProductID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID] = dataItem.auxiliaryProductID;
}
if (dataItem.quantity != null && dataItem.quantity != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY] = dataItem.quantity;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE] = dataItem.price;
}
if (dataItem.isPriceIncludesTax != null && dataItem.isPriceIncludesTax != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX] = dataItem.isPriceIncludesTax;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED] = dataItem.isDeleted;
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

if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

}
            
            id = await db.update(TablesBase.TABLE_PRODUCTAUXILIARY, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateProductAuxiliaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteProductAuxiliaryRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_PRODUCTAUXILIARY, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteProductAuxiliaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID];
            }
            
        } catch ( ex) {
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID} = $id";

            final db = await databaseHandler.database;
            List <Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }


            //db.close();
        } catch ( ex) {
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ProductAuxiliary>> GetProductAuxiliaryUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async {
        List<ProductAuxiliary> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";


      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetProductAuxiliaryUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ProductAuxiliary?> GetProductAuxiliaryRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        ProductAuxiliary ?dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${Columns.KEY_PRODUCT_AUXILIARYPRODUCTNAME}";
		selectQuery += " FROM ${TablesBase.TABLE_PRODUCTAUXILIARY} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_PRODUCTAUXILIARY_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ProductAuxiliary dataItem = new ProductAuxiliary();
                    dataItem.auxiliaryProductID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID].toString();
                    dataItem.productAuxiliaryCode = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE].toString();
                    dataItem.productID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID].toString();
                    dataItem.quantity = element[ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY].toString();
                    dataItem.price = element[ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE].toString();
                    dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX].toString();
                    dataItem.createdBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY].toString();
                    dataItem.createdOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON].toString();
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY].toString();
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON].toString();
                    dataItem.isActive = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED].toString();
                    dataItem.uid = element[ColumnsBase.KEY_PRODUCTAUXILIARY_UID].toString();
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID].toString();
                    dataItem.appUserID = element[ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID].toString();
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER].toString();

                    dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();
                    dataItem.auxiliaryProductName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME].toString();


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
	    Globals.handleException( "ProductAuxiliaryDataHandlerBase:GetProductAuxiliaryRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}