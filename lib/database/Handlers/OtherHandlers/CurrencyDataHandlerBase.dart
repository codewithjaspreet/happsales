
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Currency.dart';
import '../DataBaseHandler.dart';

class CurrencyDataHandlerBase {

CurrencyDataHandlerBase();
     static Future<List<Currency>> GetCurrencyRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<Currency> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_COUNTRY} D ON A.${ColumnsBase.KEY_CURRENCY_COUNTRYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Currency_ColumnsBase.KEY_CURRENCY_CURRENCYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();



            final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];

  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CurrencyDataHandlerBase:GetCurrencyRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Currency>> GetCurrencyRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<Currency> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_COUNTRY} D ON A.${ColumnsBase.KEY_CURRENCY_COUNTRYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CURRENCY_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME} COLLATE NOCASE ASC ";

           final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];
  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           
  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CurrencyDataHandlerBase:GetCurrencyRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Currency?> GetCurrencyRecord(DatabaseHandler databaseHandler,  String id) async{
        Currency? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_COUNTRY} D ON A.${ColumnsBase.KEY_CURRENCY_COUNTRYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];
  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CurrencyDataHandlerBase:GetCurrencyRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Currency?> GetMasterCurrencyRecord(DatabaseHandler databaseHandler,  String id) async{
        Currency? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_COUNTRY} D ON A.${ColumnsBase.KEY_CURRENCY_COUNTRYID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CURRENCY_CURRENCYID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];
  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
           



            }
        } catch ( ex) {
            Globals.handleException( "CurrencyDataHandlerBase:GetMasterCurrencyRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddCurrencyRecord(DatabaseHandler databaseHandler,  Currency dataItem)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.currencyID != null && dataItem.currencyID != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYID] = dataItem.currencyID;
  if (dataItem.currencyCode != null && dataItem.currencyCode != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYCODE] = dataItem.currencyCode;
  if (dataItem.currencyName != null && dataItem.currencyName != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYNAME] = dataItem.currencyName;
  if (dataItem.countryID != null && dataItem.countryID != "null")
    values[ColumnsBase.KEY_CURRENCY_COUNTRYID] = dataItem.countryID;
  if (dataItem.standardCurrencyCode != null && dataItem.standardCurrencyCode != "null")
    values[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE] = dataItem.standardCurrencyCode;
  if (dataItem.currencySymbol != null && dataItem.currencySymbol != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL] = dataItem.currencySymbol;
  if (dataItem.exchangeRate != null && dataItem.exchangeRate != "null")
    values[ColumnsBase.KEY_CURRENCY_EXCHANGERATE] = dataItem.exchangeRate;
  if (dataItem.isDefaultCurrency != null && dataItem.isDefaultCurrency != "null")
    values[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY] = dataItem.isDefaultCurrency;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_CURRENCY_CREATEDON] = dataItem.createdOn;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_CURRENCY_CREATEDBY] = dataItem.createdBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_CURRENCY_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_CURRENCY_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_CURRENCY_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_CURRENCY_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_CURRENCY_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_CURRENCY_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_CURRENCY_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

  values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
  values[ColumnsBase.KEY_ISACTIVE] = "true";
  values[ColumnsBase.KEY_ISDELETED] = "false";

            id =  await db.insert(TablesBase.TABLE_CURRENCY, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddCurrencyRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateCurrencyRecord(DatabaseHandler databaseHandler,  String id1, Currency dataItem)async {
        int id = 0;
        try {
           final db = await  databaseHandler.database;
            Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.currencyID != null && dataItem.currencyID != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYID] = dataItem.currencyID;
  if (dataItem.currencyCode != null && dataItem.currencyCode != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYCODE] = dataItem.currencyCode;
  if (dataItem.currencyName != null && dataItem.currencyName != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYNAME] = dataItem.currencyName;
  if (dataItem.countryID != null && dataItem.countryID != "null")
    values[ColumnsBase.KEY_CURRENCY_COUNTRYID] = dataItem.countryID;
  if (dataItem.standardCurrencyCode != null && dataItem.standardCurrencyCode != "null")
    values[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE] = dataItem.standardCurrencyCode;
  if (dataItem.currencySymbol != null && dataItem.currencySymbol != "null")
    values[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL] = dataItem.currencySymbol;
  if (dataItem.exchangeRate != null && dataItem.exchangeRate != "null")
    values[ColumnsBase.KEY_CURRENCY_EXCHANGERATE] = dataItem.exchangeRate;
  if (dataItem.isDefaultCurrency != null && dataItem.isDefaultCurrency != "null")
    values[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY] = dataItem.isDefaultCurrency;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_CURRENCY_CREATEDON] = dataItem.createdOn;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_CURRENCY_CREATEDBY] = dataItem.createdBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_CURRENCY_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_CURRENCY_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_CURRENCY_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_CURRENCY_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_CURRENCY_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_CURRENCY_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_CURRENCY_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

            id =  await db.update(TablesBase.TABLE_CURRENCY, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateCurrencyRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteCurrencyRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            id =  await db.delete(TablesBase.TABLE_CURRENCY, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteCurrencyRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_CURRENCY_CURRENCYID}";
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_CURRENCY_CURRENCYID];
            }
         
        } catch ( ex) {
            Globals.handleException( "CurrencyDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CURRENCY_CURRENCYID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }


        } catch ( ex) {
            Globals.handleException( "CurrencyDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Currency>> GetCurrencyUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<Currency> dataList = [];
        try {
            String selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_CURRENCY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_CURRENCY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_CURRENCY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];
  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
            Globals.handleException( "CurrencyDataHandlerBase:GetCurrencyUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<Currency?> GetCurrencyRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        Currency? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
		selectQuery += "${" FROM " + TablesBase.TABLE_CURRENCY} A "; 
		selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_COUNTRY} D ON A.${ColumnsBase.KEY_CURRENCY_COUNTRYID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_CURRENCY_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_CURRENCY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db = await databaseHandler.database;

            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                    Currency dataItem = new Currency();

                    dataItem.currencyID = element[ColumnsBase.KEY_CURRENCY_CURRENCYID];
                    dataItem.currencyCode = element[ColumnsBase.KEY_CURRENCY_CURRENCYCODE];
                    dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
                    dataItem.countryID = element[ColumnsBase.KEY_CURRENCY_COUNTRYID];
                    dataItem.standardCurrencyCode = element[ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE];
                    dataItem.currencySymbol = element[ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL];
                    dataItem.exchangeRate = element[ColumnsBase.KEY_CURRENCY_EXCHANGERATE];
                    dataItem.isDefaultCurrency = element[ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY];
                    dataItem.isArchived = element[ColumnsBase.KEY_CURRENCY_ISARCHIVED];
                    dataItem.isActive = element[ColumnsBase.KEY_CURRENCY_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CURRENCY_ISDELETED];
                    dataItem.createdBy = element[ColumnsBase.KEY_CURRENCY_CREATEDBY];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_CURRENCY_MODIFIEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CURRENCY_CREATEDON];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CURRENCY_MODIFIEDON];

                    dataItem.countryName = element[ColumnsBase.KEY_COUNTRY_COUNTRYNAME];

                    dataItem.uid = element[ColumnsBase.KEY_CURRENCY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_CURRENCY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CURRENCY_APPUSERGROUPID];

  dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
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
	    Globals.handleException( "CurrencyDataHandlerBase:GetCurrencyRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}