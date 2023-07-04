

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/PerformanceSummary.dart';
import '../DataBaseHandler.dart';

class PerformanceSummaryDataHandlerBase {

     static Future<List<PerformanceSummary>> GetPerformanceSummaryRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<PerformanceSummary> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} F ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE},'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_PerformanceSummary_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME} LIKE '%" + searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_PerformanceSummary_Columns.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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

            //db.close();
        } catch ( ex) {
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetPerformanceSummaryRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<PerformanceSummary>> GetPerformanceSummaryRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<PerformanceSummary> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} F ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE},'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_PerformanceSummary_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME} COLLATE NOCASE ASC ";

             final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetPerformanceSummaryRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<PerformanceSummary?> GetPerformanceSummaryRecord(DatabaseHandler databaseHandler,  String id)async {
        PerformanceSummary ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} F ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetPerformanceSummaryRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<PerformanceSummary?> GetPerformanceSummaryRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        PerformanceSummary? dataItem ;
        try {

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} F ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PERFORMANCESUMMARY_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
 final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetPerformanceSummaryRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<PerformanceSummary?> GetMasterPerformanceSummaryRecord(DatabaseHandler databaseHandler,  String id) async{
        PerformanceSummary ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} F ON A.${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetMasterPerformanceSummaryRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddPerformanceSummaryRecord(DatabaseHandler databaseHandler,  PerformanceSummary dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.performanceSummaryID != null && dataItem.performanceSummaryID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID] = dataItem.performanceSummaryID;
}
if (dataItem.performanceSummaryCode != null && dataItem.performanceSummaryCode != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE] = dataItem.performanceSummaryCode;
}
if (dataItem.performanceSummaryName != null && dataItem.performanceSummaryName != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME] = dataItem.performanceSummaryName;
}
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.performanceType != null && dataItem.performanceType != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE] = dataItem.performanceType;
}
if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID] = dataItem.activityTypeID;
}
if (dataItem.financialYearID != null && dataItem.financialYearID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID] = dataItem.financialYearID;
}
if (dataItem.periodName != null && dataItem.periodName != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME] = dataItem.periodName;
}
if (dataItem.startDate != null && dataItem.startDate != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE] = dataItem.startDate;
}
if (dataItem.endDate != null && dataItem.endDate != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE] = dataItem.endDate;
}
if (dataItem.target != null && dataItem.target != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET] = dataItem.target;
}
if (dataItem.achievement != null && dataItem.achievement != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT] = dataItem.achievement;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED] = dataItem.isDeleted;
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
values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";

 id = await db.insert(TablesBase.TABLE_NOTIFICATION, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddPerformanceSummaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdatePerformanceSummaryRecord(DatabaseHandler databaseHandler,  String id1, PerformanceSummary dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.performanceSummaryID != null && dataItem.performanceSummaryID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID] = dataItem.performanceSummaryID;
}
if (dataItem.performanceSummaryCode != null && dataItem.performanceSummaryCode != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE] = dataItem.performanceSummaryCode;
}
if (dataItem.performanceSummaryName != null && dataItem.performanceSummaryName != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME] = dataItem.performanceSummaryName;
}
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.performanceType != null && dataItem.performanceType != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE] = dataItem.performanceType;
}
if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID] = dataItem.activityTypeID;
}
if (dataItem.financialYearID != null && dataItem.financialYearID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID] = dataItem.financialYearID;
}
if (dataItem.periodName != null && dataItem.periodName != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME] = dataItem.periodName;
}
if (dataItem.startDate != null && dataItem.startDate != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE] = dataItem.startDate;
}
if (dataItem.endDate != null && dataItem.endDate != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE] = dataItem.endDate;
}
if (dataItem.target != null && dataItem.target != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET] = dataItem.target;
}
if (dataItem.achievement != null && dataItem.achievement != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT] = dataItem.achievement;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED] = dataItem.isDeleted;
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
            id =await  db.update(TablesBase.TABLE_PERFORMANCESUMMARY, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdatePerformanceSummaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeletePerformanceSummaryRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_PERFORMANCESUMMARY, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeletePerformanceSummaryRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
            }

            //db.close();
        } catch ( ex) {
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID} = $id";

            final db =await  databaseHandler.database;
            
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<PerformanceSummary>> GetPerformanceSummaryUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<PerformanceSummary> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PERFORMANCESUMMARY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            //selectQuery += " AND " + ColumnsBase.KEY_PERFORMANCESUMMARY_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

            final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
                    PerformanceSummary dataItem = new PerformanceSummary();

                    dataItem.performanceSummaryID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID].toString();
                    dataItem.performanceSummaryCode = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE].toString();
                    dataItem.performanceSummaryName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME].toString();
                    dataItem.businessFeatureID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID].toString();
                    dataItem.performanceType = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE].toString();
                    dataItem.activityTypeID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID].toString();
                    dataItem.financialYearID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID].toString();
                    dataItem.periodName = element[ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME].toString();
                    dataItem.startDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE].toString();
                    dataItem.endDate = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE].toString();
                    dataItem.target = element[ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET].toString();
                    dataItem.achievement  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT].toString();
                    dataItem.createdOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON].toString();
                    dataItem.modifiedOn  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON].toString();
                    dataItem.uid  = element[ColumnsBase.KEY_PERFORMANCESUMMARY_UID].toString();

                    dataItem.appUserID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID].toString();

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID].toString();

                    dataItem.isArchived = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED].toString();

                    dataItem.isActive = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE].toString();
                    dataItem.isDeleted = element[ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED].toString();

                    dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME].toString();

                    dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME].toString();

                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME].toString();

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "PerformanceSummaryDataHandlerBase:GetPerformanceSummaryUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
