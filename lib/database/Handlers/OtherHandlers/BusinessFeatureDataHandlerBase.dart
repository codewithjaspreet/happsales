
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/BusinessFeature.dart';
import '../DataBaseHandler.dart';

class BusinessFeatureDataHandlerBase {

     static Future<List<BusinessFeature>> GetBusinessFeatureRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<BusinessFeature> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} LIKE '%${searchString.replaceAll("'","''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_BusinessFeature_Columns.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetBusinessFeatureRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<BusinessFeature>> GetBusinessFeatureRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<BusinessFeature> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} LIKE '${searchString.replaceAll("'","''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetBusinessFeatureRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<BusinessFeature?> GetBusinessFeatureRecord(DatabaseHandler databaseHandler,  String id)async {
        BusinessFeature? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";

          final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetBusinessFeatureRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<BusinessFeature?> GetMasterBusinessFeatureRecord(DatabaseHandler databaseHandler,  String id) async{
        BusinessFeature? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
          final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetMasterBusinessFeatureRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddBusinessFeatureRecord(DatabaseHandler databaseHandler,  BusinessFeature dataItem) async{
        int id = 0;
        try {
             final db =await  databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.businessFeatureCode != null && dataItem.businessFeatureCode != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE] = dataItem.businessFeatureCode;
}
if (dataItem.businessFeatureName != null && dataItem.businessFeatureName != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME] = dataItem.businessFeatureName;
}
if (dataItem.appIcon != null && dataItem.appIcon != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPICON] = dataItem.appIcon;
}
if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON] = dataItem.consoleIcon;
}
if (dataItem.descriptionText != null && dataItem.descriptionText != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT] = dataItem.descriptionText;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED] = dataItem.isDeleted;
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
            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE ] =  "true";
            values[ColumnsBase.KEY_ISDELETED] =  "false";

            id = await  db.insert(TablesBase.TABLE_BUSINESSFEATURE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddBusinessFeatureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateBusinessFeatureRecord(DatabaseHandler databaseHandler,  String id1, BusinessFeature dataItem) async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.businessFeatureCode != null && dataItem.businessFeatureCode != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE] = dataItem.businessFeatureCode;
}
if (dataItem.businessFeatureName != null && dataItem.businessFeatureName != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME] = dataItem.businessFeatureName;
}
if (dataItem.appIcon != null && dataItem.appIcon != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPICON] = dataItem.appIcon;
}
if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON] = dataItem.consoleIcon;
}
if (dataItem.descriptionText != null && dataItem.descriptionText != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT] = dataItem.descriptionText;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED] = dataItem.isDeleted;
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

            id = await  db.update(TablesBase.TABLE_BUSINESSFEATURE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateBusinessFeatureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteBusinessFeatureRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_BUSINESSFEATURE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteBusinessFeatureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            if (list.length > 0) {
                serverId = list[0][ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID} = $id";

            final db = await  databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            if (list.length > 0) {
                localId = list[0][ColumnsBase.KEY_ID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<BusinessFeature>> GetBusinessFeatureUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<BusinessFeature> dataList = [];
        try {
            String selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_BUSINESSFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_BUSINESSFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_BUSINESSFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetBusinessFeatureUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<BusinessFeature?> GetBusinessFeatureRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        BusinessFeature? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_BUSINESSFEATURE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSFEATURE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
          final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessFeature dataItem = new BusinessFeature();

                    dataItem.businessFeatureID = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID];
                    dataItem.businessFeatureCode = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE];
                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                    dataItem.appIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_APPICON];
                    dataItem.consoleIcon = element[ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT];
                    dataItem.descriptionText = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.descriptionHtml = element[ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML];
                    dataItem.internalCode = element[ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSFEATURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED];
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
            Globals.handleException( "BusinessFeatureDataHandlerBase:GetBusinessFeatureRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}