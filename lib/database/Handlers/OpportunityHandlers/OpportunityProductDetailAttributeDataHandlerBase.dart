import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityProductDetailAttribute.dart';
import '../DataBaseHandler.dart';

class OpportunityProductDetailAttributeDataHandlerBase {
  static Future<List<OpportunityProductDetailAttribute>>
      GetOpportunityProductDetailAttributeRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<OpportunityProductDetailAttribute> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME},E.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTEVALUE} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} F ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityProductDetailAttribute_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityProductDetailAttribute_ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetOpportunityProductDetailAttributeRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProductDetailAttribute>>
      GetOpportunityProductDetailAttributeRecords(
          DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityProductDetailAttribute> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME},E.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTEVALUE} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} F ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityProductDetailAttribute_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetOpportunityProductDetailAttributeRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityProductDetailAttribute?>
      GetOpportunityProductDetailAttributeRecord(
          DatabaseHandler databaseHandler, String id) async {
    OpportunityProductDetailAttribute? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME},E.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTEVALUE} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} F ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetOpportunityProductDetailAttributeRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityProductDetailAttribute?>
      GetOpportunityProductDetailAttributeRecordByUid(
          DatabaseHandler databaseHandler, String uid) async {
    OpportunityProductDetailAttribute? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME},E.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTEVALUE} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} F ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetOpportunityProductDetailAttributeRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityProductDetailAttribute?>
      GetMasterOpportunityProductDetailAttributeRecord(
          DatabaseHandler databaseHandler, String id) async {
    OpportunityProductDetailAttribute? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME},E.${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTEVALUE} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} F ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetMasterOpportunityProductDetailAttributeRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityProductDetailAttributeRecord(
      DatabaseHandler databaseHandler,
      OpportunityProductDetailAttribute dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.opportunityProductDetailAttributeID != null &&
          dataItem.opportunityProductDetailAttributeID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID] =
            dataItem.opportunityProductDetailAttributeID;
      }
      if (dataItem.opportunityProductDetailAttributeCode != null &&
          dataItem.opportunityProductDetailAttributeCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE] =
            dataItem.opportunityProductDetailAttributeCode;
      }
      if (dataItem.opportunityProductDetailID != null &&
          dataItem.opportunityProductDetailID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID] =
            dataItem.opportunityProductDetailID;
      }
      if (dataItem.attributeID != null && dataItem.attributeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID] =
            dataItem.attributeID;
      }
      if (dataItem.attributeValueID != null &&
          dataItem.attributeValueID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID] =
            dataItem.attributeValueID;
      }
      if (dataItem.attributeValue != null &&
          dataItem.attributeValue != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE] =
            dataItem.attributeValue;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID] =
            dataItem.uid;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED] =
            dataItem.isDeleted;
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
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
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
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(
          TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityProductDetailAttributeRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityProductDetailAttributeRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityProductDetailAttribute dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.opportunityProductDetailAttributeID != null &&
          dataItem.opportunityProductDetailAttributeID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID] =
            dataItem.opportunityProductDetailAttributeID;
      }
      if (dataItem.opportunityProductDetailAttributeCode != null &&
          dataItem.opportunityProductDetailAttributeCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE] =
            dataItem.opportunityProductDetailAttributeCode;
      }
      if (dataItem.opportunityProductDetailID != null &&
          dataItem.opportunityProductDetailID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID] =
            dataItem.opportunityProductDetailID;
      }
      if (dataItem.attributeID != null && dataItem.attributeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID] =
            dataItem.attributeID;
      }
      if (dataItem.attributeValueID != null &&
          dataItem.attributeValueID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID] =
            dataItem.attributeValueID;
      }
      if (dataItem.attributeValue != null &&
          dataItem.attributeValue != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE] =
            dataItem.attributeValue;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID] =
            dataItem.uid;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED] =
            dataItem.isDeleted;
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
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
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
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(
          TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityProductDetailAttributeRecord()",
          ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityProductDetailAttributeRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityProductDetailAttributeRecord()",
          ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID}";
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetServerId()", ex);
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
      selectQuery +=
          " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityProductDetailAttribute>>
      GetOpportunityProductDetailAttributeUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityProductDetailAttribute> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      //selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProductDetailAttribute dataItem =
            new OpportunityProductDetailAttribute();
        dataItem.opportunityProductDetailAttributeID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID];
        dataItem.opportunityProductDetailAttributeCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE];
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID];
        dataItem.attributeID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID];
        dataItem.attributeValueID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID];
        dataItem.attributeValue = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE];
        dataItem.createdBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY];
        dataItem.createdOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON];
        dataItem.modifiedBy = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY];
        dataItem.modifiedOn = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE];
        dataItem.uid =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID];
        dataItem.referenceIdentifier = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID];
        dataItem.appUserGroupID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID];
        dataItem.isArchived = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED];
        dataItem.isDeleted = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];
        dataItem.attributeValueName =
            element[ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailAttributeDataHandlerBase:GetOpportunityProductDetailAttributeUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
