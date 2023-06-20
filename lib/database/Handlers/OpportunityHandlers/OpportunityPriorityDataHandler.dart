
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityPriority.dart';
import '../DataBaseHandler.dart';
import 'OpportunityPriorityDataHandlerBase.dart';

class OpportunityPriorityDataHandler extends OpportunityPriorityDataHandlerBase {

     static Future<OpportunityPriority?> GetDefaultOpportunityPriority(DatabaseHandler databaseHandler) async{
        OpportunityPriority? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " A ";
            selectQuery += " WHERE COALESCE(A." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT + ",'false') = 'true' ";
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

         final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
            Globals.handleException( "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}