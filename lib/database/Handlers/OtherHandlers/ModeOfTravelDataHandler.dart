

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ModeOfTravel.dart';
import '../DataBaseHandler.dart';
import 'ModeOfTravelDataHandlerBase.dart';

 class ModeOfTravelDataHandler extends ModeOfTravelDataHandlerBase {

     static Future<ModeOfTravel?> GetModeOfTravelByName(DatabaseHandler databaseHandler, String modeOfTravelName) async{
        ModeOfTravel ?dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_MODEOFTRAVEL} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME} = '$modeOfTravelName'";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_MODEOFTRAVEL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            
            final db = await databaseHandler.database;

             List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    ModeOfTravel dataItem = new ModeOfTravel();
                    dataItem.modeOfTravelID = element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELID];
                    dataItem.modeOfTravelCode = element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELCODE];
                    dataItem.modeOfTravelName = element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];
                    dataItem.ratePerKilometer = element[ColumnsBase.KEY_MODEOFTRAVEL_RATEPERKILOMETER];
                    dataItem.createdOn = element[ColumnsBase.KEY_MODEOFTRAVEL_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_MODEOFTRAVEL_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_MODEOFTRAVEL_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_MODEOFTRAVEL_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_MODEOFTRAVEL_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_MODEOFTRAVEL_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_MODEOFTRAVEL_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_MODEOFTRAVEL_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_MODEOFTRAVEL_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_MODEOFTRAVEL_ISDELETED];


                            
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
            Globals.handleException( "ModeOfTravelDataHandlerBase:GetModeOfTravelRecord()", ex);
            throw ex;
        }
        return dataItem;
    }


    /*-------------------HAPPSALES-------------------*/

}