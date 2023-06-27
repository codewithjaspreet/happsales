
import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/CreditRating.dart';
import '../DataBaseHandler.dart';

 class CreditRatingDataHandlerBase {

  CreditRatingDataHandlerBase();

     static Future<List<CreditRating>> GetCreditRatingRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<CreditRating> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_CreditRating_ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<CreditRating>> GetCreditRatingRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<CreditRating> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CREDITRATING_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME} COLLATE NOCASE ASC ";
  final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<CreditRating?> GetCreditRatingRecord(DatabaseHandler databaseHandler,  String id) async{
        CreditRating? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<CreditRating?> GetMasterCreditRatingRecord(DatabaseHandler databaseHandler,  String id) async{
        CreditRating? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
  final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetMasterCreditRatingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddCreditRatingRecord(DatabaseHandler databaseHandler,  CreditRating dataItem)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.creditRatingID != null && dataItem.creditRatingID != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID] = dataItem.creditRatingID;
  if (dataItem.creditRatingCode != null && dataItem.creditRatingCode != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE] = dataItem.creditRatingCode;
  if (dataItem.creditRatingName != null && dataItem.creditRatingName != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME] = dataItem.creditRatingName;
  if (dataItem.creditRatingDescription != null && dataItem.creditRatingDescription != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION] = dataItem.creditRatingDescription;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREATEDON] = dataItem.createdOn;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREATEDBY] = dataItem.createdBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_CREDITRATING_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_CREDITRATING_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_CREDITRATING_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

  values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
  values[ColumnsBase.KEY_ISACTIVE] = "true";
  values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.insert(TablesBase.TABLE_CREDITRATING, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddCreditRatingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateCreditRatingRecord(DatabaseHandler databaseHandler,  String id1, CreditRating dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
            Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.creditRatingID != null && dataItem.creditRatingID != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID] = dataItem.creditRatingID;
  if (dataItem.creditRatingCode != null && dataItem.creditRatingCode != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE] = dataItem.creditRatingCode;
  if (dataItem.creditRatingName != null && dataItem.creditRatingName != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME] = dataItem.creditRatingName;
  if (dataItem.creditRatingDescription != null && dataItem.creditRatingDescription != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION] = dataItem.creditRatingDescription;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREATEDON] = dataItem.createdOn;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_CREDITRATING_CREATEDBY] = dataItem.createdBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_CREDITRATING_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_CREDITRATING_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_CREDITRATING_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_CREDITRATING_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

            id = await db.update(TablesBase.TABLE_CREDITRATING, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateCreditRatingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteCreditRatingRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_CREDITRATING, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteCreditRatingRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID}";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_CREDITRATING_CREDITRATINGID].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
          
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<CreditRating>> GetCreditRatingUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<CreditRating> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_CREDITRATING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CREDITRATING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_CREDITRATING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecord()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<CreditRating?> GetMasterCreditRatingRecord2(DatabaseHandler databaseHandler,  String id) async{
        CreditRating? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
  final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingUpSyncRecords()", ex);
            throw ex;
        }
        return dataItem;
    }


	  static Future<CreditRating?> GetCreditRatingRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        CreditRating? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_CREDITRATING_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<CreditRating?> GetMasterCreditRatingRecord1(DatabaseHandler databaseHandler,  String id) async{
        CreditRating? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_CREDITRATING} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
  final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    CreditRating dataItem = new CreditRating();
                    dataItem.creditRatingID = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGID];
                    dataItem.creditRatingCode = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE];
                    dataItem.creditRatingName = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
                    dataItem.creditRatingDescription = element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION];
                    dataItem.createdOn = element[ColumnsBase.KEY_CREDITRATING_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_CREDITRATING_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CREDITRATING_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_CREDITRATING_ISACTIVE];
                    dataItem.isArchived = element[ColumnsBase.KEY_CREDITRATING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CREDITRATING_ISDELETED];
                    dataItem.uid = element[ColumnsBase.KEY_CREDITRATING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CREDITRATING_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID];
                     dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
	    Globals.handleException( "CreditRatingDataHandlerBase:GetCreditRatingRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}