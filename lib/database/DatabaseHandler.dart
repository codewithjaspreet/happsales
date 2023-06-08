import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'Columns.dart';
import 'ColumnsBase.dart';
import 'TablesBase.dart';

class DatabaseHandler {
  static Database? _database;
  static final DatabaseHandler db = DatabaseHandler._();
  static const String DATABASE_NAME = "amidb";

  DatabaseHandler._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, DATABASE_NAME);

    try {
      return await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        final String CREATE_TABLE_CONFIGURATION =
            "CREATE TABLE ${TablesBase.TABLE_CONFIGURATION} ("
            "${ColumnsBase.KEY_CONFIGURATION_ID} INTEGER PRIMARY KEY,"
            "${ColumnsBase.KEY_CONFIGURATION_APPID} TEXT,"
            "${ColumnsBase.KEY_CONFIGURATION_APP_VERSION} TEXT,"
            "${ColumnsBase.KEY_CONFIGURATION_OS_VERSION} TEXT,"
            "${ColumnsBase.KEY_CONFIGURATION_EULA} TEXT,"
            "${ColumnsBase.KEY_CONFIGURATION_BASE_URL} TEXT,"
            "${ColumnsBase.KEY_CONFIGURATION_DEPLOYEDTIME} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CONFIGURATION);
        String CREATE_TABLE_SYNC = "CREATE TABLE ${TablesBase.TABLE_APPSYNC} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_APPSYNC_TABLENAME} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_PAGESIZE} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_RECORDS} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_PAGE} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_SYNCTIME} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_SYNC);

        String CREATE_TABLE_DESIGNATION_BC =
            "CREATE TABLE ${TablesBase.TABLE_DESIGNATION_BC} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} TEXT"
            ")";
        await db.execute(CREATE_TABLE_DESIGNATION_BC);
        String CREATE_TABLE_ACCOUNT =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_WEBSITE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_TURNOVER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_CURRENCYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_PHONE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_EMAIL} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_FAX} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_CITY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_STATE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_COUNTRY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_PIN} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_TERRITORYNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT} TEXT,"
            "${Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH} TEXT,"
            "${Columns.KEY_ACCOUNT_LOGO_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_TAGS} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";

        await db.execute(CREATE_TABLE_ACCOUNT);
        String CREATE_TABLE_ACCOUNTADDRESS =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTADDRESS} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_CITY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_STATE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_PIN} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTADDRESS);

        String CREATE_TABLE_ACCOUNTBUSINESSPLAN =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTBUSINESSPLAN);

        String CREATE_TABLE_ACCOUNTBUYINGPROCESS =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTBUYINGPROCESS} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ACCOUNTBUYINGPROCESSID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ACCOUNTBUYINGPROCESSCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_BUYINGPROCESS} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTBUYINGPROCESS_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTBUYINGPROCESS);

        String CREATE_TABLE_ACCOUNTCATEGORY =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTCATEGORY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTCATEGORY);

        String CREATE_TABLE_ACCOUNTCATEGORYMAPPING =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTCATEGORYMAPPING);

        String CREATE_TABLE_ACCOUNTCOMPETITIONACTIVITY =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTCOMPETITIONACTIVITY);

        String CREATE_TABLE_ACCOUNTFORM =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTFORM} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_FORMID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_FILENAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_FILEURL} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTFORM);

        String CREATE_TABLE_ACCOUNTFORMVALUE =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTFORMVALUE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUEID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMVALUECODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ACCOUNTFORMID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_FORMCELLELEMENTVALUE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ROWINDEX} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTFORMVALUE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTFORMVALUE);

        String CREATE_TABLE_ACCOUNTMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIAID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_TAGS} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_LOCALMEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTMEDIA);

        String CREATE_TABLE_ACCOUNTPHONE =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTPHONE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONEID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTPHONECODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_PHONE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_PHONETYPENAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ACCOUNTADDRESSID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTPHONE_LEADQUALIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTPHONE);

        String CREATE_TABLE_ACCOUNTSEGMENT =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTSEGMENT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_MINIMUMTURNOVER} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_CURRENCYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSEGMENT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTSEGMENT);

        String CREATE_TABLE_ACCOUNTSTATUS =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTSTATUS} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTSTATUS_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTSTATUS);

        String CREATE_TABLE_ACCOUNTTERRITORY =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTTERRITORY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ACCOUNTTERRITORYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ACCOUNTTERRITORYCODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_TERRITORYID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTERRITORY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTTERRITORY);
        String CREATE_TABLE_ACCOUNTTYPE =
            "CREATE TABLE ${TablesBase.TABLE_ACCOUNTTYPE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPECODE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_UID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACCOUNTTYPE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACCOUNTTYPE);
        String CREATE_TABLE_ACTIVITY =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_LEADSOURCE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_CURRENCYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISTRAVELLED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_INVOICEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_TAGS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISAPPROVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_LOCATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISLOCKED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITY);

        String CREATE_TABLE_ACTIVITYMEASURE =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYMEASURE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ACTIVITYMEASUREID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ACTIVITYMEASURECODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ACTIVITYMEASURENAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ISDEFAULT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_SEQUENTIALORDER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEASURE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYMEASURE);

        String CREATE_TABLE_ACTIVITYMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIAID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_TAGS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_LOCALMEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_LOCATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYMEDIA);

        String CREATE_TABLE_ACTIVITYPERMISSION =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYPERMISSION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYPERMISSION);

        String CREATE_TABLE_ACTIVITYPRIORITY =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYPRIORITY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYPRIORITY);

        String CREATE_TABLE_ACTIVITYPRODUCT =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYPRODUCT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_PRICE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYPRODUCT);

        String CREATE_TABLE_ACTIVITYPRODUCTDETAIL =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYPRODUCTDETAIL);

        String CREATE_TABLE_ACTIVITYSTATUS =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYSTATUS} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ALERTMESSAGE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYSTATUS);

        String CREATE_TABLE_ACTIVITYTEAM =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYTEAM} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYTEAM);

        String CREATE_TABLE_ACTIVITYTRAVEL =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELDATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_STARTLOCATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ENDLOCATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_STARTLOCATIONCOORDINATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ENDLOCATIONCOORDINATE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTUALDISTANCE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_DISTANCETRAVELLED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_MODEOFTRAVELID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_TRAVELEXPENSE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_REASONFORDEVIATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_OTHEREXPENSE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_TAGS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ISSUBMITTED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_REMARKS} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_LOCATION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVEL_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYTRAVEL);

        String CREATE_TABLE_ACTIVITYTRAVELMAPPING =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYTRAVELMAPPING} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYTRAVELMAPPING);

        String CREATE_TABLE_ACTIVITYTRAVELMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYTRAVELMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ACTIVITYTRAVELMEDIAID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ACTIVITYTRAVELMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ACTIVITYTRAVELMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ACTIVITYTRAVELID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_TAGS} TEXT,"
            "${Columns.KEY_ACTIVITYTRAVELMEDIA_LOCALMEDIAPATH} TEXT,"
            "${Columns.KEY_ACTIVITYTRAVELMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTRAVELMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYTRAVELMEDIA);

        String CREATE_TABLE_ACTIVITYTYPE =
            "CREATE TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPEID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPECODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_BUSINESSFEATUREID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_SEQUENTIALORDER} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_UID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ACTIVITYTYPE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ACTIVITYTYPE);

        String CREATE_TABLE_ADDRESSTYPE =
            "CREATE TABLE ${TablesBase.TABLE_ADDRESSTYPE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPEID} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPECODE} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ADDRESSTYPENAME} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_UID} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_ADDRESSTYPE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_ADDRESSTYPE);

        String CREATE_TABLE_APPFEATURE =
            "CREATE TABLE ${TablesBase.TABLE_APPFEATURE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_APPFEATURE_APPFEATUREID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPFEATURECODE} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPFEATURENAME} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_FORMNAME} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPICON} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_CONSOLEICON} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_UID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_APPFEATURE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_APPFEATURE);

