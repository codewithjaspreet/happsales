

import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ReimbursementType.dart';
import '../DataBaseHandler.dart';

 class ReimbursementTypeDataHandlerBase {

     static Future<List<ReimbursementType>> GetReimbursementTypeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ReimbursementType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ReimbursementType_Columns.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetReimbursementTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ReimbursementType>> GetReimbursementTypeRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<ReimbursementType> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetReimbursementTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ReimbursementType?> GetReimbursementTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        ReimbursementType ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetReimbursementTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ReimbursementType?> GetMasterReimbursementTypeRecord(DatabaseHandler databaseHandler,  String id)async  {
        ReimbursementType? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetMasterReimbursementTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddReimbursementTypeRecord(DatabaseHandler databaseHandler,  ReimbursementType dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.reimbursementTypeID != null && dataItem.reimbursementTypeID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID] = dataItem.reimbursementTypeID;
}
if (dataItem.reimbursementTypeCode != null && dataItem.reimbursementTypeCode != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE] = dataItem.reimbursementTypeCode;
}
if (dataItem.reimbursementTypeName != null && dataItem.reimbursementTypeName != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME] = dataItem.reimbursementTypeName;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED] = dataItem.isDeleted;
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

            id =await  db.insert(TablesBase.TABLE_REIMBURSEMENTTYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddReimbursementTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateReimbursementTypeRecord(DatabaseHandler databaseHandler,  String id1, ReimbursementType dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.reimbursementTypeID != null && dataItem.reimbursementTypeID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID] = dataItem.reimbursementTypeID;
}
if (dataItem.reimbursementTypeCode != null && dataItem.reimbursementTypeCode != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE] = dataItem.reimbursementTypeCode;
}
if (dataItem.reimbursementTypeName != null && dataItem.reimbursementTypeName != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME] = dataItem.reimbursementTypeName;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED] = dataItem.isDeleted;
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

if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != ("null")) {

  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;


}

            id =await  db.update(TablesBase.TABLE_REIMBURSEMENTTYPE, values,  where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateReimbursementTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteReimbursementTypeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =await  databaseHandler.database;
            id =await  db.delete(TablesBase.TABLE_REIMBURSEMENTTYPE,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteReimbursementTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

       if(result != null && result.length > 0){
        serverId = result[0][ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];

       }

             
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID} = $id";

           final db = await databaseHandler.database;



      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);


        if(result != null && result.length > 0){

        localId = result[0][ColumnsBase.KEY_ID];

        }
        
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ReimbursementType>> GetReimbursementTypeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ReimbursementType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

         
           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReimbursementTypeDataHandlerBase:GetReimbursementTypeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ReimbursementType?> GetReimbursementTypeRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        ReimbursementType? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_REIMBURSEMENTTYPE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_REIMBURSEMENTTYPE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

        
           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    ReimbursementType dataItem = new ReimbursementType();
                    dataItem.reimbursementTypeID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID];
                    dataItem.reimbursementTypeCode = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE];
                    dataItem.reimbursementTypeName = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED];
                    dataItem.isArchived = ele[ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED];
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
	    Globals.handleException( "ReimbursementTypeDataHandlerBase:GetReimbursementTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}