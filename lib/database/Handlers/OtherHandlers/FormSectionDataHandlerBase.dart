
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormSection.dart';
import '../DataBaseHandler.dart';

class FormSectionDataHandlerBase {

     static Future<List<FormSection>> GetFormSectionRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<FormSection> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_FORM + " D ON A." + ColumnsBase.KEY_FORMSECTION_FORMID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME + " LIKE '%" + searchString + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_FormSection_Columns.KEY_FORMSECTION_FORMSECTIONNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();


            
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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
        // 
  // Add the dataItem to your desired collection or perform any further operations
}

            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FormSection>> GetFormSectionRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<FormSection> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_FORM + " D ON A." + ColumnsBase.KEY_FORMSECTION_FORMID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_FORMSECTION_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME + " LIKE '" + searchString + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME + " COLLATE NOCASE ASC ";

                
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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
        // 
  // Add the dataItem to your desired collection or perform any further operations
}
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<FormSection?> GetFormSectionRecord(DatabaseHandler databaseHandler,  String id) async{
        FormSection? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_FORM + " D ON A." + ColumnsBase.KEY_FORMSECTION_FORMID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

                
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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


        // 
  // Add the dataItem to your desired collection or perform any further operations
}
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<FormSection?> GetMasterFormSectionRecord(DatabaseHandler databaseHandler,  String id)async {
        FormSection? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_FORM + " D ON A." + ColumnsBase.KEY_FORMSECTION_FORMID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
     
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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


        // 
  // Add the dataItem to your desired collection or perform any further operations
}
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetMasterFormSectionRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddFormSectionRecord(DatabaseHandler databaseHandler,  FormSection dataItem)async {
        int id = 0;
        try {

          final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.formSectionID != null && dataItem.formSectionID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID] = dataItem.formSectionID;
}
if (dataItem.formSectionCode != null && dataItem.formSectionCode != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE] = dataItem.formSectionCode;
}
if (dataItem.formSectionName != null && dataItem.formSectionName != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME] = dataItem.formSectionName;
}
if (dataItem.formID != null && dataItem.formID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMID] = dataItem.formID;
}
if (dataItem.numberOfRows != null && dataItem.numberOfRows != "null") {
  values[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS] = dataItem.numberOfRows;
}
if (dataItem.numberOfColumns != null && dataItem.numberOfColumns != "null") {
  values[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS] = dataItem.numberOfColumns;
}
if (dataItem.columnWidths != null && dataItem.columnWidths != "null") {
  values[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS] = dataItem.columnWidths;
}
if (dataItem.sectionStyle != null && dataItem.sectionStyle != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE] = dataItem.sectionStyle;
}
if (dataItem.sectionType != null && dataItem.sectionType != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE] = dataItem.sectionType;
}
if (dataItem.sectionOrder != null && dataItem.sectionOrder != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONORDER] = dataItem.sectionOrder;
}
if (dataItem.backgroundColor != null && dataItem.backgroundColor != "null") {
  values[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR] = dataItem.backgroundColor;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.displayInReport != null && dataItem.displayInReport != "null") {
  values[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT] = dataItem.displayInReport;
}
if (dataItem.isRepeatable != null && dataItem.isRepeatable != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE] = dataItem.isRepeatable;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_FORMSECTION_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_FORMSECTION_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_FORMSECTION_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_FORMSECTION_UID] = dataItem.uid;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISDELETED] = dataItem.isDeleted;
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
            values[ColumnsBase.KEY_ISACTIVE ] =  "true";
            values[ColumnsBase.KEY_ISDELETED ] = "false";

            id = await db.insert(TablesBase.TABLE_FORMSECTION, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddFormSectionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateFormSectionRecord(DatabaseHandler databaseHandler,  String id1, FormSection dataItem) async{
        int id = 0;
        try {
            final db =await  databaseHandler.database;
          Map<String, dynamic> values = {};

if (dataItem.formSectionID != null && dataItem.formSectionID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID] = dataItem.formSectionID;
}
if (dataItem.formSectionCode != null && dataItem.formSectionCode != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE] = dataItem.formSectionCode;
}
if (dataItem.formSectionName != null && dataItem.formSectionName != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME] = dataItem.formSectionName;
}
if (dataItem.formID != null && dataItem.formID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_FORMID] = dataItem.formID;
}
if (dataItem.numberOfRows != null && dataItem.numberOfRows != "null") {
  values[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS] = dataItem.numberOfRows;
}
if (dataItem.numberOfColumns != null && dataItem.numberOfColumns != "null") {
  values[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS] = dataItem.numberOfColumns;
}
if (dataItem.columnWidths != null && dataItem.columnWidths != "null") {
  values[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS] = dataItem.columnWidths;
}
if (dataItem.sectionStyle != null && dataItem.sectionStyle != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE] = dataItem.sectionStyle;
}
if (dataItem.sectionType != null && dataItem.sectionType != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE] = dataItem.sectionType;
}
if (dataItem.sectionOrder != null && dataItem.sectionOrder != "null") {
  values[ColumnsBase.KEY_FORMSECTION_SECTIONORDER] = dataItem.sectionOrder;
}
if (dataItem.backgroundColor != null && dataItem.backgroundColor != "null") {
  values[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR] = dataItem.backgroundColor;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.displayInReport != null && dataItem.displayInReport != "null") {
  values[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT] = dataItem.displayInReport;
}
if (dataItem.isRepeatable != null && dataItem.isRepeatable != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE] = dataItem.isRepeatable;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_FORMSECTION_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_FORMSECTION_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_FORMSECTION_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_FORMSECTION_UID] = dataItem.uid;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_FORMSECTION_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_FORMSECTION, values, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);



            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateFormSectionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteFormSectionRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_FORMSECTION, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteFormSectionRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONID;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

 final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
      }
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONID + " = " + id;



 final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
            
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<FormSection>> GetFormSectionUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<FormSection> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_FORMSECTION + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_FORMSECTION + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_FORMSECTION + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

              
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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
        // 
  // Add the dataItem to your desired collection or perform any further operations
}
        } catch ( ex) {
            Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<FormSection?> GetFormSectionRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        FormSection? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
		selectQuery += " FROM " + TablesBase.TABLE_FORMSECTION + " A "; 
		selectQuery += " LEFT JOIN " + TablesBase.TABLE_FORM + " D ON A." + ColumnsBase.KEY_FORMSECTION_FORMID + " = D." + ColumnsBase.KEY_ID;
			selectQuery += " WHERE A."  + ColumnsBase.KEY_FORMSECTION_UID + " = '" + uid + "'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

                
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
for (var element in list) {
  FormSection dataItem = FormSection();

  dataItem.formSectionID = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONID];
  dataItem.formSectionCode = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE];
  dataItem.formSectionName = element[ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME];
  dataItem.formID = element[ColumnsBase.KEY_FORMSECTION_FORMID];
  dataItem.numberOfRows = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS];
  dataItem.numberOfColumns = element[ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS];
  dataItem.columnWidths = element[ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS];
  dataItem.sectionStyle = element[ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE];
  dataItem.sectionType = element[ColumnsBase.KEY_FORMSECTION_SECTIONTYPE];
  dataItem.sectionOrder = element[ColumnsBase.KEY_FORMSECTION_SECTIONORDER];
  dataItem.backgroundColor = element[ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP];
  dataItem.displayInReport = element[ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT];
  dataItem.isRepeatable = element[ColumnsBase.KEY_FORMSECTION_ISREPEATABLE];
  dataItem.createdOn = element[ColumnsBase.KEY_FORMSECTION_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORMSECTION_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORMSECTION_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORMSECTION_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORMSECTION_UID];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER];
  dataItem.appUserID = element[ColumnsBase.KEY_FORMSECTION_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORMSECTION_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORMSECTION_ISDELETED];

  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
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




        // 
  // Add the dataItem to your desired collection or perform any further operations
}
        }
        catch( ex)
        {
	    Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}