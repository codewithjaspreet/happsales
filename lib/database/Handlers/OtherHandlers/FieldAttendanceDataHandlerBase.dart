

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FieldAttendance.dart';
import '../DataBaseHandler.dart';

class FieldAttendanceDataHandlerBase {

     static Future<List<FieldAttendance>> GetFieldAttendanceRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<FieldAttendance> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_FieldAttendance_Columns.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

     final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
              FieldAttendance      dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetFieldAttendanceRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FieldAttendance>> GetFieldAttendanceRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<FieldAttendance> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
              FieldAttendance      dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetFieldAttendanceRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<FieldAttendance?> GetFieldAttendanceRecord(DatabaseHandler databaseHandler,  String id) async{
        FieldAttendance? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetFieldAttendanceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<FieldAttendance?> GetMasterFieldAttendanceRecord(DatabaseHandler databaseHandler,  String id) async{
        FieldAttendance? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetMasterFieldAttendanceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddFieldAttendanceRecord(DatabaseHandler databaseHandler,  FieldAttendance dataItem) async{
        int id = 0;
        try {

           final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.fieldAttendanceID != null && dataItem.fieldAttendanceID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID] = dataItem.fieldAttendanceID;
if (dataItem.fieldAttendanceCode != null && dataItem.fieldAttendanceCode != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE] = dataItem.fieldAttendanceCode;
if (dataItem.fieldAttendanceTitle != null && dataItem.fieldAttendanceTitle != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE] = dataItem.fieldAttendanceTitle;
if (dataItem.fieldAttendanceDate != null && dataItem.fieldAttendanceDate != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE] = dataItem.fieldAttendanceDate;
if (dataItem.punchInTime != null && dataItem.punchInTime != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME] = dataItem.punchInTime;
if (dataItem.punchOutTime != null && dataItem.punchOutTime != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME] = dataItem.punchOutTime;
if (dataItem.punchInLocation != null && dataItem.punchInLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION] = dataItem.punchInLocation;
if (dataItem.userSpecifiedPunchInLocation != null && dataItem.userSpecifiedPunchInLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION] = dataItem.userSpecifiedPunchInLocation;
if (dataItem.punchOutLocation != null && dataItem.punchOutLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION] = dataItem.punchOutLocation;
if (dataItem.userSpecifiedPunchOutLocation != null && dataItem.userSpecifiedPunchOutLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION] = dataItem.userSpecifiedPunchOutLocation;
if (dataItem.remarks != null && dataItem.remarks != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS] = dataItem.remarks;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED] = dataItem.isDeleted;
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


            values[ColumnsBase.KEY_UPSYNCINDEX]  = 0;
            values[ColumnsBase.KEY_ISACTIVE ] =  "true";
            values[ColumnsBase.KEY_ISDELETED ] = "false";

            id = await db.insert(TablesBase.TABLE_FIELDATTENDANCE,  values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddFieldAttendanceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateFieldAttendanceRecord(DatabaseHandler databaseHandler,  String id1, FieldAttendance dataItem)async {
        int id = 0;
        try {

          final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.fieldAttendanceID != null && dataItem.fieldAttendanceID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID] = dataItem.fieldAttendanceID;
if (dataItem.fieldAttendanceCode != null && dataItem.fieldAttendanceCode != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE] = dataItem.fieldAttendanceCode;
if (dataItem.fieldAttendanceTitle != null && dataItem.fieldAttendanceTitle != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE] = dataItem.fieldAttendanceTitle;
if (dataItem.fieldAttendanceDate != null && dataItem.fieldAttendanceDate != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE] = dataItem.fieldAttendanceDate;
if (dataItem.punchInTime != null && dataItem.punchInTime != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME] = dataItem.punchInTime;
if (dataItem.punchOutTime != null && dataItem.punchOutTime != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME] = dataItem.punchOutTime;
if (dataItem.punchInLocation != null && dataItem.punchInLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION] = dataItem.punchInLocation;
if (dataItem.userSpecifiedPunchInLocation != null && dataItem.userSpecifiedPunchInLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION] = dataItem.userSpecifiedPunchInLocation;
if (dataItem.punchOutLocation != null && dataItem.punchOutLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION] = dataItem.punchOutLocation;
if (dataItem.userSpecifiedPunchOutLocation != null && dataItem.userSpecifiedPunchOutLocation != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION] = dataItem.userSpecifiedPunchOutLocation;
if (dataItem.remarks != null && dataItem.remarks != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS] = dataItem.remarks;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED] = dataItem.isDeleted;
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

id = await db.update(TablesBase.TABLE_FIELDATTENDANCE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateFieldAttendanceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteFieldAttendanceRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_FIELDATTENDANCE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteFieldAttendanceRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID}";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

             final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
      }
        } catch ( ex) {
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID} = $id";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
        } catch ( ex) {
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<FieldAttendance>> GetFieldAttendanceUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)  async{
        List<FieldAttendance> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                  FieldAttendance  dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetFieldAttendanceUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<FieldAttendance?> GetFieldAttendanceRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        FieldAttendance?dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FIELDATTENDANCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FIELDATTENDANCE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                  FieldAttendance  dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            Globals.handleException( "FieldAttendanceDataHandlerBase:GetFieldAttendanceRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}