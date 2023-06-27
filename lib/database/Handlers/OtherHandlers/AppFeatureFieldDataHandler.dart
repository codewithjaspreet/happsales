

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppFeatureField.dart';
import '../DataBaseHandler.dart';
import 'AppFeatureFieldDataHandlerBase.dart';

class AppFeatureFieldDataHandler extends AppFeatureFieldDataHandlerBase {

     static Future<List<AppFeatureField>> GetAppFeatureFieldRecordsByFeatureCode(DatabaseHandler databaseHandler,  String featureCode)async {
        List<AppFeatureField> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND B.${ColumnsBase.KEY_APPFEATURE_INTERNALCODE} = '$featureCode'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME} COLLATE NOCASE ASC ";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  AppFeatureField dataItem = new AppFeatureField();
                                  dataItem.appFeatureFieldID = element[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID];
                                  dataItem.appFeatureFieldCode = element[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDCODE];
                                  dataItem.appFeatureFieldName = element[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME];
                                  dataItem.appFeatureID = element[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID];
                                  dataItem.descriptionText = element[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONTEXT];
                                  dataItem.descriptionHtml = element[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONHTML];
                                  dataItem.appFeatureFieldOrder = element[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDORDER];
                                  dataItem.isHidden = element[ColumnsBase.KEY_APPFEATUREFIELD_ISHIDDEN];
                                  dataItem.isRequired = element[ColumnsBase.KEY_APPFEATUREFIELD_ISREQUIRED];
                                  dataItem.isRequired = element[ColumnsBase.KEY_APPFEATUREFIELD_ISREQUIRED];
                                  dataItem.newLabel = element[ColumnsBase.KEY_APPFEATUREFIELD_NEWLABEL];
                                  dataItem.createdBy  = element[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDBY];
                                  dataItem.createdOn  = element[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDON];
                                  dataItem.modifiedBy  = element[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDBY];
                                  dataItem.modifiedOn  = element[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDON];
                                  dataItem.deviceIdentifier  = element[ColumnsBase.KEY_APPFEATUREFIELD_DEVICEIDENTIFIER];
                                  dataItem.referenceIdentifier  = element[ColumnsBase.KEY_APPFEATUREFIELD_REFERENCEIDENTIFIER];
                                  dataItem.isActive  = element[ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE];
                                  dataItem.uid  = element[ColumnsBase.KEY_APPFEATUREFIELD_UID];
                                  dataItem.appUserID  = element[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERID];
                                  dataItem.appUserGroupID  = element[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID];
                                  dataItem.isArchived  = element[ColumnsBase.KEY_APPFEATUREFIELD_ISARCHIVED];
                                  dataItem.isDeleted  = element[ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED];
                                  dataItem.appFeatureName  = element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
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
            Globals.handleException( "DatabaseHandler:GetAppFeatureFieldRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	/*-------------------HAPPSALES-------------------*/

}