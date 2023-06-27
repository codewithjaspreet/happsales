
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Currency.dart';
import '../DataBaseHandler.dart';
import 'CurrencyDataHandlerBase.dart';

class CurrencyDataHandler extends CurrencyDataHandlerBase {

     static Future<Currency?> GetDefaultCurrency(DatabaseHandler databaseHandler) async{
        Currency? dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_COUNTRY_COUNTRYNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CURRENCY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_COUNTRY + " D ON A." + ColumnsBase.KEY_CURRENCY_COUNTRYID + " = D." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE COALESCE(A." + ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY + ",'false') = 'true' ";
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_CURRENCY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

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

	/*-------------------HAPPSALES-------------------*/

}