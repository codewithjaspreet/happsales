

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Unit.dart';
import '../DataBaseHandler.dart';

class UnitDataHandlerBase {

     static Future<List<Unit>> GetUnitRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<Unit> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_UNIT_UNITNAME} AS ${ColumnsBase.KEY_UNIT_PARENTUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_UNIT} D ON A.${ColumnsBase.KEY_UNIT_PARENTUNITID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_UNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_UNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_UNIT_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_UNIT_UNITNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Unit_Columns.KEY_UNIT_UNITNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();
 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetUnitRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Unit>> GetUnitRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<Unit> dataList  = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_UNIT_UNITNAME} AS ${ColumnsBase.KEY_UNIT_PARENTUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_UNIT} D ON A.${ColumnsBase.KEY_UNIT_PARENTUNITID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_UNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_UNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_UNIT_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length> 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_UNIT_UNITNAME} LIKE '" + searchString.replaceAll("'", "''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_UNIT_UNITNAME} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetUnitRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Unit?> GetUnitRecord(DatabaseHandler databaseHandler,  String id)async {
        Unit? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_UNIT_UNITNAME} AS ${ColumnsBase.KEY_UNIT_PARENTUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_UNIT} D ON A.${ColumnsBase.KEY_UNIT_PARENTUNITID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_UNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Unit?> GetUnitRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        Unit? dataItem ;
        try {

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_UNIT_UNITNAME} AS ${ColumnsBase.KEY_UNIT_PARENTUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_UNIT} D ON A.${ColumnsBase.KEY_UNIT_PARENTUNITID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_UNIT_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_UNIT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetUnitRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Unit?> GetMasterUnitRecord(DatabaseHandler databaseHandler,  String id)async {
        Unit? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_UNIT_UNITNAME} AS ${ColumnsBase.KEY_UNIT_PARENTUNITNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_UNIT} D ON A.${ColumnsBase.KEY_UNIT_PARENTUNITID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_UNIT_UNITID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_UNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetMasterUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddUnitRecord(DatabaseHandler databaseHandler,  Unit dataItem) async{
        int id = 0;
        try {
              final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.unitID != null && dataItem.unitID != "null") {
  values[ColumnsBase.KEY_UNIT_UNITID] = dataItem.unitID;
}
if (dataItem.unitCode != null && dataItem.unitCode != "null") {
  values[ColumnsBase.KEY_UNIT_UNITCODE] = dataItem.unitCode;
}
if (dataItem.unitName != null && dataItem.unitName != "null") {
  values[ColumnsBase.KEY_UNIT_UNITNAME] = dataItem.unitName;
}
if (dataItem.shortForm != null && dataItem.shortForm != "null") {
  values[ColumnsBase.KEY_UNIT_SHORTFORM] = dataItem.shortForm;
}
if (dataItem.numberSystemBase != null && dataItem.numberSystemBase != "null") {
  values[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE] = dataItem.numberSystemBase;
}
if (dataItem.parentUnitID != null && dataItem.parentUnitID != "null") {
  values[ColumnsBase.KEY_UNIT_PARENTUNITID] = dataItem.parentUnitID;
}
if (dataItem.parentUnitName != null && dataItem.parentUnitName != "null") {
  values[ColumnsBase.KEY_UNIT_PARENTUNITNAME] = dataItem.parentUnitName;
}
if (dataItem.conversionFactor != null && dataItem.conversionFactor != "null") {
  values[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR] = dataItem.conversionFactor;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_UNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_UNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_UNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_UNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_UNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_UNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_UNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_UNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_UNIT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_UNIT_ISDELETED] = dataItem.isDeleted;
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

// Assuming you have a reference to the database, you can use the following code to insert the updated values into the table
id = await db.insert(TablesBase.TABLE_UNIT, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateUnitRecord(DatabaseHandler databaseHandler,  String id1, Unit dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.unitID != null && dataItem.unitID != "null") {
  values[ColumnsBase.KEY_UNIT_UNITID] = dataItem.unitID;
}
if (dataItem.unitCode != null && dataItem.unitCode != "null") {
  values[ColumnsBase.KEY_UNIT_UNITCODE] = dataItem.unitCode;
}
if (dataItem.unitName != null && dataItem.unitName != "null") {
  values[ColumnsBase.KEY_UNIT_UNITNAME] = dataItem.unitName;
}
if (dataItem.shortForm != null && dataItem.shortForm != "null") {
  values[ColumnsBase.KEY_UNIT_SHORTFORM] = dataItem.shortForm;
}
if (dataItem.numberSystemBase != null && dataItem.numberSystemBase != "null") {
  values[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE] = dataItem.numberSystemBase;
}
if (dataItem.parentUnitID != null && dataItem.parentUnitID != "null") {
  values[ColumnsBase.KEY_UNIT_PARENTUNITID] = dataItem.parentUnitID;
}
if (dataItem.parentUnitName != null && dataItem.parentUnitName != "null") {
  values[ColumnsBase.KEY_UNIT_PARENTUNITNAME] = dataItem.parentUnitName;
}
if (dataItem.conversionFactor != null && dataItem.conversionFactor != "null") {
  values[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR] = dataItem.conversionFactor;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_UNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_UNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_UNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_UNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_UNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_UNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_UNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_UNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_UNIT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_UNIT_ISDELETED] = dataItem.isDeleted;
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
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}

// Assuming you have a reference to the database, you can use the following code to insert the values into the table


            id = await db.update(TablesBase.TABLE_UNIT, values,  where :"${ColumnsBase.KEY_ID} = $id1", whereArgs :null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteUnitRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_UNIT, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_UNIT_UNITID}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_UNIT_UNITID];
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "UnitDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_UNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_UNIT_UNITID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
           
        } catch ( ex) {
            Globals.handleException( "UnitDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Unit>> GetUnitUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<Unit> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_UNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_UNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_UNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_UNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            //selectQuery += " AND " + ColumnsBase.KEY_UNIT_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {

                    Unit dataItem = new Unit();
                    dataItem.unitID = ele[ColumnsBase.KEY_UNIT_UNITID];
                    dataItem.unitCode = ele[ColumnsBase.KEY_UNIT_UNITCODE];
                    dataItem.unitName = ele[ColumnsBase.KEY_UNIT_UNITNAME];
                    dataItem.shortForm = ele[ColumnsBase.KEY_UNIT_SHORTFORM];
                    dataItem.numberSystemBase = ele[ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE];
                    dataItem.parentUnitID = ele[ColumnsBase.KEY_UNIT_PARENTUNITID];
                    dataItem.parentUnitName = ele[ColumnsBase.KEY_UNIT_PARENTUNITNAME];
                    dataItem.conversionFactor = ele[ColumnsBase.KEY_UNIT_CONVERSIONFACTOR];
                    dataItem.createdOn = ele[ColumnsBase.KEY_UNIT_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_UNIT_CREATEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_UNIT_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_UNIT_MODIFIEDBY];
                    dataItem.isActive = ele[ColumnsBase.KEY_UNIT_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_UNIT_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_UNIT_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_UNIT_APPUSERGROUPID];
                    dataItem.isArchived = ele[ColumnsBase.KEY_UNIT_ISARCHIVED];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_UNIT_ISDELETED];
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
            Globals.handleException( "UnitDataHandlerBase:GetUnitUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
