
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppFeatureField.dart';
import '../DataBaseHandler.dart';

class AppFeatureFieldDataHandlerBase {

     static Future<List<AppFeatureField>> GetAppFeatureFieldRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppFeatureField> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppFeatureField_Columns.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


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
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetAppFeatureFieldRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppFeatureField>> GetAppFeatureFieldRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AppFeatureField> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME} LIKE '$searchString%'";
            }
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
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetAppFeatureFieldRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppFeatureField?> GetAppFeatureFieldRecord(DatabaseHandler databaseHandler,  String id) async{
        AppFeatureField? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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


                                  

            }
        } catch ( ex) {
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetAppFeatureFieldRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppFeatureField?> GetMasterAppFeatureFieldRecord(DatabaseHandler databaseHandler,  String id) async{
        AppFeatureField? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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


                                  

            }
        } catch ( ex) {
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetMasterAppFeatureFieldRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppFeatureFieldRecord(DatabaseHandler databaseHandler,  AppFeatureField dataItem)async {
        int id = 0;
        try {

          final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.appFeatureFieldID != null && dataItem.appFeatureFieldID != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID] = dataItem.appFeatureFieldID;
if (dataItem.appFeatureFieldCode != null && dataItem.appFeatureFieldCode != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDCODE] = dataItem.appFeatureFieldCode;
if (dataItem.appFeatureFieldName != null && dataItem.appFeatureFieldName != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME] = dataItem.appFeatureFieldName;
if (dataItem.appFeatureID != null && dataItem.appFeatureID != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID] = dataItem.appFeatureID;
if (dataItem.descriptionText != null && dataItem.descriptionText != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONTEXT] = dataItem.descriptionText;
if (dataItem.descriptionHtml != null && dataItem.descriptionHtml != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONHTML] = dataItem.descriptionHtml;
if (dataItem.appFeatureFieldOrder != null && dataItem.appFeatureFieldOrder != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDORDER] = dataItem.appFeatureFieldOrder;
if (dataItem.isHidden != null && dataItem.isHidden != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISHIDDEN] = dataItem.isHidden;
if (dataItem.isRequired != null && dataItem.isRequired != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISREQUIRED] = dataItem.isRequired;
if (dataItem.newLabel != null && dataItem.newLabel != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_NEWLABEL] = dataItem.newLabel;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED] = dataItem.isDeleted;
if (dataItem.id != null && dataItem.id != "null")
  values[ColumnsBase.KEY_ID] = dataItem.id;
if (dataItem.isDirty != null && dataItem.isDirty != "null")
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE] = "true";
            values[ColumnsBase.KEY_ISDELETED]  = "false";

            id = await db.insert(TablesBase.TABLE_APPFEATUREFIELD, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppFeatureFieldRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppFeatureFieldRecord(DatabaseHandler databaseHandler,  String id1, AppFeatureField dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;  
          Map<String, dynamic> values = {};

if (dataItem.appFeatureFieldID != null && dataItem.appFeatureFieldID != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID] = dataItem.appFeatureFieldID;
}
if (dataItem.appFeatureFieldCode != null && dataItem.appFeatureFieldCode != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDCODE] = dataItem.appFeatureFieldCode;
}
if (dataItem.appFeatureFieldName != null && dataItem.appFeatureFieldName != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDNAME] = dataItem.appFeatureFieldName;
}
if (dataItem.appFeatureID != null && dataItem.appFeatureID != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID] = dataItem.appFeatureID;
}
if (dataItem.descriptionText != null && dataItem.descriptionText != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONTEXT] = dataItem.descriptionText;
}
if (dataItem.descriptionHtml != null && dataItem.descriptionHtml != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_DESCRIPTIONHTML] = dataItem.descriptionHtml;
}
if (dataItem.appFeatureFieldOrder != null && dataItem.appFeatureFieldOrder != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDORDER] = dataItem.appFeatureFieldOrder;
}
if (dataItem.isHidden != null && dataItem.isHidden != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISHIDDEN] = dataItem.isHidden;
}
if (dataItem.isRequired != null && dataItem.isRequired != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISREQUIRED] = dataItem.isRequired;
}
if (dataItem.newLabel != null && dataItem.newLabel != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_NEWLABEL] = dataItem.newLabel;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPFEATUREFIELD_ISDELETED] = dataItem.isDeleted;
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
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
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
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}


            id = await db.update(TablesBase.TABLE_APPFEATUREFIELD, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs :null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppFeatureFieldRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppFeatureFieldRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPFEATUREFIELD, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppFeatureFieldRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID];
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREFIELDID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
           ;
        } catch ( ex) {
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppFeatureField>> GetAppFeatureFieldUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async {
        List<AppFeatureField> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPFEATUREFIELD} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPFEATUREFIELD} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPFEATUREFIELD} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
            Globals.handleException( "AppFeatureFieldDataHandlerBase:GetAppFeatureFieldUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppFeatureField?> GetAppFeatureFieldRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        AppFeatureField? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",B." + ColumnsBase.KEY_APPFEATURE_APPFEATURENAME;
		selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREFIELD} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPFEATURE} B ON A.${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATUREID} = B.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPFEATUREFIELD_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_APPFEATUREFIELD_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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


                                  

            }
        }
        catch( ex)
        {
	    Globals.handleException( "AppFeatureFieldDataHandlerBase:GetAppFeatureFieldRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}