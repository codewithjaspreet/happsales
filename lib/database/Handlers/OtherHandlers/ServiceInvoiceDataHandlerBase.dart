

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ServiceInvoice.dart';
import '../DataBaseHandler.dart';

class ServiceInvoiceDataHandlerBase {


     static Future<List<ServiceInvoice>> GetServiceInvoiceRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ServiceInvoice> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},F.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} F ON A.${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} G ON A.${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ServiceInvoice_Columns.KEY_SERVICEINVOICE_SERVICEINVOICETITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";
            
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServiceInvoiceRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ServiceInvoice>> GetServiceInvoiceRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<ServiceInvoice> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},F.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} F ON A.${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} G ON A.${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServiceInvoiceRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ServiceInvoice?> GetServiceInvoiceRecord(DatabaseHandler databaseHandler,  String id)async {
        ServiceInvoice? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},F.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} F ON A.${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} G ON A.${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

         final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServiceInvoiceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ServiceInvoice?> GetMasterServiceInvoiceRecord(DatabaseHandler databaseHandler,  String id) async{
        ServiceInvoice? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},F.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} F ON A.${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} G ON A.${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetMasterServiceInvoiceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddServiceInvoiceRecord(DatabaseHandler databaseHandler,  ServiceInvoice dataItem)async {
        int id = 0;
        try {
            final db =await  databaseHandler.database;

// Create a new map for values
Map<String, dynamic> values = {};

if (dataItem.serviceInvoiceID != null && dataItem.serviceInvoiceID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID] = dataItem.serviceInvoiceID;
}
if (dataItem.serviceInvoiceCode != null && dataItem.serviceInvoiceCode != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE] = dataItem.serviceInvoiceCode;
}
if (dataItem.serviceInvoiceTitle != null && dataItem.serviceInvoiceTitle != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE] = dataItem.serviceInvoiceTitle;
}
if (dataItem.serviceInvoiceDate != null && dataItem.serviceInvoiceDate != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE] = dataItem.serviceInvoiceDate;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID] = dataItem.productID;
}
if (dataItem.barCode != null && dataItem.barCode != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_BARCODE] = dataItem.barCode;
}
if (dataItem.isInWarranty != null && dataItem.isInWarranty != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY] = dataItem.isInWarranty;
}
if (dataItem.productPartsPrice != null && dataItem.productPartsPrice != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE] = dataItem.productPartsPrice;
}
if (dataItem.serviceCharge != null && dataItem.serviceCharge != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE] = dataItem.serviceCharge;
}
if (dataItem.tax != null && dataItem.tax != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_TAX] = dataItem.tax;
}
if (dataItem.totalAmount != null && dataItem.totalAmount != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT] = dataItem.totalAmount;
}
if (dataItem.amountPaid != null && dataItem.amountPaid != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID] = dataItem.amountPaid;
}
if (dataItem.currencyID != null && dataItem.currencyID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID] = dataItem.currencyID;
}
if (dataItem.paymentDate != null && dataItem.paymentDate != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE] = dataItem.paymentDate;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED] = dataItem.isDeleted;
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

id = await db.insert(TablesBase.TABLE_SERVICEINVOICE, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddServiceInvoiceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateServiceInvoiceRecord(DatabaseHandler databaseHandler,  String id1, ServiceInvoice dataItem) async{
        int id = 0;
        try {
                       final db =await  databaseHandler.database;

// Create a new map for values
Map<String, dynamic> values = {};

if (dataItem.serviceInvoiceID != null && dataItem.serviceInvoiceID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID] = dataItem.serviceInvoiceID;
}
if (dataItem.serviceInvoiceCode != null && dataItem.serviceInvoiceCode != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE] = dataItem.serviceInvoiceCode;
}
if (dataItem.serviceInvoiceTitle != null && dataItem.serviceInvoiceTitle != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE] = dataItem.serviceInvoiceTitle;
}
if (dataItem.serviceInvoiceDate != null && dataItem.serviceInvoiceDate != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE] = dataItem.serviceInvoiceDate;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.productID != null && dataItem.productID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID] = dataItem.productID;
}
if (dataItem.barCode != null && dataItem.barCode != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_BARCODE] = dataItem.barCode;
}
if (dataItem.isInWarranty != null && dataItem.isInWarranty != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY] = dataItem.isInWarranty;
}
if (dataItem.productPartsPrice != null && dataItem.productPartsPrice != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE] = dataItem.productPartsPrice;
}
if (dataItem.serviceCharge != null && dataItem.serviceCharge != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE] = dataItem.serviceCharge;
}
if (dataItem.tax != null && dataItem.tax != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_TAX] = dataItem.tax;
}
if (dataItem.totalAmount != null && dataItem.totalAmount != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT] = dataItem.totalAmount;
}
if (dataItem.amountPaid != null && dataItem.amountPaid != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID] = dataItem.amountPaid;
}
if (dataItem.currencyID != null && dataItem.currencyID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID] = dataItem.currencyID;
}
if (dataItem.paymentDate != null && dataItem.paymentDate != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE] = dataItem.paymentDate;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_SERVICEINVOICE, values, where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateServiceInvoiceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteServiceInvoiceRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id =await  db.delete(TablesBase.TABLE_SERVICEINVOICE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteServiceInvoiceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final  db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
            }
            
        } catch ( ex) {
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
            
        } catch ( ex) {
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ServiceInvoice>> GetServiceInvoiceUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<ServiceInvoice> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
            Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServiceInvoiceUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ServiceInvoice?> GetServiceInvoiceRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        ServiceInvoice? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME},F.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
		selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICE} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} F ON A.${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} = F.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} G ON A.${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} = G.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_SERVICEINVOICE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    ServiceInvoice dataItem = new ServiceInvoice();
                    dataItem.serviceInvoiceID = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID];
                    dataItem.serviceInvoiceCode = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE];
                    dataItem.serviceInvoiceTitle = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
                    dataItem.serviceInvoiceDate = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE];
                    dataItem.accountID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID];
                    dataItem.activityID = ele[ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID];
                    dataItem.productID = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID];
                    dataItem.barCode = ele[ColumnsBase.KEY_SERVICEINVOICE_BARCODE];
                    dataItem.isInWarranty = ele[ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY];
                    dataItem.productPartsPrice = ele[ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE];
                    dataItem.serviceCharge = ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE];
                    dataItem.tax = ele[ColumnsBase.KEY_SERVICEINVOICE_TAX];
                    dataItem.totalAmount = ele[ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT];
                    dataItem.amountPaid = ele[ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID];
                    dataItem.currencyID = ele[ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID];
                    dataItem.paymentDate = ele[ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE];
                    dataItem.createdBy = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY];
                    
                    dataItem.createdOn = ele[ColumnsBase.KEY_SERVICEINVOICE_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_SERVICEINVOICE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED];
                    dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_SERVICEINVOICE_APPUSERID];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
                    dataItem.currencyName = ele[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

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
        }
        catch( ex)
        {
	    Globals.handleException( "ServiceInvoiceDataHandlerBase:GetServiceInvoiceRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}