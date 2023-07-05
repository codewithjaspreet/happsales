
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormCellElement.dart';
import '../DataBaseHandler.dart';
import 'FormCellElementDataHandlerBase.dart';

class FormCellElementDataHandler extends FormCellElementDataHandlerBase {

     static Future<List<FormCellElement>> GetFormCellElementRecordsByFormId(DatabaseHandler databaseHandler,  String formId)async {
        List<FormCellElement> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELLELEMENT} A ";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMCELL} E ON A.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMSECTION} F ON E.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND F.${ColumnsBase.KEY_FORMSECTION_FORMID} = ${formId == ("") ? "-1" : formId}";
            selectQuery += " ORDER BY D.${ColumnsBase.KEY_FORMSECTION_SECTIONORDER}, A.${ColumnsBase.KEY_FORMCELL_ROWINDEX}";

         final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        FormCellElement dataItem = FormCellElement();

        dataItem.formCellElementID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID];
        dataItem.formCellElementCode =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE];
        dataItem.formCellElementName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];
        dataItem.formCellID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID];
        dataItem.controlName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME];
        dataItem.controlType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE];
        dataItem.controlLabel =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL];
        dataItem.checkBoxLabelPosition =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION];
        dataItem.controlValues =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES];
        dataItem.defaultValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE];
        dataItem.height = element[ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT];
        dataItem.width = element[ColumnsBase.KEY_FORMCELLELEMENT_WIDTH];
        dataItem.isRequired =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED];
        dataItem.isPlaceHolder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER];
        dataItem.placeHolderWidth =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH];
        dataItem.displayInApp =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP];
        dataItem.displayInReport =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT];
        dataItem.horizontalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT];
        dataItem.verticalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT];
        dataItem.fontSize = element[ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE];
        dataItem.fontWeight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT];
        dataItem.foreColor = element[ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR];
        dataItem.backgroundColor =
            element[ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR];
        dataItem.sequentialOrder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER];
        dataItem.startOnNewLine =
            element[ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE];
        dataItem.lineBreakAfter =
            element[ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER];
        dataItem.paddingLeft =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT];
        dataItem.paddingRight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT];
        dataItem.needAutoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER];
        dataItem.autoNumberPrefix =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX];
        dataItem.autoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER];
        dataItem.isDisabled =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED];
        dataItem.attributeID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID];
        dataItem.canTriggerEvent =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT];
        dataItem.dataScriptApp1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1];
        dataItem.dataScriptApp2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2];
        dataItem.dataScriptWeb1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1];
        dataItem.dataScriptWeb2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2];
        dataItem.eventClassName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME];
        dataItem.isTotalValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE];
        dataItem.signatureType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE];
        dataItem.createdOn = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_FORMCELLELEMENT_UID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED];

        dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];

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

        // Add dataItem to your desired collection or perform further operations

        dataList.add(dataItem);
      }
        } catch ( ex) {
            Globals.handleException( "FormCellElementDataHandlerBase:GetFormCellElementRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FormCellElement>> GetFormCellElementRecordsByFormCellId(DatabaseHandler databaseHandler,   String formCellId)async {
        List<FormCellElement> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELLELEMENT} A ";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMCELL} E ON A.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELL_FORMCELLID} = ${formCellId == ("") ? "-1" : formCellId}";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER}" ;

          final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        FormCellElement dataItem = FormCellElement();

        dataItem.formCellElementID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID];
        dataItem.formCellElementCode =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE];
        dataItem.formCellElementName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];
        dataItem.formCellID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID];
        dataItem.controlName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME];
        dataItem.controlType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE];
        dataItem.controlLabel =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL];
        dataItem.checkBoxLabelPosition =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION];
        dataItem.controlValues =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES];
        dataItem.defaultValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE];
        dataItem.height = element[ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT];
        dataItem.width = element[ColumnsBase.KEY_FORMCELLELEMENT_WIDTH];
        dataItem.isRequired =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED];
        dataItem.isPlaceHolder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER];
        dataItem.placeHolderWidth =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH];
        dataItem.displayInApp =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP];
        dataItem.displayInReport =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT];
        dataItem.horizontalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT];
        dataItem.verticalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT];
        dataItem.fontSize = element[ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE];
        dataItem.fontWeight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT];
        dataItem.foreColor = element[ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR];
        dataItem.backgroundColor =
            element[ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR];
        dataItem.sequentialOrder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER];
        dataItem.startOnNewLine =
            element[ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE];
        dataItem.lineBreakAfter =
            element[ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER];
        dataItem.paddingLeft =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT];
        dataItem.paddingRight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT];
        dataItem.needAutoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER];
        dataItem.autoNumberPrefix =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX];
        dataItem.autoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER];
        dataItem.isDisabled =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED];
        dataItem.attributeID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID];
        dataItem.canTriggerEvent =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT];
        dataItem.dataScriptApp1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1];
        dataItem.dataScriptApp2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2];
        dataItem.dataScriptWeb1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1];
        dataItem.dataScriptWeb2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2];
        dataItem.eventClassName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME];
        dataItem.isTotalValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE];
        dataItem.signatureType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE];
        dataItem.createdOn = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_FORMCELLELEMENT_UID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED];

        dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];

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

        // Add dataItem to your desired collection or perform further operations

        dataList.add(dataItem);
      }
        } catch ( ex) {
            Globals.handleException( "FormCellElementDataHandlerBase:GetFormCellElementRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FormCellElement>> GetFormCellElementTotalValueRecords(DatabaseHandler databaseHandler, String formIds)async {
        List<FormCellElement> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_FORMCELL_FORMCELLNAME},D.${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME}";
            selectQuery += " FROM ${TablesBase.TABLE_FORMCELLELEMENT} A ";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMCELL} E ON A.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " INNER JOIN ${TablesBase.TABLE_FORMSECTION} S ON E.${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} = S.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ATTRIBUTE} D ON A.${ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND S.${ColumnsBase.KEY_FORMSECTION_FORMID} IN ($formIds)";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE},'false') = 'true' ";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER}" ;
