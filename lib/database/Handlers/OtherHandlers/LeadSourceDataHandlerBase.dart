
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/LeadSource.dart';
import '../DataBaseHandler.dart';

class LeadSourceDataHandlerBase {

 static Future<List<LeadSource>> GetLeadSourceRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
	List<LeadSource> dataList = [];
	try
	{	
		int startRowIndex =((pageIndex - 1) * pageSize);
	
		String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A "; 
		selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
		selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
		selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_LEADSOURCE_ISDELETED},'false')) = 'false' ";
		selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_LEADSOURCE_ISACTIVE},'true')) = 'true' ";
		if (searchString.trim().length > 0) {
		  selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_LeadSource_Columns.KEY_LEADSOURCE_LEADSOURCENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/
		
		selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
		selectQuery += " LIMIT $startRowIndex,$pageSize";

 final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
        
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
	}
	catch( ex)
	{
		Globals.handleException( "LeadSourceDataHandlerBase:GetLeadSourceRecordsPaged()", ex);
		throw ex;
	}
	return dataList;
}
 static Future<List<LeadSource>> GetLeadSourceRecords(DatabaseHandler databaseHandler,  String searchString) async{
	List<LeadSource> dataList = [];
	try
	{		
		String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A "; 
		selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
		selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
		selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_LEADSOURCE_ISDELETED},'false')) = 'false' ";
		selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_LEADSOURCE_ISACTIVE},'true')) = 'true' ";
		if (searchString.trim().length > 0) {
		  selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME} LIKE '$searchString%'";
		}
            	selectQuery += " ORDER BY A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME} COLLATE NOCASE ASC ";

	final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
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
		Globals.handleException( "LeadSourceDataHandlerBase:GetLeadSourceRecords()", ex);
		throw ex;
	}
	return dataList;
}
 
     static Future<LeadSource?> GetLeadSourceRecord(DatabaseHandler databaseHandler,  String id) async{
        LeadSource ?dataItem ;
        try
        {
		id = Globals.tryParseLongForDBId(id);

            String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
			
         final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
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
	    Globals.handleException( "LeadSourceDataHandlerBase:GetLeadSourceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }
  static Future<LeadSource?> GetMasterLeadSourceRecord(DatabaseHandler databaseHandler,  String id)async {
        LeadSource? dataItem ;
        try
        {
	    id = Globals.tryParseLongForDBId(id);

 	    String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A "; 
 	    selectQuery += " WHERE A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID} = $id";
		selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
		selectQuery += " AND A.${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

        final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
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
	    Globals.handleException( "LeadSourceDataHandlerBase:GetMasterLeadSourceRecord()", ex);
            throw ex;
        }
        return dataItem;
    }
 static Future<int> AddLeadSourceRecord(DatabaseHandler databaseHandler,  LeadSource dataItem) async{
	int id = 0;
	try
	{
		 final db = await databaseHandler.database;
var values = Map<String, dynamic>();
if (dataItem.leadSourceID != null && dataItem.leadSourceID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID] = dataItem.leadSourceID;
}
if (dataItem.leadSourceCode != null && dataItem.leadSourceCode != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE] = dataItem.leadSourceCode;
}
if (dataItem.leadSourceName != null && dataItem.leadSourceName != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME] = dataItem.leadSourceName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION] = dataItem.description;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_ISDELETED] = dataItem.isDeleted;
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
		values[ColumnsBase.KEY_ISACTIVE] =  "true";
		values[ColumnsBase.KEY_ISDELETED]  = "false";

		id =await  db.insert(TablesBase.TABLE_LEADSOURCE, values);
		//db.close();
	}
	catch( ex)
	{
		Globals.handleException( "DatabaseHandler:AddLeadSourceRecord()", ex);
		throw ex;
	}
	return id;
}
 static Future<int> UpdateLeadSourceRecord(DatabaseHandler databaseHandler,  String id1, LeadSource dataItem) async{
	int id = 0;
	try
	{
    final db = await databaseHandler.database;
var values = Map<String, dynamic>();
if (dataItem.leadSourceID != null && dataItem.leadSourceID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID] = dataItem.leadSourceID;
}
if (dataItem.leadSourceCode != null && dataItem.leadSourceCode != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE] = dataItem.leadSourceCode;
}
if (dataItem.leadSourceName != null && dataItem.leadSourceName != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME] = dataItem.leadSourceName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION] = dataItem.description;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_LEADSOURCE_ISDELETED] = dataItem.isDeleted;
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

 id = await db.update(TablesBase.TABLE_LEADSOURCE, values,where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
// db.close(); // Remove this line; Dart manages the connection automatically

	}
	catch( ex)
	{
		Globals.handleException( "DatabaseHandler:UpdateLeadSourceRecord()", ex);
		throw ex;
	}
	return id;
}
 static Future<int> DeleteLeadSourceRecord(DatabaseHandler databaseHandler,  String id1) async{
	int id = 0;
	try
	{
		final db =await  databaseHandler.database;
		id =await  db.delete(TablesBase.TABLE_LEADSOURCE,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
		//db.close();
	}
	catch( ex)
	{
		Globals.handleException( "DatabaseHandler:DeleteLeadSourceRecord()", ex);
		throw ex;
	}
	return id;
}
  static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
		id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID}";
            selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

             final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
      }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "LeadSourceDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

		id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}" ;
            selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID} = $id";

             final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "LeadSourceDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

 static Future<List<LeadSource>> GetLeadSourceUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
	List<LeadSource> dataList = [];
	try
	{		
		 String selectQuery = "SELECT * FROM ${TablesBase.TABLE_LEADSOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
		if (changeType ==(AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
			selectQuery = "SELECT * FROM ${TablesBase.TABLE_LEADSOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
		} else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
			selectQuery = "SELECT * FROM ${TablesBase.TABLE_LEADSOURCE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
		}
		selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
		selectQuery += " AND ${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
			
		final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
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
		Globals.handleException( "LeadSourceDataHandlerBase:GetLeadSourceUpSyncRecords()", ex);
		throw ex;
	}
	return dataList;
}


	  static Future<LeadSource?> GetLeadSourceRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        LeadSource? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_LEADSOURCE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_LEADSOURCE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {

				LeadSource dataItem = new LeadSource();

        dataItem.leadSourceID = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID];
        dataItem.leadSourceCode = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE];
        dataItem.leadSourceName = element[ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME];
        dataItem.description = element[ColumnsBase.KEY_LEADSOURCE_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_LEADSOURCE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_LEADSOURCE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_LEADSOURCE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_LEADSOURCE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_LEADSOURCE_ISDELETED];
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
	    Globals.handleException( "LeadSourceDataHandlerBase:GetLeadSourceRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}