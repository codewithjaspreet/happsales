

 import '../../AppConstants.dart';
import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityApproval.dart';
import '../DataBaseHandler.dart';

class ActivityApprovalDataHandlerBase {

     static Future<List<ActivityApproval>> GetActivityApprovalRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ActivityApproval> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",F." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " AS " + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVALTYPE + " B ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVAL + " F ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE + ",'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityApproval_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " LIKE '%" + searchString.replaceAll("'", "''") + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityApproval_Columns.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                  ActivityApproval dataItem = new ActivityApproval();

                  dataItem.activityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
                  dataItem.activityApprovalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE];
                  dataItem.activityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE];
                  dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID];
                  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID];
                  dataItem.requestDate = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE];
                  dataItem.requestDetail = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL];
                  dataItem.isSubmitted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED];
                  dataItem.parentActivityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID];
                  dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
                  dataItem.approvalStatus = element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
                  dataItem.approvalByAppUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID];
                  dataItem.approvalTime = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME];
                  dataItem.approverRemarks = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS];
                  dataItem.isApprovalCompleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED];
                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON];
                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY];
                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON];
                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY];
                  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER];
                  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER];
                  dataItem.location = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION];

                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
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
            Globals.handleException("ActivityApprovalDataHandlerBase:GetActivityApprovalRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityApproval>> GetActivityApprovalRecords(DatabaseHandler databaseHandler, String searchString) async{
        List<ActivityApproval> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",F." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " AS " + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVALTYPE + " B ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVAL + " F ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE + ",'true')) = 'true' ";
            //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityApproval_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " LIKE '" + searchString.replaceAll("'", "''") + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " COLLATE NOCASE ASC ";

         final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                  ActivityApproval dataItem = new ActivityApproval();

                  dataItem.activityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
                  dataItem.activityApprovalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE];
                  dataItem.activityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE];
                  dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID];
                  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID];
                  dataItem.requestDate = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE];
                  dataItem.requestDetail = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL];
                  dataItem.isSubmitted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED];
                  dataItem.parentActivityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID];
                  dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
                  dataItem.approvalStatus = element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
                  dataItem.approvalByAppUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID];
                  dataItem.approvalTime = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME];
                  dataItem.approverRemarks = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS];
                  dataItem.isApprovalCompleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED];
                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON];
                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY];
                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON];
                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY];
                  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER];
                  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER];
                  dataItem.location = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION];

                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
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
            Globals.handleException( "ActivityApprovalDataHandlerBase:GetActivityApprovalRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityApproval?> GetActivityApprovalRecord(DatabaseHandler databaseHandler, String id) async{
        ActivityApproval? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",F." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " AS " + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVALTYPE + " B ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVAL + " F ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                  ActivityApproval dataItem = new ActivityApproval();

                  dataItem.activityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
                  dataItem.activityApprovalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE];
                  dataItem.activityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE];
                  dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID];
                  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID];
                  dataItem.requestDate = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE];
                  dataItem.requestDetail = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL];
                  dataItem.isSubmitted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED];
                  dataItem.parentActivityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID];
                  dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
                  dataItem.approvalStatus = element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
                  dataItem.approvalByAppUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID];
                  dataItem.approvalTime = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME];
                  dataItem.approverRemarks = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS];
                  dataItem.isApprovalCompleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED];
                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON];
                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY];
                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON];
                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY];
                  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER];
                  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER];
                  dataItem.location = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION];

                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
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
            Globals.handleException( "ActivityApprovalDataHandlerBase:GetActivityApprovalRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityApproval?> GetActivityApprovalRecordByUid(DatabaseHandler databaseHandler, String uid) async{
        ActivityApproval? dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",F." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE + " AS " + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVALTYPE + " B ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYAPPROVAL + " F ON A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                  ActivityApproval dataItem = new ActivityApproval();

                  dataItem.activityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
                  dataItem.activityApprovalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE];
                  dataItem.activityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE];
                  dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID];
                  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID];
                  dataItem.requestDate = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE];
                  dataItem.requestDetail = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL];
                  dataItem.isSubmitted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED];
                  dataItem.parentActivityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID];
                  dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
                  dataItem.approvalStatus = element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
                  dataItem.approvalByAppUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID];
                  dataItem.approvalTime = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME];
                  dataItem.approverRemarks = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS];
                  dataItem.isApprovalCompleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED];
                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON];
                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY];
                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON];
                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY];
                  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER];
                  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER];
                  dataItem.location = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION];

                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
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
            Globals.handleException( "ActivityApprovalDataHandlerBase:GetMasterActivityApprovalRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityApprovalRecord(DatabaseHandler databaseHandler, ActivityApproval dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
        Map<String, dynamic> values = new Map();


            if (dataItem.activityApprovalID != null && dataItem.activityApprovalID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID] =  dataItem.activityApprovalID;
            }

            if (dataItem.activityApprovalCode != null && dataItem.activityApprovalCode != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE] =  dataItem.activityApprovalCode;
            }

            if (dataItem.activityApprovalTitle != null && dataItem.activityApprovalTitle != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE] =  dataItem.activityApprovalTitle;
            }

            if (dataItem.activityApprovalTypeID != null && dataItem.activityApprovalTypeID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID] =  dataItem.activityApprovalTypeID;
            }

            if (dataItem.activityID != null && dataItem.activityID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID] =  dataItem.activityID;
            }

            if (dataItem.requestDate != null && dataItem.requestDate != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE] =  dataItem.requestDate;
            }

            if (dataItem.requestDetail != null && dataItem.requestDetail != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL] =  dataItem.requestDetail;
            }

            
           
