
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormCell.dart';
import '../DataBaseHandler.dart';
import 'FormCellDataHandlerBase.dart';

 class FormCellDataHandler extends FormCellDataHandlerBase {

     static Future<List<FormCell>> GetFormCellRecordsByFormId(DatabaseHandler databaseHandler, String formId) async{
        List<FormCell> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND D.${ColumnsBase.KEY_FORMSECTION_FORMID} = ${formId == ("") ? "-1" : formId}";
            selectQuery += " ORDER BY D.${ColumnsBase.KEY_FORMSECTION_SECTIONORDER}, A.${ColumnsBase.KEY_FORMCELL_ROWINDEX}";

            

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

     static Future<List<FormCell>> GetFormCellRecordsByFormSectionId(DatabaseHandler databaseHandler, String formSectionId) async{
        List<FormCell> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME;
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMSECTION} D ON A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELL_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = ${formSectionId == ("") ? "-1" : formSectionId}";
            selectQuery += " ORDER BY D.${ColumnsBase.KEY_FORMSECTION_SECTIONORDER}, A.${ColumnsBase.KEY_FORMCELL_ROWINDEX}";

            

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FormCellDataHandlerBase:GetFormCellRecords()", ex);
            throw ex;
        }
        return dataList;
    }
	/*-------------------HAPPSALES-------------------*/

}