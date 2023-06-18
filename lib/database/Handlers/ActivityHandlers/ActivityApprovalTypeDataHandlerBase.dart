

 import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityApprovalType.dart';
import '../DataBaseHandler.dart';

class ActivityApprovalTypeDataHandlerBase {

     static Future<List<ActivityApprovalType>> GetActivityApprovalTypeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ActivityApprovalType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE},'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityApprovalType_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityApprovalType_Columns.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetActivityApprovalTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityApprovalType>> GetActivityApprovalTypeRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<ActivityApprovalType> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE},'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityApprovalType_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetActivityApprovalTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityApprovalType?> GetActivityApprovalTypeRecord(DatabaseHandler databaseHandler,  String id) async {
        ActivityApprovalType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityApprovalType?>GetActivityApprovalTypeRecordByUid(DatabaseHandler databaseHandler,  String uid) async {
        ActivityApprovalType? dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetActivityApprovalTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityApprovalType?> GetMasterActivityApprovalTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        ActivityApprovalType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetMasterActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityApprovalTypeRecord(DatabaseHandler databaseHandler,  ActivityApprovalType dataItem) async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
          Map<String, dynamic> values = new Map();
           if (dataItem.activityApprovalTypeID != null && dataItem.activityApprovalTypeID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID] = dataItem.activityApprovalTypeID;
}
if (dataItem.activityApprovalTypeCode != null && dataItem.activityApprovalTypeCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE] = dataItem.activityApprovalTypeCode;
}
if (dataItem.activityApprovalTypeName != null && dataItem.activityApprovalTypeName != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME] = dataItem.activityApprovalTypeName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION] = dataItem.description;
}
if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID] = dataItem.activityTypeID;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_ACTIVITYAPPROVALTYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityApprovalTypeRecord(DatabaseHandler databaseHandler,  String id1, ActivityApprovalType dataItem) async {
        int id = 0;
        try {
            
          final db = await databaseHandler.database;
          Map<String, dynamic> values = new Map();
           if (dataItem.activityApprovalTypeID != null && dataItem.activityApprovalTypeID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID] = dataItem.activityApprovalTypeID;
}
if (dataItem.activityApprovalTypeCode != null && dataItem.activityApprovalTypeCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE] = dataItem.activityApprovalTypeCode;
}
if (dataItem.activityApprovalTypeName != null && dataItem.activityApprovalTypeName != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME] = dataItem.activityApprovalTypeName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION] = dataItem.description;
}
if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID] = dataItem.activityTypeID;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_ACTIVITYAPPROVALTYPE, values, where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteActivityApprovalTypeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
           final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACTIVITYAPPROVALTYPE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID].toString();
            }


            //db.close();
        } catch ( ex) {
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID} = $id";

             final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID].toString();
            }

        } catch ( ex) {
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ActivityApprovalType>> GetActivityApprovalTypeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<ActivityApprovalType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            //selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";
 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    ActivityApprovalType dataItem = new ActivityApprovalType();

dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID];
dataItem.activityApprovalTypeCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.description = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION];
dataItem.activityTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID];
dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE];
dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON];
dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY];
dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED];

dataItem.activityTypeName = element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];

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
            Globals.handleException( "ActivityApprovalTypeDataHandlerBase:GetMasterActivityApprovalTypeRecord()", ex);
            throw ex;
        }
        return dataList;
    }

    



}
