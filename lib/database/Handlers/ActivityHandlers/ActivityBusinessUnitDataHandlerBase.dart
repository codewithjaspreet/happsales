
 import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityBusinessUnit.dart';
import '../DataBaseHandler.dart';

class ActivityBusinessUnitDataHandlerBase {

     static Future<List<ActivityBusinessunit>> GetActivityBusinessUnitRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ActivityBusinessunit> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE} LIKE '%${searchString.replaceAll("'","''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityBusinessUnit_Columns.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
  ActivityBusinessunit dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetActivityBusinessUnitRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityBusinessunit>> GetActivityBusinessUnitRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<ActivityBusinessunit> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += "${" AND A." + ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE + " LIKE '" + searchString.replaceAll("'","''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE} COLLATE NOCASE ASC ";

          
            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
  ActivityBusinessunit dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetActivityBusinessUnitRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityBusinessunit?> GetActivityBusinessUnitRecord(DatabaseHandler databaseHandler,  String id) async {
        ActivityBusinessunit? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
  ActivityBusinessunit dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetActivityBusinessUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityBusinessunit?> GetActivityBusinessUnitRecordByUid(DatabaseHandler databaseHandler,  String uid) async {
        ActivityBusinessunit? dataItem;
        try {

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
  ActivityBusinessunit dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetActivityBusinessUnitRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityBusinessunit?> GetMasterActivityBusinessUnitRecord(DatabaseHandler databaseHandler,  String id) async{
        ActivityBusinessunit? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

             final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
   dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetMasterActivityBusinessUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityBusinessUnitRecord(DatabaseHandler databaseHandler,  ActivityBusinessunit dataItem) async{
        int id = 0;
        try {
          final db  = await databaseHandler.database;
          Map<String,dynamic> values = new Map();
           if (dataItem.activityBusinessUnitID != null && dataItem.activityBusinessUnitID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID] = dataItem.activityBusinessUnitID;
}
if (dataItem.activityBusinessUnitCode != null && dataItem.activityBusinessUnitCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE] = dataItem.activityBusinessUnitCode;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.businessUnitID != null && dataItem.businessUnitID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID] = dataItem.businessUnitID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED] = dataItem.isArchived;
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


            id = await db.insert(TablesBase.TABLE_ACTIVITYBUSINESSUNIT, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityBusinessUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityBusinessUnitRecord(DatabaseHandler databaseHandler,  String id1, ActivityBusinessunit dataItem)  async{
        int id = 0;
        try {
            final db  = await databaseHandler.database;
          Map<String,dynamic> values = new Map();
           if (dataItem.activityBusinessUnitID != null && dataItem.activityBusinessUnitID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID] = dataItem.activityBusinessUnitID;
}
if (dataItem.activityBusinessUnitCode != null && dataItem.activityBusinessUnitCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE] = dataItem.activityBusinessUnitCode;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.businessUnitID != null && dataItem.businessUnitID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID] = dataItem.businessUnitID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED] = dataItem.isArchived;
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
            id = await db.update(TablesBase.TABLE_ACTIVITYBUSINESSUNIT, values,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityBusinessUnitRecord()", ex);
            throw ex;
        }
        return id;
    }
static Future<int> deleteActivityBusinessUnitRecord(DatabaseHandler databaseHandler, String id1) async {
  int id = 0;
  try {
            final db  = await databaseHandler.database;
    id = await db.delete(TablesBase.TABLE_ACTIVITYBUSINESSUNIT, where : "${ColumnsBase.KEY_ID} = $id1");
    // db.close();
  } catch (ex) {
    Globals.handleException( "DatabaseHandler:DeleteActivityBusinessUnitRecord()", ex);
    rethrow;
  }
  return id;
}

static Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db  = await databaseHandler.database;
    var result = await db.rawQuery(selectQuery);
    if (result.isNotEmpty) {
      serverId = result.first[0].toString();
    }
    // db.close();
  } catch (ex) {
    Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetServerId()", ex);
    rethrow;
  }
  return serverId;
}

static Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} A ";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID} = $id";

            final db  = await databaseHandler.database;
    var result = await db.rawQuery(selectQuery);
    if (result.isNotEmpty) {
      localId = result.first[0].toString();
    }
    // db.close();
  } catch (ex) {
    Globals.handleException( "ActivityBusinessUnitDataHandlerBase:GetLocalId()", ex);
    rethrow;
  }
  return localId;
}


     static Future<List<ActivityBusinessunit>> GetActivityBusinessUnitUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ActivityBusinessunit> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

            final db =  await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

           for (var element in list) {
   ActivityBusinessunit dataItem = ActivityBusinessunit();
  dataItem.activityBusinessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID];

  dataItem.activityBusinessUnitCode = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE];
  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID];
  dataItem.businessUnitID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID];
  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON];
  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER];
  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED];
  dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED];

  dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
  dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
            Globals.handleException("ActivityBusinessUnitDataHandlerBase:GetActivityBusinessUnitUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
