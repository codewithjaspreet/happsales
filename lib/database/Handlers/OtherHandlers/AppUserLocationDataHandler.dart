
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserLocation.dart';
import '../DataBaseHandler.dart';
import 'AppUserLocationDataHandlerBase.dart';

class AppUserLocationDataHandler extends AppUserLocationDataHandlerBase {

     static Future<AppUserLocation?> GetUserLocationRecordByDate(DatabaseHandler databaseHandler,  String dateString) async{
        AppUserLocation? dataItem;
        try
        {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERLOCATION} WHERE  date(${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE}) = '$dateString'";
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AppUserLocation dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
        }
        catch( ex)
        {
            Globals.handleException( "AppUserLocationDataHandler:GetUserLocationRecordByDate()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<void> UpdateUserLocationData(DatabaseHandler databaseHandler,  String id, String userlocation, String userlocationaddress, String modifiedby, String modifiedon)async {
        try {

            String sqlUpdate = " UPDATE ${TablesBase.TABLE_APPUSERLOCATION} SET ";
            sqlUpdate = "$sqlUpdate${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES}  =  ${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES} ||  ',$userlocation'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS}  =  ${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS} ||  ',$userlocationaddress'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES}  = '${userlocation.replaceAll("'", "''")}'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS}  =  '${userlocationaddress.replaceAll("'", "''")}'";
            sqlUpdate = "${"$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME}  =  '" + Globals.getDateTimeNowDBFormat()}'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY}  =  '$modifiedby'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON}  =  '$modifiedon'";
            sqlUpdate = "$sqlUpdate,${ColumnsBase.KEY_ISDIRTY} = 'true' ";
            sqlUpdate = "$sqlUpdate WHERE ${ColumnsBase.KEY_ID}  =  $id";

            final db = await databaseHandler.database;

            db.execute(sqlUpdate);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AppUserLocationDataHandler:UpdateUserLocationData()", ex);
            throw ex;
        }
    }

	/*-------------------HAPPSALES-------------------*/

}