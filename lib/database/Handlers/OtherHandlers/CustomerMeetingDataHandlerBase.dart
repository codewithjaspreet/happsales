

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/CustomerMeeting.dart';
import '../DataBaseHandler.dart';

class CustomerMeetingDataHandlerBase {

     static List<CustomerMeeting> GetCustomerMeetingRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
        List<CustomerMeeting> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE + " LIKE '%" + searchString + "%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_CustomerMeeting_Columns.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();



 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<CustomerMeeting> GetCustomerMeetingRecords(DatabaseHandler databaseHandler, String searchString) {
        List<CustomerMeeting> dataList = new ArrayList<CustomerMeeting>();
        try {
            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length() > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE + " LIKE '" + searchString + "%'";
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE + " COLLATE NOCASE ASC ";


 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static CustomerMeeting GetCustomerMeetingRecord(DatabaseHandler databaseHandler, String id) {
        CustomerMeeting dataItem = null;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
			selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;


 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static CustomerMeeting GetMasterCustomerMeetingRecord(DatabaseHandler databaseHandler, String id) {
        CustomerMeeting dataItem = null;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID + " = " + id;
			selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

          

 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetMasterCustomerMeetingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static long AddCustomerMeetingRecord(DatabaseHandler databaseHandler, CustomerMeeting dataItem) {
        long id = 0;
        try {
            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            ContentValues values = new ContentValues();
            if (dataItem.getCustomerMeetingID() != null && !dataItem.getCustomerMeetingID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID, dataItem.getCustomerMeetingID());
            if (dataItem.getCustomerMeetingCode() != null && !dataItem.getCustomerMeetingCode().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE, dataItem.getCustomerMeetingCode());
            if (dataItem.getCustomerMeetingTitle() != null && !dataItem.getCustomerMeetingTitle().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE, dataItem.getCustomerMeetingTitle());
            if (dataItem.getActivityID() != null && !dataItem.getActivityID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID, dataItem.getActivityID());
            if (dataItem.getAccountID() != null && !dataItem.getAccountID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID, dataItem.getAccountID());
            if (dataItem.getContactID() != null && !dataItem.getContactID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID, dataItem.getContactID());
            if (dataItem.getCustomerMeetingDate() != null && !dataItem.getCustomerMeetingDate().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE, dataItem.getCustomerMeetingDate());
            if (dataItem.getPunchInTime() != null && !dataItem.getPunchInTime().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME, dataItem.getPunchInTime());
            if (dataItem.getPunchOutTime() != null && !dataItem.getPunchOutTime().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME, dataItem.getPunchOutTime());
            if (dataItem.getPunchInLocation() != null && !dataItem.getPunchInLocation().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION, dataItem.getPunchInLocation());
            if (dataItem.getPunchOutLocation() != null && !dataItem.getPunchOutLocation().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTLOCATION, dataItem.getPunchOutLocation());
            if (dataItem.getRemarks() != null && !dataItem.getRemarks().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_REMARKS, dataItem.getRemarks());
            if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY, dataItem.getCreatedBy());
            if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON, dataItem.getCreatedOn());
            if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY, dataItem.getModifiedBy());
            if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON, dataItem.getModifiedOn());
            if (dataItem.getDeviceIdentifier() != null && !dataItem.getDeviceIdentifier().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER, dataItem.getDeviceIdentifier());
            if (dataItem.getReferenceIdentifier() != null && !dataItem.getReferenceIdentifier().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER, dataItem.getReferenceIdentifier());
            if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE, dataItem.getIsActive());
            if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_UID, dataItem.getUid());
            if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID, dataItem.getAppUserID());
            if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID, dataItem.getAppUserGroupID());
            if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED, dataItem.getIsArchived());
            if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED, dataItem.getIsDeleted());
            if (dataItem.getId() != null && !dataItem.getId().equals("null"))
                values.put(ColumnsBase.KEY_ID, dataItem.getId());
            if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
                values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
            if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
                values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
            if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
                values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
            if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
                values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
            if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
                values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
            if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
                values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
            if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
                values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
            if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
                values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
            if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
                values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
            values.put(ColumnsBase.KEY_UPSYNCINDEX, 0);
            values.put(ColumnsBase.KEY_ISACTIVE, "true");
            values.put(ColumnsBase.KEY_ISDELETED, "false");

            id = db.insert(TablesBase.TABLE_CUSTOMERMEETING, null, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static long UpdateCustomerMeetingRecord(DatabaseHandler databaseHandler, String id1, CustomerMeeting dataItem) {
        long id = 0;
        try {
            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            ContentValues values = new ContentValues();
            if (dataItem.getCustomerMeetingID() != null && !dataItem.getCustomerMeetingID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID, dataItem.getCustomerMeetingID());
            if (dataItem.getCustomerMeetingCode() != null && !dataItem.getCustomerMeetingCode().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE, dataItem.getCustomerMeetingCode());
            if (dataItem.getCustomerMeetingTitle() != null && !dataItem.getCustomerMeetingTitle().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE, dataItem.getCustomerMeetingTitle());
            if (dataItem.getActivityID() != null && !dataItem.getActivityID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID, dataItem.getActivityID());
            if (dataItem.getAccountID() != null && !dataItem.getAccountID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID, dataItem.getAccountID());
            if (dataItem.getContactID() != null && !dataItem.getContactID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID, dataItem.getContactID());
            if (dataItem.getCustomerMeetingDate() != null && !dataItem.getCustomerMeetingDate().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE, dataItem.getCustomerMeetingDate());
            if (dataItem.getPunchInTime() != null && !dataItem.getPunchInTime().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME, dataItem.getPunchInTime());
            if (dataItem.getPunchOutTime() != null && !dataItem.getPunchOutTime().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME, dataItem.getPunchOutTime());
            if (dataItem.getPunchInLocation() != null && !dataItem.getPunchInLocation().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION, dataItem.getPunchInLocation());
            if (dataItem.getPunchOutLocation() != null && !dataItem.getPunchOutLocation().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTLOCATION, dataItem.getPunchOutLocation());
            if (dataItem.getRemarks() != null && !dataItem.getRemarks().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_REMARKS, dataItem.getRemarks());
            if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY, dataItem.getCreatedBy());
            if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON, dataItem.getCreatedOn());
            if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY, dataItem.getModifiedBy());
            if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON, dataItem.getModifiedOn());
            if (dataItem.getDeviceIdentifier() != null && !dataItem.getDeviceIdentifier().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER, dataItem.getDeviceIdentifier());
            if (dataItem.getReferenceIdentifier() != null && !dataItem.getReferenceIdentifier().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER, dataItem.getReferenceIdentifier());
            if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE, dataItem.getIsActive());
            if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_UID, dataItem.getUid());
            if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID, dataItem.getAppUserID());
            if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID, dataItem.getAppUserGroupID());
            if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED, dataItem.getIsArchived());
            if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
                values.put(ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED, dataItem.getIsDeleted());
            if (dataItem.getId() != null && !dataItem.getId().equals("null"))
                values.put(ColumnsBase.KEY_ID, dataItem.getId());
            if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
                values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
            if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
                values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
            if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
                values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
            if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
                values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
            if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
                values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
            if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
                values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
            if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
                values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
            if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
                values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
            if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
                values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
            if (dataItem.getUpSyncIndex() != null && !dataItem.getUpSyncIndex().equals("null"))
                values.put(ColumnsBase.KEY_UPSYNCINDEX, dataItem.getUpSyncIndex());

            id = db.update(TablesBase.TABLE_CUSTOMERMEETING, values, ColumnsBase.KEY_ID + " = " + id1, null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static long DeleteCustomerMeetingRecord(DatabaseHandler databaseHandler, String id1) {
        long id = 0;
        try {
            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            id = db.delete(TablesBase.TABLE_CUSTOMERMEETING, ColumnsBase.KEY_ID + " = " + id1, null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static String GetServerId(DatabaseHandler databaseHandler, String id) {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                serverId = cursor.getString(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static String GetLocalId(DatabaseHandler databaseHandler, String id) {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID + " = " + id;

            SQLiteDatabase db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                localId = cursor.getString(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static List<CustomerMeeting> GetCustomerMeetingUpSyncRecords(DatabaseHandler databaseHandler, String changeType) {
        List<CustomerMeeting> dataList = new ArrayList<CustomerMeeting>();
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_CUSTOMERMEETING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CUSTOMERMEETING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CUSTOMERMEETING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }
			selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			selectQuery += " AND " + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

         

 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static CustomerMeeting GetCustomerMeetingRecordByUid(DatabaseHandler databaseHandler, String uid) {
        CustomerMeeting dataItem = null;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME;
		selectQuery += " FROM " + TablesBase.TABLE_CUSTOMERMEETING + " A "; 
		selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
		selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
		selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID + " = F." + ColumnsBase.KEY_ID;
			selectQuery += " WHERE A."  + ColumnsBase.KEY_CUSTOMERMEETING_UID + " = '" + uid + "'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

          

 final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
        }
        catch( ex)
        {
	    Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}