if (dataItem.isSubmitted != null && dataItem.isSubmitted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED] = dataItem.isSubmitted;
}
if (dataItem.parentActivityApprovalID != null && dataItem.parentActivityApprovalID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID] = dataItem.parentActivityApprovalID;
}
if (dataItem.parentActivityApprovalTitle != null && dataItem.parentActivityApprovalTitle != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE] = dataItem.parentActivityApprovalTitle;
}
if (dataItem.approvalStatus != null && dataItem.approvalStatus != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALSTATUS] = dataItem.approvalStatus;
}
if (dataItem.approvalByAppUserID != null && dataItem.approvalByAppUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID] = dataItem.approvalByAppUserID;
}
if (dataItem.approvalTime != null && dataItem.approvalTime != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME] = dataItem.approvalTime;
}
if (dataItem.approverRemarks != null && dataItem.approverRemarks != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS] = dataItem.approverRemarks;
}
if (dataItem.isApprovalCompleted != null && dataItem.isApprovalCompleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED] = dataItem.isApprovalCompleted;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.location != null && dataItem.location != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION] = dataItem.location;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED] = dataItem.isDeleted;
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
            



          
          

            id = await  db.insert(TablesBase.TABLE_ACTIVITYAPPROVAL, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityApprovalRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityApprovalRecord(DatabaseHandler databaseHandler, String id1, ActivityApproval dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
        Map<String, dynamic> values = new Map();


            if (dataItem.activityApprovalID != null && dataItem.activityApprovalID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID] =  dataItem.activityApprovalID;
            }

            if (dataItem.activityApprovalCode != null && dataItem.activityApprovalCode != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE] =  dataItem.activityApprovalCode;
            }

            if (dataItem.activityApprovalTitle != null && dataItem.activityApprovalTitle != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE] =  dataItem.activityApprovalTitle;
            }

            if (dataItem.activityApprovalTypeID != null && dataItem.activityApprovalTypeID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID] =  dataItem.activityApprovalTypeID;
            }

            if (dataItem.activityID != null && dataItem.activityID != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID] =  dataItem.activityID;
            }

            if (dataItem.requestDate != null && dataItem.requestDate != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE] =  dataItem.requestDate;
            }

            if (dataItem.requestDetail != null && dataItem.requestDetail != ("null")) {
              values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL] =  dataItem.requestDetail;
            }

            
           