// Add more tables here if needed

// Sample usage:
// await db.execute(CREATE_TABLE_ANOTHER_TABLE);

        String CREATE_TABLE_APPFEATUREGROUP =
            "CREATE TABLE ${TablesBase.TABLE_APPFEATUREGROUP} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPICON} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_UID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_APPFEATUREGROUP);

        String CREATE_TABLE_APPLOG =
            "CREATE TABLE ${TablesBase.TABLE_APPLOG} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPLOG_APPLOGID} TEXT," +
                "${ColumnsBase.KEY_APPLOG_APPLOGCODE} TEXT," +
                "${ColumnsBase.KEY_APPLOG_APPLOGDETAIL} TEXT," +
                "${ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM} TEXT," +
                "${ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION} TEXT," +
                "${ColumnsBase.KEY_APPLOG_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPLOG_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPLOG_UID} TEXT," +
                "${ColumnsBase.KEY_APPLOG_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPLOG_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPLOG_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPLOG);

        String CREATE_TABLE_APPREPORT =
            "CREATE TABLE ${TablesBase.TABLE_APPREPORT} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPREPORT_APPREPORTID} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPREPORTCODE} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPREPORTPATH} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPREPORTTYPE} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_UID} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPREPORT_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPREPORT);

        String CREATE_TABLE_APPUSAGE =
            "CREATE TABLE ${TablesBase.TABLE_APPUSAGE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSAGE_APPUSAGEID} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_APPUSAGECODE} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_APPUSAGENAME} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_USAGECOUNT} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSAGE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSAGE);

        String CREATE_TABLE_APPUSER = "CREATE TABLE ${TablesBase.TABLE_APPUSER} (" +
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
            "${ColumnsBase.KEY_APPUSER_APPUSERID} TEXT," +
            "${ColumnsBase.KEY_APPUSER_APPUSERCODE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_APPUSERNAME} TEXT," +
            "${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} TEXT," +
            "${ColumnsBase.KEY_APPUSER_DESIGNATION} TEXT," +
            "${ColumnsBase.KEY_APPUSER_MOBILENUMBER} TEXT," +
            "${ColumnsBase.KEY_APPUSER_EMAIL} TEXT," +
            "${ColumnsBase.KEY_APPUSER_OFFICIALADDRESS} TEXT," +
            "${ColumnsBase.KEY_APPUSER_EMPLOYEEID} TEXT," +
            "${ColumnsBase.KEY_APPUSER_LOGINNAME} TEXT," +
            "${ColumnsBase.KEY_APPUSER_PASSCODE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL1} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE1} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION1} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL2} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE2} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION2} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL3} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE3} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION3} TEXT," +
            "${ColumnsBase.KEY_APPUSER_PROFILEPICTURE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_PROFILECAPTION} TEXT," +
            "${ColumnsBase.KEY_APPUSER_PROFILELOCATION} TEXT," +
            "${ColumnsBase.KEY_APPUSER_COMPANYLOGO} TEXT," +
            "${ColumnsBase.KEY_APPUSER_COMPANYCAPTION} TEXT," +
            "${ColumnsBase.KEY_APPUSER_USECOMPANYLOGO} TEXT," +
            "${ColumnsBase.KEY_APPUSER_TIMEZONECODE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_CURRECYCODE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_CURRENTLOGINON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_LASTLOGINON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_APPLASTLOGINON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISMAILSENT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_CONTACTSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACTIVITYOTHERSSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_OPPORTUNITYDELIVEREDSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_NOTESORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_USERTOKEN} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED} TEXT," +
            "${Columns.KEY_APPUSER_CONFIGURATION} TEXT," +
            "${Columns.KEY_APPUSER_MUTECHAT} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISWOR} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISAPPALLOWED} TEXT," +
            "${ColumnsBase.KEY_APPUSER_CREATEDBY} TEXT," +
            "${ColumnsBase.KEY_APPUSER_CREATEDON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_MODIFIEDBY} TEXT," +
            "${ColumnsBase.KEY_APPUSER_MODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_APPUSER_UID} TEXT," +
            "${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISARCHIVED} TEXT," +
            "${ColumnsBase.KEY_APPUSER_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_ISDIRTY} TEXT," +
            "${ColumnsBase.KEY_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_SCREATEDON} TEXT," +
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
            "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
            ")";
        await db.execute(CREATE_TABLE_APPUSER);

        String CREATE_TABLE_APPUSERLOCATION =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERLOCATION} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_LOCATION} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERLOCATION_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERLOCATION);

        String CREATE_TABLE_APPUSERMESSAGE =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERMESSAGE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERMESSAGE);

        String CREATE_TABLE_APPUSERPRODUCT =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERPRODUCT} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERPRODUCT);

        String CREATE_TABLE_APPUSERREMARK =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERREMARK} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_LOCATION} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERREMARK_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERREMARK);

        String CREATE_TABLE_APPUSERROLE =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERROLE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERROLE_APPUSERROLEID} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_APPUSERROLECODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_USERROLEID} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERROLE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERROLE);

        String CREATE_TABLE_APPUSERTEAM =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERTEAM} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAM_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERTEAM);

        String CREATE_TABLE_APPUSERTEAMMEMBER =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERTEAMMEMBER} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERTEAMMEMBER);
        String CREATE_TABLE_APPUSERTERRITORY =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERTERRITORY} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERTERRITORYID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERTERRITORYCODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_TERRITORYID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_APPUSERTERRITORY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERTERRITORY);
        String CREATE_TABLE_APPUSERTYPE =
            "CREATE TABLE ${TablesBase.TABLE_APPUSERTYPE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_UID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_APPUSERTYPE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_APPUSERTYPE);

        String CREATE_TABLE_ATTRIBUTE =
            "CREATE TABLE ${TablesBase.TABLE_ATTRIBUTE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_UID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_ATTRIBUTE);

        String CREATE_TABLE_ATTRIBUTEVALUE =
            "CREATE TABLE ${TablesBase.TABLE_ATTRIBUTEVALUE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUEID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUECODE} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_MULTIPLIER} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_UID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_ATTRIBUTEVALUE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_ATTRIBUTEVALUE);

        String CREATE_TABLE_BUSINESSEMAIL =
            "CREATE TABLE ${TablesBase.TABLE_BUSINESSEMAIL} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILCODE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILADDRESS} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_PURPOSE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_REMARKS} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_ISAPPROVED} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_HSREMARKS} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_UID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_BUSINESSEMAIL_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_BUSINESSEMAIL);

        String CREATE_TABLE_BUSINESSFEATURE =
            "CREATE TABLE ${TablesBase.TABLE_BUSINESSFEATURE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_APPICON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_UID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_BUSINESSFEATURE);

        String CREATE_TABLE_CHATMESSAGE =
            "CREATE TABLE ${TablesBase.TABLE_CHATMESSAGE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECODE} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECONTENT} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CONTENTTYPE} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_LOCALMEDIAPATH} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_ISUPLOADED} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_MEDIAPATH} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_ISREAD} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_READSTATUS} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_OBJECTNAME} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_OBJECTID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_OBJECTCODE} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_OBJECTACTION} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_UID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_CHATMESSAGE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_CHATMESSAGE);
        String CREATE_TABLE_CHATUSERANDGROUP =
            "CREATE TABLE ${TablesBase.TABLE_CHATUSERANDGROUP} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_UID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_CHATUSERANDGROUP);

        String CREATE_TABLE_CHATUSERGROUPMEMBER =
            "CREATE TABLE ${TablesBase.TABLE_CHATUSERGROUPMEMBER} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID} TEXT," +
                "${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME} TEXT," +
                "${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION} TEXT," +
                "${Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER} TEXT," +
                "${Columns.KEY_CHATUSERGROUPMEMBER_EMAIL} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_CHATUSERGROUPMEMBER);

        String CREATE_TABLE_CONTACT =
            "CREATE TABLE ${TablesBase.TABLE_CONTACT} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_CONTACT_CONTACTID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CONTACTCODE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_TITLE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_FIRSTNAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_MIDDLENAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_LASTNAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CONTACTNAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ACCOUNTID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_DEPARTMENTNAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_DESIGNATION} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REPORTINGMANAGER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_MOBILENUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_WORKPHONE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_RESIDENCEPHONE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_EMAIL} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ADDRESSLINE1} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ADDRESSLINE2} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ADDRESSLINE3} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CITY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_STATE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_COUNTRY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_PIN} TEXT," +
                "${ColumnsBase.KEY_CONTACT_GPSCOORDINATES} TEXT," +
                "${ColumnsBase.KEY_CONTACT_LINKEDIN} TEXT," +
                "${ColumnsBase.KEY_CONTACT_PASTACCOUNTS} TEXT," +
                "${ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS} TEXT," +
                "${ColumnsBase.KEY_CONTACT_DATEOFBIRTH} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REMARKS} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REFERENCEHISTORY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT} TEXT," +
                "${ColumnsBase.KEY_CONTACT_TAGS} TEXT," +
                "${ColumnsBase.KEY_CONTACT_FREETEXTFIELD1} TEXT," +
                "${ColumnsBase.KEY_CONTACT_FREETEXTFIELD2} TEXT," +
                "${ColumnsBase.KEY_CONTACT_FREETEXTFIELD3} TEXT," +
                "${ColumnsBase.KEY_CONTACT_COMPANYNAME} TEXT," +
                "${ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_PASSPORTNUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_CONTACT_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_CONTACT_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_CONTACT_UID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_CONTACT_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_CONTACT);

        String CREATE_TABLE_CONTACTALIGNMENT =
            "CREATE TABLE ${TablesBase.TABLE_CONTACTALIGNMENT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTID} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTCODE} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_INDICATORCOLOR} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_UID} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CONTACTALIGNMENT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CONTACTALIGNMENT);

        String CREATE_TABLE_CONTACTMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_CONTACTMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIAID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CONTACTMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_TAGS} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_LOCALMEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CONTACTMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CONTACTMEDIA);

        String CREATE_TABLE_CONTACTTITLE =
            "CREATE TABLE ${TablesBase.TABLE_CONTACTTITLE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLEID} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLECODE} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_CONTACTTITLENAME} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_UID} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CONTACTTITLE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CONTACTTITLE);

        String CREATE_TABLE_CONTENTTYPE =
            "CREATE TABLE ${TablesBase.TABLE_CONTENTTYPE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPECODE} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_UID} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CONTENTTYPE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CONTENTTYPE);

        String CREATE_TABLE_COUNTRY =
            "CREATE TABLE ${TablesBase.TABLE_COUNTRY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_COUNTRY_COUNTRYID} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_COUNTRYCODE} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_COUNTRYNAME} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_UID} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_COUNTRY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_COUNTRY);

        String CREATE_TABLE_CREDITRATING =
            "CREATE TABLE ${TablesBase.TABLE_CREDITRATING} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CREDITRATING_CREDITRATINGID} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_CREDITRATINGCODE} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_CREDITRATINGDESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_UID} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CREDITRATING_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CREDITRATING);
        String CREATE_TABLE_CURRENCY =
            "CREATE TABLE ${TablesBase.TABLE_CURRENCY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CURRENCY_CURRENCYID} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_CURRENCYCODE} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_CURRENCYNAME} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_COUNTRYID} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_STANDARDCURRENCYCODE} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_CURRENCYSYMBOL} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_EXCHANGERATE} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_ISDEFAULTCURRENCY} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_UID} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CURRENCY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CURRENCY);

        String CREATE_TABLE_CUSTOMERMEETING =
            "CREATE TABLE ${TablesBase.TABLE_CUSTOMERMEETING} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGTITLE} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTLOCATION} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_REMARKS} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_UID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_CUSTOMERMEETING);

        String CREATE_TABLE_DEPARTMENT = "CREATE TABLE " +
            TablesBase.TABLE_DEPARTMENT +
            "(" +
            ColumnsBase.KEY_ID +
            " INTEGER PRIMARY KEY AUTOINCREMENT," +
            ColumnsBase.KEY_DEPARTMENT_DEPARTMENTID +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_DEPARTMENTCODE +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_DEPARTMENTNAME +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_CREATEDON +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_CREATEDBY +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_MODIFIEDON +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_MODIFIEDBY +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_ISACTIVE +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_UID +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_APPUSERID +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_APPUSERGROUPID +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_ISARCHIVED +
            " TEXT," +
            ColumnsBase.KEY_DEPARTMENT_ISDELETED +
            " TEXT," +
            ColumnsBase.KEY_ISDIRTY +
            " TEXT," +
            ColumnsBase.KEY_ISACTIVE +
            " TEXT," +
            ColumnsBase.KEY_ISDELETED +
            " TEXT," +
            ColumnsBase.KEY_UPSYNCMESSAGE +
            " TEXT," +
            ColumnsBase.KEY_DOWNSYNCMESSAGE +
            " TEXT," +
            ColumnsBase.KEY_SCREATEDON +
            " TEXT," +
            ColumnsBase.KEY_SMODIFIEDON +
            " TEXT," +
            ColumnsBase.KEY_CREATEDBYUSER +
            " TEXT," +
            ColumnsBase.KEY_MODIFIEDBYUSER +
            " TEXT," +
            ColumnsBase.KEY_UPSYNCINDEX +
            " INTEGER," +
            ColumnsBase.KEY_OWNERUSERID +
            " TEXT" +
            ")";
        await db.execute(CREATE_TABLE_DEPARTMENT);

        String CREATE_TABLE_DESIGNATION =
            "CREATE TABLE ${TablesBase.TABLE_DESIGNATION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_DESIGNATION_DESIGNATIONID} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_UID} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_DESIGNATION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_DESIGNATION);

        String CREATE_TABLE_EMAILMANUALTEMPLATE =
            "CREATE TABLE ${TablesBase.TABLE_EMAILMANUALTEMPLATE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATEID} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATECODE} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILMANUALTEMPLATENAME} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTEMPLATETYPE} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_SUBJECT} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_MAILBODY} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_FROMEMAIL} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_TOEMAIL} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_CCEMAIL} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_EMAILTYPE} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISSYSTEMDEFINED} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_UID} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_EMAILMANUALTEMPLATE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_EMAILMANUALTEMPLATE);

        String CREATE_TABLE_FIELDATTENDANCE =
            "CREATE TABLE ${TablesBase.TABLE_FIELDATTENDANCE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_REMARKS} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_UID} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FIELDATTENDANCE);

        String CREATE_TABLE_FINANCIALYEAR =
            "CREATE TABLE ${TablesBase.TABLE_FINANCIALYEAR} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_UID} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FINANCIALYEAR_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FINANCIALYEAR);

        String CREATE_TABLE_FORM = "CREATE TABLE ${TablesBase.TABLE_FORM} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FORM_FORMID} TEXT,"
            "${ColumnsBase.KEY_FORM_FORMCODE} TEXT,"
            "${ColumnsBase.KEY_FORM_FORMNAME} TEXT,"
            "${ColumnsBase.KEY_FORM_BUSINESSFEATUREID} TEXT,"
            "${ColumnsBase.KEY_FORM_FORMTYPE} TEXT,"
            "${ColumnsBase.KEY_FORM_LINKTO} TEXT,"
            "${ColumnsBase.KEY_FORM_FORSTATUS} TEXT,"
            "${ColumnsBase.KEY_FORM_SORTORDER} TEXT,"
            "${ColumnsBase.KEY_FORM_ISMANDATORY} TEXT,"
            "${ColumnsBase.KEY_FORM_DISPLAYINAPP} TEXT,"
            "${ColumnsBase.KEY_FORM_PDFSIZE} TEXT,"
            "${ColumnsBase.KEY_FORM_DATASCRIPTWEB} TEXT,"
            "${ColumnsBase.KEY_FORM_DATASCRIPTAPP} TEXT,"
            "${ColumnsBase.KEY_FORM_PARENTFORMID} TEXT,"
            "${ColumnsBase.KEY_FORM_EMAILMANUALTEMPLATEID} TEXT,"
            "${ColumnsBase.KEY_FORM_EMAILAUTOMATEDTEMPLATEID} TEXT,"
            "${ColumnsBase.KEY_FORM_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FORM_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FORM_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FORM_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FORM_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FORM_UID} TEXT,"
            "${ColumnsBase.KEY_FORM_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FORM_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FORM_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FORM_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FORM);

        String CREATE_TABLE_FORMCELL =
            "CREATE TABLE ${TablesBase.TABLE_FORMCELL} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FORMCELL_FORMCELLID} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_FORMCELLCODE} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_FORMCELLNAME} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_FORMSECTIONID} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ROWINDEX} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_COLUMNINDEX} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ROWSPAN} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_COLUMNSPAN} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ALIGNMENT} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_VERTICALALIGNMENT} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_UID} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FORMCELL_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FORMCELL);

        String CREATE_TABLE_FORMCELLELEMENT =
            "CREATE TABLE ${TablesBase.TABLE_FORMCELLELEMENT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTCODE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLELEMENTNAME} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FORMCELLID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CONTROLNAME} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CONTROLTYPE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CONTROLLABEL} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CHECKBOXLABELPOSITION} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CONTROLVALUES} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DEFAULTVALUE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_HEIGHT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_WIDTH} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISREQUIRED} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISPLACEHOLDER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_PLACEHOLDERWIDTH} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINAPP} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DISPLAYINREPORT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_HORIZONTALALIGNMENT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_VERTICALALIGNMENT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FONTSIZE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FONTWEIGHT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_FORECOLOR} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_BACKGROUNDCOLOR} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_SEQUENTIALORDER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_STARTONNEWLINE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_LINEBREAKAFTER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_PADDINGLEFT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_PADDINGRIGHT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_NEEDAUTONUMBER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBERPREFIX} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_AUTONUMBER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISDISABLED} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ATTRIBUTEID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CANTRIGGEREVENT} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP1} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTAPP2} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB1} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_DATASCRIPTWEB2} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_EVENTCLASSNAME} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISTOTALVALUE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_SIGNATURETYPE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_UID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FORMCELLELEMENT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FORMCELLELEMENT);

        String CREATE_TABLE_FORMSECTION =
            "CREATE TABLE ${TablesBase.TABLE_FORMSECTION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_FORMSECTION_FORMSECTIONID} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_FORMSECTIONCODE} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_FORMSECTIONNAME} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_FORMID} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_NUMBEROFROWS} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_NUMBEROFCOLUMNS} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_COLUMNWIDTHS} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_SECTIONSTYLE} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_SECTIONTYPE} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_SECTIONORDER} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_BACKGROUNDCOLOR} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_DISPLAYINAPP} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_DISPLAYINREPORT} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_ISREPEATABLE} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_UID} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_FORMSECTION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_FORMSECTION);

        String CREATE_TABLE_INDUSTRY =
            "CREATE TABLE ${TablesBase.TABLE_INDUSTRY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_INDUSTRY_INDUSTRYID} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_INDUSTRYCODE} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_INDUSTRYNAME} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_UID} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_INDUSTRY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_INDUSTRY);

        String CREATE_TABLE_LEADSOURCE =
            "CREATE TABLE ${TablesBase.TABLE_LEADSOURCE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_LEADSOURCE_LEADSOURCEID} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_LEADSOURCECODE} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_LEADSOURCENAME} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_UID} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_LEADSOURCE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_LEADSOURCE);

        String CREATE_TABLE_MODEOFTRAVEL =
            "CREATE TABLE ${TablesBase.TABLE_MODEOFTRAVEL} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELID} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELCODE} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_RATEPERKILOMETER} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_UID} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_MODEOFTRAVEL_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_MODEOFTRAVEL);
        String CREATE_TABLE_NOTE = "CREATE TABLE ${TablesBase.TABLE_NOTE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_NOTE_NOTEID} TEXT,"
            "${ColumnsBase.KEY_NOTE_NOTECODE} TEXT,"
            "${ColumnsBase.KEY_NOTE_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_NOTE_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_NOTE_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_NOTE_ACTIVITYID} TEXT,"
            "${ColumnsBase.KEY_NOTE_ISPERSONAL} TEXT,"
            "${ColumnsBase.KEY_NOTE_NOTEDATE} TEXT,"
            "${ColumnsBase.KEY_NOTE_NOTECONTENT} TEXT,"
            "${ColumnsBase.KEY_NOTE_TAGS} TEXT,"
            "${ColumnsBase.KEY_NOTE_FREETEXTFIELD1} TEXT,"
            "${ColumnsBase.KEY_NOTE_FREETEXTFIELD2} TEXT,"
            "${ColumnsBase.KEY_NOTE_FREETEXTFIELD3} TEXT,"
            "${ColumnsBase.KEY_NOTE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_NOTE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_NOTE_UID} TEXT,"
            "${ColumnsBase.KEY_NOTE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_NOTE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_NOTE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_NOTE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_NOTE);

        String CREATE_TABLE_NOTEMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_NOTEMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_NOTEID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_TAGS} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_NOTEMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_NOTEMEDIA);

        String CREATE_TABLE_NOTEPERMISSION =
            "CREATE TABLE ${TablesBase.TABLE_NOTEPERMISSION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONID} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_NOTEPERMISSIONCODE} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_NOTEID} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_PERMISSIONLEVEL} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_UID} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_NOTEPERMISSION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_NOTEPERMISSION);

        String CREATE_TABLE_NOTIFICATION =
            "CREATE TABLE ${TablesBase.TABLE_NOTIFICATION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_SENDTOALL} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_UID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_NOTIFICATION);

        String CREATE_TABLE_NOTIFICATIONASSIGNMENT =
            "CREATE TABLE ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_NOTIFICATIONASSIGNMENT);

        String CREATE_TABLE_OPPORTUNITY =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_TAGS} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISLOCKED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITY);

        String CREATE_TABLE_OPPORTUNITYCONTACT =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYCONTACT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYCONTACT);

        String CREATE_TABLE_OPPORTUNITYMEASURE =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYMEASURE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYMEASURE);

        String CREATE_TABLE_OPPORTUNITYFULFILLMENTSTATUS =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYFULFILLMENTSTATUS);

        String CREATE_TABLE_OPPORTUNITYMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYMEDIA} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYMEDIA);

        String CREATE_TABLE_OPPORTUNITYNAME =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYNAME} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYNAME);

        String CREATE_TABLE_OPPORTUNITYPERMISSION =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPERMISSION} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYPERMISSION);

        String CREATE_TABLE_OPPORTUNITYPRIORITY =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPRIORITY} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYPRIORITY);

        String CREATE_TABLE_OPPORTUNITYPRODUCT =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCT} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRICE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_OPPORTUNITYPRODUCT_REFERENCEIDENTIFIER} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYPRODUCT);

        String CREATE_TABLE_OPPORTUNITYPRODUCTDETAIL =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_UID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYPRODUCTDETAIL);

        String CREATE_TABLE_OPPORTUNITYSTAGE =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS} TEXT," +
                // "${Columns.KEY_OPPORTUNITYSTAGE_STAGNANTDAYS} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGE_UID} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYSTAGE);

        String CREATE_TABLE_OPPORTUNITYSTAGETYPE =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGETYPE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYSTAGETYPE);

        String CREATE_TABLE_OPPORTUNITYSTATUS =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTATUS} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_ALERTMESSAGE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_UID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYSTATUS);

        String CREATE_TABLE_OPPORTUNITYTEAM =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYTEAM} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_UID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYTEAM);

        String CREATE_TABLE_OPPORTUNITYTYPE =
            "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYTYPE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_INTERNALCODE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_ISDEFAULT} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_UID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_OPPORTUNITYTYPE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_OPPORTUNITYTYPE);

        String CREATE_TABLE_PHONETYPE =
            "CREATE TABLE ${TablesBase.TABLE_PHONETYPE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_PHONETYPE_PHONETYPEID} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_PHONETYPECODE} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_PHONETYPENAME} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_UID} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_PHONETYPE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_PHONETYPE);

        String CREATE_TABLE_PRODUCT =
            "CREATE TABLE ${TablesBase.TABLE_PRODUCT} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTCODE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_MANUFACTURER} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_HSNCODE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_MRP} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRICE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRICEFORSALES} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISSALEABLE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_TAGS} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_REMARKS} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_UID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_PRODUCT_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_PRODUCT);

        String CREATE_TABLE_PRODUCTAUXILIARY =
            "CREATE TABLE ${TablesBase.TABLE_PRODUCTAUXILIARY} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_UID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER} TEXT," +
                "${ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_PRODUCTAUXILIARY);

        String CREATE_TABLE_PRODUCTCATEGORY =
            "CREATE TABLE ${TablesBase.TABLE_PRODUCTCATEGORY} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYCODE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_PARENTPRODUCTCATEGORYID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_UID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_PRODUCTCATEGORY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_PRODUCTCATEGORY);

        String CREATE_TABLE_PRODUCTINSTALLATION = "CREATE TABLE ${TablesBase.TABLE_PRODUCTINSTALLATION} (" +
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTINSTALLATIONID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTINSTALLATIONCODE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_INSTALLATIONIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_ACCOUNTID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_CONTACTID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_SERIALNUMBER} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_PARTNUMBER} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_MODEL} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_DATEOFMANUFACTURE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_LOCATIONUNIT} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_LOCATIONADDRESS} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_DATEOFCOMMISSIONING} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_APPLICATIONOFPRODUCT} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_WARRANTYENDDATE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_USAGEHOURSPERWEEK} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_CREATEDON} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_CREATEDBY} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_MODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_MODIFIEDBY} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_UID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_APPUSERID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_APPUSERGROUPID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_ISARCHIVED} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATION_REFERENCEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_ISDIRTY} TEXT," +
            "${ColumnsBase.KEY_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_SCREATEDON} TEXT," +
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
            "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
            ")";
        await db.execute(CREATE_TABLE_PRODUCTINSTALLATION);

        String CREATE_TABLE_PRODUCTINSTALLATIONDETAIL = "CREATE TABLE ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} (" +
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_SERIALNUMBER} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PARTNUMBER} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODEL} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_DATEOFMANUFACTURE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPLICATIONOFPRODUCT} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_DATEOFCOMMISSIONING} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_LIFETIMEINHOURS} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_USAGEHOURSPERWEEK} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_CREATEDON} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_CREATEDBY} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODIFIEDBY} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_UID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPUSERID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPUSERGROUPID} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISARCHIVED} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_REFERENCEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_ISDIRTY} TEXT," +
            "${ColumnsBase.KEY_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_SCREATEDON} TEXT," +
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
            "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
            ")";
        await db.execute(CREATE_TABLE_PRODUCTINSTALLATIONDETAIL);

        String CREATE_TABLE_PRODUCTMEDIA =
            "CREATE TABLE ${TablesBase.TABLE_PRODUCTMEDIA} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIAID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIACODE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIANAME} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_CONTENTTYPEID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_MEDIAPATH} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_MEDIACONTENT} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_TAGS} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_LOCALMEDIAPATH} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_ISUPLOADED} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_UID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_PRODUCTMEDIA_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_PRODUCTMEDIA);

        String CREATE_TABLE_REIMBURSEMENT =
            "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENT} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTCODE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTTITLE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTDATE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_VOUCHERNUMBER} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_AMOUNT} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_ISPAID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_UID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENT_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_REIMBURSEMENT);

        String CREATE_TABLE_REIMBURSEMENTDETAIL =
            "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENTDETAIL} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILCODE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILTITLE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_BILLNUMBER} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_BILLDATE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_AMOUNT} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTTYPEID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ACTIVITYID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ACTIVITYTRAVELID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DOCUMENTPATH} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DOCUMENTCONTENT} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_UID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_REIMBURSEMENTDETAIL);

        String CREATE_TABLE_REIMBURSEMENTTYPE =
            "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENTTYPE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_UID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_REIMBURSEMENTTYPE);

        String CREATE_TABLE_REMINDER =
            "CREATE TABLE ${TablesBase.TABLE_REMINDER} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERCODE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERTITLE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERDATE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERTIME} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REMINDERREPEAT} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REPEATNUMBER} TEXT," +
                "${ColumnsBase.KEY_REMINDER_REPEATTYPE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ACTIVE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ACTIVITYID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ACCOUNTID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM} TEXT," +
                "${ColumnsBase.KEY_REMINDER_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_REMINDER_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_REMINDER_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_REMINDER_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_REMINDER_UID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_REMINDER_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_REMINDER);

        String CREATE_TABLE_RESOURCE =
            "CREATE TABLE ${TablesBase.TABLE_RESOURCE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_RESOURCE_RESOURCEID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_RESOURCECODE} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_RESOURCENAME} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_RESOURCEPATH} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_RESOURCECONTENT} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_DESCRIPTION} TEXT," +
                "${Columns.KEY_RESOURCE_RESOURCECATEGORYNAME} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_ISSHARABLE} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_VALIDUPTO} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_UID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_RESOURCE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_RESOURCE);

        String CREATE_TABLE_SERVICEINVOICE =
            "CREATE TABLE ${TablesBase.TABLE_SERVICEINVOICE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_BARCODE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_TAX} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_UID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_SERVICEINVOICE);

        String CREATE_TABLE_SERVICEINVOICEDETAIL =
            "CREATE TABLE ${TablesBase.TABLE_SERVICEINVOICEDETAIL} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_SERVICEINVOICEDETAIL);

        String CREATE_TABLE_TAG = "CREATE TABLE ${TablesBase.TABLE_TAG} (" +
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
            "${ColumnsBase.KEY_TAG_TAGID} TEXT," +
            "${ColumnsBase.KEY_TAG_TAGCODE} TEXT," +
            "${ColumnsBase.KEY_TAG_TAGNAME} TEXT," +
            "${ColumnsBase.KEY_TAG_DESCRIPTION} TEXT," +
            "${ColumnsBase.KEY_TAG_PARENTTAGID} TEXT," +
            "${ColumnsBase.KEY_TAG_TAGGROUPID} TEXT," +
            "${ColumnsBase.KEY_TAG_SORTORDER} TEXT," +
            "${ColumnsBase.KEY_TAG_CREATEDBY} TEXT," +
            "${ColumnsBase.KEY_TAG_CREATEDON} TEXT," +
            "${ColumnsBase.KEY_TAG_MODIFIEDBY} TEXT," +
            "${ColumnsBase.KEY_TAG_MODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_TAG_DEVICEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER} TEXT," +
            "${ColumnsBase.KEY_TAG_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_TAG_UID} TEXT," +
            "${ColumnsBase.KEY_TAG_APPUSERID} TEXT," +
            "${ColumnsBase.KEY_TAG_APPUSERGROUPID} TEXT," +
            "${ColumnsBase.KEY_TAG_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_ISDIRTY} TEXT," +
            "${ColumnsBase.KEY_ISACTIVE} TEXT," +
            "${ColumnsBase.KEY_ISDELETED} TEXT," +
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
            "${ColumnsBase.KEY_SCREATEDON} TEXT," +
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
            "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
            ")";
        await db.execute(CREATE_TABLE_TAG);

        String CREATE_TABLE_TAGGROUP =
            "CREATE TABLE ${TablesBase.TABLE_TAGGROUP} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_TAGGROUP_TAGGROUPID} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_LINKTO} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_SORTORDER} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_POSITIONINDEX} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_UID} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_TAGGROUP_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_TAGGROUP);

        String CREATE_TABLE_TERRITORY =
            "CREATE TABLE ${TablesBase.TABLE_TERRITORY} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_TERRITORY_TERRITORYID} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_TERRITORYCODE} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_TERRITORYNAME} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_DESCRIPTION} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_PARENTTERRITORYID} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_UID} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_TERRITORY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_TERRITORY);

        String CREATE_TABLE_TIMEZONE =
            "CREATE TABLE ${TablesBase.TABLE_TIMEZONE} (" +
                "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
                "${ColumnsBase.KEY_TIMEZONE_TIMEZONEID} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_TIMEZONECODE} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_TIMEZONENAME} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_GMTOFFSET} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_DSTCORRECTION} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_CREATEDON} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_CREATEDBY} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_MODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_MODIFIEDBY} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_UID} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_APPUSERID} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_ISARCHIVED} TEXT," +
                "${ColumnsBase.KEY_TIMEZONE_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_ISDIRTY} TEXT," +
                "${ColumnsBase.KEY_ISACTIVE} TEXT," +
                "${ColumnsBase.KEY_ISDELETED} TEXT," +
                "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT," +
                "${ColumnsBase.KEY_SCREATEDON} TEXT," +
                "${ColumnsBase.KEY_SMODIFIEDON} TEXT," +
                "${ColumnsBase.KEY_CREATEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT," +
                "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER," +
                "${ColumnsBase.KEY_OWNERUSERID} TEXT" +
                ")";
        await db.execute(CREATE_TABLE_TIMEZONE);

        String CREATE_TABLE_TRAVELPURPOSE =
            "CREATE TABLE ${TablesBase.TABLE_TRAVELPURPOSE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEID} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSECODE} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSENAME} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_TRAVELPURPOSEDESCRIPTION} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_BUSINESSFEATUREID} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_UID} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_TRAVELPURPOSE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_TRAVELPURPOSE);

        String CREATE_TABLE_USERROLE =
            "CREATE TABLE ${TablesBase.TABLE_USERROLE} ("
            "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${ColumnsBase.KEY_USERROLE_USERROLEID} TEXT,"
            "${ColumnsBase.KEY_USERROLE_USERROLECODE} TEXT,"
            "${ColumnsBase.KEY_USERROLE_USERROLENAME} TEXT,"
            "${ColumnsBase.KEY_USERROLE_CREATEDBY} TEXT,"
            "${ColumnsBase.KEY_USERROLE_CREATEDON} TEXT,"
            "${ColumnsBase.KEY_USERROLE_MODIFIEDBY} TEXT,"
            "${ColumnsBase.KEY_USERROLE_MODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_USERROLE_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED} TEXT,"
            "${ColumnsBase.KEY_USERROLE_UID} TEXT,"
            "${ColumnsBase.KEY_USERROLE_APPUSERID} TEXT,"
            "${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} TEXT,"
            "${ColumnsBase.KEY_USERROLE_ISARCHIVED} TEXT,"
            "${ColumnsBase.KEY_USERROLE_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_ISDIRTY} TEXT,"
            "${ColumnsBase.KEY_ISACTIVE} TEXT,"
            "${ColumnsBase.KEY_ISDELETED} TEXT,"
            "${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,"
            "${ColumnsBase.KEY_SCREATEDON} TEXT,"
            "${ColumnsBase.KEY_SMODIFIEDON} TEXT,"
            "${ColumnsBase.KEY_CREATEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,"
            "${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,"
            "${ColumnsBase.KEY_OWNERUSERID} TEXT"
            ")";
        await db.execute(CREATE_TABLE_USERROLE);

