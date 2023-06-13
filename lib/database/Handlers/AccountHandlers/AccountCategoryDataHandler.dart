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
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountCategory.dart';
import '../DataBaseHandler.dart';
import 'AccountCategoryDataHandlerBase.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : AccountCategoryDataHandler
// Created By    : Vijay Kumar Vettath
// Created Date  : Dec-2019
// Purpose       : Class containing the custom data handler methods for AccountCategory table.
// Details       :
// Change History:-
// Date:
// Author:
// Change:
//////////////////////////////////////////////////////////////////////////////////////////////////


 class AccountCategoryDataHandler extends AccountCategoryDataHandlerBase {

     static Future<List<AccountCategory>> GetAccountCategoryRecordsForAccountId(DatabaseHandler databaseHandler, String accountId) async{
        List<AccountCategory> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ID} IN (";
            selectQuery += " SELECT IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} IQ ";
            selectQuery += " WHERE IQ.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = $accountId" ;
            selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED},'false')) = 'false')";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
     AccountCategory   dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
           // Globals.HandleException(context, "AccountCategoryDataHandler:GetAccountCategoryRecordsForAccountId()", ex);
            throw ex;
        }
        return dataList;
    }

	/*-------------------HAPPSALES-------------------*/

}