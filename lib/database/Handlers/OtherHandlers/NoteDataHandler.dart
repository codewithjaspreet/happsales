
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Note.dart';
import '../DataBaseHandler.dart';
import 'NoteDataHandlerBase.dart';

class NoteDataHandler extends NoteDataHandlerBase {

     static Future<List<Note>> GetNoteRecordsByOpportunityId(DatabaseHandler databaseHandler,   String opportunityId)async {
        List<Note> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_NOTE + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_NOTE_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_NOTE_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " G ON A." + ColumnsBase.KEY_NOTE_OPPORTUNITYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_OPPORTUNITYID + " = " + opportunityId;
            selectQuery += " ORDER BY date(A." + ColumnsBase.KEY_NOTE_NOTEDATE + ") COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
        } catch ( ex) {
            Globals.handleException( "NoteDataHandlerBase:GetNoteRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Note>> GetNoteRecordsByActivityId(DatabaseHandler databaseHandler,   String activityId) async{
        List<Note> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE}";
            selectQuery += " FROM " + TablesBase.TABLE_NOTE + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_NOTE_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_NOTE_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " G ON A." + ColumnsBase.KEY_NOTE_OPPORTUNITYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_ACTIVITYID + " = " + activityId;
            selectQuery += " ORDER BY date(A." + ColumnsBase.KEY_NOTE_NOTEDATE + ") COLLATE NOCASE ASC ";

            
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
        } catch ( ex) {
            Globals.handleException( "NoteDataHandlerBase:GetNoteRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<Note>> GetNoteRecordsByAccountId(DatabaseHandler databaseHandler,   String accountId) async{
        List<Note> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + ",C." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
            selectQuery += " FROM " + TablesBase.TABLE_NOTE + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_NOTE_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_NOTE_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " G ON A." + ColumnsBase.KEY_NOTE_OPPORTUNITYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = " + accountId;
            selectQuery += " ORDER BY date(A." + ColumnsBase.KEY_NOTE_NOTEDATE + ") COLLATE NOCASE ASC ";

           
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
        } catch ( ex) {
            Globals.handleException( "NoteDataHandlerBase:GetNoteRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<int> GetNotesCount(DatabaseHandler databaseHandler,  String contactId,String accountId)async {
        int itemCount = 0;
        try {
            String selectQuery = "SELECT COUNT(*)";
            selectQuery += " FROM " + TablesBase.TABLE_NOTE + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " C ON A." + ColumnsBase.KEY_NOTE_ACTIVITYID + " = C." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_NOTE_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " G ON A." + ColumnsBase.KEY_NOTE_OPPORTUNITYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_NOTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_NOTE_ISARCHIVED + ",'false')) = 'false' ";
            if (contactId.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_NOTE_CONTACTID + " = " + contactId;

            if (accountId.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_NOTE_ACCOUNTID + " = " + accountId;

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                itemCount = result[0]["COUNT(*)"];
            }

          
        } catch ( ex) {
            Globals.handleException( "NoteDataHandler:GetNotesCount()", ex);
            throw ex;
        }
        return itemCount;
    }



    /*-------------------HAPPSALES-------------------*/

}