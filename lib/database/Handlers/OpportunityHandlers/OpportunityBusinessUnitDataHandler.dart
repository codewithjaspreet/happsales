import 'dart:core';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityBusinessUnit.dart';
import '../DataBaseHandler.dart';
import 'OpportunityBusinessUnitDataHandlerBase.dart';

class OpportunityBusinessUnitDataHandler
    extends OpportunityBusinessUnitDataHandlerBase {
  static Future<List<OpportunityBusinessUnit>>
      GetOpportunityBusinessUnitRecordsAllByOpportunityId(
          DatabaseHandler databaseHandler, String opportunityId) async {
    List<OpportunityBusinessUnit> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = $opportunityId";
      selectQuery +=
          " ORDER BY D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
    } catch (ex) {
      Globals.handleException(
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
