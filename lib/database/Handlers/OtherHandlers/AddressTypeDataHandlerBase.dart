
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AddressType.dart';
import '../DataBaseHandler.dart';

class AddressTypeDataHandlerBase {

     static Future<List<AddressType>> GetAddressTypeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AddressType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME} LIKE '%" + searchString.replaceAll("'","''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AddressType_Columns.KEY_ADDRESSTYPE_ADDRESSTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
            Globals.handleException( "AddressTypeDataHandlerBase:GetAddressTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AddressType>> GetAddressTypeRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AddressType> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME} LIKE '${searchString.replaceAll("'","''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
            Globals.handleException( "AddressTypeDataHandlerBase:GetAddressTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AddressType?> GetAddressTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        AddressType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
            Globals.handleException( "AddressTypeDataHandlerBase:GetAddressTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AddressType?> GetMasterAddressTypeRecord(DatabaseHandler databaseHandler,  String id)async {
        AddressType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
            Globals.handleException( "AddressTypeDataHandlerBase:GetMasterAddressTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAddressTypeRecord(DatabaseHandler databaseHandler,  AddressType dataItem) async{
        int id = 0;
        try {
           final db = await  databaseHandler.database;
Map<String, dynamic> values = Map<String, dynamic>();

if (dataItem.addressTypeID != null && dataItem.addressTypeID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID] = dataItem.addressTypeID;
}

if (dataItem.addressTypeCode != null && dataItem.addressTypeCode != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE] = dataItem.addressTypeCode;
}

if (dataItem.addressTypeName != null && dataItem.addressTypeName != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME] = dataItem.addressTypeName;
}

if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED] = dataItem.isArchived;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_ADDRESSTYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAddressTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAddressTypeRecord(DatabaseHandler databaseHandler,  String id1, AddressType dataItem) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
Map<String, dynamic> values = Map<String, dynamic>();

if (dataItem.addressTypeID != null && dataItem.addressTypeID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID] = dataItem.addressTypeID;
}

if (dataItem.addressTypeCode != null && dataItem.addressTypeCode != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE] = dataItem.addressTypeCode;
}

if (dataItem.addressTypeName != null && dataItem.addressTypeName != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME] = dataItem.addressTypeName;
}

if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED] = dataItem.isArchived;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_ADDRESSTYPE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAddressTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAddressTypeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ADDRESSTYPE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null );
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAddressTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID].toString();
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "AddressTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "AddressTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AddressType>> GetAddressTypeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AddressType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ADDRESSTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ADDRESSTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ADDRESSTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
            Globals.handleException( "AddressTypeDataHandlerBase:GetAddressTypeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AddressType?> GetAddressTypeRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AddressType? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_ADDRESSTYPE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_ADDRESSTYPE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AddressType dataItem = new AddressType();

                    dataItem.addressTypeID  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID];
                    dataItem.addressTypeCode  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE];
                    dataItem.addressTypeName  = element[ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME];
                    dataItem.createdOn  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDON];
                    dataItem.createdBy  = element[ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY];

                    dataItem.modifiedOn  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON];
                    dataItem.modifiedBy  = element[ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY];
                    dataItem.isActive  = element[ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_ADDRESSTYPE_UID];
                    dataItem.appUserID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERID];

                    dataItem.appUserGroupID  = element[ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID];
                    dataItem.isArchived  = element[ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED];

                    dataItem.isDeleted  = element[ColumnsBase.KEY_ADDRESSTYPE_ISDELETED];
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
	    Globals.handleException( "AddressTypeDataHandlerBase:GetAddressTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}