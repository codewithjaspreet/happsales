

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormSection.dart';
import '../DataBaseHandler.dart';
import 'FormSectionDataHandlerBase.dart';

class FormSectionDataHandler extends FormSectionDataHandlerBase {

     static Future<List<FormSection>> GetFormSectionRecordsByFormId(DatabaseHandler databaseHandler, String formId)async {
        List<FormSection> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORM_FORMNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMSECTION} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORM} D ON A.${ColumnsBase.KEY_FORMSECTION_FORMID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMSECTION_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMSECTION_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMSECTION_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMSECTION_FORMID} = ${formId == ("") ? "-1" : formId}";
            selectQuery += " ORDER BY CAST(A.${ColumnsBase.KEY_FORMSECTION_SECTIONORDER} AS INTEGER)";

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
            Globals.handleException( "FormSectionDataHandlerBase:GetFormSectionRecords()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}