

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Form.dart';
import '../DataBaseHandler.dart';
import 'FormDataHandlerBase.dart';

 class FormDataHandler extends FormDataHandlerBase {


     static Future<List<Form>> GetFormRecordsForFormType(DatabaseHandler databaseHandler,  String formType) async {
        List<Form> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} E ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMTYPE} = '$formType'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORM_SORTORDER} ASC ";

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
            Globals.handleException( "FormDataHandlerBase:GetFormRecordsForFormType()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<Form>> GetFormRecordsForBusinessFeatureAndFormType(DatabaseHandler databaseHandler,  String businessFeatureName, String formType,String searchString) async{
        List<Form> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} E ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} = '$businessFeatureName'";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMTYPE} = '$formType'";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMNAME} LIKE '%$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORM_SORTORDER} ASC ";



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

     static Future<List<Form>> GetFormRecordsForBusinessFeatureAndFormType2(DatabaseHandler databaseHandler,  String formType,String searchString) async{
        List<Form> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_FORM_FORMNAME} AS ${ColumnsBase.KEY_FORM_PARENTFORMNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORM} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} E ON A.${ColumnsBase.KEY_FORM_PARENTFORMID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORM_ISARCHIVED},'false')) = 'false' ";
            //selectQuery += " AND D." + ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME + " = '" + businessFeatureName + "'";
            selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMTYPE} = '$formType'";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_FORM_FORMNAME} LIKE '%$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORM_SORTORDER} ASC ";

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


    /*-------------------HAPPSALES-------------------*/

}