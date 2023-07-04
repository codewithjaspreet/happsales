

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/CustomerMeeting.dart';
import '../DataBaseHandler.dart';

class CustomerMeetingDataHandlerBase {

     static Future<List<CustomerMeeting>> GetCustomerMeetingRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<CustomerMeeting> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE} LIKE '%$searchString%'";

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

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";



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

     static Future<List<CustomerMeeting>> GetCustomerMeetingRecords(DatabaseHandler databaseHandler, String searchString) async {
        List<CustomerMeeting> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE} COLLATE NOCASE ASC ";


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

     static Future<CustomerMeeting?> GetCustomerMeetingRecord(DatabaseHandler databaseHandler, String id)async {
        CustomerMeeting? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";


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

                    


            }
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<CustomerMeeting?> GetMasterCustomerMeetingRecord(DatabaseHandler databaseHandler, String id) async{
        CustomerMeeting? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          

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

                    


            }
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetMasterCustomerMeetingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddCustomerMeetingRecord(DatabaseHandler databaseHandler, CustomerMeeting dataItem)async {
        int id = 0;
        try {
            final  db = await databaseHandler.database;
final Map<String, dynamic> values = {};

if (dataItem.customerMeetingID != null && dataItem.customerMeetingID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID] = dataItem.customerMeetingID;
}
if (dataItem.customerMeetingCode != null && dataItem.customerMeetingCode != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE] = dataItem.customerMeetingCode;
}
if (dataItem.customerMeetingTitle != null && dataItem.customerMeetingTitle != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE] = dataItem.customerMeetingTitle;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.contactID != null && dataItem.contactID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID] = dataItem.contactID;
}
if (dataItem.customerMeetingDate != null && dataItem.customerMeetingDate != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE] = dataItem.customerMeetingDate;
}
if (dataItem.punchInTime != null && dataItem.punchInTime != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME] = dataItem.punchInTime;
}
if (dataItem.punchOutTime != null && dataItem.punchOutTime != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME] = dataItem.punchOutTime;
}
if (dataItem.punchInLocation != null && dataItem.punchInLocation != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION] = dataItem.punchInLocation;
}
if (dataItem.punchOutLocation != null && dataItem.punchOutLocation != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTLOCATION] = dataItem.punchOutLocation;
}
if (dataItem.remarks != null && dataItem.remarks != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS] = dataItem.remarks;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED] = dataItem.isDeleted;
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

final id = await db.insert(TablesBase.TABLE_CUSTOMERMEETING, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateCustomerMeetingRecord(DatabaseHandler databaseHandler, String id1, CustomerMeeting dataItem) async{
        int id = 0;
        try {
            
            final  db = await databaseHandler.database;
final Map<String, dynamic> values = {};

if (dataItem.customerMeetingID != null && dataItem.customerMeetingID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID] = dataItem.customerMeetingID;
}
if (dataItem.customerMeetingCode != null && dataItem.customerMeetingCode != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE] = dataItem.customerMeetingCode;
}
if (dataItem.customerMeetingTitle != null && dataItem.customerMeetingTitle != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE] = dataItem.customerMeetingTitle;
}
if (dataItem.activityID != null && dataItem.activityID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID] = dataItem.activityID;
}
if (dataItem.accountID != null && dataItem.accountID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID] = dataItem.accountID;
}
if (dataItem.contactID != null && dataItem.contactID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID] = dataItem.contactID;
}
if (dataItem.customerMeetingDate != null && dataItem.customerMeetingDate != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE] = dataItem.customerMeetingDate;
}
if (dataItem.punchInTime != null && dataItem.punchInTime != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME] = dataItem.punchInTime;
}
if (dataItem.punchOutTime != null && dataItem.punchOutTime != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME] = dataItem.punchOutTime;
}
if (dataItem.punchInLocation != null && dataItem.punchInLocation != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION] = dataItem.punchInLocation;
}
if (dataItem.punchOutLocation != null && dataItem.punchOutLocation != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTLOCATION] = dataItem.punchOutLocation;
}
if (dataItem.remarks != null && dataItem.remarks != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS] = dataItem.remarks;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED] = dataItem.isDeleted;
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


if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null"){

  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

}



           
            id = await db.update(TablesBase.TABLE_CUSTOMERMEETING, values,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteCustomerMeetingRecord(DatabaseHandler databaseHandler, String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_CUSTOMERMEETING,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteCustomerMeetingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler, String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID].toString();
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler, String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID} = $id";

           final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID].toString();
            }
        } catch ( ex) {
            Globals.handleException( "CustomerMeetingDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<CustomerMeeting>> GetCustomerMeetingUpSyncRecords(DatabaseHandler databaseHandler, String changeType)async {
        List<CustomerMeeting> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_CUSTOMERMEETING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CUSTOMERMEETING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CUSTOMERMEETING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

         

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


	  static Future<CustomerMeeting?> GetCustomerMeetingRecordByUid(DatabaseHandler databaseHandler, String uid)async {
        CustomerMeeting? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
		selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_CUSTOMERMEETING_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          

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