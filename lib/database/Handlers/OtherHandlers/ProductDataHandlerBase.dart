

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Product.dart';
import '../DataBaseHandler.dart';

class ProductDataHandlerBase {

     static Future<List<Product>> GetProductRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<Product> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " LIKE '%" + searchString + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Product_Columns.KEY_PRODUCT_PRODUCTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();




      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Product>> GetProductRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<Product> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " LIKE '" + searchString + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " COLLATE NOCASE ASC ";

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Product>> GetProductRecordsLimited(DatabaseHandler databaseHandler,  String searchString) async {
        List<Product> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_PRODUCT_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " LIKE '%" + searchString + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " COLLATE NOCASE ASC LIMIT 300";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Product?> GetProductRecord(DatabaseHandler databaseHandler,  String id) async {
        Product? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Product?> GetMasterProductRecord(DatabaseHandler databaseHandler,  String id) async {
        Product? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_PRODUCT_PRODUCTID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetMasterProductRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddProductRecord(DatabaseHandler databaseHandler,  Product dataItem) async {
        int id = 0;
        try {
           final db = await databaseHandler.database;
Map<String, dynamic> values = Map<String, dynamic>();

if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTID] = dataItem.productID;
}
if (dataItem.productCode != null && dataItem.productCode != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCODE] = dataItem.productCode;
}
if (dataItem.productName != null && dataItem.productName != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTNAME] = dataItem.productName;
}
if (dataItem.productDescription != null && dataItem.productDescription != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION] = dataItem.productDescription;
}
if (dataItem.manufacturer != null && dataItem.manufacturer != "null") {
  values[ColumnsBase.KEY_PRODUCT_MANUFACTURER] = dataItem.manufacturer;
}
if (dataItem.hsnCode != null && dataItem.hsnCode != "null") {
  values[ColumnsBase.KEY_PRODUCT_HSNCODE] = dataItem.hsnCode;
}
if (dataItem.mrp != null && dataItem.mrp != "null") {
  values[ColumnsBase.KEY_PRODUCT_MRP] = dataItem.mrp;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRICE] = dataItem.price;
}
if (dataItem.currentStock != null && dataItem.currentStock != "null") {
  values[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK] = dataItem.currentStock;
}
if (dataItem.unitID != null && dataItem.unitID != "null") {
  values[ColumnsBase.KEY_PRODUCT_UNITID] = dataItem.unitID;
}
if (dataItem.cgstPercentage != null && dataItem.cgstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE] = dataItem.cgstPercentage;
}
if (dataItem.sgstPercentage != null && dataItem.sgstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE] = dataItem.sgstPercentage;
}
if (dataItem.gstPercentage != null && dataItem.gstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE] = dataItem.gstPercentage;
}
if (dataItem.isPriceIncludesTax != null && dataItem.isPriceIncludesTax != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX] = dataItem.isPriceIncludesTax;
}
if (dataItem.priceForSales != null && dataItem.priceForSales != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRICEFORSALES] = dataItem.priceForSales;
}
if (dataItem.minimumSalesPrice != null && dataItem.minimumSalesPrice != "null") {
  values[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE] = dataItem.minimumSalesPrice;
}
if (dataItem.maximumSalesPrice != null && dataItem.maximumSalesPrice != "null") {
  values[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE] = dataItem.maximumSalesPrice;
}
if (dataItem.isAttributeBased != null && dataItem.isAttributeBased != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED] = dataItem.isAttributeBased;
}
if (dataItem.productCategoryID != null && dataItem.productCategoryID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID] = dataItem.productCategoryID;
}
if (dataItem.lifeTimeInHours != null && dataItem.lifeTimeInHours != "null") {
  values[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS] = dataItem.lifeTimeInHours;
}
if (dataItem.parentProductID != null && dataItem.parentProductID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID] = dataItem.parentProductID;
}
// if (dataItem.parentProductName != null && dataItem.parentProductName != "null")
//     values[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME] = dataItem.parentProductName;
if (dataItem.productThumbnailImagePath != null && dataItem.productThumbnailImagePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH] = dataItem.productThumbnailImagePath;
}
if (dataItem.productImagePath != null && dataItem.productImagePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH] = dataItem.productImagePath;
}
if (dataItem.productBrochurePath != null && dataItem.productBrochurePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH] = dataItem.productBrochurePath;
}
if (dataItem.productCategoryHierarchy != null && dataItem.productCategoryHierarchy != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY] = dataItem.productCategoryHierarchy;
}
if (dataItem.productAttributes != null && dataItem.productAttributes != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES] = dataItem.productAttributes;
}
if (dataItem.isSaleable != null && dataItem.isSaleable != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISSALEABLE] = dataItem.isSaleable;
}
if (dataItem.featureOptions != null && dataItem.featureOptions != "null") {
  values[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS] = dataItem.featureOptions;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_PRODUCT_TAGS] = dataItem.tags;
}
if (dataItem.remarks != null && dataItem.remarks != "null") {
  values[ColumnsBase.KEY_PRODUCT_REMARKS] = dataItem.remarks;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PRODUCT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PRODUCT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PRODUCT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PRODUCT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PRODUCT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PRODUCT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISDELETED] = dataItem.isDeleted;
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

