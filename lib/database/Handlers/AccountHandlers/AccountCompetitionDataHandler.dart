/*************************************************************************
 *
 * HAPPSALES CONFIDENTIAL
 * ____________________________________
 *
 *  [2019-23] HappSales Private Limited
 *  www.happsales.com
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains the property of HappSales Private Limited.
 * The intellectual and technical concepts contained herein are proprietary to HappSales Private Limited
 * and  are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material is strictly forbidden unless prior
 * written permission is obtained from HappSales Private Limited.
 */
//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : AccountCompetitionActivityDataHandler
// Created By    : Vijay Kumar Vettath
// Created Date  : Dec-2019
// Purpose       : Class containing the custom data handler methods for AccountCompetitionActivity table.
// Details       :
// Change History:-
// Date:
// Author:
// Change:
//////////////////////////////////////////////////////////////////////////////////////////////////


 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountCompetitionActivity.dart';
import '../DataBaseHandler.dart';
import 'AccountCompetitionActivityDataHandlerBase.dart';

class AccountCompetitionActivityDataHandler extends AccountCompetitionActivityDataHandlerBase {


     static Future<List<AccountCompetitionActivity>> GetAccountCompetitionActivityRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId) async{
        List<AccountCompetitionActivity> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY + " LIKE '%" + searchString + "%'";

            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID + " = " + accountId + "";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountCompetitionActivity_Columns.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();


      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
         //   Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

    static  Future<List<AccountCompetitionActivity>> GetAccountCompetitionActivityRecordsByOpportunityId(DatabaseHandler databaseHandler, String opportunityId)async {
        List<AccountCompetitionActivity> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",E." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " E ON A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
            selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID + " = " + opportunityId;
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME + " COLLATE NOCASE ASC ";

            
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
           // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecords()", ex);
            throw ex;
        }
        return dataList;
    }

    /*-------------------HAPPSALES-------------------*/

}