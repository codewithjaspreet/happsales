
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityType.dart';
import '../DataBaseHandler.dart';
import 'OpportunityTypeDataHandlerBase.dart';

class OpportunityTypeDataHandler extends OpportunityTypeDataHandlerBase {

     static Future<OpportunityType?> GetDefaultOpportunityType(DatabaseHandler databaseHandler) async {
        OpportunityType? dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTYPE + " A ";
            selectQuery += " WHERE COALESCE(A." + ColumnsBase.KEY_OPPORTUNITYTYPE_ISDEFAULT + ",'false') = 'true' ";
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
   final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityType dataItem = new OpportunityType();
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID];
                    dataItem.opportunityTypeCode = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE];
                    dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYTYPE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYTYPE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYTYPE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYTYPE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYTYPE_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYTYPE_ISARCHIVED];

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
            Globals.handleException( "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }
	/*-------------------HAPPSALES-------------------*/

}