if (dataItem.isSubmitted != null && dataItem.isSubmitted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED] = dataItem.isSubmitted;
}
if (dataItem.parentActivityApprovalID != null && dataItem.parentActivityApprovalID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID] = dataItem.parentActivityApprovalID;
}
if (dataItem.parentActivityApprovalTitle != null && dataItem.parentActivityApprovalTitle != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE] = dataItem.parentActivityApprovalTitle;
}
if (dataItem.approvalStatus != null && dataItem.approvalStatus != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALSTATUS] = dataItem.approvalStatus;
}
if (dataItem.approvalByAppUserID != null && dataItem.approvalByAppUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID] = dataItem.approvalByAppUserID;
}
if (dataItem.approvalTime != null && dataItem.approvalTime != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME] = dataItem.approvalTime;
}
if (dataItem.approverRemarks != null && dataItem.approverRemarks != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS] = dataItem.approverRemarks;
}
if (dataItem.isApprovalCompleted != null && dataItem.isApprovalCompleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED] = dataItem.isApprovalCompleted;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.location != null && dataItem.location != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION] = dataItem.location;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_ACTIVITYAPPROVAL, values, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityApprovalRecord()", ex);
            throw ex;
        }
        return id;
    }


static Future<int> deleteActivityApprovalRecord(DatabaseHandler databaseHandler, String id1) async {
  int id = 0;
  try {
    final db= await databaseHandler.database;
    id = await db.delete(TablesBase.TABLE_ACTIVITYAPPROVAL, where : "${ColumnsBase.KEY_ID} = $id1");
    //db.close();
  } catch (ex) {
    Globals.handleException( "DatabaseHandler:DeleteActivityApprovalRecord()", ex);
    rethrow;
  }
  return id;
}

static Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
  String serverId = "-1";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVAL} A";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

    final db= await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      serverId = result[0][ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
    }
    //db.close();
  } catch (ex) {
    Globals.handleException( "ActivityApprovalDataHandlerBase:GetServerId()", ex);
    rethrow;
  }
  return serverId;
}

static Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

    String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
    selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYAPPROVAL} A";
    selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID} = $id";

    final db= await databaseHandler.database;
    List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
    if (result.isNotEmpty) {
      localId = result[0][ColumnsBase.KEY_ID];
    }
    //db.close();
  } catch (ex) {
    Globals.handleException( "ActivityApprovalDataHandlerBase:GetLocalId()", ex);
    rethrow;
  }
  return localId;
}


     static Future<List<ActivityApproval>> GetActivityApprovalUpSyncRecords(DatabaseHandler databaseHandler, String changeType) async{
        List<ActivityApproval> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYAPPROVAL + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            //selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYAPPROVAL_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

         final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                  ActivityApproval dataItem = new ActivityApproval();

                  dataItem.activityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID];
                  dataItem.activityApprovalCode = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE];
                  dataItem.activityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE];
                  dataItem.activityApprovalTypeID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID];
                  dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID];
                  dataItem.requestDate = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE];
                  dataItem.requestDetail = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL];
                  dataItem.isSubmitted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED];
                  dataItem.parentActivityApprovalID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID];
                  dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
                  dataItem.approvalStatus = element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
                  dataItem.approvalByAppUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID];
                  dataItem.approvalTime = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME];
                  dataItem.approverRemarks = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS];
                  dataItem.isApprovalCompleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED];
                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON];
                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY];
                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON];
                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY];
                  dataItem.deviceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER];
                  dataItem.referenceIdentifier = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER];
                  dataItem.location = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION];

                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE];
dataItem.uid = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_UID];
dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED];
dataItem.activityApprovalTypeName = element[ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME];
dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
dataItem.parentActivityApprovalTitle = element[ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALTITLE];
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
            Globals.handleException( "ActivityApprovalDataHandlerBase:GetActivityApprovalUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
