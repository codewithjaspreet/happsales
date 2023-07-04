import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FormCellElement.dart';
import '../DataBaseHandler.dart';

class FormCellElementDataHandlerBase {
  static Future<List<FormCellElement>> GetFormCellElementRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<FormCellElement> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_FORMCELL_FORMCELLNAME +
          ",D." +
          ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_ATTRIBUTE +
          " D ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID +
          " = D." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_FORMCELL +
          " E ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISDELETED +
          ",'false')) = 'false' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED +
          ",'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISACTIVE +
          ",'true')) = 'true' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE +
          ",'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A." +
            ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME +
            " LIKE '%" +
            searchString +
            "%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_FormCellElement_Columns.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
      selectQuery +=
          " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();

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

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetFormCellElementRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<FormCellElement>> GetFormCellElementRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<FormCellElement> dataList = [];
    try {
      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_FORMCELL_FORMCELLNAME +
          ",D." +
          ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_ATTRIBUTE +
          " D ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID +
          " = D." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_FORMCELL +
          " E ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISDELETED +
          ",'false')) = 'false' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED +
          ",'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_ISACTIVE +
          ",'true')) = 'true' AND LOWER(IFNULL(A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE +
          ",'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A." +
            ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME +
            " LIKE '" +
            searchString +
            "%'";
      selectQuery += " ORDER BY A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME +
          " COLLATE NOCASE ASC ";

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

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetFormCellElementRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<FormCellElement?> GetFormCellElementRecord(
      DatabaseHandler databaseHandler, String id) async {
    FormCellElement? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_FORMCELL_FORMCELLNAME +
          ",D." +
          ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_ATTRIBUTE +
          " D ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID +
          " = D." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_FORMCELL +
          " E ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
      selectQuery += " AND A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();
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
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetFormCellElementRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<FormCellElement?> GetMasterFormCellElementRecord(
      DatabaseHandler databaseHandler, String id) async {
    FormCellElement? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_FORMCELL_FORMCELLNAME +
          ",D." +
          ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_ATTRIBUTE +
          " D ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID +
          " = D." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_FORMCELL +
          " E ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID +
          " = " +
          id;
      selectQuery += " AND A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();

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
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetMasterFormCellElementRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddFormCellElementRecord(
      DatabaseHandler databaseHandler, FormCellElement dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.formCellElementID != null &&
          dataItem.formCellElementID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID] =
            dataItem.formCellElementID;
      if (dataItem.formCellElementCode != null &&
          dataItem.formCellElementCode != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE] =
            dataItem.formCellElementCode;
      if (dataItem.formCellElementName != null &&
          dataItem.formCellElementName != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME] =
            dataItem.formCellElementName;
      if (dataItem.formCellID != null && dataItem.formCellID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID] =
            dataItem.formCellID;
      if (dataItem.controlName != null && dataItem.controlName != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME] =
            dataItem.controlName;
      if (dataItem.controlType != null && dataItem.controlType != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE] =
            dataItem.controlType;
      if (dataItem.controlLabel != null && dataItem.controlLabel != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL] =
            dataItem.controlLabel;
      if (dataItem.checkBoxLabelPosition != null &&
          dataItem.checkBoxLabelPosition != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION] =
            dataItem.checkBoxLabelPosition;
      if (dataItem.controlValues != null && dataItem.controlValues != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES] =
            dataItem.controlValues;
      if (dataItem.defaultValue != null && dataItem.defaultValue != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE] =
            dataItem.defaultValue;
      if (dataItem.height != null && dataItem.height != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT] = dataItem.height;
      if (dataItem.width != null && dataItem.width != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_WIDTH] = dataItem.width;
      if (dataItem.isRequired != null && dataItem.isRequired != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED] =
            dataItem.isRequired;
      if (dataItem.isPlaceHolder != null && dataItem.isPlaceHolder != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER] =
            dataItem.isPlaceHolder;
      if (dataItem.placeHolderWidth != null &&
          dataItem.placeHolderWidth != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH] =
            dataItem.placeHolderWidth;
      if (dataItem.displayInApp != null && dataItem.displayInApp != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP] =
            dataItem.displayInApp;
      if (dataItem.displayInReport != null &&
          dataItem.displayInReport != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT] =
            dataItem.displayInReport;
      if (dataItem.horizontalAlignment != null &&
          dataItem.horizontalAlignment != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT] =
            dataItem.horizontalAlignment;
      if (dataItem.verticalAlignment != null &&
          dataItem.verticalAlignment != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT] =
            dataItem.verticalAlignment;

      if (dataItem.fontSize != null && dataItem.fontSize != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE] = dataItem.fontSize;
      if (dataItem.fontWeight != null && dataItem.fontWeight != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT] =
            dataItem.fontWeight;
      if (dataItem.foreColor != null && dataItem.foreColor != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR] = dataItem.foreColor;
      if (dataItem.backgroundColor != null &&
          dataItem.backgroundColor != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR] =
            dataItem.backgroundColor;
      if (dataItem.sequentialOrder != null &&
          dataItem.sequentialOrder != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER] =
            dataItem.sequentialOrder;
      if (dataItem.startOnNewLine != null && dataItem.startOnNewLine != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE] =
            dataItem.startOnNewLine;
      if (dataItem.lineBreakAfter != null && dataItem.lineBreakAfter != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER] =
            dataItem.lineBreakAfter;
      if (dataItem.paddingLeft != null && dataItem.paddingLeft != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT] =
            dataItem.paddingLeft;
      if (dataItem.paddingRight != null && dataItem.paddingRight != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT] =
            dataItem.paddingRight;
      if (dataItem.needAutoNumber != null && dataItem.needAutoNumber != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER] =
            dataItem.needAutoNumber;
      if (dataItem.autoNumberPrefix != null &&
          dataItem.autoNumberPrefix != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX] =
            dataItem.autoNumberPrefix;
      if (dataItem.autoNumber != null && dataItem.autoNumber != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER] =
            dataItem.autoNumber;
      if (dataItem.isDisabled != null && dataItem.isDisabled != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED] =
            dataItem.isDisabled;
      if (dataItem.attributeID != null && dataItem.attributeID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID] =
            dataItem.attributeID;

      if (dataItem.canTriggerEvent != null &&
          dataItem.canTriggerEvent != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT] =
            dataItem.canTriggerEvent;
      }
      if (dataItem.dataScriptApp1 != null &&
          dataItem.dataScriptApp1 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1] =
            dataItem.dataScriptApp1;
      }
      if (dataItem.dataScriptApp2 != null &&
          dataItem.dataScriptApp2 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2] =
            dataItem.dataScriptApp2;
      }
      if (dataItem.dataScriptWeb1 != null &&
          dataItem.dataScriptWeb1 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1] =
            dataItem.dataScriptWeb1;
      }
      if (dataItem.dataScriptWeb2 != null &&
          dataItem.dataScriptWeb2 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2] =
            dataItem.dataScriptWeb2;
      }
      if (dataItem.eventClassName != null &&
          dataItem.eventClassName != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME] =
            dataItem.eventClassName;
      }
      if (dataItem.isTotalValue != null && dataItem.isTotalValue != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE] =
            dataItem.isTotalValue;
      }
      if (dataItem.signatureType != null && dataItem.signatureType != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE] =
            dataItem.signatureType;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_UID] = dataItem.uid;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED] = dataItem.isDeleted;
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
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
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
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_FORMCELLELEMENT, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddFormCellElementRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateFormCellElementRecord(
      DatabaseHandler databaseHandler,
      String id1,
      FormCellElement dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.formCellElementID != null &&
          dataItem.formCellElementID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID] =
            dataItem.formCellElementID;
      if (dataItem.formCellElementCode != null &&
          dataItem.formCellElementCode != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE] =
            dataItem.formCellElementCode;
      if (dataItem.formCellElementName != null &&
          dataItem.formCellElementName != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME] =
            dataItem.formCellElementName;
      if (dataItem.formCellID != null && dataItem.formCellID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID] =
            dataItem.formCellID;
      if (dataItem.controlName != null && dataItem.controlName != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME] =
            dataItem.controlName;
      if (dataItem.controlType != null && dataItem.controlType != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE] =
            dataItem.controlType;
      if (dataItem.controlLabel != null && dataItem.controlLabel != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL] =
            dataItem.controlLabel;
      if (dataItem.checkBoxLabelPosition != null &&
          dataItem.checkBoxLabelPosition != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION] =
            dataItem.checkBoxLabelPosition;
      if (dataItem.controlValues != null && dataItem.controlValues != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES] =
            dataItem.controlValues;
      if (dataItem.defaultValue != null && dataItem.defaultValue != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE] =
            dataItem.defaultValue;
      if (dataItem.height != null && dataItem.height != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT] = dataItem.height;
      if (dataItem.width != null && dataItem.width != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_WIDTH] = dataItem.width;
      if (dataItem.isRequired != null && dataItem.isRequired != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED] =
            dataItem.isRequired;
      if (dataItem.isPlaceHolder != null && dataItem.isPlaceHolder != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER] =
            dataItem.isPlaceHolder;
      if (dataItem.placeHolderWidth != null &&
          dataItem.placeHolderWidth != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH] =
            dataItem.placeHolderWidth;
      if (dataItem.displayInApp != null && dataItem.displayInApp != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP] =
            dataItem.displayInApp;
      if (dataItem.displayInReport != null &&
          dataItem.displayInReport != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT] =
            dataItem.displayInReport;
      if (dataItem.horizontalAlignment != null &&
          dataItem.horizontalAlignment != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT] =
            dataItem.horizontalAlignment;
      if (dataItem.verticalAlignment != null &&
          dataItem.verticalAlignment != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT] =
            dataItem.verticalAlignment;

      if (dataItem.fontSize != null && dataItem.fontSize != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE] = dataItem.fontSize;
      if (dataItem.fontWeight != null && dataItem.fontWeight != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT] =
            dataItem.fontWeight;
      if (dataItem.foreColor != null && dataItem.foreColor != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR] = dataItem.foreColor;
      if (dataItem.backgroundColor != null &&
          dataItem.backgroundColor != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR] =
            dataItem.backgroundColor;
      if (dataItem.sequentialOrder != null &&
          dataItem.sequentialOrder != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER] =
            dataItem.sequentialOrder;
      if (dataItem.startOnNewLine != null && dataItem.startOnNewLine != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE] =
            dataItem.startOnNewLine;
      if (dataItem.lineBreakAfter != null && dataItem.lineBreakAfter != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER] =
            dataItem.lineBreakAfter;
      if (dataItem.paddingLeft != null && dataItem.paddingLeft != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT] =
            dataItem.paddingLeft;
      if (dataItem.paddingRight != null && dataItem.paddingRight != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT] =
            dataItem.paddingRight;
      if (dataItem.needAutoNumber != null && dataItem.needAutoNumber != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER] =
            dataItem.needAutoNumber;
      if (dataItem.autoNumberPrefix != null &&
          dataItem.autoNumberPrefix != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX] =
            dataItem.autoNumberPrefix;
      if (dataItem.autoNumber != null && dataItem.autoNumber != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER] =
            dataItem.autoNumber;
      if (dataItem.isDisabled != null && dataItem.isDisabled != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED] =
            dataItem.isDisabled;
      if (dataItem.attributeID != null && dataItem.attributeID != "null")
        values[ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID] =
            dataItem.attributeID;

      if (dataItem.canTriggerEvent != null &&
          dataItem.canTriggerEvent != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT] =
            dataItem.canTriggerEvent;
      }
      if (dataItem.dataScriptApp1 != null &&
          dataItem.dataScriptApp1 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1] =
            dataItem.dataScriptApp1;
      }
      if (dataItem.dataScriptApp2 != null &&
          dataItem.dataScriptApp2 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2] =
            dataItem.dataScriptApp2;
      }
      if (dataItem.dataScriptWeb1 != null &&
          dataItem.dataScriptWeb1 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1] =
            dataItem.dataScriptWeb1;
      }
      if (dataItem.dataScriptWeb2 != null &&
          dataItem.dataScriptWeb2 != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2] =
            dataItem.dataScriptWeb2;
      }
      if (dataItem.eventClassName != null &&
          dataItem.eventClassName != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME] =
            dataItem.eventClassName;
      }
      if (dataItem.isTotalValue != null && dataItem.isTotalValue != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE] =
            dataItem.isTotalValue;
      }
      if (dataItem.signatureType != null && dataItem.signatureType != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE] =
            dataItem.signatureType;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_UID] = dataItem.uid;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED] = dataItem.isDeleted;
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
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
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
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_FORMCELLELEMENT, values,
          where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateFormCellElementRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteFormCellElementRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_FORMCELLELEMENT,
          where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteFormCellElementRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A." + ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID];
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  static Future<String> GetLocalId(
      DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID +
          " = " +
          id;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<FormCellElement>> GetFormCellElementUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<FormCellElement> dataList = [];
    try {
      String selectQuery = "SELECT * FROM " +
          TablesBase.TABLE_FORMCELLELEMENT +
          " WHERE " +
          ColumnsBase.KEY_ISDIRTY +
          " = 'true' AND " +
          ColumnsBase.KEY_UPSYNCINDEX +
          " < " +
          Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery = "SELECT * FROM " +
            TablesBase.TABLE_FORMCELLELEMENT +
            " WHERE " +
            ColumnsBase.KEY_ISDIRTY +
            " = 'true' AND " +
            ColumnsBase.KEY_ISDELETED +
            " = 'false' " +
            " AND " +
            ColumnsBase.KEY_UPSYNCINDEX +
            " < " +
            Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery = "SELECT * FROM " +
            TablesBase.TABLE_FORMCELLELEMENT +
            " WHERE " +
            ColumnsBase.KEY_ISDIRTY +
            " = 'true' AND " +
            ColumnsBase.KEY_ISDELETED +
            " = 'true' " +
            " AND " +
            ColumnsBase.KEY_UPSYNCINDEX +
            " < " +
            Globals.SyncIndex.toString();
      }
      selectQuery += " AND " +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND " +
          ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();

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
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetFormCellElementUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<FormCellElement?> GetFormCellElementRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    FormCellElement? dataItem;
    try {
      String selectQuery = "SELECT A.* " +
          ",E." +
          ColumnsBase.KEY_FORMCELL_FORMCELLNAME +
          ",D." +
          ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME;
      selectQuery += " FROM " + TablesBase.TABLE_FORMCELLELEMENT + " A ";
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_ATTRIBUTE +
          " D ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID +
          " = D." +
          ColumnsBase.KEY_ID;
      selectQuery += " LEFT JOIN " +
          TablesBase.TABLE_FORMCELL +
          " E ON A." +
          ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID +
          " = E." +
          ColumnsBase.KEY_ID;
      selectQuery += " WHERE A." +
          ColumnsBase.KEY_FORMCELLELEMENT_UID +
          " = '" +
          uid +
          "'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
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
      }
    } catch (ex) {
      Globals.handleException(
          "FormCellElementDataHandlerBase:GetFormCellElementRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
