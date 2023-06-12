import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../AppTables/Columns.dart';
import '../AppTables/ColumnsBase.dart';
import '../AppTables/Globals.dart';
import '../AppTables/Tables.dart';
import '../AppTables/TablesBase.dart';

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
      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          final String createTableConfiguration =
              "CREATE TABLE ${TablesBase.TABLE_CONFIGURATION} ("
              "${ColumnsBase.KEY_CONFIGURATION_ID} INTEGER PRIMARY KEY,"
              "${ColumnsBase.KEY_CONFIGURATION_APPID} TEXT,"
              "${ColumnsBase.KEY_CONFIGURATION_APP_VERSION} TEXT,"
              "${ColumnsBase.KEY_CONFIGURATION_OS_VERSION} TEXT,"
              "${ColumnsBase.KEY_CONFIGURATION_EULA} TEXT,"
              "${ColumnsBase.KEY_CONFIGURATION_BASE_URL} TEXT,"
              "${ColumnsBase.KEY_CONFIGURATION_DEPLOYEDTIME} TEXT"
              ")";
          await db.execute(createTableConfiguration);
          String createTableSync = "CREATE TABLE ${TablesBase.TABLE_APPSYNC} ("
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
          await db.execute(createTableSync);

          String createTableDesignationBc =
              "CREATE TABLE ${TablesBase.TABLE_DESIGNATION_BC} ("
              "${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
              "${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} TEXT"
              ")";
          await db.execute(createTableDesignationBc);
          String createTableAccount =
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

          await db.execute(createTableAccount);
          String createTableAccountaddress =
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
          await db.execute(createTableAccountaddress);

          String createTableAccountbusinessplan =
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
          await db.execute(createTableAccountbusinessplan);

          String createTableAccountbuyingprocess =
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
          await db.execute(createTableAccountbuyingprocess);

          String createTableAccountcategory =
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
          await db.execute(createTableAccountcategory);

          String createTableAccountcategorymapping =
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
          await db.execute(createTableAccountcategorymapping);

          String createTableAccountcompetitionactivity =
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
          await db.execute(createTableAccountcompetitionactivity);

          String createTableAccountform =
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
          await db.execute(createTableAccountform);

          String createTableAccountformvalue =
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
          await db.execute(createTableAccountformvalue);

          String createTableAccountmedia =
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
          await db.execute(createTableAccountmedia);

          String createTableAccountphone =
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
          await db.execute(createTableAccountphone);

          String createTableAccountsegment =
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
          await db.execute(createTableAccountsegment);

          String createTableAccountstatus =
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
          await db.execute(createTableAccountstatus);

          String createTableAccountterritory =
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
          await db.execute(createTableAccountterritory);
          String createTableAccounttype =
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
          await db.execute(createTableAccounttype);
          String createTableActivity =
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
          await db.execute(createTableActivity);

          String createTableActivitymeasure =
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
          await db.execute(createTableActivitymeasure);

          String createTableActivitymedia =
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
          await db.execute(createTableActivitymedia);

          String createTableActivitypermission =
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
          await db.execute(createTableActivitypermission);

          String createTableActivitypriority =
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
          await db.execute(createTableActivitypriority);

          String createTableActivityproduct =
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
          await db.execute(createTableActivityproduct);

          String createTableActivityproductdetail =
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
          await db.execute(createTableActivityproductdetail);

          String createTableActivitystatus =
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
          await db.execute(createTableActivitystatus);

          String createTableActivityteam =
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
          await db.execute(createTableActivityteam);

          String createTableActivitytravel =
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
          await db.execute(createTableActivitytravel);

          String createTableActivitytravelmapping =
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
          await db.execute(createTableActivitytravelmapping);

          String createTableActivitytravelmedia =
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
          await db.execute(createTableActivitytravelmedia);

          String createTableActivitytype =
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
          await db.execute(createTableActivitytype);

          String createTableAddresstype =
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
          await db.execute(createTableAddresstype);

          String createTableAppfeature =
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
          await db.execute(createTableAppfeature);

// Add more tables here if needed

