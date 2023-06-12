import 'package:happsales_crm/database/models/AccountModels/AccountAddress.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../Models/BaseEntity.dart';
import '../DataBaseHandler.dart';
import 'AccountAddressDataHandlerBase.dart';

class AccountAddressDataHandler extends AccountAddressDataHandlerBase {

   static Future<List<AccountAddress>> GetAccountAddressRecordsPaged(
      DatabaseHandler databaseHandler,
      String accountId,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountAddress> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = $accountId";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND (B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%$searchString%'";
        selectQuery +=
            " OR E.${ColumnsBase.KEY_CONTACT_CONTACTNAME} LIKE '%$searchString%'";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} LIKE '%$searchString%'";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1} LIKE '%$searchString%'";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2} LIKE '%$searchString%'";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3} LIKE '%$searchString%'";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACCOUNTADDRESS_CITY} LIKE '%$searchString%'";
        selectQuery += ")";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountAddress_Columns.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountAddress accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(accountAddress);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }



   static Future<List<AccountAddress>> GetAccountAddressRecords(
      DatabaseHandler databaseHandler,
      String accountId,
      String searchString,
      ) async {
    List<AccountAddress> dataList = [];
    try {

      String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} =  $accountId";
            if (searchString.trim().isNotEmpty) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountAddress accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(accountAddress);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }


     static Future<String> GetAccountAddressRecordByAdddressType(DatabaseHandler databaseHandler, String accountId, String adddressType) async {
    
       String address = "";

       try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = $accountId";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} = '$adddressType' LIMIT 1";


            final db = await databaseHandler.database;

            final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery,null);

            for(var element in result){

              String addressLine1 = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1).toString();
              String addressLine2 = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2).toString();
              String addressLine3= element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3).toString();
              String city = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_CITY).toString();
              String state = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_STATE).toString();
              String country = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY).toString();
              String pin = element.keys.toList().indexOf(ColumnsBase.KEY_ACCOUNTADDRESS_PIN).toString();


              address += (addressLine1.trim() != "") ? "$addressLine1\n" : "";
              address += (addressLine2.trim() != "") ? "$addressLine2\n" : "";
              address += (addressLine3.trim() != "") ? "$addressLine3\n" : "";
              address += (city.trim() != "") ? "$city\n" : "";
              address += (state.trim() != "") ? "$state\n" : "";
              address += (country.trim() != "") ? "$country\n" : "";
              address += (pin.trim() != "") ? "$pin\n" : "";
              
 


            }
         
       } catch (e) {
         

       }

       return address;
    }

   
}
