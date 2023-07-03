

import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Tag.dart';
import '../DataBaseHandler.dart';

 class TagDataHandlerBase {

     static Future<List<Tag>> GetTagRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<Tag> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAG_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAG_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_TAG_TAGNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Tag_Columns.KEY_TAG_TAGNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


           
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];



            dataList.add(dataItem);

            }
            
        
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetTagRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Tag>> GetTagRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<Tag> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAG_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAG_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND E.${ColumnsBase.KEY_TAGGROUP_LINKTO} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_TAG_TAGNAME} COLLATE NOCASE ASC ";

       
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];



            dataList.add(dataItem);

            }
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetTagRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Tag?> GetTagRecord(DatabaseHandler databaseHandler,  String id)async {
        Tag? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];




            }
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetTagRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Tag?> GetMasterTagRecord(DatabaseHandler databaseHandler,  String id)async {
        Tag? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_TAG_TAGID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];




            }
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetMasterTagRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddTagRecord(DatabaseHandler databaseHandler,  Tag dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.tagID != null && dataItem.tagID != "null") {
  values[ColumnsBase.KEY_TAG_TAGID] = dataItem.tagID;
}
if (dataItem.tagCode != null && dataItem.tagCode != "null") {
  values[ColumnsBase.KEY_TAG_TAGCODE] = dataItem.tagCode;
}
if (dataItem.tagName != null && dataItem.tagName != "null") {
  values[ColumnsBase.KEY_TAG_TAGNAME] = dataItem.tagName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_TAG_DESCRIPTION] = dataItem.description;
}
if (dataItem.parentTagID != null && dataItem.parentTagID != "null") {
  values[ColumnsBase.KEY_TAG_PARENTTAGID] = dataItem.parentTagID;
}
// Uncomment the following lines if needed
// if (dataItem.parentTagName != null && dataItem.parentTagName != "null") {
//   values[ColumnsBase.KEY_TAG_PARENTTAGNAME] = dataItem.parentTagName;
// }
if (dataItem.tagGroupID != null && dataItem.tagGroupID != "null") {
  values[ColumnsBase.KEY_TAG_TAGGROUPID] = dataItem.tagGroupID;
}
if (dataItem.sortOrder != null && dataItem.sortOrder != "null") {
  values[ColumnsBase.KEY_TAG_SORTORDER] = dataItem.sortOrder;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_TAG_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_TAG_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_TAG_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_TAG_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_TAG_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_TAG_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_TAG_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_TAG_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_TAG_ISDELETED] = dataItem.isDeleted;
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

            id = await db.insert(TablesBase.TABLE_TAG, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddTagRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateTagRecord(DatabaseHandler databaseHandler,  String id1, Tag dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.tagID != null && dataItem.tagID != "null") {
  values[ColumnsBase.KEY_TAG_TAGID] = dataItem.tagID;
}
if (dataItem.tagCode != null && dataItem.tagCode != "null") {
  values[ColumnsBase.KEY_TAG_TAGCODE] = dataItem.tagCode;
}
if (dataItem.tagName != null && dataItem.tagName != "null") {
  values[ColumnsBase.KEY_TAG_TAGNAME] = dataItem.tagName;
}
if (dataItem.description != null && dataItem.description != "null") {
  values[ColumnsBase.KEY_TAG_DESCRIPTION] = dataItem.description;
}
if (dataItem.parentTagID != null && dataItem.parentTagID != "null") {
  values[ColumnsBase.KEY_TAG_PARENTTAGID] = dataItem.parentTagID;
}
// Uncomment the following lines if needed
// if (dataItem.parentTagName != null && dataItem.parentTagName != "null") {
//   values[ColumnsBase.KEY_TAG_PARENTTAGNAME] = dataItem.parentTagName;
// }
if (dataItem.tagGroupID != null && dataItem.tagGroupID != "null") {
  values[ColumnsBase.KEY_TAG_TAGGROUPID] = dataItem.tagGroupID;
}
if (dataItem.sortOrder != null && dataItem.sortOrder != "null") {
  values[ColumnsBase.KEY_TAG_SORTORDER] = dataItem.sortOrder;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_TAG_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_TAG_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_TAG_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_TAG_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_TAG_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_TAG_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_TAG_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_TAG_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_TAG_ISDELETED] = dataItem.isDeleted;
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
          if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {

            values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
          }

            id =  await db.update(TablesBase.TABLE_TAG, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateTagRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteTagRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_TAG,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteTagRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_TAG_TAGID}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> data = await db.rawQuery(selectQuery, null);


             if (data.isNotEmpty) {
      serverId = data.first[ColumnsBase.KEY_TAG_TAGID].toString();
    }

            
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_TAG} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_TAG_TAGID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> data = await db.rawQuery(selectQuery, null);

            if (data.isNotEmpty) {

      localId = data.first[ColumnsBase.KEY_ID].toString();

    }
           
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Tag>> GetTagUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<Tag> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_TAG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_TAG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_TAG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_TAG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];



            dataList.add(dataItem);

            }
        } catch ( ex) {
            Globals.handleException( "TagDataHandlerBase:GetTagUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<Tag?> GetTagRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        Tag? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,D.${ColumnsBase.KEY_TAG_TAGNAME} AS ${ColumnsBase.KEY_TAG_PARENTTAGNAME},E.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME}";
		selectQuery += " FROM ${TablesBase.TABLE_TAG} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAG} D ON A.${ColumnsBase.KEY_TAG_PARENTTAGID} = D.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_TAGGROUP} E ON A.${ColumnsBase.KEY_TAG_TAGGROUPID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_TAG_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_TAG_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
 final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var ele in result){

                    Tag dataItem = new Tag();
                    dataItem.tagID = ele[ColumnsBase.KEY_TAG_TAGID];
                    dataItem.tagCode = ele[ColumnsBase.KEY_TAG_TAGCODE];
                    dataItem.tagName = ele[ColumnsBase.KEY_TAG_TAGNAME];
                    dataItem.description  = ele[ColumnsBase.KEY_TAG_DESCRIPTION];
                    dataItem.parentTagID = ele[ColumnsBase.KEY_TAG_PARENTTAGID];
                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupID = ele[ColumnsBase.KEY_TAG_TAGGROUPID];
                    dataItem.sortOrder = ele[ColumnsBase.KEY_TAG_SORTORDER];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TAG_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TAG_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TAG_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TAG_MODIFIEDON];
                    dataItem.deviceIdentifier = ele[ColumnsBase.KEY_TAG_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = ele[ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER];
                    dataItem.isActive = ele[ColumnsBase.KEY_TAG_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_TAG_UID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TAG_APPUSERID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAG_APPUSERGROUPID];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TAG_ISDELETED];

                    dataItem.parentTagName = ele[ColumnsBase.KEY_TAG_PARENTTAGNAME];
                    dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
                    dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage =
            ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage =
            ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn =
            ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser =
            ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser =
            ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID =
            ele[ColumnsBase.KEY_OWNERUSERID];




            }
        }
        catch( ex)
        {
	    Globals.handleException( "TagDataHandlerBase:GetTagRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}