// Sample usage:
// await db.execute(CREATE_TABLE_ANOTHER_TABLE);

          String createTableAppfeaturegroup =
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
          await db.execute(createTableAppfeaturegroup);

          String createTableApplog =
              "CREATE TABLE ${TablesBase.TABLE_APPLOG} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPLOG_APPLOGID} TEXT,${ColumnsBase.KEY_APPLOG_APPLOGCODE} TEXT,${ColumnsBase.KEY_APPLOG_APPLOGDETAIL} TEXT,${ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM} TEXT,${ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION} TEXT,${ColumnsBase.KEY_APPLOG_CREATEDBY} TEXT,${ColumnsBase.KEY_APPLOG_CREATEDON} TEXT,${ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPLOG_UID} TEXT,${ColumnsBase.KEY_APPLOG_APPUSERID} TEXT,${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPLOG_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPLOG_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableApplog);

          String createTableAppreport =
              "CREATE TABLE ${TablesBase.TABLE_APPREPORT} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPREPORT_APPREPORTID} TEXT,${ColumnsBase.KEY_APPREPORT_APPREPORTCODE} TEXT,${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} TEXT,${ColumnsBase.KEY_APPREPORT_APPREPORTPATH} TEXT,${ColumnsBase.KEY_APPREPORT_APPREPORTTYPE} TEXT,${ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER} TEXT,${ColumnsBase.KEY_APPREPORT_CREATEDON} TEXT,${ColumnsBase.KEY_APPREPORT_CREATEDBY} TEXT,${ColumnsBase.KEY_APPREPORT_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPREPORT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPREPORT_ISACTIVE} TEXT,${ColumnsBase.KEY_APPREPORT_UID} TEXT,${ColumnsBase.KEY_APPREPORT_APPUSERID} TEXT,${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPREPORT_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPREPORT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppreport);

          String createTableAppusage =
              "CREATE TABLE ${TablesBase.TABLE_APPUSAGE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSAGE_APPUSAGEID} TEXT,${ColumnsBase.KEY_APPUSAGE_APPUSAGECODE} TEXT,${ColumnsBase.KEY_APPUSAGE_APPUSAGENAME} TEXT,${ColumnsBase.KEY_APPUSAGE_USAGECOUNT} TEXT,${ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM} TEXT,${ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION} TEXT,${ColumnsBase.KEY_APPUSAGE_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSAGE_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSAGE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSAGE_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSAGE_UID} TEXT,${ColumnsBase.KEY_APPUSAGE_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSAGE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppusage);

          String createTableAppuser =
              "CREATE TABLE ${TablesBase.TABLE_APPUSER} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSER_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSER_APPUSERCODE} TEXT,${ColumnsBase.KEY_APPUSER_APPUSERNAME} TEXT,${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} TEXT,${ColumnsBase.KEY_APPUSER_DESIGNATION} TEXT,${ColumnsBase.KEY_APPUSER_MOBILENUMBER} TEXT,${ColumnsBase.KEY_APPUSER_EMAIL} TEXT,${ColumnsBase.KEY_APPUSER_OFFICIALADDRESS} TEXT,${ColumnsBase.KEY_APPUSER_EMPLOYEEID} TEXT,${ColumnsBase.KEY_APPUSER_LOGINNAME} TEXT,${ColumnsBase.KEY_APPUSER_PASSCODE} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL1} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE1} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION1} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL2} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE2} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION2} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL3} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE3} TEXT,${ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION3} TEXT,${ColumnsBase.KEY_APPUSER_PROFILEPICTURE} TEXT,${ColumnsBase.KEY_APPUSER_PROFILECAPTION} TEXT,${ColumnsBase.KEY_APPUSER_PROFILELOCATION} TEXT,${ColumnsBase.KEY_APPUSER_COMPANYLOGO} TEXT,${ColumnsBase.KEY_APPUSER_COMPANYCAPTION} TEXT,${ColumnsBase.KEY_APPUSER_USECOMPANYLOGO} TEXT,${ColumnsBase.KEY_APPUSER_TIMEZONECODE} TEXT,${ColumnsBase.KEY_APPUSER_CURRECYCODE} TEXT,${ColumnsBase.KEY_APPUSER_CURRENTLOGINON} TEXT,${ColumnsBase.KEY_APPUSER_LASTLOGINON} TEXT,${ColumnsBase.KEY_APPUSER_APPLASTLOGINON} TEXT,${ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON} TEXT,${ColumnsBase.KEY_APPUSER_ISMAILSENT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTSORT} TEXT,${ColumnsBase.KEY_APPUSER_CONTACTSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACTIVITYOTHERSSORT} TEXT,${ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT} TEXT,${ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT} TEXT,${ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT} TEXT,${ColumnsBase.KEY_APPUSER_OPPORTUNITYDELIVEREDSORT} TEXT,${ColumnsBase.KEY_APPUSER_NOTESORT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT} TEXT,${ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT} TEXT,${ColumnsBase.KEY_APPUSER_USERTOKEN} TEXT,${ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED} TEXT,${Columns.KEY_APPUSER_CONFIGURATION} TEXT,${Columns.KEY_APPUSER_MUTECHAT} TEXT,${ColumnsBase.KEY_APPUSER_ISWOR} TEXT,${ColumnsBase.KEY_APPUSER_ISAPPALLOWED} TEXT,${ColumnsBase.KEY_APPUSER_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSER_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSER_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSER_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSER_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSER_UID} TEXT,${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSER_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSER_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuser);

          String createTableAppuserlocation =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERLOCATION} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_LOCATION} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_UID} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERLOCATION_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserlocation);

          String createTableAppusermessage =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERMESSAGE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGECODE} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETEXT} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_OBJECTTYPE} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_OBJECTID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_ISATTACHMENT} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_PARENTAPPUSERMESSAGEID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGETO} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERMESSAGEREADBY} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_UID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_ISDELETED} TEXT,${ColumnsBase.KEY_APPUSERMESSAGE_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppusermessage);

          String createTableAppuserproduct =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERPRODUCT} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTID} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERPRODUCTCODE} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_PRODUCTID} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_UID} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERPRODUCT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserproduct);

          String createTableAppuserremark =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERREMARK} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID} TEXT,${ColumnsBase.KEY_APPUSERREMARK_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERREMARK_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_APPUSERREMARK_LOCATION} TEXT,${ColumnsBase.KEY_APPUSERREMARK_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERREMARK_UID} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERREMARK_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserremark);

          String createTableAppuserrole =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERROLE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERROLE_APPUSERROLEID} TEXT,${ColumnsBase.KEY_APPUSERROLE_APPUSERROLECODE} TEXT,${ColumnsBase.KEY_APPUSERROLE_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERROLE_USERROLEID} TEXT,${ColumnsBase.KEY_APPUSERROLE_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERROLE_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERROLE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERROLE_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERROLE_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERROLE_UID} TEXT,${ColumnsBase.KEY_APPUSERROLE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERROLE_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERROLE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserrole);

          String createTableAppuserteam =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERTEAM} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID} TEXT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE} TEXT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME} TEXT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION} TEXT,${ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID} TEXT,${ColumnsBase.KEY_APPUSERTEAM_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERTEAM_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERTEAM_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERTEAM_UID} TEXT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERTEAM_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERTEAM_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserteam);

          String createTableAppuserteammember =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERTEAMMEMBER} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_UID} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserteammember);
          String createTableAppuserterritory =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERTERRITORY} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERTERRITORYID} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERTERRITORYCODE} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_TERRITORYID} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_UID} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_ISARCHIVED} TEXT,${ColumnsBase.KEY_APPUSERTERRITORY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppuserterritory);
          String createTableAppusertype =
              "CREATE TABLE ${TablesBase.TABLE_APPUSERTYPE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID} TEXT,${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE} TEXT,${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME} TEXT,${ColumnsBase.KEY_APPUSERTYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_APPUSERTYPE_CREATEDON} TEXT,${ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_APPUSERTYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_APPUSERTYPE_UID} TEXT,${ColumnsBase.KEY_APPUSERTYPE_APPUSERID} TEXT,${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_APPUSERTYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAppusertype);

          String createTableAttribute =
              "CREATE TABLE ${TablesBase.TABLE_ATTRIBUTE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTEID} TEXT,${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTECODE} TEXT,${ColumnsBase.KEY_ATTRIBUTE_ATTRIBUTENAME} TEXT,${ColumnsBase.KEY_ATTRIBUTE_DESCRIPTION} TEXT,${ColumnsBase.KEY_ATTRIBUTE_CREATEDON} TEXT,${ColumnsBase.KEY_ATTRIBUTE_CREATEDBY} TEXT,${ColumnsBase.KEY_ATTRIBUTE_MODIFIEDON} TEXT,${ColumnsBase.KEY_ATTRIBUTE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ATTRIBUTE_ISACTIVE} TEXT,${ColumnsBase.KEY_ATTRIBUTE_UID} TEXT,${ColumnsBase.KEY_ATTRIBUTE_APPUSERID} TEXT,${ColumnsBase.KEY_ATTRIBUTE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ATTRIBUTE_ISARCHIVED} TEXT,${ColumnsBase.KEY_ATTRIBUTE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAttribute);

          String createTableAttributevalue =
              "CREATE TABLE ${TablesBase.TABLE_ATTRIBUTEVALUE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUEID} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUECODE} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEVALUENAME} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ATTRIBUTEID} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_DESCRIPTION} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_MULTIPLIER} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDON} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_CREATEDBY} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDON} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ISACTIVE} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_UID} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERID} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ISARCHIVED} TEXT,${ColumnsBase.KEY_ATTRIBUTEVALUE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableAttributevalue);

          String createTableBusinessemail =
              "CREATE TABLE ${TablesBase.TABLE_BUSINESSEMAIL} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILID} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILCODE} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_BUSINESSEMAILADDRESS} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_PURPOSE} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_REMARKS} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_ISAPPROVED} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_HSREMARKS} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_CREATEDON} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_CREATEDBY} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_MODIFIEDON} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_ISACTIVE} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_UID} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_APPUSERID} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_ISARCHIVED} TEXT,${ColumnsBase.KEY_BUSINESSEMAIL_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableBusinessemail);

          String createTableBusinessfeature =
              "CREATE TABLE ${TablesBase.TABLE_BUSINESSFEATURE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATUREID} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURECODE} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_APPICON} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_CONSOLEICON} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONTEXT} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_DESCRIPTIONHTML} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_INTERNALCODE} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_CREATEDON} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_CREATEDBY} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDON} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_ISACTIVE} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_UID} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERID} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_ISARCHIVED} TEXT,${ColumnsBase.KEY_BUSINESSFEATURE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableBusinessfeature);

          String createTableChatmessage =
              "CREATE TABLE ${TablesBase.TABLE_CHATMESSAGE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGEID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECODE} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CHATMESSAGECONTENT} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CONTENTTYPE} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CHATUSERANDGROUPID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_TOCHATUSERANDGROUPID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_LOCALMEDIAPATH} TEXT,${ColumnsBase.KEY_CHATMESSAGE_ISUPLOADED} TEXT,${ColumnsBase.KEY_CHATMESSAGE_MEDIAPATH} TEXT,${ColumnsBase.KEY_CHATMESSAGE_ISREAD} TEXT,${ColumnsBase.KEY_CHATMESSAGE_READSTATUS} TEXT,${ColumnsBase.KEY_CHATMESSAGE_OBJECTNAME} TEXT,${ColumnsBase.KEY_CHATMESSAGE_OBJECTID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_OBJECTCODE} TEXT,${ColumnsBase.KEY_CHATMESSAGE_OBJECTACTION} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CREATEDON} TEXT,${ColumnsBase.KEY_CHATMESSAGE_CREATEDBY} TEXT,${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDON} TEXT,${ColumnsBase.KEY_CHATMESSAGE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_CHATMESSAGE_ISACTIVE} TEXT,${ColumnsBase.KEY_CHATMESSAGE_UID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_APPUSERID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_CHATMESSAGE_ISARCHIVED} TEXT,${ColumnsBase.KEY_CHATMESSAGE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableChatmessage);
          String createTableChatuserandgroup =
              "CREATE TABLE ${TablesBase.TABLE_CHATUSERANDGROUP} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPID} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPCODE} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPNAME} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPLOGO} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CHATUSERANDGROUPDESCRIPTION} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_PHONENUMBER} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_EMAIL} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_TARGETAPPUSERID} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_ISGROUP} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDBY} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_CREATEDON} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDBY} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_MODIFIEDON} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_ISACTIVE} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_UID} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERID} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_ISDELETED} TEXT,${ColumnsBase.KEY_CHATUSERANDGROUP_ISARCHIVED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableChatuserandgroup);

          String createTableChatusergroupmember =
              "CREATE TABLE ${TablesBase.TABLE_CHATUSERGROUPMEMBER} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERID} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERGROUPMEMBERCODE} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CHATUSERANDGROUPID} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_TARGETAPPUSERID} TEXT,${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERNAME} TEXT,${Columns.KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION} TEXT,${Columns.KEY_CHATUSERGROUPMEMBER_PHONENUMBER} TEXT,${Columns.KEY_CHATUSERGROUPMEMBER_EMAIL} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDBY} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_CREATEDON} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDBY} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_MODIFIEDON} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_UID} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERID} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISARCHIVED} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISACTIVE} TEXT,${ColumnsBase.KEY_CHATUSERGROUPMEMBER_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableChatusergroupmember);

          String createTableContact =
              "CREATE TABLE ${TablesBase.TABLE_CONTACT} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_CONTACT_CONTACTID} TEXT,${ColumnsBase.KEY_CONTACT_CONTACTCODE} TEXT,${ColumnsBase.KEY_CONTACT_TITLE} TEXT,${ColumnsBase.KEY_CONTACT_FIRSTNAME} TEXT,${ColumnsBase.KEY_CONTACT_MIDDLENAME} TEXT,${ColumnsBase.KEY_CONTACT_LASTNAME} TEXT,${ColumnsBase.KEY_CONTACT_CONTACTNAME} TEXT,${ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER} TEXT,${ColumnsBase.KEY_CONTACT_ACCOUNTID} TEXT,${ColumnsBase.KEY_CONTACT_DEPARTMENTNAME} TEXT,${ColumnsBase.KEY_CONTACT_DESIGNATION} TEXT,${ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES} TEXT,${ColumnsBase.KEY_CONTACT_REPORTINGMANAGER} TEXT,${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} TEXT,${ColumnsBase.KEY_CONTACT_MOBILENUMBER} TEXT,${ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER} TEXT,${ColumnsBase.KEY_CONTACT_WORKPHONE} TEXT,${ColumnsBase.KEY_CONTACT_RESIDENCEPHONE} TEXT,${ColumnsBase.KEY_CONTACT_EMAIL} TEXT,${ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL} TEXT,${ColumnsBase.KEY_CONTACT_ADDRESSLINE1} TEXT,${ColumnsBase.KEY_CONTACT_ADDRESSLINE2} TEXT,${ColumnsBase.KEY_CONTACT_ADDRESSLINE3} TEXT,${ColumnsBase.KEY_CONTACT_CITY} TEXT,${ColumnsBase.KEY_CONTACT_STATE} TEXT,${ColumnsBase.KEY_CONTACT_COUNTRY} TEXT,${ColumnsBase.KEY_CONTACT_PIN} TEXT,${ColumnsBase.KEY_CONTACT_GPSCOORDINATES} TEXT,${ColumnsBase.KEY_CONTACT_LINKEDIN} TEXT,${ColumnsBase.KEY_CONTACT_PASTACCOUNTS} TEXT,${ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS} TEXT,${ColumnsBase.KEY_CONTACT_DATEOFBIRTH} TEXT,${ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY} TEXT,${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} TEXT,${ColumnsBase.KEY_CONTACT_REMARKS} TEXT,${ColumnsBase.KEY_CONTACT_REFERENCEHISTORY} TEXT,${ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT} TEXT,${ColumnsBase.KEY_CONTACT_TAGS} TEXT,${ColumnsBase.KEY_CONTACT_FREETEXTFIELD1} TEXT,${ColumnsBase.KEY_CONTACT_FREETEXTFIELD2} TEXT,${ColumnsBase.KEY_CONTACT_FREETEXTFIELD3} TEXT,${ColumnsBase.KEY_CONTACT_COMPANYNAME} TEXT,${ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER} TEXT,${ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER} TEXT,${ColumnsBase.KEY_CONTACT_PASSPORTNUMBER} TEXT,${ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER} TEXT,${ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER} TEXT,${ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID} TEXT,${ColumnsBase.KEY_CONTACT_CREATEDBY} TEXT,${ColumnsBase.KEY_CONTACT_CREATEDON} TEXT,${ColumnsBase.KEY_CONTACT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_CONTACT_MODIFIEDON} TEXT,${ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_CONTACT_ISACTIVE} TEXT,${ColumnsBase.KEY_CONTACT_UID} TEXT,${ColumnsBase.KEY_CONTACT_APPUSERID} TEXT,${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_CONTACT_ISARCHIVED} TEXT,${ColumnsBase.KEY_CONTACT_ISDELETED} TEXT,${ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableContact);

          String createTableContactalignment =
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
          await db.execute(createTableContactalignment);

          String createTableContactmedia =
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
          await db.execute(createTableContactmedia);

          String createTableContacttitle =
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
          await db.execute(createTableContacttitle);

          String createTableContenttype =
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
          await db.execute(createTableContenttype);

          String createTableCountry =
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
          await db.execute(createTableCountry);

          String createTableCreditrating =
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
          await db.execute(createTableCreditrating);
          String createTableCurrency =
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
          await db.execute(createTableCurrency);

          String createTableCustomermeeting =
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
          await db.execute(createTableCustomermeeting);

          String createTableDepartment =
              "CREATE TABLE ${TablesBase.TABLE_DEPARTMENT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_DEPARTMENT_DEPARTMENTID} TEXT,${ColumnsBase.KEY_DEPARTMENT_DEPARTMENTCODE} TEXT,${ColumnsBase.KEY_DEPARTMENT_DEPARTMENTNAME} TEXT,${ColumnsBase.KEY_DEPARTMENT_CREATEDON} TEXT,${ColumnsBase.KEY_DEPARTMENT_CREATEDBY} TEXT,${ColumnsBase.KEY_DEPARTMENT_MODIFIEDON} TEXT,${ColumnsBase.KEY_DEPARTMENT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_DEPARTMENT_ISACTIVE} TEXT,${ColumnsBase.KEY_DEPARTMENT_UID} TEXT,${ColumnsBase.KEY_DEPARTMENT_APPUSERID} TEXT,${ColumnsBase.KEY_DEPARTMENT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_DEPARTMENT_ISARCHIVED} TEXT,${ColumnsBase.KEY_DEPARTMENT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableDepartment);

          String createTableDesignation =
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
          await db.execute(createTableDesignation);

          String createTableEmailmanualtemplate =
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
          await db.execute(createTableEmailmanualtemplate);

          String createTableFieldattendance =
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
          await db.execute(createTableFieldattendance);

          String createTableFinancialyear =
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
          await db.execute(createTableFinancialyear);

          String createTableForm = "CREATE TABLE ${TablesBase.TABLE_FORM} ("
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
          await db.execute(createTableForm);

          String createTableFormcell =
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
          await db.execute(createTableFormcell);

          String createTableFormcellelement =
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
          await db.execute(createTableFormcellelement);

          String createTableFormsection =
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
          await db.execute(createTableFormsection);

          String createTableIndustry =
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
          await db.execute(createTableIndustry);

          String createTableLeadsource =
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
          await db.execute(createTableLeadsource);

          String createTableModeoftravel =
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
          await db.execute(createTableModeoftravel);
          String createTableNote = "CREATE TABLE ${TablesBase.TABLE_NOTE} ("
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
          await db.execute(createTableNote);

          String createTableNotemedia =
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
          await db.execute(createTableNotemedia);

          String createTableNotepermission =
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
          await db.execute(createTableNotepermission);

          String createTableNotification =
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
          await db.execute(createTableNotification);

          String createTableNotificationassignment =
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
          await db.execute(createTableNotificationassignment);

          String createTableOpportunity =
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
          await db.execute(createTableOpportunity);

          String createTableOpportunitycontact =
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
          await db.execute(createTableOpportunitycontact);

          String createTableOpportunitymeasure =
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
          await db.execute(createTableOpportunitymeasure);

          String createTableOpportunityfulfillmentstatus =
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
          await db.execute(createTableOpportunityfulfillmentstatus);

          String createTableOpportunitymedia =
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
          await db.execute(createTableOpportunitymedia);

          String createTableOpportunityname =
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
          await db.execute(createTableOpportunityname);

          String createTableOpportunitypermission =
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
          await db.execute(createTableOpportunitypermission);

          String createTableOpportunitypriority =
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
          await db.execute(createTableOpportunitypriority);

          String createTableOpportunityproduct =
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
          await db.execute(createTableOpportunityproduct);

          String createTableOpportunityproductdetail =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunityproductdetail);

          String createTableOpportunitystage =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGE_UID} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunitystage);

          String createTableOpportunitystagetype =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGETYPE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunitystagetype);

          String createTableOpportunitystatus =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYSTATUS} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_ALERTMESSAGE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunitystatus);

          String createTableOpportunityteam =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYTEAM} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunityteam);

          String createTableOpportunitytype =
              "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYTYPE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_INTERNALCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_ISDEFAULT} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYTYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableOpportunitytype);

          String createTablePhonetype =
              "CREATE TABLE ${TablesBase.TABLE_PHONETYPE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PHONETYPE_PHONETYPEID} TEXT,${ColumnsBase.KEY_PHONETYPE_PHONETYPECODE} TEXT,${ColumnsBase.KEY_PHONETYPE_PHONETYPENAME} TEXT,${ColumnsBase.KEY_PHONETYPE_CREATEDON} TEXT,${ColumnsBase.KEY_PHONETYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_PHONETYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_PHONETYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PHONETYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_PHONETYPE_UID} TEXT,${ColumnsBase.KEY_PHONETYPE_APPUSERID} TEXT,${ColumnsBase.KEY_PHONETYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PHONETYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_PHONETYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTablePhonetype);

          String createTableProduct =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCT} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCT_PRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTCODE} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTNAME} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTDESCRIPTION} TEXT,${ColumnsBase.KEY_PRODUCT_MANUFACTURER} TEXT,${ColumnsBase.KEY_PRODUCT_HSNCODE} TEXT,${ColumnsBase.KEY_PRODUCT_MRP} TEXT,${ColumnsBase.KEY_PRODUCT_PRICE} TEXT,${ColumnsBase.KEY_PRODUCT_PRICEFORSALES} TEXT,${ColumnsBase.KEY_PRODUCT_ISATTRIBUTEBASED} TEXT,${ColumnsBase.KEY_PRODUCT_CGSTPERCENTAGE} TEXT,${ColumnsBase.KEY_PRODUCT_SGSTPERCENTAGE} TEXT,${ColumnsBase.KEY_PRODUCT_GSTPERCENTAGE} TEXT,${ColumnsBase.KEY_PRODUCT_ISPRICEINCLUDESTAX} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYID} TEXT,${ColumnsBase.KEY_PRODUCT_LIFETIMEINHOURS} TEXT,${ColumnsBase.KEY_PRODUCT_PARENTPRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTTHUMBNAILIMAGEPATH} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTIMAGEPATH} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTBROCHUREPATH} TEXT,${ColumnsBase.KEY_PRODUCT_PRODUCTATTRIBUTES} TEXT,${ColumnsBase.KEY_PRODUCT_ISSALEABLE} TEXT,${ColumnsBase.KEY_PRODUCT_TAGS} TEXT,${ColumnsBase.KEY_PRODUCT_REMARKS} TEXT,${ColumnsBase.KEY_PRODUCT_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCT_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCT_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCT_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCT_UID} TEXT,${ColumnsBase.KEY_PRODUCT_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCT_ISARCHIVED} TEXT,${ColumnsBase.KEY_PRODUCT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProduct);

          String createTableProductauxiliary =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCTAUXILIARY} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTAUXILIARYCODE} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_PRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_AUXILIARYPRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_QUANTITY} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_PRICE} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_ISPRICEINCLUDESTAX} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_UID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_SEQUENTIALORDER} TEXT,${ColumnsBase.KEY_PRODUCTAUXILIARY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProductauxiliary);

          String createTableProductcategory =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCTCATEGORY} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYID} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYCODE} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_PRODUCTCATEGORYNAME} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_DESCRIPTION} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_PARENTPRODUCTCATEGORYID} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_UID} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_ISARCHIVED} TEXT,${ColumnsBase.KEY_PRODUCTCATEGORY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProductcategory);

          String createTableProductinstallation =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCTINSTALLATION} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTINSTALLATIONID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTINSTALLATIONCODE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_INSTALLATIONIDENTIFIER} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_ACCOUNTID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_CONTACTID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_PRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_SERIALNUMBER} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_PARTNUMBER} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_MODEL} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_DATEOFMANUFACTURE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_LOCATIONUNIT} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_LOCATIONADDRESS} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_DATEOFCOMMISSIONING} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_APPLICATIONOFPRODUCT} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_WARRANTYENDDATE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_USAGEHOURSPERWEEK} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_UID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_ISARCHIVED} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_ISDELETED} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATION_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProductinstallation);

          String createTableProductinstallationdetail =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_SERIALNUMBER} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PARTNUMBER} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODEL} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_DATEOFMANUFACTURE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPLICATIONOFPRODUCT} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_DATEOFCOMMISSIONING} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_LIFETIMEINHOURS} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_USAGEHOURSPERWEEK} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_UID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISARCHIVED} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_ISDELETED} TEXT,${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProductinstallationdetail);

          String createTableProductmedia =
              "CREATE TABLE ${TablesBase.TABLE_PRODUCTMEDIA} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIAID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIACODE} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTMEDIANAME} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_PRODUCTID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_CONTENTTYPEID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_MEDIAPATH} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_MEDIACONTENT} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_DESCRIPTION} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_TAGS} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_LOCALMEDIAPATH} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_ISUPLOADED} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_CREATEDBY} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_CREATEDON} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_MODIFIEDON} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_ISACTIVE} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_UID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_APPUSERID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_ISARCHIVED} TEXT,${ColumnsBase.KEY_PRODUCTMEDIA_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableProductmedia);

          String createTableReimbursement =
              "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENT} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTID} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTCODE} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTTITLE} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_REIMBURSEMENTDATE} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_VOUCHERNUMBER} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_DESCRIPTION} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_AMOUNT} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_ISPAID} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_CREATEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_CREATEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_MODIFIEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_ISACTIVE} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_UID} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_APPUSERID} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_ISARCHIVED} TEXT,${ColumnsBase.KEY_REIMBURSEMENT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableReimbursement);

          String createTableReimbursementdetail =
              "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENTDETAIL} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILCODE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTDETAILTITLE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_BILLNUMBER} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_BILLDATE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_AMOUNT} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_REIMBURSEMENTTYPEID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ACTIVITYID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ACTIVITYTRAVELID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DESCRIPTION} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DOCUMENTPATH} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_DOCUMENTCONTENT} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_CREATEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_CREATEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_MODIFIEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISACTIVE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_UID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_APPUSERID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISARCHIVED} TEXT,${ColumnsBase.KEY_REIMBURSEMENTDETAIL_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableReimbursementdetail);

          String createTableReimbursementtype =
              "CREATE TABLE ${TablesBase.TABLE_REIMBURSEMENTTYPE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPEID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPECODE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_REIMBURSEMENTTYPENAME} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_UID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_REIMBURSEMENTTYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableReimbursementtype);

          String createTableReminder =
              "CREATE TABLE ${TablesBase.TABLE_REMINDER} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_REMINDER_REMINDERID} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERCODE} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERTITLE} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERDATE} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERTIME} TEXT,${ColumnsBase.KEY_REMINDER_REMINDERREPEAT} TEXT,${ColumnsBase.KEY_REMINDER_REPEATNUMBER} TEXT,${ColumnsBase.KEY_REMINDER_REPEATTYPE} TEXT,${ColumnsBase.KEY_REMINDER_ACTIVE} TEXT,${ColumnsBase.KEY_REMINDER_ACTIVITYID} TEXT,${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} TEXT,${ColumnsBase.KEY_REMINDER_ACCOUNTID} TEXT,${ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM} TEXT,${ColumnsBase.KEY_REMINDER_CREATEDBY} TEXT,${ColumnsBase.KEY_REMINDER_CREATEDON} TEXT,${ColumnsBase.KEY_REMINDER_MODIFIEDBY} TEXT,${ColumnsBase.KEY_REMINDER_MODIFIEDON} TEXT,${ColumnsBase.KEY_REMINDER_ISACTIVE} TEXT,${ColumnsBase.KEY_REMINDER_UID} TEXT,${ColumnsBase.KEY_REMINDER_APPUSERID} TEXT,${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_REMINDER_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableReminder);

          String createTableResource =
              "CREATE TABLE ${TablesBase.TABLE_RESOURCE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_RESOURCE_RESOURCEID} TEXT,${ColumnsBase.KEY_RESOURCE_RESOURCECODE} TEXT,${ColumnsBase.KEY_RESOURCE_RESOURCENAME} TEXT,${ColumnsBase.KEY_RESOURCE_PRODUCTID} TEXT,${ColumnsBase.KEY_RESOURCE_CONTENTTYPEID} TEXT,${ColumnsBase.KEY_RESOURCE_RESOURCEPATH} TEXT,${ColumnsBase.KEY_RESOURCE_RESOURCECONTENT} TEXT,${ColumnsBase.KEY_RESOURCE_DESCRIPTION} TEXT,${Columns.KEY_RESOURCE_RESOURCECATEGORYNAME} TEXT,${ColumnsBase.KEY_RESOURCE_ISSHARABLE} TEXT,${ColumnsBase.KEY_RESOURCE_VALIDUPTO} TEXT,${ColumnsBase.KEY_RESOURCE_CREATEDBY} TEXT,${ColumnsBase.KEY_RESOURCE_CREATEDON} TEXT,${ColumnsBase.KEY_RESOURCE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_RESOURCE_MODIFIEDON} TEXT,${ColumnsBase.KEY_RESOURCE_ISACTIVE} TEXT,${ColumnsBase.KEY_RESOURCE_UID} TEXT,${ColumnsBase.KEY_RESOURCE_APPUSERID} TEXT,${ColumnsBase.KEY_RESOURCE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_RESOURCE_ISARCHIVED} TEXT,${ColumnsBase.KEY_RESOURCE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableResource);

          String createTableServiceinvoice =
              "CREATE TABLE ${TablesBase.TABLE_SERVICEINVOICE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICECODE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICETITLE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_SERVICEINVOICEDATE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ACCOUNTID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ACTIVITYID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_BARCODE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ISINWARRANTY} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_PRODUCTPARTSPRICE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_SERVICECHARGE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_TAX} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_TOTALAMOUNT} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_AMOUNTPAID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_CURRENCYID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_PAYMENTDATE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_CREATEDBY} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_CREATEDON} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_MODIFIEDON} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ISACTIVE} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_UID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_APPUSERID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ISARCHIVED} TEXT,${ColumnsBase.KEY_SERVICEINVOICE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableServiceinvoice);

          String createTableServiceinvoicedetail =
              "CREATE TABLE ${TablesBase.TABLE_SERVICEINVOICEDETAIL} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEDETAILCODE} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTPARTBARCODE} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_SERVICEINVOICEID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRODUCTID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_QUANTITY} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_RATE} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_PRICE} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDON} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_CREATEDBY} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDON} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISACTIVE} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_UID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISARCHIVED} TEXT,${ColumnsBase.KEY_SERVICEINVOICEDETAIL_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableServiceinvoicedetail);

          String createTableTag =
              "CREATE TABLE ${TablesBase.TABLE_TAG} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_TAG_TAGID} TEXT,${ColumnsBase.KEY_TAG_TAGCODE} TEXT,${ColumnsBase.KEY_TAG_TAGNAME} TEXT,${ColumnsBase.KEY_TAG_DESCRIPTION} TEXT,${ColumnsBase.KEY_TAG_PARENTTAGID} TEXT,${ColumnsBase.KEY_TAG_TAGGROUPID} TEXT,${ColumnsBase.KEY_TAG_SORTORDER} TEXT,${ColumnsBase.KEY_TAG_CREATEDBY} TEXT,${ColumnsBase.KEY_TAG_CREATEDON} TEXT,${ColumnsBase.KEY_TAG_MODIFIEDBY} TEXT,${ColumnsBase.KEY_TAG_MODIFIEDON} TEXT,${ColumnsBase.KEY_TAG_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_TAG_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_TAG_ISACTIVE} TEXT,${ColumnsBase.KEY_TAG_UID} TEXT,${ColumnsBase.KEY_TAG_APPUSERID} TEXT,${ColumnsBase.KEY_TAG_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_TAG_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableTag);

          String createTableTaggroup =
              "CREATE TABLE ${TablesBase.TABLE_TAGGROUP} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_TAGGROUP_TAGGROUPID} TEXT,${ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE} TEXT,${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} TEXT,${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} TEXT,${ColumnsBase.KEY_TAGGROUP_LINKTO} TEXT,${ColumnsBase.KEY_TAGGROUP_SORTORDER} TEXT,${ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP} TEXT,${ColumnsBase.KEY_TAGGROUP_POSITIONINDEX} TEXT,${ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES} TEXT,${ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET} TEXT,${ColumnsBase.KEY_TAGGROUP_CREATEDON} TEXT,${ColumnsBase.KEY_TAGGROUP_CREATEDBY} TEXT,${ColumnsBase.KEY_TAGGROUP_MODIFIEDON} TEXT,${ColumnsBase.KEY_TAGGROUP_MODIFIEDBY} TEXT,${ColumnsBase.KEY_TAGGROUP_ISACTIVE} TEXT,${ColumnsBase.KEY_TAGGROUP_UID} TEXT,${ColumnsBase.KEY_TAGGROUP_APPUSERID} TEXT,${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_TAGGROUP_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableTaggroup);

          String createTableTerritory =
              "CREATE TABLE ${TablesBase.TABLE_TERRITORY} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_TERRITORY_TERRITORYID} TEXT,${ColumnsBase.KEY_TERRITORY_TERRITORYCODE} TEXT,${ColumnsBase.KEY_TERRITORY_TERRITORYNAME} TEXT,${ColumnsBase.KEY_TERRITORY_DESCRIPTION} TEXT,${ColumnsBase.KEY_TERRITORY_PARENTTERRITORYID} TEXT,${ColumnsBase.KEY_TERRITORY_CREATEDON} TEXT,${ColumnsBase.KEY_TERRITORY_CREATEDBY} TEXT,${ColumnsBase.KEY_TERRITORY_MODIFIEDON} TEXT,${ColumnsBase.KEY_TERRITORY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_TERRITORY_ISACTIVE} TEXT,${ColumnsBase.KEY_TERRITORY_UID} TEXT,${ColumnsBase.KEY_TERRITORY_APPUSERID} TEXT,${ColumnsBase.KEY_TERRITORY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_TERRITORY_ISARCHIVED} TEXT,${ColumnsBase.KEY_TERRITORY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableTerritory);

          String createTableTimezone =
              "CREATE TABLE ${TablesBase.TABLE_TIMEZONE} (${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_TIMEZONE_TIMEZONEID} TEXT,${ColumnsBase.KEY_TIMEZONE_TIMEZONECODE} TEXT,${ColumnsBase.KEY_TIMEZONE_TIMEZONENAME} TEXT,${ColumnsBase.KEY_TIMEZONE_GMTOFFSET} TEXT,${ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES} TEXT,${ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET} TEXT,${ColumnsBase.KEY_TIMEZONE_DSTCORRECTION} TEXT,${ColumnsBase.KEY_TIMEZONE_CREATEDON} TEXT,${ColumnsBase.KEY_TIMEZONE_CREATEDBY} TEXT,${ColumnsBase.KEY_TIMEZONE_MODIFIEDON} TEXT,${ColumnsBase.KEY_TIMEZONE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_TIMEZONE_ISACTIVE} TEXT,${ColumnsBase.KEY_TIMEZONE_UID} TEXT,${ColumnsBase.KEY_TIMEZONE_APPUSERID} TEXT,${ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_TIMEZONE_ISARCHIVED} TEXT,${ColumnsBase.KEY_TIMEZONE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
          await db.execute(createTableTimezone);

          String createTableTravelpurpose =
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
          await db.execute(createTableTravelpurpose);

          String createTableUserrole =
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
          await db.execute(createTableUserrole);

