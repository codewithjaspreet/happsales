
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormCell.dart';
import '../DataBaseHandler.dart';

class FormCellDataHandlerBase {

     static Future<List<FormCell>> GetFormCellRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<FormCell> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += "${" FROM " + TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_FormCell_Columns.KEY_FORMCELL_FORMCELLNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();


          final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
            Globals.handleException( "FormCellDataHandlerBase:GetFormCellRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FormCell>> GetFormCellRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<FormCell> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME} COLLATE NOCASE ASC ";

              final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
            Globals.handleException( "FormCellDataHandlerBase:GetFormCellRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<FormCell?> GetFormCellRecord(DatabaseHandler databaseHandler,  String id) async{
        FormCell ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FormCellDataHandlerBase:GetFormCellRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<FormCell?>  GetMasterFormCellRecord(DatabaseHandler databaseHandler,  String id)async {
        FormCell ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FORMCELL_FORMCELLID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
            Globals.handleException( "FormCellDataHandlerBase:GetMasterFormCellRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddFormCellRecord(DatabaseHandler databaseHandler,  FormCell dataItem) async{
        int id = 0;
        try {
                     final db = await databaseHandler.database;

            Map<String, dynamic> values = {};

if (dataItem.formCellID != null && dataItem.formCellID != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLID] = dataItem.formCellID;
if (dataItem.formCellCode != null && dataItem.formCellCode != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLCODE] = dataItem.formCellCode;
if (dataItem.formCellName != null && dataItem.formCellName != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLNAME] = dataItem.formCellName;
if (dataItem.formSectionID != null && dataItem.formSectionID != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMSECTIONID] = dataItem.formSectionID;
if (dataItem.rowIndex != null && dataItem.rowIndex != "null")
  values[ColumnsBase.KEY_FORMCELL_ROWINDEX] = dataItem.rowIndex;
if (dataItem.columnIndex != null && dataItem.columnIndex != "null")
  values[ColumnsBase.KEY_FORMCELL_COLUMNINDEX] = dataItem.columnIndex;
if (dataItem.rowSpan != null && dataItem.rowSpan != "null")
  values[ColumnsBase.KEY_FORMCELL_ROWSPAN] = dataItem.rowSpan;
if (dataItem.columnSpan != null && dataItem.columnSpan != "null")
  values[ColumnsBase.KEY_FORMCELL_COLUMNSPAN] = dataItem.columnSpan;
if (dataItem.alignment != null && dataItem.alignment != "null")
  values[ColumnsBase.KEY_FORMCELL_ALIGNMENT] = dataItem.alignment;
if (dataItem.verticalAlignment != null && dataItem.verticalAlignment != "null")
  values[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT] = dataItem.verticalAlignment;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_FORMCELL_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_FORMCELL_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_FORMCELL_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_FORMCELL_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_FORMCELL_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_FORMCELL_UID] = dataItem.uid;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_FORMCELL_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_FORMCELL_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_FORMCELL_ISDELETED] = dataItem.isDeleted;
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



            id =await db.insert(TablesBase.TABLE_FORMCELL, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddFormCellRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateFormCellRecord(DatabaseHandler databaseHandler,  String id1, FormCell dataItem) async{
        int id = 0;
        try {
           final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.formCellID != null && dataItem.formCellID != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLID] = dataItem.formCellID;
if (dataItem.formCellCode != null && dataItem.formCellCode != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLCODE] = dataItem.formCellCode;
if (dataItem.formCellName != null && dataItem.formCellName != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMCELLNAME] = dataItem.formCellName;
if (dataItem.formSectionID != null && dataItem.formSectionID != "null")
  values[ColumnsBase.KEY_FORMCELL_FORMSECTIONID] = dataItem.formSectionID;
if (dataItem.rowIndex != null && dataItem.rowIndex != "null")
  values[ColumnsBase.KEY_FORMCELL_ROWINDEX] = dataItem.rowIndex;
if (dataItem.columnIndex != null && dataItem.columnIndex != "null")
  values[ColumnsBase.KEY_FORMCELL_COLUMNINDEX] = dataItem.columnIndex;
if (dataItem.rowSpan != null && dataItem.rowSpan != "null")
  values[ColumnsBase.KEY_FORMCELL_ROWSPAN] = dataItem.rowSpan;
if (dataItem.columnSpan != null && dataItem.columnSpan != "null")
  values[ColumnsBase.KEY_FORMCELL_COLUMNSPAN] = dataItem.columnSpan;
if (dataItem.alignment != null && dataItem.alignment != "null")
  values[ColumnsBase.KEY_FORMCELL_ALIGNMENT] = dataItem.alignment;
if (dataItem.verticalAlignment != null && dataItem.verticalAlignment != "null")
  values[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT] = dataItem.verticalAlignment;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_FORMCELL_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_FORMCELL_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_FORMCELL_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_FORMCELL_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_FORMCELL_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_FORMCELL_UID] = dataItem.uid;
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null")
  values[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_FORMCELL_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_FORMCELL_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_FORMCELL_ISDELETED] = dataItem.isDeleted;
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

  if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null"){

    values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
  }

            id = await db.update(TablesBase.TABLE_FORMCELL, values,  where : "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateFormCellRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteFormCellRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =await  databaseHandler.database;
            id =await db.delete(TablesBase.TABLE_FORMCELL, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteFormCellRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_FORMCELL_FORMCELLID}";
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_FORMCELL_FORMCELLID];
      }
        } catch ( ex) {
            Globals.handleException( "FormCellDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FORMCELL_FORMCELLID} = $id";

           
            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0]
            [ColumnsBase.KEY_ID];
      }
        } catch ( ex) {
            Globals.handleException( "FormCellDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<FormCell>> GetFormCellUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<FormCell> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORMCELL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORMCELL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORMCELL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
            Globals.handleException( "FormCellDataHandlerBase:GetFormCellUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<FormCell?>  GetFormCellRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        FormCell? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
		selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_FORMCELL_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_FORMCELL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

         for (var element in list) {
                    FormCell dataItem = new FormCell();
                    dataItem.formCellID = element[ColumnsBase.KEY_FORMCELL_FORMCELLID];
                    dataItem.formCellCode = element[ColumnsBase.KEY_FORMCELL_FORMCELLCODE];
                    dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
                    dataItem.formSectionID = element[ColumnsBase.KEY_FORMCELL_FORMSECTIONID];
                    dataItem.rowIndex = element[ColumnsBase.KEY_FORMCELL_ROWINDEX];
                    dataItem.columnIndex = element[ColumnsBase.KEY_FORMCELL_COLUMNINDEX];
                    dataItem.columnSpan = element[ColumnsBase.KEY_FORMCELL_COLUMNSPAN];

                    dataItem.rowSpan = element[ColumnsBase.KEY_FORMCELL_ROWSPAN];

                    dataItem.alignment = element[ColumnsBase.KEY_FORMCELL_ALIGNMENT];

                    dataItem.verticalAlignment = element[ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT];

                    dataItem.createdOn = element[ColumnsBase.KEY_FORMCELL_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_FORMCELL_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_FORMCELL_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_FORMCELL_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_FORMCELL_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELL_ISDELETED];

                    dataItem.isArchived = element[ColumnsBase.KEY_FORMCELL_ISARCHIVED];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMCELL_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FORMCELL_APPUSERID];

                    dataItem.uid = element[ColumnsBase.KEY_FORMCELL_UID];

                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER];

                    dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];

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
	    Globals.handleException( "FormCellDataHandlerBase:GetFormCellRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}