import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityContact.dart';
import '../DataBaseHandler.dart';
import 'OpportunityContactDataHandlerBase.dart';

class OpportunityContactDataHandler extends OpportunityContactDataHandlerBase {
  static Future<List<OpportunityContact>>
      GetOpportunityContactRecordsByOpportunityId(
          DatabaseHandler databaseHandler, String opportunityId) async {
    List<OpportunityContact> dataList = [];
    try {
      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME +
          ",C." +
          ColumnsBase.KEY_CONTACT_FIRSTNAME;
      selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYCONTACT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_OPPORTUNITY +
          " E ON A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_CONTACT +
          " C ON A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID +
          " = C." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISDELETED +
          ",'false')) = 'false' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED +
          ",'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISACTIVE +
          ",'true')) = 'true' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE +
          ",'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED +
          ",'false')) = 'false' ";
      selectQuery += " AND A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID +
          " = " +
          opportunityId;
      selectQuery += " ORDER BY A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE +
          " COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityContact>>
      GetOpportunityContactRecordsAllByOpportunityId(
          DatabaseHandler databaseHandler, String opportunityId) async {
    List<OpportunityContact> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",E." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYCONTACT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_OPPORTUNITY +
          " E ON A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID +
          " = " +
          opportunityId;
      selectQuery += " ORDER BY A." +
          ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE +
          " COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
