

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityTeam.dart';
import '../DataBaseHandler.dart';
import 'OpportunityTeamDataHandlerBase.dart';

class OpportunityTeamDataHandler extends OpportunityTeamDataHandlerBase {

     static Future<List<OpportunityTeam>> GetOpportunityTeamRecordsByOpportunityId(DatabaseHandler databaseHandler,  String opportunityId) async {
        List<OpportunityTeam> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYTEAM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} = $opportunityId";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME} COLLATE NOCASE ASC ";

            
   final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityTeam dataItem = new OpportunityTeam();
                    dataItem.opportunityTeamID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID];
                    dataItem.opportunityTeamCode = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE];
                    dataItem.opportunityTeamAppUserID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID];
                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION];
                    dataItem.appUserName = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME];
                    dataItem.designation = element[ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];

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

            };
        } catch ( ex) {
            Globals.handleException( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordsByOpportunityId()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<OpportunityTeam>> GetOpportunityTeamRecordsAllByOpportunityId(DatabaseHandler databaseHandler,  String opportunityId) async {
        List<OpportunityTeam> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYTEAM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} = $opportunityId";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME} COLLATE NOCASE ASC ";
   
   final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityTeam dataItem = new OpportunityTeam();
                    dataItem.opportunityTeamID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID];
                    dataItem.opportunityTeamCode = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE];
                    dataItem.opportunityTeamAppUserID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID];
                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION];
                    dataItem.appUserName = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME];
                    dataItem.designation = element[ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];

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
            Globals.handleException( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordsByOpportunityId()", ex);
            throw ex;
        }
        return dataList;
    }

    /*-------------------HAPPSALES-------------------*/

}