// table initialisation done
        },
        onUpgrade: (db, oldVersion, newVersion) {
            //  if (oldVersion <= 2) {
           
            // }

            Upgrade_Tables_V2(db);
            Upgrade_DownSyncTables_V2( db, Globals.AppUserUID, Globals.AppUserGroupUID);


            Upgrade_Tables_V3(db);
            Upgrade_DownSyncTables_V3( db, Globals.AppUserUID, Globals.AppUserGroupUID);

            Upgrade_Tables_V6(db);

            Upgrade_Tables_V7(db);
            Upgrade_DownSyncTables_V7(
                db, Globals.AppUserUID, Globals.AppUserGroupUID);

            Upgrade_Tables_V8(db);
            Upgrade_Tables_V9(db);

            Upgrade_Tables_V10(db, Globals.AppUserUID, Globals.AppUserGroupUID);
            Upgrade_Tables_V11(db);
            Upgrade_Tables_V12(db);
            Upgrade_Tables_V13(db);

            
          // if (oldVersion <= 3) 
          // {
         
          // }
        },
      );
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

  void AddConfigurationData(Database db) {
    var uuid = const Uuid();
    try {
      String sql =
          "INSERT INTO ${TablesBase.TABLE_CONFIGURATION}(${ColumnsBase.KEY_CONFIGURATION_ID},${ColumnsBase.KEY_CONFIGURATION_APPID},${ColumnsBase.KEY_CONFIGURATION_APP_VERSION}";
      sql =
          "$sql,${ColumnsBase.KEY_CONFIGURATION_OS_VERSION},${ColumnsBase.KEY_CONFIGURATION_EULA},${ColumnsBase.KEY_CONFIGURATION_BASE_URL},${ColumnsBase.KEY_CONFIGURATION_DEPLOYEDTIME})";

      // global file needed

      // sql = sql + " VALUES(1,'" + uuid.v4() + "','1.0','0','','','" + Globals.GetDateTimeNowDBFormat() + "')";
      db.execute(sql);
    } catch (e) {
      print(e);
      // Globals.HandleException(context, "DatabaseHandler:AddConfigurationData()", ex);
    }
  }

  void addDefaultDesignations(Database db) async {
    try {
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('manager');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('consultant');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('director');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('architect');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('officer');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('homeopath');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('president');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('executive');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('incharge');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('business development');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('inside sales');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('engineer');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('registrar');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('ea to coo');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('trainee');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('global head');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('specialist');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('proprietor');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('leader');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('advisor');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('merchandiser');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('vice president');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('vp');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('secretary');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('dr.');");
      await db.execute(
          "INSERT INTO ${TablesBase.TABLE_DESIGNATION_BC} (${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME}) VALUES ('adv.');");
    } catch (e) {
      // Globals.HandleException(context, "DatabaseHandler:AddDefaultDesignations()", ex);
    }
  }

  void AddDownSyncTables(String appUserId, String appUserGroupId) async {
    try {
      final db = await database;

      //Master
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('BusinessFeature','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //20
      //AppFeature
      //db.execute("INSERT INTO " + TablesBase.TABLE_APPSYNC + "(" + ColumnsBase.KEY_APPSYNC_TABLENAME + "," + ColumnsBase.KEY_APPSYNC_LOCALMAXDATE  + "," + ColumnsBase.KEY_APPSYNC_SERVERMAXDATE + "," + ColumnsBase.KEY_APPSYNC_PAGESIZE + "," + ColumnsBase.KEY_APPSYNC_RECORDS + "," + ColumnsBase.KEY_APPSYNC_PAGE + "," + ColumnsBase.KEY_APPSYNC_APPUSERID + "," + ColumnsBase.KEY_APPSYNC_APPUSERGROUPID + ") VALUES ('AppFeatureGroup','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0'," + appUserId + "," + appUserGroupId + ")");   //40
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppFeature','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //60
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppFeatureField','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //80

      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountSegment','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //100
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //120
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Territory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //140
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Country','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //160
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Industry','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //180
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('LeadSource','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //200
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('CreditRating','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //220
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ContactAlignment','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //240
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ContactTitle','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //260
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('PhoneType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //280
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AddressType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //300
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //320
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityStatus','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //340
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityStage','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //360
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityStatus','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //380
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Department','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //400
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityFulfillmentStatus','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //420
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ModeOfTravel','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //440
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('TravelPurpose','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //460
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ContentType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //480
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppReport','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //500
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Currency','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //520
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('TagGroup','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //540
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Tag','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //560
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Attribute','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //580
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AttributeValue','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //600
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FinancialYear','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //620
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('TimeZone','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //640
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Designation','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //680
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountStatus','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //700
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('BusinessEmail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //720
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountCategory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //740
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('EmailManualTemplate','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //760
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityPriority','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //780
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityPriority','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //800
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityMeasure','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //820
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityMeasure','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //840
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //860
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityStageType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //880
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ReimbursementType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //900
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityName','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //920
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ProductCategory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //940
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Product','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //960
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ProductAuxiliary','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //980
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Resource','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1000

      //Objects
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Account','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1020
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountCategoryMapping','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1040
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Contact','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1060
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('CustomerMeeting','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1080
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Opportunity','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1100
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityProduct','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1120
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityProductDetail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1140
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Activity','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1160
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityProduct','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1180
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityProductDetail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1200

      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityContact','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1210
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountAddress','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1220
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountPhone','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1240
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountBuyingProcess','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1260
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountBusinessPlan','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1280
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountCompetitionActivity','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1300
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Note','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1320
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityTravel','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1340
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityTravelMapping','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1360
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountTerritory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1380
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Notification','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1400
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityContact','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1420

      //AppUser
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUser','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1440
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserTerritory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1460

      //Form
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Form','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1480
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FormSection','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1500
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FormCell','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1520
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FormCellElement','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1540

      //Chat
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ChatUserAndGroup','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1560
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ChatUserGroupMember','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1580
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ChatMessage','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1600

      //Attendance
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserLocation','2000-01-01T00:00:00','2000-01-01T00:00:00','1','0','0',$appUserId,$appUserGroupId)"); //1620
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FieldAttendance','2000-01-01T00:00:00','2000-01-01T00:00:00','1','0','0',$appUserId,$appUserGroupId)"); //1640

      //Assignment
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('NotificationAssignment','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1660

      //Permission
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityPermission','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1680
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('NotePermission','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1700
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityPermission','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1720

      //Service Install Base
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ProductInstallation','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1740
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ProductInstallationDetail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1760

      //Reimbursement
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Reimbursement','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1780
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ReimbursementDetail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1800

      //Reminder
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Reminder','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1820

      //Service Invoice
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ServiceInvoice','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1840
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ServiceInvoiceDetail','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1860

      //Team
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserTeam','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1880
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserTeamMember','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1900
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityTeam','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1920
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityTeam','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1940

      //AppUser Objects
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserProduct','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1960
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserRemark','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //1980
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AppUserMessage','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2000

      //Form Values
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountForm','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2020
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountFormValue','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2040

      //Media
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ProductMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2060
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2080
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ContactMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2100
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2120
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2140
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('NoteMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2160
      db.execute(
          "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityTravelMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)"); //2180

      //UPGRADES
      // Upgrade_DownSyncTables_V2(db, appUserId, appUserGroupId);
      // Upgrade_DownSyncTables_V3(db, appUserId, appUserGroupId);
    } catch (e) {
      print(e);

      // Globals.HandleException(context, "DatabaseHandler:AddDownSyncTables()", ex);
    }
  }

  void ResetPendingUpSyncIndexes() async {
    try {
      final db = await database;

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTCATEGORY} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDA sTE ${TablesBase.TABLE_ACCOUNT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CONTACT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITY} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CUSTOMERMEETING} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITY} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYPRODUCT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYCONTACT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTADDRESS} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTPHONE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTBUYINGPROCESS} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDAT E ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_NOTE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYTRAVEL} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CHATUSERANDGROUP} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CHATUSERGROUPMEMBER} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CHATMESSAGE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_APPUSERLOCATION} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_FIELDATTENDANCE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYPERMISSION} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_NOTEPERMISSION} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYPERMISSION} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_REIMBURSEMENT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_REIMBURSEMENTDETAIL} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_REMINDER} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYTEAM} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYTEAM} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_APPUSERREMARK} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_APPUSERMESSAGE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTFORM} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTFORMVALUE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYTRAVELMAPPING} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      //db.execute("UPDATE " + TablesBase.TABLE_APPLOG + " SET " + ColumnsBase.KEY_UPSYNCINDEX + " = 1 WHERE CAST(COALESCE(" + ColumnsBase.KEY_UPSYNCINDEX + ",100) AS INTEGER) >= " + Globals.MAX_UPSYNC_INDEX + " AND  " + ColumnsBase.KEY_ISDIRTY + " = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_CONTACTMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_APPUSAGE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYTRAVELMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_NOTEMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_HSSUPPORTTICKET} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");

      db.execute(
          "UPDATE ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} SET ${ColumnsBase.KEY_UPSYNCINDEX} = 1 WHERE CAST(COALESCE(${ColumnsBase.KEY_UPSYNCINDEX},100) AS INTEGER) >= ${Globals.MAX_UPSYNC_INDEX} AND  ${ColumnsBase.KEY_ISDIRTY} = 'true'");
    } catch (e) {
      // Globals.HandleException(context, "DatabaseHandler:ResetPendingUpSyncIndexes()", ex);
    }
  }

  void Upgrade_Tables_V2(Database db) async {
    //Adding BusinessUnit features for Account, Activity and Opportunity
    try {
      String createTableBusinessunit =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_BUSINESSUNIT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITID} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITCODE} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_DESCRIPTION} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_HEADOFBUSINESSUNITAPPUSERID} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_CREATEDON} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_CREATEDBY} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDON} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_ISACTIVE} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_ISDELETED} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_UID} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_APPUSERID} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_BUSINESSUNIT_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableBusinessunit);

      String createTableAccountbusinessunit =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED} TEXT,${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableAccountbusinessunit);

      String createTableActivitybusinessunit =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_ACTIVITYBUSINESSUNIT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYBUSINESSUNITCODE} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ACTIVITYID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_BUSINESSUNITID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_CREATEDON} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_MODIFIEDON} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISACTIVE} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_UID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISDELETED} TEXT,${ColumnsBase.KEY_ACTIVITYBUSINESSUNIT_ISARCHIVED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableActivitybusinessunit);

      String createTableOpportunitybusinessunit =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED} TEXT,${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableOpportunitybusinessunit);

      //Add New ColumnsBase
      if (!await ColumnExists(db, TablesBase.TABLE_ACCOUNT,
          ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME)) {
        String alterTableAccountAddPrimarycontactname =
            "ALTER TABLE ${TablesBase.TABLE_ACCOUNT} ADD ${ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME} TEXT";
        db.execute(alterTableAccountAddPrimarycontactname);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL,
          ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE)) {
        String alterTableOpportunityproductdetailAddPrice =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} ADD ${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE} TEXT";
        db.execute(alterTableOpportunityproductdetailAddPrice);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYPRODUCTDETAIL,
          ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE)) {
        String alterTableActivityproductdetailAddPrice =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} ADD ${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE} TEXT";
        db.execute(alterTableActivityproductdetailAddPrice);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS)) {
        String alterTableActivityAddAssignmentdetails =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS} TEXT";
        db.execute(alterTableActivityAddAssignmentdetails);
      }

      if (!await ColumnExists(
          db, TablesBase.TABLE_ACTIVITY, ColumnsBase.KEY_ACTIVITY_REMARKS)) {
        String alterTableActivityAddRemarks =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_REMARKS} TEXT";
        db.execute(alterTableActivityAddRemarks);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS)) {
        String alterTableOpportunityAddAssignmentdetails =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS} TEXT";
        db.execute(alterTableOpportunityAddAssignmentdetails);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS)) {
        String alterTableOpportunityAddWorkflowdetails =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS} TEXT";
        db.execute(alterTableOpportunityAddWorkflowdetails);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_REMARKS)) {
        String alterTableOpportunityAddRemarks =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_REMARKS} TEXT";
        db.execute(alterTableOpportunityAddRemarks);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_TRAVELPURPOSENAME)) {
        String alterTableActivitytravelAddTravelpurposename =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_TRAVELPURPOSENAME} TEXT";
        db.execute(alterTableActivitytravelAddTravelpurposename);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_TOTALEXPENSE)) {
        String alterTableActivitytravelAddTotalexpense =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_TOTALEXPENSE} TEXT";
        db.execute(alterTableActivitytravelAddTotalexpense);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVALSTATUS)) {
        String alterTableActivitytravelAddApprovalstatus =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVALSTATUS} TEXT";
        db.execute(alterTableActivitytravelAddApprovalstatus);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDBYAPPUSERNAME)) {
        String alterTableActivitytravelAddApprovedbyappusername =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDBYAPPUSERNAME} TEXT";
        db.execute(alterTableActivitytravelAddApprovedbyappusername);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDTIME)) {
        String alterTableActivitytravelAddApprovedtime =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDTIME} TEXT";
        db.execute(alterTableActivitytravelAddApprovedtime);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVERREMARKS)) {
        String alterTableActivitytravelAddApproverremarks =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVERREMARKS} TEXT";
        db.execute(alterTableActivitytravelAddApproverremarks);
      }
    } catch (e) {
      // Utility.showToast(context,ex.toString());
    }
  }

  void Upgrade_DownSyncTables_V2(
      Database db, String appUserId, String appUserGroupId) {
    try {
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "BusinessUnit")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('BusinessUnit','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "AccountBusinessUnit")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('AccountBusinessUnit','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ActivityBusinessUnit")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityBusinessUnit','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "OpportunityBusinessUnit")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityBusinessUnit','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0',$appUserId,$appUserGroupId)");
      }
    } catch (e) {}
  }

  void Upgrade_Tables_V3(Database db) async {
    //
    try {
      String createTableActivitytravelexpense =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED} TEXT,${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableActivitytravelexpense);

      String createTableContactcategory =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_CONTACTCATEGORY}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_CONTACTCATEGORY_CONTACTCATEGORYID} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_CONTACTCATEGORYCODE} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_CONTACTCATEGORYNAME} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_CREATEDON} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_CREATEDBY} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_MODIFIEDON} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_ISACTIVE} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_UID} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_APPUSERID} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_ISARCHIVED} TEXT,${ColumnsBase.KEY_CONTACTCATEGORY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableContactcategory);

      String createTableExpensetype =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_EXPENSETYPE}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID} TEXT,${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE} TEXT,${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME} TEXT,${ColumnsBase.KEY_EXPENSETYPE_CREATEDON} TEXT,${ColumnsBase.KEY_EXPENSETYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_EXPENSETYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_EXPENSETYPE_UID} TEXT,${ColumnsBase.KEY_EXPENSETYPE_APPUSERID} TEXT,${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_EXPENSETYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableExpensetype);

      String createTableHssupportticket =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_HSSUPPORTTICKET}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETCODE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTYPE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETDETAIL} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDBY} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_CREATEDON} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDBY} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_MODIFIEDON} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_PARENTHSSUPPORTTICKETID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_ASSIGNEDTOHSUSERID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_TICKETSTATUS} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTION} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_RESOLUTIONTIME} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_ISACTIVE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_UID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKET_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableHssupportticket);

      String createTableHssupportticketmedia =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS} TEXT,${Columns.KEY_HSSUPPORTTICKETMEDIA_LOCALMEDIAPATH} TEXT,${Columns.KEY_HSSUPPORTTICKETMEDIA_ISUPLOADED} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED} TEXT,${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableHssupportticketmedia);

      //Add New ColumnsBase
      if (!await ColumnExists(db, TablesBase.TABLE_CONTACT,
          ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID)) {
        String alterTableContactAddContactcategoryid =
            "ALTER TABLE ${TablesBase.TABLE_CONTACT} ADD ${ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID} TEXT";
        db.execute(alterTableContactAddContactcategoryid);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTRAVEL,
          ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELENDDATE)) {
        String alterTableActivitytravelAddActivitytravelenddate =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTRAVEL} ADD ${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELENDDATE} TEXT";
        db.execute(alterTableActivitytravelAddActivitytravelenddate);
      }

      if (!await ColumnExists(
          db, TablesBase.TABLE_APPSYNC, Columns.KEY_APPSYNC_SEQUENTIALORDER)) {
        String alterTableTableAppsyncAddSequentialorder =
            "ALTER TABLE ${TablesBase.TABLE_APPSYNC} ADD ${Columns.KEY_APPSYNC_SEQUENTIALORDER} TEXT";
        db.execute(alterTableTableAppsyncAddSequentialorder);
      }
    } catch (e) {}
  }

  void Upgrade_Tables_V6(Database db) async {
    //
    try {
      //Add New ColumnsBase
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL,
          ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REMARKS)) {
        String alterTableOpportunityproductdetailAddRemarks =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} ADD ${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REMARKS} TEXT";
        db.execute(alterTableOpportunityproductdetailAddRemarks);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_PRODUCT,
          ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS)) {
        String alterTableProductAddFeatureoptions =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_FEATUREOPTIONS} TEXT";
        db.execute(alterTableProductAddFeatureoptions);
      }
    } catch (e) {}
  }

  void Upgrade_DownSyncTables_V3(
      Database db, String appUserId, String appUserGroupId) async {
    try {
      updateAppSyncSequentialOrder_V3();

      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ContactCategory")) {
        db.execute(
            "${"INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER}"},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ContactCategory','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','1005',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ExpenseType")) {
        db.execute(
            "${"INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER}"},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ExpenseType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','1010',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ActivityTravelExpense")) {
        db.execute(
            "${"INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER}"},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityTravelExpense','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','1425',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "HSSupportTicket")) {
        db.execute(
            "${"INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER}"},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('HSSupportTicket','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','4000',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "HSSupportTicketMedia")) {
        db.execute(
            "${"INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER}"},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('HSSupportTicketMedia','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','4020',$appUserId,$appUserGroupId)");
      }
    } catch (e) {}
  }

  void Upgrade_All_DownSyncTables() async {
    try {
      final db = await database;
      Upgrade_DownSyncTables_V2(
          db, Globals.AppUserUID, Globals.AppUserGroupUID);
      Upgrade_DownSyncTables_V3(
          db, Globals.AppUserUID, Globals.AppUserGroupUID);
    } catch (e) {}
  }

  void Upgrade_Tables_V7(Database db) async {
    //
    try {
      String createTableActivityapproval =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_ACTIVITYAPPROVAL}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALCODE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTITLE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYAPPROVALTYPEID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ACTIVITYID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDATE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_REQUESTDETAIL} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ISSUBMITTED} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_PARENTACTIVITYAPPROVALID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALSTATUS} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALBYAPPUSERID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVALTIME} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPROVERREMARKS} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_CREATEDON} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_MODIFIEDON} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_LOCATION} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ISACTIVE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_UID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ISARCHIVED} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVAL_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableActivityapproval);

      String createTableActivityapprovaltype =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPEID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPECODE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYAPPROVALTYPENAME} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_DESCRIPTION} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ACTIVITYTYPEID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDON} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_UID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableActivityapprovaltype);

      String createTableCompetitor =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_COMPETITOR}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_COMPETITOR_COMPETITORID} TEXT,${ColumnsBase.KEY_COMPETITOR_COMPETITORCODE} TEXT,${ColumnsBase.KEY_COMPETITOR_COMPETITORNAME} TEXT,${ColumnsBase.KEY_COMPETITOR_DESCRIPTION} TEXT,${ColumnsBase.KEY_COMPETITOR_CREATEDON} TEXT,${ColumnsBase.KEY_COMPETITOR_CREATEDBY} TEXT,${ColumnsBase.KEY_COMPETITOR_MODIFIEDON} TEXT,${ColumnsBase.KEY_COMPETITOR_MODIFIEDBY} TEXT,${ColumnsBase.KEY_COMPETITOR_ISACTIVE} TEXT,${ColumnsBase.KEY_COMPETITOR_UID} TEXT,${ColumnsBase.KEY_COMPETITOR_APPUSERID} TEXT,${ColumnsBase.KEY_COMPETITOR_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_COMPETITOR_ISARCHIVED} TEXT,${ColumnsBase.KEY_COMPETITOR_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableCompetitor);

      String createTableFinancialinstitution =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_FINANCIALINSTITUTION}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_UID} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_ISARCHIVED} TEXT,${ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableFinancialinstitution);

      String createTableOpportunityapproval =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_OPPORTUNITYAPPROVAL}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableOpportunityapproval);

      String createTableOpportunityapprovaltype =
          "CREATE TABLE IF NOT EXISTS ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableOpportunityapprovaltype);

      if (!await ColumnExists(db, TablesBase.TABLE_ACCOUNT,
          ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID)) {
        String alterTableAccountAddKeyAssignedbyappuserid =
            "ALTER TABLE ${TablesBase.TABLE_ACCOUNT} ADD ${ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID} TEXT";
        db.execute(alterTableAccountAddKeyAssignedbyappuserid);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_CONTACT,
          ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID)) {
        String alterTableContactAddKeyAssignedbyappuserid =
            "ALTER TABLE ${TablesBase.TABLE_CONTACT} ADD ${ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID} TEXT";
        db.execute(alterTableContactAddKeyAssignedbyappuserid);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED)) {
        String alterTableActivityAddKeyIsapprovalrequired =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED} TEXT";
        db.execute(alterTableActivityAddKeyIsapprovalrequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR)) {
        String alterTableOpportunityAddKeyLosttocompetitor =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR} TEXT";
        db.execute(alterTableOpportunityAddKeyLosttocompetitor);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS)) {
        String alterTableOpportunityAddKeyReasonforopportunitystatus =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS} TEXT";
        db.execute(alterTableOpportunityAddKeyReasonforopportunitystatus);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER)) {
        String alterTableOpportunityAddKeyOpportunityidentifier =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER} TEXT";
        db.execute(alterTableOpportunityAddKeyOpportunityidentifier);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER)) {
        String alterTableOpportunityAddKeyPurchaseordernumber =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER} TEXT";
        db.execute(alterTableOpportunityAddKeyPurchaseordernumber);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER)) {
        String alterTableOpportunityAddKeyQuotationnumber =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER} TEXT";
        db.execute(alterTableOpportunityAddKeyQuotationnumber);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED)) {
        String alterTableOpportunityAddKeyIsfinancerequired =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED} TEXT";
        db.execute(alterTableOpportunityAddKeyIsfinancerequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_FINANCEBY)) {
        String alterTableOpportunityAddKeyFinanceby =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_FINANCEBY} TEXT";
        db.execute(alterTableOpportunityAddKeyFinanceby);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS)) {
        String alterTableOpportunityAddKeyFinanceremarks =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS} TEXT";
        db.execute(alterTableOpportunityAddKeyFinanceremarks);
      }
    } catch (e) {}
  }

  void Upgrade_DownSyncTables_V7(
      Database db, String appUserId, String appUserGroupId) {
    try {
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ActivityApprovalType")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityApprovalType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','962',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "Competitor")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Competitor','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','964',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "FinancialInstitution")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('FinancialInstitution','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','966',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "OpportunityApproval")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityApproval','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','968',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "ActivityApproval")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('ActivityApproval','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','2360',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "OpportunityApprovalType")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityApprovalType','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','2380',$appUserId,$appUserGroupId)");
      }
    } catch (e) {}
  }

  void Upgrade_Tables_V8(Database db) async {
    //
    try {
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE)) {
        String alterTableOpportunityAddKeyActualopportunityvalue =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE} TEXT";
        db.execute(alterTableOpportunityAddKeyActualopportunityvalue);
      }
    } catch (e) {}
  }

  void Upgrade_Tables_V9(Database db) async {
    //
    try {
      //Activity
      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS)) {
        String alterTableActivityAddKeyApprovalstatus =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS} TEXT";
        db.execute(alterTableActivityAddKeyApprovalstatus);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS)) {
        String alterTableActivityAddKeyApprovaldetails =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS} TEXT";
        db.execute(alterTableActivityAddKeyApprovaldetails);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_COMPLETEDDATE)) {
        String alterTableActivityAddKeyCompleteddate =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_COMPLETEDDATE} TEXT";
        db.execute(alterTableActivityAddKeyCompleteddate);
      }

      //Activity Type
      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISENDDATEREQUIRED)) {
        String alterTableActivitytypeAddKeyIsenddaterequired =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISENDDATEREQUIRED} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsenddaterequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISDURATIONREQUIRED)) {
        String alterTableActivitytypeAddKeyIsdurationrequired =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISDURATIONREQUIRED} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsdurationrequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISACCOUNTMANDATORY)) {
        String alterTableActivitytypeAddKeyIsaccountmandatory =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISACCOUNTMANDATORY} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsaccountmandatory);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISAPPROVALREQUIREDONCOMPLETION)) {
        String alterTableActivitytypeAddKeyIsapprovalrequiredoncompletion =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISAPPROVALREQUIREDONCOMPLETION} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsapprovalrequiredoncompletion);
      }

      //Expense Type
      if (!await ColumnExists(db, TablesBase.TABLE_EXPENSETYPE,
          ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED)) {
        String alterTableExpensetypeAddKeyIstravelrequired =
            "ALTER TABLE ${TablesBase.TABLE_EXPENSETYPE} ADD ${ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED} TEXT";
        db.execute(alterTableExpensetypeAddKeyIstravelrequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_EXPENSETYPE,
          ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED)) {
        String alterTableExpensetypeAddKeyCalculatedistancetravelled =
            "ALTER TABLE ${TablesBase.TABLE_EXPENSETYPE} ADD ${ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED} TEXT";
        db.execute(alterTableExpensetypeAddKeyCalculatedistancetravelled);
      }

      //opportunity
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED)) {
        String alterTableOpportunityAddKeyIsapprovalrequired =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED} TEXT";
        db.execute(alterTableOpportunityAddKeyIsapprovalrequired);
      }
    } catch (ex) {}
  }

  void Upgrade_Tables_V10(
      Database db, String appUserId, String appUserGroupId) async {
    //
    try {
      String createTableUnit =
          "CREATE TABLE ${TablesBase.TABLE_UNIT}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_UNIT_UNITID} TEXT,${ColumnsBase.KEY_UNIT_UNITCODE} TEXT,${ColumnsBase.KEY_UNIT_UNITNAME} TEXT,${ColumnsBase.KEY_UNIT_SHORTFORM} TEXT,${ColumnsBase.KEY_UNIT_NUMBERSYSTEMBASE} TEXT,${ColumnsBase.KEY_UNIT_PARENTUNITID} TEXT,${ColumnsBase.KEY_UNIT_CONVERSIONFACTOR} TEXT,${ColumnsBase.KEY_UNIT_CREATEDON} TEXT,${ColumnsBase.KEY_UNIT_CREATEDBY} TEXT,${ColumnsBase.KEY_UNIT_MODIFIEDON} TEXT,${ColumnsBase.KEY_UNIT_MODIFIEDBY} TEXT,${ColumnsBase.KEY_UNIT_ISACTIVE} TEXT,${ColumnsBase.KEY_UNIT_UID} TEXT,${ColumnsBase.KEY_UNIT_APPUSERID} TEXT,${ColumnsBase.KEY_UNIT_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_UNIT_ISARCHIVED} TEXT,${ColumnsBase.KEY_UNIT_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableUnit);

      String createTableOpportunityproductdetailattribute =
          "CREATE TABLE ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILATTRIBUTECODE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_OPPORTUNITYPRODUCTDETAILID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUEID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ATTRIBUTEVALUE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_CREATEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDBY} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_MODIFIEDON} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISACTIVE} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_UID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_REFERENCEIDENTIFIER} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISARCHIVED} TEXT,${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAILATTRIBUTE_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTableOpportunityproductdetailattribute);

      String createTablePerformancesummary =
          "CREATE TABLE ${TablesBase.TABLE_PERFORMANCESUMMARY}(${ColumnsBase.KEY_ID} INTEGER PRIMARY KEY AUTOINCREMENT,${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYCODE} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCESUMMARYNAME} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_BUSINESSFEATUREID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_PERFORMANCETYPE} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ACTIVITYTYPEID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_FINANCIALYEARID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_PERIODNAME} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_STARTDATE} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ENDDATE} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_TARGET} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ACHIEVEMENT} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDON} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_CREATEDBY} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDON} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_MODIFIEDBY} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_UID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_APPUSERGROUPID} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ISARCHIVED} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ISACTIVE} TEXT,${ColumnsBase.KEY_PERFORMANCESUMMARY_ISDELETED} TEXT,${ColumnsBase.KEY_ISDIRTY} TEXT,${ColumnsBase.KEY_ISACTIVE} TEXT,${ColumnsBase.KEY_ISDELETED} TEXT,${ColumnsBase.KEY_UPSYNCMESSAGE} TEXT,${ColumnsBase.KEY_DOWNSYNCMESSAGE} TEXT,${ColumnsBase.KEY_SCREATEDON} TEXT,${ColumnsBase.KEY_SMODIFIEDON} TEXT,${ColumnsBase.KEY_CREATEDBYUSER} TEXT,${ColumnsBase.KEY_MODIFIEDBYUSER} TEXT,${ColumnsBase.KEY_UPSYNCINDEX} INTEGER,${ColumnsBase.KEY_OWNERUSERID} TEXT)";
      db.execute(createTablePerformancesummary);

      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "Unit")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('Unit','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','90',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(
          TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME,
          "OpportunityProductDetailAttribute")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('OpportunityProductDetailAttribute','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','1145',$appUserId,$appUserGroupId)");
      }
      if (!valueExists(TablesBase.TABLE_APPSYNC,
          ColumnsBase.KEY_APPSYNC_TABLENAME, "PerformanceSummary")) {
        db.execute(
            "INSERT INTO ${TablesBase.TABLE_APPSYNC}(${ColumnsBase.KEY_APPSYNC_TABLENAME},${ColumnsBase.KEY_APPSYNC_LOCALMAXDATE},${ColumnsBase.KEY_APPSYNC_SERVERMAXDATE},${ColumnsBase.KEY_APPSYNC_PAGESIZE},${ColumnsBase.KEY_APPSYNC_RECORDS},${ColumnsBase.KEY_APPSYNC_PAGE},${Columns.KEY_APPSYNC_SEQUENTIALORDER},${ColumnsBase.KEY_APPSYNC_APPUSERID},${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID}) VALUES ('PerformanceSummary','2000-01-01T00:00:00','2000-01-01T00:00:00','10','0','0','2200',$appUserId,$appUserGroupId)");
      }

      if (!await ColumnExists(db, TablesBase.TABLE_FIELDATTENDANCE,
          ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION)) {
        String alterTableFieldattendanceAddKeyUserspecifiedpunchinlocation =
            "ALTER TABLE ${TablesBase.TABLE_FIELDATTENDANCE} ADD ${ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION} TEXT";
        db.execute(alterTableFieldattendanceAddKeyUserspecifiedpunchinlocation);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_FIELDATTENDANCE,
          ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION)) {
        String alterTableFieldattendanceAddKeyUserspecifiedpunchoutlocation =
            "ALTER TABLE ${TablesBase.TABLE_FIELDATTENDANCE} ADD ${ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION} TEXT";
        db.execute(
            alterTableFieldattendanceAddKeyUserspecifiedpunchoutlocation);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACCOUNTBUSINESSPLAN,
          ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE)) {
        String alterTableAccountbusinessplanAddKeyCustomertargetdate =
            "ALTER TABLE ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} ADD ${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE} TEXT";
        db.execute(alterTableAccountbusinessplanAddKeyCustomertargetdate);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ACCOUNTSTATUS,
          ColumnsBase.KEY_ACCOUNTSTATUS_ISCUSTOMERSTATUS)) {
        String alterTableAccountstatusAddKeyIscustomerstatus =
            "ALTER TABLE ${TablesBase.TABLE_ACCOUNTSTATUS} ADD ${ColumnsBase.KEY_ACCOUNTSTATUS_ISCUSTOMERSTATUS} TEXT";
        db.execute(alterTableAccountstatusAddKeyIscustomerstatus);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYAPPROVAL,
          ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED)) {
        String alterTableActivityapprovalAddKeyIsapprovalcompleted =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYAPPROVAL} ADD ${ColumnsBase.KEY_ACTIVITYAPPROVAL_ISAPPROVALCOMPLETED} TEXT";
        db.execute(alterTableActivityapprovalAddKeyIsapprovalcompleted);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYAPPROVAL,
          ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED)) {
        String alterTableOpportunityapprovalAddKeyIsapprovalcompleted =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} ADD ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED} TEXT";
        db.execute(alterTableOpportunityapprovalAddKeyIsapprovalcompleted);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYAPPROVALTYPE,
          ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE)) {
        String alterTableActivityapprovaltypeAddKeyInternalcode =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYAPPROVALTYPE} ADD ${ColumnsBase.KEY_ACTIVITYAPPROVALTYPE_INTERNALCODE} TEXT";
        db.execute(alterTableActivityapprovaltypeAddKeyInternalcode);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE,
          ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE)) {
        String alterTableOpportunityapprovaltypeAddKeyInternalcode =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} ADD ${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE} TEXT";
        db.execute(alterTableOpportunityapprovaltypeAddKeyInternalcode);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYPRIORITY,
          ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE)) {
        String alterTableActivitypriorityAddKeyAlertonscheduleslippage =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYPRIORITY} ADD ${ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE} TEXT";
        db.execute(alterTableActivitypriorityAddKeyAlertonscheduleslippage);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ALERTONSCHEDULESLIPPAGE)) {
        String alterTableActivitytypeAddKeyAlertonscheduleslippage =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ALERTONSCHEDULESLIPPAGE} TEXT";
        db.execute(alterTableActivitytypeAddKeyAlertonscheduleslippage);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISOPPORTUNITYREQUIRED)) {
        String alterTableActivitytypeAddKeyIsopportunityrequired =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISOPPORTUNITYREQUIRED} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsopportunityrequired);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_APPUSER,
          ColumnsBase.KEY_APPUSER_ACCOUNTSACCESSLEVEL)) {
        String alterTableAppuserAddKeyAccountsaccesslevel =
            "ALTER TABLE ${TablesBase.TABLE_APPUSER} ADD ${ColumnsBase.KEY_APPUSER_ACCOUNTSACCESSLEVEL} TEXT";
        db.execute(alterTableAppuserAddKeyAccountsaccesslevel);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_APPUSER,
          ColumnsBase.KEY_APPUSER_PRODUCTSACCESSLEVEL)) {
        String alterTableAppuserAddKeyProductsaccesslevel =
            "ALTER TABLE ${TablesBase.TABLE_APPUSER} ADD ${ColumnsBase.KEY_APPUSER_PRODUCTSACCESSLEVEL} TEXT";
        db.execute(alterTableAppuserAddKeyProductsaccesslevel);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_APPUSERTYPE,
          ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER)) {
        String alterTableAppusertypeAddKeyIsexternaluser =
            "ALTER TABLE ${TablesBase.TABLE_APPUSERTYPE} ADD ${ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER} TEXT";
        db.execute(alterTableAppusertypeAddKeyIsexternaluser);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTE,
          ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS)) {
        String alterTableAttributeAddKeyApplytoallproducts =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTE} ADD ${ColumnsBase.KEY_ATTRIBUTE_APPLYTOALLPRODUCTS} TEXT";
        db.execute(alterTableAttributeAddKeyApplytoallproducts);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTE,
          ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING)) {
        String alterTableAttributeAddKeyIsselfreferencing =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTE} ADD ${ColumnsBase.KEY_ATTRIBUTE_ISSELFREFERENCING} TEXT";
        db.execute(alterTableAttributeAddKeyIsselfreferencing);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTE,
          ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID)) {
        String alterTableAttributeAddKeyParentattributeid =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTE} ADD ${ColumnsBase.KEY_ATTRIBUTE_PARENTATTRIBUTEID} TEXT";
        db.execute(alterTableAttributeAddKeyParentattributeid);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTE,
          Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME)) {
        String alterTableAttributeAddKeyParentattributename =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTE} ADD ${Columns.KEY_ATTRIBUTE_PARENTATTRIBUTENAME} TEXT";
        db.execute(alterTableAttributeAddKeyParentattributename);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTE,
          ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER)) {
        String alterTableAttributeAddKeySequentialorder =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTE} ADD ${ColumnsBase.KEY_ATTRIBUTE_SEQUENTIALORDER} TEXT";
        db.execute(alterTableAttributeAddKeySequentialorder);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTEVALUE,
          ColumnsBase.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUEID)) {
        String alterTableAttributevalueAddKeyParentattributevalueid =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTEVALUE} ADD ${ColumnsBase.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUEID} TEXT";
        db.execute(alterTableAttributevalueAddKeyParentattributevalueid);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_ATTRIBUTEVALUE,
          Columns.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUENAME)) {
        String alterTableAttributevalueAddKeyParentattributevaluename =
            "ALTER TABLE ${TablesBase.TABLE_ATTRIBUTEVALUE} ADD ${Columns.KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUENAME} TEXT";
        db.execute(alterTableAttributevalueAddKeyParentattributevaluename);
      }
      if (!await ColumnExists(
          db, TablesBase.TABLE_NOTE, ColumnsBase.KEY_NOTE_NOTETITLE)) {
        String alterTableNoteAddKeyNotetitle =
            "ALTER TABLE ${TablesBase.TABLE_NOTE} ADD ${ColumnsBase.KEY_NOTE_NOTETITLE} TEXT";
        db.execute(alterTableNoteAddKeyNotetitle);
      }
      if (!await ColumnExists(
          db, TablesBase.TABLE_NOTE, ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID)) {
        String alterTableNoteAddKeyOpportunitystageid =
            "ALTER TABLE ${TablesBase.TABLE_NOTE} ADD ${ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID} TEXT";
        db.execute(alterTableNoteAddKeyOpportunitystageid);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE)) {
        String alterTableOpportunityAddKeyPlanneddeliverydate =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE} TEXT";
        db.execute(alterTableOpportunityAddKeyPlanneddeliverydate);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE)) {
        String alterTableOpportunityAddKeyActualdeliverydate =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE} TEXT";
        db.execute(alterTableOpportunityAddKeyActualdeliverydate);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER)) {
        String alterTableOpportunityAddKeyCurrentactionowner =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER} TEXT";
        db.execute(alterTableOpportunityAddKeyCurrentactionowner);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER)) {
        String alterTableOpportunityAddKeyReferenceidentifier =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER} TEXT";
        db.execute(alterTableOpportunityAddKeyReferenceidentifier);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID)) {
        String alterTableOpportunityAddKeyCustomercallid =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID} TEXT";
        db.execute(alterTableOpportunityAddKeyCustomercallid);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID)) {
        String alterTableOpportunityAddKeyCustomersatisfactionid =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID} TEXT";
        db.execute(alterTableOpportunityAddKeyCustomersatisfactionid);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYSTAGE,
          ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME)) {
        String alterTableOpportunitystageAddKeyWorkflowstagename =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} ADD ${ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME} TEXT";
        db.execute(alterTableOpportunitystageAddKeyWorkflowstagename);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYSTAGE,
          ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION)) {
        String alterTableOpportunitystageAddKeyActiononselection =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} ADD ${ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION} TEXT";
        db.execute(alterTableOpportunitystageAddKeyActiononselection);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYSTAGE,
          ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE)) {
        String alterTableOpportunitystageAddKeyInternalcode =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} ADD ${ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE} TEXT";
        db.execute(alterTableOpportunitystageAddKeyInternalcode);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITYSTAGE,
          ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE)) {
        String alterTableOpportunitystageAddKeyOpportunitystagetype =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITYSTAGE} ADD ${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE} TEXT";
        db.execute(alterTableOpportunitystageAddKeyOpportunitystagetype);
      }
      if (!await ColumnExists(
          db, TablesBase.TABLE_PRODUCT, ColumnsBase.KEY_PRODUCT_CURRENTSTOCK)) {
        String alterTableProductAddKeyCurrentstock =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_CURRENTSTOCK} TEXT";
        db.execute(alterTableProductAddKeyCurrentstock);
      }
      if (!await ColumnExists(
          db, TablesBase.TABLE_PRODUCT, ColumnsBase.KEY_PRODUCT_UNITID)) {
        String alterTableProductAddKeyUnitid =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_UNITID} TEXT";
        db.execute(alterTableProductAddKeyUnitid);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_PRODUCT,
          ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE)) {
        String alterTableProductAddKeyMinimumsalesprice =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_MINIMUMSALESPRICE} TEXT";
        db.execute(alterTableProductAddKeyMinimumsalesprice);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_PRODUCT,
          ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE)) {
        String alterTableProductAddKeyMaximumsalesprice =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_MAXIMUMSALESPRICE} TEXT";
        db.execute(alterTableProductAddKeyMaximumsalesprice);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_APPUSER,
          Columns.KEY_APPUSER_SYSTEMCONFIGURATION)) {
        String alterTableAppuserAddKeySystemconfiguration =
            "ALTER TABLE ${TablesBase.TABLE_APPUSER} ADD ${Columns.KEY_APPUSER_SYSTEMCONFIGURATION} TEXT";
        db.execute(alterTableAppuserAddKeySystemconfiguration);
      }
    } catch (ex) {}
  }

  void Upgrade_Tables_V11(Database db) async {
    try {
      //Opportunity Table
      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_REQUESTEDDELIVERYDATE)) {
        String alterTableOpportunityAddKeyRequesteddeliverydate =
            "ALTER TABLE ${TablesBase.TABLE_OPPORTUNITY} ADD ${ColumnsBase.KEY_OPPORTUNITY_REQUESTEDDELIVERYDATE} TEXT";
        db.execute(alterTableOpportunityAddKeyRequesteddeliverydate);
      }

      //AppFeatureField table
      if (!await ColumnExists(db, TablesBase.TABLE_APPFEATUREFIELD,
          ColumnsBase.KEY_APPFEATUREFIELD_APPFEATURENAME)) {
        String alterTableAppfeaturefieldAddKeyAppfeaturename =
            "ALTER TABLE ${TablesBase.TABLE_APPFEATUREFIELD} ADD ${ColumnsBase.KEY_APPFEATUREFIELD_APPFEATURENAME} TEXT";
        db.execute(alterTableAppfeaturefieldAddKeyAppfeaturename);
      }

      //AppFeatureField table
      if (!await ColumnExists(db, TablesBase.TABLE_APPFEATUREFIELD,
          ColumnsBase.KEY_APPFEATUREFIELD_ISHIDDENINFAB)) {
        String alterTableAppfeaturefieldAddKeyIshiddeninfab =
            "ALTER TABLE ${TablesBase.TABLE_APPFEATUREFIELD} ADD ${ColumnsBase.KEY_APPFEATUREFIELD_ISHIDDENINFAB} TEXT";
        db.execute(alterTableAppfeaturefieldAddKeyIshiddeninfab);
      }

      //Product table

      if (!await ColumnExists(db, TablesBase.TABLE_PRODUCT,
          ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY)) {
        String alterTableProductAddKeyProductcategoryhierarchy =
            "ALTER TABLE ${TablesBase.TABLE_PRODUCT} ADD ${ColumnsBase.KEY_PRODUCT_PRODUCTCATEGORYHIERARCHY} TEXT";
        db.execute(alterTableProductAddKeyProductcategoryhierarchy);
      }
    } catch (ex) {}
  }

  void Upgrade_Tables_V12(Database db) async {
    try {
      if (!await ColumnExists(db, TablesBase.TABLE_FORMCELLELEMENT,
          ColumnsBase.KEY_FORMCELLELEMENT_SHOWCONTROLLABELIN)) {
        String alterTableFormcellelementAddKeyShowcontrollabelin =
            "ALTER TABLE ${TablesBase.TABLE_FORMCELLELEMENT} ADD ${ColumnsBase.KEY_FORMCELLELEMENT_SHOWCONTROLLABELIN} TEXT";
        db.execute(alterTableFormcellelementAddKeyShowcontrollabelin);
      }
      if (!await ColumnExists(db, TablesBase.TABLE_FORMSECTION,
          ColumnsBase.KEY_FORMSECTION_SHOWHEADERIN)) {
        String alterTableFormsectionAddKeyShowheaderin =
            "ALTER TABLE ${TablesBase.TABLE_FORMSECTION} ADD ${ColumnsBase.KEY_FORMSECTION_SHOWHEADERIN} TEXT";
        db.execute(alterTableFormsectionAddKeyShowheaderin);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITYTYPE,
          ColumnsBase.KEY_ACTIVITYTYPE_ISOPPORTUNITYNAMEREQUIRED)) {
        String alterTableActivitytypeAddKeyIsopportunitynamerequired =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITYTYPE} ADD ${ColumnsBase.KEY_ACTIVITYTYPE_ISOPPORTUNITYNAMEREQUIRED} TEXT";
        db.execute(alterTableActivitytypeAddKeyIsopportunitynamerequired);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_PRINCIPALNAME)) {
        String alterTableActivityAddKeyPrincipalname =
            "ALTER TABLE ${TablesBase.TABLE_ACTIVITY} ADD ${ColumnsBase.KEY_ACTIVITY_PRINCIPALNAME} TEXT";
        db.execute(alterTableActivityAddKeyPrincipalname);
      }
    } catch (ex) {}
  }

  void Upgrade_Tables_V13(Database db) async {
    try {
      if (!await ColumnExists(db, TablesBase.TABLE_ACCOUNT,
          ColumnsBase.KEY_ACCOUNT_ACCOUNTCODEINTERNAL)) {
        String ALTER_TABLE_ACCOUNT_ADD_KEY_ACCOUNTCODEINTERNAL =
            "ALTER TABLE " +
                TablesBase.TABLE_ACCOUNT +
                " ADD " +
                ColumnsBase.KEY_ACCOUNT_ACCOUNTCODEINTERNAL +
                " TEXT";
        db.execute(ALTER_TABLE_ACCOUNT_ADD_KEY_ACCOUNTCODEINTERNAL);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_CONTACT,
          ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL)) {
        String ALTER_TABLE_CONTACT_ADD_KEY_CONTACTCODEINTERNAL =
            "ALTER TABLE " +
                TablesBase.TABLE_CONTACT +
                " ADD " +
                ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL +
                " TEXT";
        db.execute(ALTER_TABLE_CONTACT_ADD_KEY_CONTACTCODEINTERNAL);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_OPPORTUNITY,
          ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODEINTERNAL)) {
        String ALTER_TABLE_OPPORTUNITY_ADD_KEY_OPPORTUNITYCODEINTERNAL =
            "ALTER TABLE " +
                TablesBase.TABLE_OPPORTUNITY +
                " ADD " +
                ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODEINTERNAL +
                " TEXT";
        db.execute(ALTER_TABLE_OPPORTUNITY_ADD_KEY_OPPORTUNITYCODEINTERNAL);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_ACTIVITY,
          ColumnsBase.KEY_ACTIVITY_ACTIVITYCODEINTERNAL)) {
        String ALTER_TABLE_ACTIVITY_ADD_KEY_ACTIVITYCODEINTERNAL =
            "ALTER TABLE " +
                TablesBase.TABLE_ACTIVITY +
                " ADD " +
                ColumnsBase.KEY_ACTIVITY_ACTIVITYCODEINTERNAL +
                " TEXT";
        db.execute(ALTER_TABLE_ACTIVITY_ADD_KEY_ACTIVITYCODEINTERNAL);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_PRODUCT,
          ColumnsBase.KEY_PRODUCT_PRODUCTCODEINTERNAL)) {
        String ALTER_TABLE_PRODUCT_ADD_KEY_PRODUCTCODEINTERNAL =
            "ALTER TABLE " +
                TablesBase.TABLE_PRODUCT +
                " ADD " +
                ColumnsBase.KEY_PRODUCT_PRODUCTCODEINTERNAL +
                " TEXT";
        db.execute(ALTER_TABLE_PRODUCT_ADD_KEY_PRODUCTCODEINTERNAL);
      }

      if (!await ColumnExists(db, TablesBase.TABLE_APPUSER,
          ColumnsBase.KEY_APPUSER_REPORTEECOUNT)) {
        String ALTER_TABLE_APPUSER_ADD_KEY_REPORTEECOUNT = "ALTER TABLE " +
            TablesBase.TABLE_APPUSER +
            " ADD " +
            ColumnsBase.KEY_APPUSER_REPORTEECOUNT +
            " TEXT";
        db.execute(ALTER_TABLE_APPUSER_ADD_KEY_REPORTEECOUNT);
      }
    } catch (ex) {}
  }

  //  -----Common Functions------

  static Future<bool> ColumnExists(
      Database db, String tableName, String columnName) async {
    bool isExists = false;

    // Query the table's schema to get the column information
    try {
      List<Map<String, dynamic>> columns =
          await db.rawQuery("PRAGMA table_info('$tableName')");

      // Iterate over the columns to check if the specified column exists
      for (var column in columns) {
        String name = column['name'];
        if (name == columnName) {
          isExists = true; // Column found
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return isExists; // Column not found
  }

  bool valueExists(String tableName, String columnName, String value) {
    try {
      String sql =
          "SELECT COUNT(*) FROM $tableName WHERE $columnName = '${value.replaceAll("'", "''")}' AND AppUserGroupID = ${Globals.AppUserGroupID} AND AppUserID = ${Globals.AppUserID}";
      if (executeScalar(sql) == 0) {
        return false;
      }
    } catch (Exception) {
      // Handle the exception, if required
    }
    return true;
  }

  Future<int> executeScalar(String sql) async {
    int itemCount = 0;
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      if (result.isNotEmpty) {
        itemCount = result.first.values.first as int;
      }
    } catch (e) {
      print(e.toString());
    }
    return itemCount;
  }

  void updateAppSyncSequentialOrder_V3() async {
    try {
      int sequentialOrder = 0;
      final db = await database;
      String sql = "SELECT A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
      sql +=
          " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      sql += " ORDER BY CAST(A.${ColumnsBase.KEY_ID} AS INTEGER)";
      print('SQL: $sql');
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      for (Map<String, dynamic> row in result) {
        sequentialOrder += 20;
        String id = row[ColumnsBase.KEY_ID].toString();
        await db.rawUpdate(
            "UPDATE ${TablesBase.TABLE_APPSYNC} SET ${Columns.KEY_APPSYNC_SEQUENTIALORDER} = $sequentialOrder WHERE ${ColumnsBase.KEY_ID} = $id");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> getSyncRecordCount(
      String appUserId, String appUserGroupId) async {
    int itemCount = 0;
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(
          "SELECT COUNT(*) FROM ${TablesBase.TABLE_APPSYNC} WHERE ${ColumnsBase.KEY_APPSYNC_APPUSERID} = $appUserId AND ${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = $appUserGroupId",
          null);
      if (result.isNotEmpty) {
        itemCount = result.first.values.first as int;
      }
    } catch (Exception) {
      rethrow;
    }
    return itemCount;
  }

  Future<int> getRecordCount(String tableName) async {
    int itemCount = 0;
    try {
      final db = await database;
      List<Map<String, dynamic>> result =
          await db.rawQuery("SELECT COUNT(*) FROM $tableName", null);
      if (result.isNotEmpty) {
        itemCount = result.first.values.first as int;
      }
    } catch (e) {}
    return itemCount;
  }

// List<KeyValuePair> getValueTitlePairs(String tableName, String displayColumn, String valueColumn) {
//   List<KeyValuePair> dataList = [];
//   try {
//     String selectQuery = "SELECT $displayColumn, $valueColumn FROM $tableName";
//     final db = await database;
//     List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
//     for (Map<String, dynamic> row in result) {
//       KeyValuePair dataItem = KeyValuePair(
//         int.parse(row[displayColumn].toString()),
//         row[valueColumn].toString(),
//       );
//       dataList.add(dataItem);
//     }
//   } catch (Exception) {
//     rethrow;
//   }
//   return dataList;
// }

  Future<List<String>> getTitles(String tableName, String displayColumn) async {
    List<String> dataList = [];
    try {
      String selectQuery = "SELECT $displayColumn FROM $tableName";
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (Map<String, dynamic> row in result) {
        dataList.add(row[displayColumn].toString());
      }
    } catch (Exception) {
      rethrow;
    }
    return dataList;
  }

  Future<String> executeStringValue(String sql) async {
    String itemString = "";
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      if (result.isNotEmpty) {
        itemString = result.first.values.first.toString();
      }
    } catch (Exception) {
      rethrow;
    }
    return itemString;
  }

  Future<List<String>> getTableColumnRows(String sql, String columnName) async {
    List<String> data = [];
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      for (Map<String, dynamic> row in result) {
        data.add(row[columnName].toString());
      }
    } catch (Exception) {
      // Handle exceptions as per your requirements
    }
    return data;
  }

  Future<String> getTableColumnValue(String sql, String columnName) async {
    String data = "";
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      if (result.isNotEmpty) {
        data = result.first[columnName].toString();
      }
    } catch (Exception) {
      // Handle exceptions as per your requirements
    }
    return data;
  }

  Future<List<String>> getDesignationsForBusinessCardScan() async {
    List<String> data = [];
    try {
      final db = await database;
      String sql =
          "SELECT ${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} FROM ${TablesBase.TABLE_DESIGNATION_BC}";
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      for (Map<String, dynamic> row in result) {
        data.add(row[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME].toString());
      }
    } catch (Exception) {
      // Handle exceptions as per your requirements
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> getTableData(String sql) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      return result;
    } catch (Exception) {
      // Handle exceptions as per your requirements
      return [];
    }
  }

  Future<String> getTableColumnData(String sql) async {
    String data = "";
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery(sql, null);
      if (result.isNotEmpty) {
        data = result.first.values.first.toString();
      }
    } catch (Exception) {
      // Handle exceptions as per your requirements
    }
    return data;
  }

  void activateDeactivateRecords(String tableName, String ids1) async {
    try {
      String ids = Globals.getStringValue(ids1);
      if (ids.isEmpty) return;

      final db = await database;
      if (tableName == "Account") {
        db.execute(
            "UPDATE ${TablesBase.TABLE_ACCOUNT} SET ${ColumnsBase.KEY_ISDELETED} = 'true' WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}, -1) AS INTEGER) NOT IN ($ids) AND COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
        db.execute(
            "UPDATE ${TablesBase.TABLE_ACCOUNT} SET ${ColumnsBase.KEY_ISDELETED} = 'false' WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}, -1) AS INTEGER) IN ($ids) AND COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
      } else if (tableName == "Contact") {
        db.execute(
            "UPDATE ${TablesBase.TABLE_CONTACT} SET ${ColumnsBase.KEY_ISDELETED} = 'true' WHERE CAST(COALESCE(${ColumnsBase.KEY_CONTACT_CONTACTID}, -1) AS INTEGER) NOT IN ($ids) AND COALESCE(${ColumnsBase.KEY_CONTACT_CONTACTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
        db.execute(
            "UPDATE ${TablesBase.TABLE_CONTACT} SET ${ColumnsBase.KEY_ISDELETED} = 'false' WHERE CAST(COALESCE(${ColumnsBase.KEY_CONTACT_CONTACTID}, -1) AS INTEGER) IN ($ids) AND COALESCE(${ColumnsBase.KEY_CONTACT_CONTACTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
      } else if (tableName == "Activity") {
        db.execute(
            "UPDATE ${TablesBase.TABLE_ACTIVITY} SET ${ColumnsBase.KEY_ISDELETED} = 'true' WHERE CAST(COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID}, -1) AS INTEGER) NOT IN ($ids) AND COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} AND COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID}, '') <> ''");
        db.execute(
            "UPDATE ${TablesBase.TABLE_ACTIVITY} SET ${ColumnsBase.KEY_ISDELETED} = 'false' WHERE CAST(COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID}, -1) AS INTEGER) IN ($ids) AND COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} AND COALESCE(${ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID}, '') <> ''");
      } else if (tableName == "Opportunity") {
        db.execute(
            "UPDATE ${TablesBase.TABLE_OPPORTUNITY} SET ${ColumnsBase.KEY_ISDELETED} = 'true' WHERE CAST(COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID}, -1) AS INTEGER) NOT IN ($ids) AND COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} AND COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID}, '') <> ''");
        db.execute(
            "UPDATE ${TablesBase.TABLE_OPPORTUNITY} SET ${ColumnsBase.KEY_ISDELETED} = 'false' WHERE CAST(COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID}, -1) AS INTEGER) IN ($ids) AND COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} AND COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID}, '') <> ''");
      } else if (tableName == "Product") {
        // db.execute("UPDATE ${TablesBase.TABLE_PRODUCT} SET ${ColumnsBase.KEY_ISDELETED} = 'false' WHERE ${ColumnsBase.KEY_PRODUCT_PRODUCTID} NOT IN ($ids) AND COALESCE(${ColumnsBase.KEY_PRODUCT_PRODUCTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
        // db.execute("UPDATE ${TablesBase.TABLE_PRODUCT} SET ${ColumnsBase.KEY_ISDELETED} = 'true' WHERE ${ColumnsBase.KEY_PRODUCT_PRODUCTID} IN ($ids) AND COALESCE(${ColumnsBase.KEY_PRODUCT_PRODUCTID}, '') <> '' AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}");
      }
    } catch (Exception) {
      // Handle exceptions as per your requirements
    }
  }

  void RemoveUserData(String appUserId, String appUserGroupId) async {
    try {
      print("WOR" + "REMOVING USER DATA");

      final db = await database;

      db.execute(
          "DELETE FROM AppSync WHERE AppUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AmiConfiguration WHERE AppUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Designationbc WHERE AppUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Account WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountAddress WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountBusinessPlan WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountBuyingProcess WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountCategory WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountCategoryMapping WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountCompetitionActivity WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountForm WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountFormValue WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountPhone WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountSegment WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountStatus WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountTerritory WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AccountType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Activity WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityMeasure WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityPermission WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityPriority WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityProduct WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityProductDetail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityStatus WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityTeam WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityTravel WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityTravelMapping WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityTravelMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ActivityType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AddressType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppFeature WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppFeatureField WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppFeatureGroup WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppLog WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppReport WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUsage WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUser WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserLocation WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserMessage WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserProduct WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserRemark WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserRole WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserTeam WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserTeamMember WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserTerritory WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AppUserType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Attribute WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM AttributeValue WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM BusinessEmail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM BusinessFeature WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ChatMessage WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ChatUserAndGroup WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ChatUserGroupMember WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Contact WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ContactAlignment WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ContactMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ContactTitle WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ContentType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Country WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM CreditRating WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Currency WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM CustomerMeeting WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Department WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Designation WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM EmailManualTemplate WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM FieldAttendance WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM FinancialYear WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Form WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM FormCell WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM FormCellElement WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM FormSection WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Industry WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM LeadSource WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ModeOfTravel WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Note WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM NoteMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM NotePermission WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Notification WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM NotificationAssignment WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Opportunity WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityContact WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityMeasure WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityFulfillmentStatus WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityName WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityPermission WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityPriority WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityProduct WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityProductDetail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityStage WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityStageType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityStatus WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityTeam WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM OpportunityType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM PhoneType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Product WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ProductAuxiliary WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ProductCategory WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ProductInstallation WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ProductInstallationDetail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ProductMedia WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Reimbursement WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ReimbursementDetail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ReimbursementType WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Reminder WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Resource WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ServiceInvoice WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM ServiceInvoiceDetail WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Tag WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM TagGroup WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM Territory WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM TimeZone WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM TravelPurpose WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");
      db.execute(
          "DELETE FROM UserRole WHERE OwnerUserID = $appUserId AND AppUserGroupID = $appUserGroupId");

      // Log.d("WOR", "REMOVED USER DATA");
    } catch (e) {
      // Globals.HandleException(context, "DatabaseHandler:RemoveUserData()", ex);
    }
  }
}