// table initialisation done
      });
    } catch (e) {}
  }

  void removeTables() async {
    
    final db = await database;

    db.query("DROP TABLE IF EXISTS AmiConfiguration");
    db.query("DROP TABLE IF EXISTS AppSync");
    db.query("DROP TABLE IF EXISTS Designationbc");

    db.query("DROP TABLE IF EXISTS Account");
    db.query("DROP TABLE IF EXISTS AccountAddress");
    db.query("DROP TABLE IF EXISTS AccountBusinessPlan");
    db.query("DROP TABLE IF EXISTS AccountBusinessUnit");
    db.query("DROP TABLE IF EXISTS AccountBuyingProcess");
    db.query("DROP TABLE IF EXISTS AccountCategory");
    db.query("DROP TABLE IF EXISTS AccountCategoryMapping");
    db.query("DROP TABLE IF EXISTS AccountCompetitionActivity");
    db.query("DROP TABLE IF EXISTS AccountForm");
    db.query("DROP TABLE IF EXISTS AccountFormValue");
    db.query("DROP TABLE IF EXISTS AccountMedia");
    db.query("DROP TABLE IF EXISTS AccountPhone");
    db.query("DROP TABLE IF EXISTS AccountSegment");
    db.query("DROP TABLE IF EXISTS AccountStatus");
    db.query("DROP TABLE IF EXISTS AccountTerritory");
    db.query("DROP TABLE IF EXISTS AccountType");
    db.query("DROP TABLE IF EXISTS Activity");
    db.query("DROP TABLE IF EXISTS ActivityMeasure");
    db.query("DROP TABLE IF EXISTS ActivityMedia");
    db.query("DROP TABLE IF EXISTS ActivityPermission");
    db.query("DROP TABLE IF EXISTS ActivityPriority");
    db.query("DROP TABLE IF EXISTS ActivityProduct");
    db.query("DROP TABLE IF EXISTS ActivityProductDetail");
    db.query("DROP TABLE IF EXISTS ActivityStatus");
    db.query("DROP TABLE IF EXISTS ActivityTeam");
    db.query("DROP TABLE IF EXISTS ActivityTravel");
    db.query("DROP TABLE IF EXISTS ActivityTravelExpense");
    db.query("DROP TABLE IF EXISTS ActivityTravelMapping");
    db.query("DROP TABLE IF EXISTS ActivityTravelMedia");
    db.query("DROP TABLE IF EXISTS ActivityType");
    db.query("DROP TABLE IF EXISTS AddressType");
    db.query("DROP TABLE IF EXISTS AppFeature");
    db.query("DROP TABLE IF EXISTS AppFeatureField");
    db.query("DROP TABLE IF EXISTS AppFeatureGroup");
    db.query("DROP TABLE IF EXISTS AppLog");
    db.query("DROP TABLE IF EXISTS AppReport");
    db.query("DROP TABLE IF EXISTS AppUsage");
    db.query("DROP TABLE IF EXISTS AppUser");
    db.query("DROP TABLE IF EXISTS AppUserLocation");
    db.query("DROP TABLE IF EXISTS AppUserMessage");
    db.query("DROP TABLE IF EXISTS AppUserProduct");
    db.query("DROP TABLE IF EXISTS AppUserRemark");
    db.query("DROP TABLE IF EXISTS AppUserRole");
    db.query("DROP TABLE IF EXISTS AppUserTeam");
    db.query("DROP TABLE IF EXISTS AppUserTeamMember");
    db.query("DROP TABLE IF EXISTS AppUserTerritory");
    db.query("DROP TABLE IF EXISTS AppUserType");
    db.query("DROP TABLE IF EXISTS Attribute");
    db.query("DROP TABLE IF EXISTS AttributeValue");
    db.query("DROP TABLE IF EXISTS BusinessEmail");
    db.query("DROP TABLE IF EXISTS BusinessFeature");
    db.query("DROP TABLE IF EXISTS BusinessUnit");

    db.query("DROP TABLE IF EXISTS ChatUserAndGroup");
    db.query("DROP TABLE IF EXISTS ChatMessage");
    db.query("DROP TABLE IF EXISTS ChatUserGroupMember");
    db.query("DROP TABLE IF EXISTS Contact");
    db.query("DROP TABLE IF EXISTS ContactAlignment");
    db.query("DROP TABLE IF EXISTS ContactCategory");
    db.query("DROP TABLE IF EXISTS ContactMedia");
    db.query("DROP TABLE IF EXISTS ContactTitle");
    db.query("DROP TABLE IF EXISTS ContentType");
    db.query("DROP TABLE IF EXISTS Country");
    db.query("DROP TABLE IF EXISTS CreditRating");
    db.query("DROP TABLE IF EXISTS Currency");
    db.query("DROP TABLE IF EXISTS CustomerMeeting");
    db.query("DROP TABLE IF EXISTS Department");
    db.query("DROP TABLE IF EXISTS Designation");
    db.query("DROP TABLE IF EXISTS EmailManualTemplate");
    db.query("DROP TABLE IF EXISTS ExpenseType");
    db.query("DROP TABLE IF EXISTS FieldAttendance");
    db.query("DROP TABLE IF EXISTS FinancialYear");
    db.query("DROP TABLE IF EXISTS Form");
    db.query("DROP TABLE IF EXISTS FormCell");
    db.query("DROP TABLE IF EXISTS FormCellElement");
    db.query("DROP TABLE IF EXISTS FormSection");
    db.query("DROP TABLE IF EXISTS Industry");
    db.query("DROP TABLE IF EXISTS HSSupportTicket");
    db.query("DROP TABLE IF EXISTS HSSupportTicketMedia");
    db.query("DROP TABLE IF EXISTS LeadSource");
    db.query("DROP TABLE IF EXISTS ModeOfTravel");
    db.query("DROP TABLE IF EXISTS Note");
    db.query("DROP TABLE IF EXISTS NoteMedia");
    db.query("DROP TABLE IF EXISTS NotePermission");
    db.query("DROP TABLE IF EXISTS Notification");
    db.query("DROP TABLE IF EXISTS NotificationAssignment");
    db.query("DROP TABLE IF EXISTS Opportunity");
    db.query("DROP TABLE IF EXISTS OpportunityBusinessUnit");
    db.query("DROP TABLE IF EXISTS OpportunityContact");
    db.query("DROP TABLE IF EXISTS OpportunityMeasure");
    db.query("DROP TABLE IF EXISTS OpportunityFulfillmentStatus");
    db.query("DROP TABLE IF EXISTS OpportunityMedia");
    db.query("DROP TABLE IF EXISTS OpportunityName");
    db.query("DROP TABLE IF EXISTS OpportunityPermission");
    db.query("DROP TABLE IF EXISTS OpportunityPriority");
    db.query("DROP TABLE IF EXISTS OpportunityProduct");
    db.query("DROP TABLE IF EXISTS OpportunityProductDetail");
    db.query("DROP TABLE IF EXISTS OpportunityStage");
    db.query("DROP TABLE IF EXISTS OpportunityStageType");
    db.query("DROP TABLE IF EXISTS OpportunityStatus");
    db.query("DROP TABLE IF EXISTS OpportunityTeam");
    db.query("DROP TABLE IF EXISTS OpportunityType");
    db.query("DROP TABLE IF EXISTS PhoneType");
    db.query("DROP TABLE IF EXISTS Product");
    db.query("DROP TABLE IF EXISTS ProductAuxiliary");
    db.query("DROP TABLE IF EXISTS ProductCategory");
    db.query("DROP TABLE IF EXISTS ProductInstallation");
    db.query("DROP TABLE IF EXISTS ProductInstallationDetail");
    db.query("DROP TABLE IF EXISTS ProductMedia");
    db.query("DROP TABLE IF EXISTS Reimbursement");
    db.query("DROP TABLE IF EXISTS ReimbursementDetail");
    db.query("DROP TABLE IF EXISTS ReimbursementType");
    db.query("DROP TABLE IF EXISTS Reminder");
    db.query("DROP TABLE IF EXISTS Resource");
    db.query("DROP TABLE IF EXISTS ServiceInvoice");
    db.query("DROP TABLE IF EXISTS ServiceInvoiceDetail");
    db.query("DROP TABLE IF EXISTS Tag");
    db.query("DROP TABLE IF EXISTS TagGroup");
    db.query("DROP TABLE IF EXISTS Territory");
    db.query("DROP TABLE IF EXISTS TimeZone");
    db.query("DROP TABLE IF EXISTS TravelPurpose");
    db.query("DROP TABLE IF EXISTS UserRole");
    db.query("DROP TABLE IF EXISTS Unit");
  }
}
