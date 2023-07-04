
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/TravelPurpose.dart';
import '../DataBaseHandler.dart';

class TravelPurposeDataHandlerBase {

     static Future<List<TravelPurpose>> GetTravelPurposeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<TravelPurpose> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_TravelPurpose_Columns.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);


      }
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetTravelPurposeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<TravelPurpose>> GetTravelPurposeRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<TravelPurpose> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME} COLLATE NOCASE ASC ";

           
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);


      }
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetTravelPurposeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<TravelPurpose?> GetTravelPurposeRecord(DatabaseHandler databaseHandler,  String id)async {
        TravelPurpose? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetTravelPurposeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<TravelPurpose?> GetMasterTravelPurposeRecord(DatabaseHandler databaseHandler,  String id) async{
        TravelPurpose ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetMasterTravelPurposeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddTravelPurposeRecord(DatabaseHandler databaseHandler,  TravelPurpose dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
             Map<String, dynamic> values = {};
if (dataItem.travelPurposeID != null && dataItem.travelPurposeID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID] = dataItem.travelPurposeID;
if (dataItem.travelPurposeCode != null && dataItem.travelPurposeCode != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE] = dataItem.travelPurposeCode;
if (dataItem.travelPurposeName != null && dataItem.travelPurposeName != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME] = dataItem.travelPurposeName;
if (dataItem.travelPurposeDescription != null && dataItem.travelPurposeDescription != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION] = dataItem.travelPurposeDescription;
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID] = dataItem.businessFeatureID;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED] = dataItem.isDeleted;
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
           values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = true;
values[ColumnsBase.KEY_ISDELETED] = false;

int id = await db.insert(TablesBase.TABLE_TRAVELPURPOSE, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddTravelPurposeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateTravelPurposeRecord(DatabaseHandler databaseHandler,  String id1, TravelPurpose dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
        Map<String, dynamic> values = {};
if (dataItem.travelPurposeID != null && dataItem.travelPurposeID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID] = dataItem.travelPurposeID;
if (dataItem.travelPurposeCode != null && dataItem.travelPurposeCode != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE] = dataItem.travelPurposeCode;
if (dataItem.travelPurposeName != null && dataItem.travelPurposeName != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME] = dataItem.travelPurposeName;
if (dataItem.travelPurposeDescription != null && dataItem.travelPurposeDescription != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION] = dataItem.travelPurposeDescription;
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID] = dataItem.businessFeatureID;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED] = dataItem.isDeleted;
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

            id = await  db.update(TablesBase.TABLE_TRAVELPURPOSE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateTravelPurposeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteTravelPurposeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_TRAVELPURPOSE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteTravelPurposeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID}";
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0]["${ColumnsBase.KEY_ID}"].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<TravelPurpose>> GetTravelPurposeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<TravelPurpose> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_TRAVELPURPOSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_TRAVELPURPOSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_TRAVELPURPOSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        } catch ( ex) {
            Globals.handleException( "TravelPurposeDataHandlerBase:GetTravelPurposeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<TravelPurpose?> GetTravelPurposeRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        TravelPurpose? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
		selectQuery += " FROM ${TablesBase.TABLE_TRAVELPURPOSE} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_TRAVELPURPOSE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

                
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    TravelPurpose dataItem = new TravelPurpose();

                    dataItem.travelPurposeID = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID];
                    dataItem.travelPurposeCode = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE];
                    dataItem.travelPurposeName = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME];
                    dataItem.travelPurposeDescription = ele[ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION];
                    dataItem.businessFeatureID = ele[ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TRAVELPURPOSE_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED];

                    dataItem.businessFeatureName = ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
                     dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        }
        catch( ex)
        {
	    Globals.handleException( "TravelPurposeDataHandlerBase:GetTravelPurposeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}