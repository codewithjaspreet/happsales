
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/EmailManualTemplate.dart';
import '../DataBaseHandler.dart';
import 'EmailManualTemplateDataHandlerBase.dart';

class EmailManualTemplateDataHandler extends EmailManualTemplateDataHandlerBase {

     static Future<EmailManualTemplate?> GetEmailManualTemplateRecordByTemplateName(DatabaseHandler databaseHandler, String templateName) async{
        EmailManualTemplate? dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_EMAILMANUALTEMPLATE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME + " = '" + templateName + "'";

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
            Globals.handleException( "EmailManualTemplateDataHandlerBase:GetEmailManualTemplateRecordByTemplateName()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}