
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Form.dart';
import '../DataBaseHandler.dart';

class FormDataHandlerBase {

     static Future<List<Form>> GetFormRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<Form> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},G.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME},F.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_EMAILMANUALTEMPLATE} F ON A.${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} G ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Form_ColumnsBase.KEY_FORM_FORMNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
            Globals.handleException( "FormDataHandlerBase:GetFormRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Form>> GetFormRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<Form> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},G.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME},F.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_EMAILMANUALTEMPLATE} F ON A.${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} G ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORM_FORMNAME} COLLATE NOCASE ASC ";

             final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
            Globals.handleException( "FormDataHandlerBase:GetFormRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Form?> GetFormRecord(DatabaseHandler databaseHandler, String id)async {
        Form? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},G.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME},F.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_EMAILMANUALTEMPLATE} F ON A.${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} G ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
            Globals.handleException( "FormDataHandlerBase:GetFormRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Form?> GetMasterFormRecord(DatabaseHandler databaseHandler, String id) async{
        Form? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},G.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME},F.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_EMAILMANUALTEMPLATE} F ON A.${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} G ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FORM_FORMID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
            Globals.handleException( "FormDataHandlerBase:GetMasterFormRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddFormRecord(DatabaseHandler databaseHandler, Form dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.formID != null && dataItem.formID != "null") {
  values[ColumnsBase.KEY_FORM_FORMID] = dataItem.formID;
}
if (dataItem.formCode != null && dataItem.formCode != "null") {
  values[ColumnsBase.KEY_FORM_FORMCODE] = dataItem.formCode;
}
if (dataItem.formName != null && dataItem.formName != "null") {
  values[ColumnsBase.KEY_FORM_FORMNAME] = dataItem.formName;
}
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_FORM_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.formType != null && dataItem.formType != "null") {
  values[ColumnsBase.KEY_FORM_FORMTYPE] = dataItem.formType;
}
if (dataItem.linkTo != null && dataItem.linkTo != "null") {
  values[ColumnsBase.KEY_FORM_LINKTO] = dataItem.linkTo;
}
if (dataItem.forStatus != null && dataItem.forStatus != "null") {
  values[ColumnsBase.KEY_FORM_FORSTATUS] = dataItem.forStatus;
}
if (dataItem.sortOrder != null && dataItem.sortOrder != "null") {
  values[ColumnsBase.KEY_FORM_SORTORDER] = dataItem.sortOrder;
}
if (dataItem.isMandatory != null && dataItem.isMandatory != "null") {
  values[ColumnsBase.KEY_FORM_ISMANDATORY] = dataItem.isMandatory;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_FORM_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.pdfSize != null && dataItem.pdfSize != "null") {
  values[ColumnsBase.KEY_FORM_PDFSIZE] = dataItem.pdfSize;
}
if (dataItem.dataScriptWeb != null && dataItem.dataScriptWeb != "null") {
  values[ColumnsBase.KEY_FORM_DATASCRIPTWEB] = dataItem.dataScriptWeb;
}
if (dataItem.dataScriptApp != null && dataItem.dataScriptApp != "null") {
  values[ColumnsBase.KEY_FORM_DATASCRIPTAPP] = dataItem.dataScriptApp;
}
if (dataItem.parentFormID != null && dataItem.parentFormID != "null") {
  values[ColumnsBase.KEY_FORM_PARENTFORMID] = dataItem.parentFormID;
}
//if (dataItem.parentFormName != null && dataItem.parentFormName != "null")
//  values[ColumnsBase.KEY_FORM_PARENTFORMNAME] = dataItem.parentFormName;
if (dataItem.emailManualTemplateID != null && dataItem.emailManualTemplateID != "null") {
  values[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID] = dataItem.emailManualTemplateID;
}
if (dataItem.emailAutomatedTemplateID != null && dataItem.emailAutomatedTemplateID != "null") {
  values[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID] = dataItem.emailAutomatedTemplateID;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_FORM_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_FORM_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_FORM_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_FORM_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_FORM_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_FORM_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_FORM_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_FORM_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_FORM_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_FORM_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_FORM, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddFormRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateFormRecord(DatabaseHandler databaseHandler,  String id1, Form dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};
if (dataItem.formID != null && dataItem.formID != "null") {
  values[ColumnsBase.KEY_FORM_FORMID] = dataItem.formID;
}
if (dataItem.formCode != null && dataItem.formCode != "null") {
  values[ColumnsBase.KEY_FORM_FORMCODE] = dataItem.formCode;
}
if (dataItem.formName != null && dataItem.formName != "null") {
  values[ColumnsBase.KEY_FORM_FORMNAME] = dataItem.formName;
}
if (dataItem.businessFeatureID != null && dataItem.businessFeatureID != "null") {
  values[ColumnsBase.KEY_FORM_BUSINESSFEATUREID] = dataItem.businessFeatureID;
}
if (dataItem.formType != null && dataItem.formType != "null") {
  values[ColumnsBase.KEY_FORM_FORMTYPE] = dataItem.formType;
}
if (dataItem.linkTo != null && dataItem.linkTo != "null") {
  values[ColumnsBase.KEY_FORM_LINKTO] = dataItem.linkTo;
}
if (dataItem.forStatus != null && dataItem.forStatus != "null") {
  values[ColumnsBase.KEY_FORM_FORSTATUS] = dataItem.forStatus;
}
if (dataItem.sortOrder != null && dataItem.sortOrder != "null") {
  values[ColumnsBase.KEY_FORM_SORTORDER] = dataItem.sortOrder;
}
if (dataItem.isMandatory != null && dataItem.isMandatory != "null") {
  values[ColumnsBase.KEY_FORM_ISMANDATORY] = dataItem.isMandatory;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_FORM_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.pdfSize != null && dataItem.pdfSize != "null") {
  values[ColumnsBase.KEY_FORM_PDFSIZE] = dataItem.pdfSize;
}
if (dataItem.dataScriptWeb != null && dataItem.dataScriptWeb != "null") {
  values[ColumnsBase.KEY_FORM_DATASCRIPTWEB] = dataItem.dataScriptWeb;
}
if (dataItem.dataScriptApp != null && dataItem.dataScriptApp != "null") {
  values[ColumnsBase.KEY_FORM_DATASCRIPTAPP] = dataItem.dataScriptApp;
}
if (dataItem.parentFormID != null && dataItem.parentFormID != "null") {
  values[ColumnsBase.KEY_FORM_PARENTFORMID] = dataItem.parentFormID;
}
//if (dataItem.parentFormName != null && dataItem.parentFormName != "null")
//  values[ColumnsBase.KEY_FORM_PARENTFORMNAME] = dataItem.parentFormName;
if (dataItem.emailManualTemplateID != null && dataItem.emailManualTemplateID != "null") {
  values[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID] = dataItem.emailManualTemplateID;
}
if (dataItem.emailAutomatedTemplateID != null && dataItem.emailAutomatedTemplateID != "null") {
  values[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID] = dataItem.emailAutomatedTemplateID;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_FORM_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_FORM_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_FORM_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_FORM_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_FORM_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_FORM_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_FORM_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_FORM_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_FORM_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_FORM_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_FORM, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateFormRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteFormRecord(DatabaseHandler databaseHandler, String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_FORM, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteFormRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_FORM_FORMID}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_FORM_FORMID].toString();
            }
         
        } catch ( ex) {
            Globals.handleException( "FormDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FORM_FORMID} = $id";

            final db = await  databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FormDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Form>> GetFormUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<Form> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FORM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
            Globals.handleException( "FormDataHandlerBase:GetFormUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<Form?> GetFormRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        Form? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},G.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME},F.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME}";
		selectQuery += " FROM ${TablesBase.TABLE_FORM} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_EMAILMANUALTEMPLATE} F ON A.${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} = F.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} G ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = G.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_FORM_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_FORM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

for (var element in result) {
  Form dataItem = Form();

  dataItem.formID = element[ColumnsBase.KEY_FORM_FORMID];
  dataItem.formCode = element[ColumnsBase.KEY_FORM_FORMCODE];
  dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
  dataItem.businessFeatureID = element[ColumnsBase.KEY_FORM_BUSINESSFEATUREID];
  dataItem.formType = element[ColumnsBase.KEY_FORM_FORMTYPE];
  dataItem.linkTo = element[ColumnsBase.KEY_FORM_LINKTO];
  dataItem.forStatus = element[ColumnsBase.KEY_FORM_FORSTATUS];
  dataItem.sortOrder = element[ColumnsBase.KEY_FORM_SORTORDER];
  dataItem.isMandatory = element[ColumnsBase.KEY_FORM_ISMANDATORY];
  dataItem.displayInApp = element[ColumnsBase.KEY_FORM_DISPLAYINAPP];
  dataItem.pdfSize = element[ColumnsBase.KEY_FORM_PDFSIZE];
  dataItem.dataScriptWeb = element[ColumnsBase.KEY_FORM_DATASCRIPTWEB];
  dataItem.dataScriptApp = element[ColumnsBase.KEY_FORM_DATASCRIPTAPP];
  dataItem.parentFormID = element[ColumnsBase.KEY_FORM_PARENTFORMID];
  dataItem.emailManualTemplateID = element[ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID];
  dataItem.emailAutomatedTemplateID = element[ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID];
  dataItem.createdOn = element[ColumnsBase.KEY_FORM_CREATEDON];
  dataItem.createdBy = element[ColumnsBase.KEY_FORM_CREATEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_FORM_MODIFIEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_FORM_MODIFIEDBY];
  dataItem.isActive = element[ColumnsBase.KEY_FORM_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_FORM_UID];
  dataItem.appUserID = element[ColumnsBase.KEY_FORM_APPUSERID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_FORM_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_FORM_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_FORM_ISDELETED];

  dataItem.businessFeatureName = element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
  dataItem.parentFormName = element[ColumnsBase.KEY_FORM_PARENTFORMNAME];
  dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
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
	    Globals.handleException( "FormDataHandlerBase:GetFormRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}