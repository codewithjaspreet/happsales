

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/PhoneType.dart';
import '../DataBaseHandler.dart';

class PhoneTypeDataHandlerBase {

     static Future<List<PhoneType>> GetPhoneTypeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<PhoneType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_PHONETYPENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_PhoneType_Columns.KEY_PHONETYPE_PHONETYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();




      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    PhoneType dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
            Globals.handleException( "PhoneTypeDataHandlerBase:GetPhoneTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<PhoneType>> GetPhoneTypeRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<PhoneType> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_PHONETYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_PHONETYPENAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_PHONETYPE_PHONETYPENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    PhoneType dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
            Globals.handleException( "PhoneTypeDataHandlerBase:GetPhoneTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<PhoneType?> GetPhoneTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        PhoneType? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    PhoneType dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
            Globals.handleException( "PhoneTypeDataHandlerBase:GetPhoneTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<PhoneType?> GetMasterPhoneTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        PhoneType ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PHONETYPE_PHONETYPEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    PhoneType dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
            Globals.handleException( "PhoneTypeDataHandlerBase:GetMasterPhoneTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddPhoneTypeRecord(DatabaseHandler databaseHandler,  PhoneType dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.phoneTypeID != null && dataItem.phoneTypeID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPEID] = dataItem.phoneTypeID;
}
if (dataItem.phoneTypeCode != null && dataItem.phoneTypeCode != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE] = dataItem.phoneTypeCode;
}
if (dataItem.phoneTypeName != null && dataItem.phoneTypeName != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME] = dataItem.phoneTypeName;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PHONETYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PHONETYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PHONETYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PHONETYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISDELETED] = dataItem.isDeleted;
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



            id = await db.insert(TablesBase.TABLE_PHONETYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddPhoneTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdatePhoneTypeRecord(DatabaseHandler databaseHandler,  String id1, PhoneType dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
Map<String, dynamic> values = {};

if (dataItem.phoneTypeID != null && dataItem.phoneTypeID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPEID] = dataItem.phoneTypeID;
}
if (dataItem.phoneTypeCode != null && dataItem.phoneTypeCode != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE] = dataItem.phoneTypeCode;
}
if (dataItem.phoneTypeName != null && dataItem.phoneTypeName != "null") {
  values[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME] = dataItem.phoneTypeName;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_PHONETYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_PHONETYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_PHONETYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_PHONETYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_PHONETYPE_ISDELETED] = dataItem.isDeleted;
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
            

            id = await db.update(TablesBase.TABLE_PHONETYPE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdatePhoneTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeletePhoneTypeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_PHONETYPE, where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeletePhoneTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_PHONETYPE_PHONETYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_PHONETYPE_PHONETYPEID].toString();
            }
          
        } catch ( ex) {
            Globals.handleException( "PhoneTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_PHONETYPE_PHONETYPEID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "PhoneTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<PhoneType>> GetPhoneTypeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<PhoneType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_PHONETYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PHONETYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_PHONETYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                    PhoneType dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
            Globals.handleException( "PhoneTypeDataHandlerBase:GetPhoneTypeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<PhoneType?> GetPhoneTypeRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        PhoneType? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_PHONETYPE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_PHONETYPE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

                     dataItem = new PhoneType();
                    dataItem.phoneTypeID = element[ColumnsBase.KEY_PHONETYPE_PHONETYPEID];
                    dataItem.phoneTypeCode = element[ColumnsBase.KEY_PHONETYPE_PHONETYPECODE];
                    dataItem.phoneTypeName = element[ColumnsBase.KEY_PHONETYPE_PHONETYPENAME];
                    dataItem.createdOn = element[ColumnsBase.KEY_PHONETYPE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_PHONETYPE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_PHONETYPE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_PHONETYPE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_PHONETYPE_UID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_PHONETYPE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_PHONETYPE_ISARCHIVED];
                    dataItem.appUserID = element[ColumnsBase.KEY_PHONETYPE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID];

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
	    Globals.handleException( "PhoneTypeDataHandlerBase:GetPhoneTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}