id = await db.insert(TablesBase.TABLE_PRODUCT, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateProductRecord(DatabaseHandler databaseHandler,  String id1, Product dataItem) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
Map<String, dynamic> values = Map<String, dynamic>();

if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTID] = dataItem.productID;
}
if (dataItem.productCode != null && dataItem.productCode != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCODE] = dataItem.productCode;
}
if (dataItem.productName != null && dataItem.productName != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTNAME] = dataItem.productName;
}
if (dataItem.productDescription != null && dataItem.productDescription != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION] = dataItem.productDescription;
}
if (dataItem.manufacturer != null && dataItem.manufacturer != "null") {
  values[ColumnsBase.KEY_PRODUCT_MANUFACTURER] = dataItem.manufacturer;
}
if (dataItem.hsnCode != null && dataItem.hsnCode != "null") {
  values[ColumnsBase.KEY_PRODUCT_HSNCODE] = dataItem.hsnCode;
}
if (dataItem.mrp != null && dataItem.mrp != "null") {
  values[ColumnsBase.KEY_PRODUCT_MRP] = dataItem.mrp;
}
if (dataItem.price != null && dataItem.price != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRICE] = dataItem.price;
}
if (dataItem.currentStock != null && dataItem.currentStock != "null") {
  values[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK] = dataItem.currentStock;
}
if (dataItem.unitID != null && dataItem.unitID != "null") {
  values[ColumnsBase.KEY_PRODUCT_UNITID] = dataItem.unitID;
}
if (dataItem.cgstPercentage != null && dataItem.cgstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE] = dataItem.cgstPercentage;
}
if (dataItem.sgstPercentage != null && dataItem.sgstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE] = dataItem.sgstPercentage;
}
if (dataItem.gstPercentage != null && dataItem.gstPercentage != "null") {
  values[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE] = dataItem.gstPercentage;
}
if (dataItem.isPriceIncludesTax != null && dataItem.isPriceIncludesTax != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX] = dataItem.isPriceIncludesTax;
}
if (dataItem.priceForSales != null && dataItem.priceForSales != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRICEFORSALES] = dataItem.priceForSales;
}
if (dataItem.minimumSalesPrice != null && dataItem.minimumSalesPrice != "null") {
  values[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE] = dataItem.minimumSalesPrice;
}
if (dataItem.maximumSalesPrice != null && dataItem.maximumSalesPrice != "null") {
  values[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE] = dataItem.maximumSalesPrice;
}
if (dataItem.isAttributeBased != null && dataItem.isAttributeBased != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED] = dataItem.isAttributeBased;
}
if (dataItem.productCategoryID != null && dataItem.productCategoryID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID] = dataItem.productCategoryID;
}
if (dataItem.lifeTimeInHours != null && dataItem.lifeTimeInHours != "null") {
  values[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS] = dataItem.lifeTimeInHours;
}
if (dataItem.parentProductID != null && dataItem.parentProductID != "null") {
  values[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID] = dataItem.parentProductID;
}
// if (dataItem.parentProductName != null && dataItem.parentProductName != "null")
//     values[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME] = dataItem.parentProductName;
if (dataItem.productThumbnailImagePath != null && dataItem.productThumbnailImagePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH] = dataItem.productThumbnailImagePath;
}
if (dataItem.productImagePath != null && dataItem.productImagePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH] = dataItem.productImagePath;
}
if (dataItem.productBrochurePath != null && dataItem.productBrochurePath != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH] = dataItem.productBrochurePath;
}
if (dataItem.productCategoryHierarchy != null && dataItem.productCategoryHierarchy != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY] = dataItem.productCategoryHierarchy;
}
if (dataItem.productAttributes != null && dataItem.productAttributes != "null") {
  values[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES] = dataItem.productAttributes;
}
if (dataItem.isSaleable != null && dataItem.isSaleable != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISSALEABLE] = dataItem.isSaleable;
}
if (dataItem.featureOptions != null && dataItem.featureOptions != "null") {
  values[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS] = dataItem.featureOptions;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_PRODUCT_TAGS] = dataItem.tags;
}
if (dataItem.remarks != null && dataItem.remarks != "null") {
  values[ColumnsBase.KEY_PRODUCT_REMARKS] = dataItem.remarks;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PRODUCT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PRODUCT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PRODUCT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PRODUCT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PRODUCT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PRODUCT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PRODUCT_ISDELETED] = dataItem.isDeleted;
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
            id =await  db.update(TablesBase.TABLE_PRODUCT, values, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteProductRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;

          
            id = await db.delete(TablesBase.TABLE_PRODUCT, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteProductRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_PRODUCT_PRODUCTID;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_PRODUCT_PRODUCTID].toString();
            }
         
        } catch ( ex) {
            Globals.handleException( "ProductDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_PRODUCT_PRODUCTID + " = " + id;

            final db =await  databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
            
        } catch ( ex) {
            Globals.handleException( "ProductDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Product>> GetProductUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async {
        List<Product> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_PRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_PRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_PRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<Product?> GetProductRecordByUid(DatabaseHandler databaseHandler,  String uid) async {
        Product? dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",E." + ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME + ",D." + ColumnsBase.KEY_PRODUCT_PRODUCTNAME + " AS " + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_PRODUCT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCT + " D ON A." + ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_PRODUCTCATEGORY + " E ON A." + ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_PRODUCT_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserGroupID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_PRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
     for (var element in list) {
  Product dataItem = Product();

  dataItem.productID = element[ColumnsBase.KEY_PRODUCT_PRODUCTID];
  dataItem.productCode = element[ColumnsBase.KEY_PRODUCT_PRODUCTCODE];
  dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
  dataItem.productDescription = element[ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION];
  dataItem.manufacturer = element[ColumnsBase.KEY_PRODUCT_MANUFACTURER];
  dataItem.hsnCode = element[ColumnsBase.KEY_PRODUCT_HSNCODE];
  dataItem.mrp = element[ColumnsBase.KEY_PRODUCT_MRP];
  dataItem.price = element[ColumnsBase.KEY_PRODUCT_PRICE];
  dataItem.currentStock = element[ColumnsBase.KEY_PRODUCT_CURRENTSTOCK];
  dataItem.unitID = element[ColumnsBase.KEY_PRODUCT_UNITID];
  dataItem.cgstPercentage = element[ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE];
  dataItem.sgstPercentage = element[ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE];
  dataItem.gstPercentage = element[ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE];
  dataItem.isPriceIncludesTax = element[ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX];
  dataItem.priceForSales = element[ColumnsBase.KEY_PRODUCT_PRICEFORSALES];
  dataItem.minimumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE];
  dataItem.maximumSalesPrice = element[ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE];
  dataItem.isAttributeBased = element[ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED];
  dataItem.productCategoryID = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID];
  dataItem.lifeTimeInHours = element[ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS];
  dataItem.parentProductID = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productThumbnailImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH];
  dataItem.productImagePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH];
  dataItem.productBrochurePath = element[ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH];
  dataItem.productAttributes = element[ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES];
  dataItem.isSaleable = element[ColumnsBase.KEY_PRODUCT_ISSALEABLE];
  dataItem.featureOptions = element[ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS];
  dataItem.tags = element[ColumnsBase.KEY_PRODUCT_TAGS];
  dataItem.remarks = element[ColumnsBase.KEY_PRODUCT_REMARKS];
  dataItem.createdBy = element[ColumnsBase.KEY_PRODUCT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_PRODUCT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_PRODUCT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_PRODUCT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_PRODUCT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_PRODUCT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_PRODUCT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_PRODUCT_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_PRODUCT_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_PRODUCT_ISDELETED];

  dataItem.productCategoryName = element[ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME];
  dataItem.parentProductName = element[ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME];
  dataItem.productCategoryHierarchy = element[ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY];


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
            Globals.handleException( "ProductDataHandlerBase:GetProductRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/


}