
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppReport.dart';
import '../DataBaseHandler.dart';
import 'AppReportDataHandlerBase.dart';

class AppReportDataHandler extends AppReportDataHandlerBase {

     static Future<List<AppReport>> GetAppReportRecordsByType(DatabaseHandler databaseHandler,  String reportType)async {
        List<AppReport> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPREPORTTYPE} = '$reportType'";
            selectQuery += " ORDER BY CAST(COALESCE(A.${ColumnsBase.KEY_APPREPORT_APPREPORTNAME},100) AS INTEGER) ASC ";

             final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandler:GetAppReportRecordsByType()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppReport?> GetAppReportRecordByAppReportName(DatabaseHandler databaseHandler,  String appReportName) async{
        AppReport? dataItem;
        try {
            //id = Globals.TryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} = '$appReportName'";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetAppReportRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}