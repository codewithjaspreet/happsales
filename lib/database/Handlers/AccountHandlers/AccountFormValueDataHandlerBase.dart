
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountFormValue.dart';
import '../DataBaseHandler.dart';

class AccountFormValueDataHandlerBase {

     static Future<List<AccountFormValue>> GetAccountFormValueRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AccountFormValue> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE} LIKE '%${searchString.replaceAll("'","''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountFormValue_Columns.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";
final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                            AccountFormValue dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
           // Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AccountFormValue>> GetAccountFormValueRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AccountFormValue> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE} LIKE '${searchString.replaceAll("'","''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE} COLLATE NOCASE ASC ";
final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                            AccountFormValue dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
           // Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AccountFormValue?> GetAccountFormValueRecord(DatabaseHandler databaseHandler,  String id) async {
        AccountFormValue? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                            AccountFormValue dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
            //Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AccountFormValue?> GetMasterAccountFormValueRecord(DatabaseHandler databaseHandler,  String id)  async{
        AccountFormValue? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

           final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                             dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
            //Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetMasterAccountFormValueRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAccountFormValueRecord(DatabaseHandler databaseHandler,  AccountFormValue dataItem) async{
        int id = 0;
        try {

            final db = await databaseHandler.database;
            Map<String, dynamic> values = new Map();

            if (dataItem.accountFormValueID != null && dataItem.accountFormValueID != ("null"))
                values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID] =  dataItem.accountFormValueID;


        if (dataItem.accountFormValueCode != null && dataItem.accountFormValueCode != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE] = dataItem.accountFormValueCode;
}
if (dataItem.accountFormID != null && dataItem.accountFormID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID] = dataItem.accountFormID;
}
if (dataItem.formCellElementID != null && dataItem.formCellElementID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID] = dataItem.formCellElementID;
}
if (dataItem.formCellElementValue != null && dataItem.formCellElementValue != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE] = dataItem.formCellElementValue;
}
if (dataItem.rowIndex != null && dataItem.rowIndex != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX] = dataItem.rowIndex;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID] = dataItem.uid;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED] = dataItem.isDeleted;
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

id = await db.insert(TablesBase.TABLE_ACCOUNTFORMVALUE, values);

            //db.close();
        } catch ( ex) {
           // Globals.HandleException(context, "DatabaseHandler:AddAccountFormValueRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAccountFormValueRecord(DatabaseHandler databaseHandler,  String id1, AccountFormValue dataItem) async{
        int id = 0;
        try {
                       final db = await databaseHandler.database;
            Map<String, dynamic> values = new Map();

            if (dataItem.accountFormValueID != null && dataItem.accountFormValueID != ("null"))
                values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID] =  dataItem.accountFormValueID;


        if (dataItem.accountFormValueCode != null && dataItem.accountFormValueCode != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE] = dataItem.accountFormValueCode;
}
if (dataItem.accountFormID != null && dataItem.accountFormID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID] = dataItem.accountFormID;
}
if (dataItem.formCellElementID != null && dataItem.formCellElementID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID] = dataItem.formCellElementID;
}
if (dataItem.formCellElementValue != null && dataItem.formCellElementValue != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE] = dataItem.formCellElementValue;
}
if (dataItem.rowIndex != null && dataItem.rowIndex != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX] = dataItem.rowIndex;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID] = dataItem.uid;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_ACCOUNTFORMVALUE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs : null);
            //db.close();
        } catch ( ex) {
            //Globals.HandleException(context, "DatabaseHandler:UpdateAccountFormValueRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAccountFormValueRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
           
           final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACCOUNTFORMVALUE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
          //  Globals.HandleException(context, "DatabaseHandler:DeleteAccountFormValueRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
           final db = await databaseHandler.database;

           List<Map<String,dynamic>> result = await db.rawQuery(selectQuery, null);
            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID].toString();
            }
            //db.close();


        } catch ( ex) {
         //   Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID} = $id";

            final db = await databaseHandler.database;

           List<Map<String,dynamic>> result = await db.rawQuery(selectQuery, null);
            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID].toString();
            }
            
            //db.close();
        } catch ( ex) {
           // Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AccountFormValue>> GetAccountFormValueUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<AccountFormValue> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTFORMVALUE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTFORMVALUE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNTFORM} WHERE coalesce(${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID},'') <> '')";

              final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                            AccountFormValue dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
            //Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AccountFormValue?> GetAccountFormValueRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AccountFormValue? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE},E.${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME}";
		selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORMVALUE} A "; 
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTFORM} B ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} = B.${ColumnsBase.KEY_ID}";
		selectQuery += " LEFT JOIN ${TablesBase.TABLE_FORMCELLELEMENT} E ON A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} = E.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTFORMVALUE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      
              final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {

                            AccountFormValue dataItem = new AccountFormValue();

                              dataItem.accountFormID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID];
                              dataItem.formCellElementID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID];
                              dataItem.formCellElementValue = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE];
                              dataItem.rowIndex = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX];
                              dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON];
                              dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY];
                              dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON];
                              dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY];
                              dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE];
                              dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_UID];
                              dataItem.referenceIdentifier  = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER];
                              dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID];
                              dataItem.appUserGroupID = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID];
                              dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED];
                              dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED];
                              dataItem.accountFormTitle = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
                              dataItem.formCellElementName = element[ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME];

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
	  //  Globals.HandleException(context, "AccountFormValueDataHandlerBase:GetAccountFormValueRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}