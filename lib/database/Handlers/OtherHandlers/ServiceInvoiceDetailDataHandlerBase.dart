import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ServiceInvoiceDetail.dart';
import '../DataBaseHandler.dart';

class ServiceInvoiceDetailDataHandlerBase {
  static Future<List<ServiceInvoiceDetail>> GetServiceInvoiceDetailRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ServiceInvoiceDetail> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_SERVICEINVOICE} E ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ServiceInvoiceDetail_Columns.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServiceInvoiceDetailRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ServiceInvoiceDetail>> GetServiceInvoiceDetailRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ServiceInvoiceDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_SERVICEINVOICE} E ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServiceInvoiceDetailRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ServiceInvoiceDetail?> GetServiceInvoiceDetailRecord(
      DatabaseHandler databaseHandler, String id) async {
    ServiceInvoiceDetail? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_SERVICEINVOICE} E ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServiceInvoiceDetailRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ServiceInvoiceDetail?> GetMasterServiceInvoiceDetailRecord(
      DatabaseHandler databaseHandler, String id) async {
    ServiceInvoiceDetail? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_SERVICEINVOICE} E ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetMasterServiceInvoiceDetailRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddServiceInvoiceDetailRecord(
      DatabaseHandler databaseHandler, ServiceInvoiceDetail dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.serviceInvoiceDetailID != null &&
          dataItem.serviceInvoiceDetailID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID] =
            dataItem.serviceInvoiceDetailID;
      if (dataItem.serviceInvoiceDetailCode != null &&
          dataItem.serviceInvoiceDetailCode != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE] =
            dataItem.serviceInvoiceDetailCode;
      if (dataItem.productPartBarCode != null &&
          dataItem.productPartBarCode != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE] =
            dataItem.productPartBarCode;
      if (dataItem.serviceInvoiceID != null &&
          dataItem.serviceInvoiceID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID] =
            dataItem.serviceInvoiceID;
      if (dataItem.productID != null && dataItem.productID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID] =
            dataItem.productID;
      if (dataItem.quantity != null && dataItem.quantity != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY] =
            dataItem.quantity;
      if (dataItem.rate != null && dataItem.rate != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE] = dataItem.rate;
      if (dataItem.price != null && dataItem.price != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE] = dataItem.price;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED] =
            dataItem.isDeleted;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";
      ;

      id = await db.insert(TablesBase.TABLE_SERVICEINVOICEDETAIL, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddServiceInvoiceDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateServiceInvoiceDetailRecord(
      DatabaseHandler databaseHandler,
      String id1,
      ServiceInvoiceDetail dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.serviceInvoiceDetailID != null &&
          dataItem.serviceInvoiceDetailID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID] =
            dataItem.serviceInvoiceDetailID;
      if (dataItem.serviceInvoiceDetailCode != null &&
          dataItem.serviceInvoiceDetailCode != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE] =
            dataItem.serviceInvoiceDetailCode;
      if (dataItem.productPartBarCode != null &&
          dataItem.productPartBarCode != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE] =
            dataItem.productPartBarCode;
      if (dataItem.serviceInvoiceID != null &&
          dataItem.serviceInvoiceID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID] =
            dataItem.serviceInvoiceID;
      if (dataItem.productID != null && dataItem.productID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID] =
            dataItem.productID;
      if (dataItem.quantity != null && dataItem.quantity != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY] =
            dataItem.quantity;
      if (dataItem.rate != null && dataItem.rate != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE] = dataItem.rate;
      if (dataItem.price != null && dataItem.price != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE] = dataItem.price;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED] =
            dataItem.isDeleted;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

      int id = await db.update(TablesBase.TABLE_SERVICEINVOICEDETAIL, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
//db.close(); // Change to Dart, and remove gt
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateServiceInvoiceDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteServiceInvoiceDetailRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_SERVICEINVOICEDETAIL,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteServiceInvoiceDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0]
                [ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  static Future<String> GetLocalId(
      DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ServiceInvoiceDetail>>
      GetServiceInvoiceDetailUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<ServiceInvoiceDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServiceInvoiceDetailUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ServiceInvoiceDetail?> GetServiceInvoiceDetailRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ServiceInvoiceDetail? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE},D.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_SERVICEINVOICEDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} D ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_SERVICEINVOICE} E ON A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        ServiceInvoiceDetail dataItem = new ServiceInvoiceDetail();
        dataItem.serviceInvoiceDetailID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID];
        dataItem.serviceInvoiceDetailCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE];
        dataItem.productPartBarCode =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE];
        dataItem.serviceInvoiceID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID];
        dataItem.productID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID];
        dataItem.quantity = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY];
        dataItem.rate = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE];
        dataItem.price = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE];
        dataItem.createdOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON];
        dataItem.createdBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY];
        dataItem.modifiedOn =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON];
        dataItem.modifiedBy =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY];
        dataItem.isActive = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID];
        dataItem.appUserID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            ele[ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED];

        dataItem.serviceInvoiceTitle =
            ele[ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE];
        dataItem.productName = ele[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];
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
    } catch (ex) {
      Globals.handleException(
          "ServiceInvoiceDetailDataHandlerBase:GetServiceInvoiceDetailRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
