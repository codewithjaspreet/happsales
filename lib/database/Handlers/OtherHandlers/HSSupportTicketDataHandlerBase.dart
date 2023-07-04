

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/HSSupportTicket.dart';
import '../DataBaseHandler.dart';

class HSSupportTicketDataHandlerBase {

     static Future<List<HSSupportTicket>> GetHSSupportTicketRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, int pageIndex, int pageSize)async {
        List<HSSupportTicket> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE + " LIKE '%" + searchString.replaceAll("'", "''") + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_HSSupportTicket_Columns.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();

final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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
  // Rest of your code...

}



        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetHSSupportTicketRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<HSSupportTicket>> GetHSSupportTicketRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<HSSupportTicket> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE + " LIKE '" + searchString.replaceAll("'", "''") + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE + " COLLATE NOCASE ASC ";

           
final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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
  // Rest of your code...

}
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetHSSupportTicketRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<HSSupportTicket?> GetHSSupportTicketRecord(DatabaseHandler databaseHandler,  String id)async {
        HSSupportTicket? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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


  // Rest of your code...

}
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetHSSupportTicketRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<HSSupportTicket?> GetHSSupportTicketRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        HSSupportTicket? dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_HSSUPPORTTICKET_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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


  // Rest of your code...

}
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetHSSupportTicketRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<HSSupportTicket?> GetMasterHSSupportTicketRecord(DatabaseHandler databaseHandler,  String id) async{
        HSSupportTicket? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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


  // Rest of your code...

}
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetMasterHSSupportTicketRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddHSSupportTicketRecord(DatabaseHandler databaseHandler,  HSSupportTicket dataItem) async{
        int id = 0;
        try {
           final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.hSSupportTicketID != null && dataItem.hSSupportTicketID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID] = dataItem.hSSupportTicketID;
}
if (dataItem.hSSupportTicketCode != null && dataItem.hSSupportTicketCode != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE] = dataItem.hSSupportTicketCode;
}
if (dataItem.hSSupportTicketTitle != null && dataItem.hSSupportTicketTitle != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE] = dataItem.hSSupportTicketTitle;
}
if (dataItem.hSSupportTicketType != null && dataItem.hSSupportTicketType != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE] = dataItem.hSSupportTicketType;
}
if (dataItem.hSSupportTicketDetail != null && dataItem.hSSupportTicketDetail != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL] = dataItem.hSSupportTicketDetail;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.parentHSSupportTicketID != null && dataItem.parentHSSupportTicketID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID] = dataItem.parentHSSupportTicketID;
}
if (dataItem.assignedToHSUserID != null && dataItem.assignedToHSUserID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID] = dataItem.assignedToHSUserID;
}
if (dataItem.ticketStatus != null && dataItem.ticketStatus != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS] = dataItem.ticketStatus;
}
if (dataItem.resolution != null && dataItem.resolution != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION] = dataItem.resolution;
}
if (dataItem.resolutionTime != null && dataItem.resolutionTime != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME] = dataItem.resolutionTime;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED] = dataItem.isDeleted;
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

id =await  db.insert(TablesBase.TABLE_HSSUPPORTTICKET, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddHSSupportTicketRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateHSSupportTicketRecord(DatabaseHandler databaseHandler,  String id1, HSSupportTicket dataItem) async{
        int id = 0;
        try {
           final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.hSSupportTicketID != null && dataItem.hSSupportTicketID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID] = dataItem.hSSupportTicketID;
}
if (dataItem.hSSupportTicketCode != null && dataItem.hSSupportTicketCode != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE] = dataItem.hSSupportTicketCode;
}
if (dataItem.hSSupportTicketTitle != null && dataItem.hSSupportTicketTitle != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE] = dataItem.hSSupportTicketTitle;
}
if (dataItem.hSSupportTicketType != null && dataItem.hSSupportTicketType != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE] = dataItem.hSSupportTicketType;
}
if (dataItem.hSSupportTicketDetail != null && dataItem.hSSupportTicketDetail != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL] = dataItem.hSSupportTicketDetail;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.parentHSSupportTicketID != null && dataItem.parentHSSupportTicketID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID] = dataItem.parentHSSupportTicketID;
}
if (dataItem.assignedToHSUserID != null && dataItem.assignedToHSUserID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID] = dataItem.assignedToHSUserID;
}
if (dataItem.ticketStatus != null && dataItem.ticketStatus != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS] = dataItem.ticketStatus;
}
if (dataItem.resolution != null && dataItem.resolution != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION] = dataItem.resolution;
}
if (dataItem.resolutionTime != null && dataItem.resolutionTime != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME] = dataItem.resolutionTime;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED] = dataItem.isDeleted;
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

            id = await  db.update(TablesBase.TABLE_HSSUPPORTTICKET, values,  where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateHSSupportTicketRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteHSSupportTicketRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_HSSUPPORTTICKET, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteHSSupportTicketRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID;
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

 final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
      }
          
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID + " = " + id;

           
 final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
          
            //db.close();
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<HSSupportTicket>> GetHSSupportTicketUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<HSSupportTicket> dataList =[];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_HSSUPPORTTICKET + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            
final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  HSSupportTicket dataItem = HSSupportTicket();

  dataItem.hSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID];
  dataItem.hSSupportTicketCode = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE];
  dataItem.hSSupportTicketTitle = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];
  dataItem.hSSupportTicketType = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE];
  dataItem.hSSupportTicketDetail = element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL];
  dataItem.createdBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON];
  dataItem.parentHSSupportTicketID = element[ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID];
  dataItem.assignedToHSUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID];
  dataItem.ticketStatus = element[ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS];
  dataItem.resolution = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION];
  dataItem.resolutionTime = element[ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME];
  dataItem.isActive = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKET_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID];
  dataItem.isDeleted = element[ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED];
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
  // Rest of your code...

}
        } catch ( ex) {
            Globals.handleException( "HSSupportTicketDataHandlerBase:GetHSSupportTicketUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
