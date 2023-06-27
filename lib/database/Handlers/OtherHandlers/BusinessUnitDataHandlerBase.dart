
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/BusinessUnit.dart';
import '../DataBaseHandler.dart';

class BusinessUnitDataHandlerBase {

     static Future<List<BusinessUnit>> GetBusinessUnitRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<BusinessUnit> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSUNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME} LIKE '%${searchString.replaceAll("'","''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_BusinessUnit_ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessUnit dataItem = new BusinessUnit();

                    dataItem.businessUnitID = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
                    dataItem.businessUnitCode = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE];
                    dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];
                    dataItem.description = element[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION];
                    dataItem.headOfBusinessUnitAppUserID = element[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSUNIT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER];

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
            Globals.handleException( "BusinessUnitDataHandlerBase:GetBusinessUnitRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<BusinessUnit>> GetBusinessUnitRecords(DatabaseHandler databaseHandler,  String searchString) async {
        List<BusinessUnit> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSUNIT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME} LIKE '${searchString.replaceAll("'","''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME} COLLATE NOCASE ASC ";

           final db =await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessUnit dataItem = new BusinessUnit();

                    dataItem.businessUnitID = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
                    dataItem.businessUnitCode = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE];
                    dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];
                    dataItem.description = element[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION];
                    dataItem.headOfBusinessUnitAppUserID = element[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSUNIT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER];

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
            Globals.handleException( "BusinessUnitDataHandlerBase:GetBusinessUnitRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<BusinessUnit?> GetBusinessUnitRecord(DatabaseHandler databaseHandler,  String id) async {
        BusinessUnit? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessUnit dataItem = new BusinessUnit();

                    dataItem.businessUnitID = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
                    dataItem.businessUnitCode = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE];
                    dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];
                    dataItem.description = element[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION];
                    dataItem.headOfBusinessUnitAppUserID = element[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSUNIT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER];

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
            Globals.handleException( "BusinessUnitDataHandlerBase:GetBusinessUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<BusinessUnit?> GetBusinessUnitRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        BusinessUnit? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSUNIT_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

        } catch ( ex) {
            Globals.handleException( "BusinessUnitDataHandlerBase:GetBusinessUnitRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<BusinessUnit?> GetMasterBusinessUnitRecord(DatabaseHandler databaseHandler,  String id) async {
        BusinessUnit? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessUnit dataItem = new BusinessUnit();

                    dataItem.businessUnitID = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
                    dataItem.businessUnitCode = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE];
                    dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];
                    dataItem.description = element[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION];
                    dataItem.headOfBusinessUnitAppUserID = element[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSUNIT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER];

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
            Globals.handleException( "BusinessUnitDataHandlerBase:GetMasterBusinessUnitRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddBusinessUnitRecord(DatabaseHandler databaseHandler,  BusinessUnit dataItem) async{
        int id = 0;
        try {
             final db =  await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.businessUnitID != null && dataItem.businessUnitID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID] = dataItem.businessUnitID;
}
if (dataItem.businessUnitCode != null && dataItem.businessUnitCode != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE] = dataItem.businessUnitCode;
}
if (dataItem.businessUnitName != null && dataItem.businessUnitName != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME] = dataItem.businessUnitName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION] = dataItem.description;
}
if (dataItem.headOfBusinessUnitAppUserID != null && dataItem.headOfBusinessUnitAppUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID] = dataItem.headOfBusinessUnitAppUserID;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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
            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE] =  "true";
            values[ColumnsBase.KEY_ISDELETED]  =  "false";

            id = await db.insert(TablesBase.TABLE_BUSINESSUNIT, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddBusinessUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateBusinessUnitRecord(DatabaseHandler databaseHandler,  String id1, BusinessUnit dataItem) async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.businessUnitID != null && dataItem.businessUnitID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID] = dataItem.businessUnitID;
}
if (dataItem.businessUnitCode != null && dataItem.businessUnitCode != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE] = dataItem.businessUnitCode;
}
if (dataItem.businessUnitName != null && dataItem.businessUnitName != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME] = dataItem.businessUnitName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION] = dataItem.description;
}
if (dataItem.headOfBusinessUnitAppUserID != null && dataItem.headOfBusinessUnitAppUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID] = dataItem.headOfBusinessUnitAppUserID;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
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

            id =  await db.update(TablesBase.TABLE_BUSINESSUNIT, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateBusinessUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteBusinessUnitRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_BUSINESSUNIT, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteBusinessUnitRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID}";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "BusinessUnitDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_BUSINESSUNIT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }


        } catch ( ex) {
            Globals.handleException( "BusinessUnitDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<BusinessUnit>> GetBusinessUnitUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<BusinessUnit> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_BUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_BUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_BUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
           final db = await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    BusinessUnit dataItem = new BusinessUnit();

                    dataItem.businessUnitID = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID];
                    dataItem.businessUnitCode = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE];
                    dataItem.businessUnitName = element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];
                    dataItem.description = element[ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION];
                    dataItem.headOfBusinessUnitAppUserID = element[ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID];
                    dataItem.createdOn = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_BUSINESSUNIT_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_BUSINESSUNIT_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER];

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
            Globals.handleException( "BusinessUnitDataHandlerBase:GetBusinessUnitUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


}