final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        FormCellElement dataItem = FormCellElement();

        dataItem.formCellElementID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID];
        dataItem.formCellElementCode =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE];
        dataItem.formCellElementName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];
        dataItem.formCellID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID];
        dataItem.controlName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME];
        dataItem.controlType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE];
        dataItem.controlLabel =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL];
        dataItem.checkBoxLabelPosition =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION];
        dataItem.controlValues =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES];
        dataItem.defaultValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE];
        dataItem.height = element[ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT];
        dataItem.width = element[ColumnsBase.KEY_FORMCELLELEMENT_WIDTH];
        dataItem.isRequired =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED];
        dataItem.isPlaceHolder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER];
        dataItem.placeHolderWidth =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH];
        dataItem.displayInApp =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP];
        dataItem.displayInReport =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT];
        dataItem.horizontalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT];
        dataItem.verticalAlignment =
            element[ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT];
        dataItem.fontSize = element[ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE];
        dataItem.fontWeight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT];
        dataItem.foreColor = element[ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR];
        dataItem.backgroundColor =
            element[ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR];
        dataItem.sequentialOrder =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER];
        dataItem.startOnNewLine =
            element[ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE];
        dataItem.lineBreakAfter =
            element[ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER];
        dataItem.paddingLeft =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT];
        dataItem.paddingRight =
            element[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT];
        dataItem.needAutoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER];
        dataItem.autoNumberPrefix =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX];
        dataItem.autoNumber =
            element[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER];
        dataItem.isDisabled =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED];
        dataItem.attributeID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID];
        dataItem.canTriggerEvent =
            element[ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT];
        dataItem.dataScriptApp1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1];
        dataItem.dataScriptApp2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2];
        dataItem.dataScriptWeb1 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1];
        dataItem.dataScriptWeb2 =
            element[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2];
        dataItem.eventClassName =
            element[ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME];
        dataItem.isTotalValue =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE];
        dataItem.signatureType =
            element[ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE];
        dataItem.createdOn = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_FORMCELLELEMENT_UID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER];
        dataItem.appUserID = element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED];

        dataItem.formCellName = element[ColumnsBase.KEY_FORMCELL_FORMCELLNAME];
        dataItem.attributeName =
            element[ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME];

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

        // Add dataItem to your desired collection or perform further operations

        dataList.add(dataItem);
      }
        } catch ( ex) {
            Globals.handleException( "FormCellElementDataHandlerBase:GetFormCellElementTotalValueRecords()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}