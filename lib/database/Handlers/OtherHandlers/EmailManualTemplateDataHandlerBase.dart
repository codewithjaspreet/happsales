
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/EmailManualTemplate.dart';
import '../DataBaseHandler.dart';

class EmailManualTemplateDataHandlerBase {

     static Future<List<EmailManualTemplate>> GetEmailManualTemplateRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<EmailManualTemplate> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_EmailManualTemplate_Columns.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


           
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<EmailManualTemplate>> GetEmailManualTemplateRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<EmailManualTemplate> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME} COLLATE NOCASE ASC ";

          
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<EmailManualTemplate?> GetEmailManualTemplateRecord(DatabaseHandler databaseHandler,  String id) async{
        EmailManualTemplate? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<EmailManualTemplate?> GetMasterEmailManualTemplateRecord(DatabaseHandler databaseHandler,  String id) async{
        EmailManualTemplate ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
              
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetMasterEmailManualTemplateRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddEmailManualTemplateRecord(DatabaseHandler databaseHandler,  EmailManualTemplate dataItem)async {
        int id = 0;
        try { 
          final db = await databaseHandler.database;
          Map<String, dynamic> values = {};

if (dataItem.emailManualTemplateID != null && dataItem.emailManualTemplateID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID] = dataItem.emailManualTemplateID;
}

if (dataItem.emailManualTemplateCode != null && dataItem.emailManualTemplateCode != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE] = dataItem.emailManualTemplateCode;
}

if (dataItem.emailManualTemplateName != null && dataItem.emailManualTemplateName != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME] = dataItem.emailManualTemplateName;
}

if (dataItem.emailTemplateType != null && dataItem.emailTemplateType != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE] = dataItem.emailTemplateType;
}

if (dataItem.subject != null && dataItem.subject != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT] = dataItem.subject;
}

if (dataItem.mailBody != null && dataItem.mailBody != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY] = dataItem.mailBody;
}

if (dataItem.fromEmail != null && dataItem.fromEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL] = dataItem.fromEmail;
}

if (dataItem.toEmail != null && dataItem.toEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL] = dataItem.toEmail;
}

if (dataItem.ccEmail != null && dataItem.ccEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL] = dataItem.ccEmail;
}

if (dataItem.emailType != null && dataItem.emailType != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE] = dataItem.emailType;
}

if (dataItem.isSystemDefined != null && dataItem.isSystemDefined != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED] = dataItem.isSystemDefined;
}

if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED] = dataItem.isDeleted;
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
            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE]  = "true";
            values[ColumnsBase.KEY_ISDELETED] =  "false";

            id = await db.insert(TablesBase.TABLE_EMAILMANUALTEMPLATE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddEmailManualTemplateRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateEmailManualTemplateRecord(DatabaseHandler databaseHandler,  String id1, EmailManualTemplate dataItem)async {
        int id = 0;
        try {
          
          final db = await databaseHandler.database;
          Map<String, dynamic> values = {};

if (dataItem.emailManualTemplateID != null && dataItem.emailManualTemplateID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID] = dataItem.emailManualTemplateID;
}

if (dataItem.emailManualTemplateCode != null && dataItem.emailManualTemplateCode != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE] = dataItem.emailManualTemplateCode;
}

if (dataItem.emailManualTemplateName != null && dataItem.emailManualTemplateName != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME] = dataItem.emailManualTemplateName;
}

if (dataItem.emailTemplateType != null && dataItem.emailTemplateType != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE] = dataItem.emailTemplateType;
}

if (dataItem.subject != null && dataItem.subject != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT] = dataItem.subject;
}

if (dataItem.mailBody != null && dataItem.mailBody != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY] = dataItem.mailBody;
}

if (dataItem.fromEmail != null && dataItem.fromEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL] = dataItem.fromEmail;
}

if (dataItem.toEmail != null && dataItem.toEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL] = dataItem.toEmail;
}

if (dataItem.ccEmail != null && dataItem.ccEmail != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL] = dataItem.ccEmail;
}

if (dataItem.emailType != null && dataItem.emailType != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE] = dataItem.emailType;
}

if (dataItem.isSystemDefined != null && dataItem.isSystemDefined != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED] = dataItem.isSystemDefined;
}

if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON] = dataItem.createdOn;
}

if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY] = dataItem.createdBy;
}

if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON] = dataItem.modifiedOn;
}

if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY] = dataItem.modifiedBy;
}

if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE] = dataItem.isActive;
}

if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID] = dataItem.uid;
}

if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID] = dataItem.appUserID;
}

if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID] = dataItem.appUserGroupID;
}

if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED] = dataItem.isDeleted;
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


            id =await db.update(TablesBase.TABLE_EMAILMANUALTEMPLATE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateEmailManualTemplateRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteEmailManualTemplateRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =await  databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_EMAILMANUALTEMPLATE,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteEmailManualTemplateRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
            }
            
        } catch ( ex) {
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID} = $id";

             final db =await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
        } catch ( ex) {
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<EmailManualTemplate>> GetEmailManualTemplateUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<EmailManualTemplate> dataList = [];
        try {
            String selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_EMAILMANUALTEMPLATE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_EMAILMANUALTEMPLATE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType ==(AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_EMAILMANUALTEMPLATE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<EmailManualTemplate?> GetEmailManualTemplateRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        EmailManualTemplate? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += "${" FROM ${TablesBase.TABLE_EMAILMANUALTEMPLATE}"} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

             
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    EmailManualTemplate dataItem = new EmailManualTemplate();

                    dataItem.emailManualTemplateID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID];
                    dataItem.emailManualTemplateCode = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE];
                    dataItem.emailManualTemplateName = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME];
                    dataItem.emailTemplateType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE];
                    dataItem.subject = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT];
                    dataItem.mailBody = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY];
                    dataItem.fromEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL];
                    dataItem.toEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL];
                    dataItem.ccEmail = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL];
                    dataItem.emailType = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE];
                    dataItem.isSystemDefined = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED];
                    dataItem.createdOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON];
                    dataItem.isDeleted = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE];
                    dataItem.createdBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID];

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
	    Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}