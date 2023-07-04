
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Product.dart';
import '../DataBaseHandler.dart';
import 'ProductDataHandlerBase.dart';

class ProductDataHandler extends ProductDataHandlerBase {

	/*-------------------HAPPSALES-------------------*/

     static Future<Product?> GetProductRecordByProductName(DatabaseHandler databaseHandler,  String productName) async{
        Product? dataItem;
        try {

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} AS ${ColumnsBase.KEY_PRODUCT_PARENTPRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTCATEGORY} E ON A.${ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} = '$productName'";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ProductDataHandlerBase:GetProductRecordByProductName()", ex);
            throw ex;
        }
        return dataItem;
    }


}