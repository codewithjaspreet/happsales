import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');

    // table names
    
    const String accountTable = "Account";
    const String contactTable = "Contact";
    const String contactTitle = "ContactTitle";


    // initialising tables
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $accountTable(Id INTEGER PRIMARY KEY AUTOINCREMENT,AccountID TEXT,AccountCode TEXT,AccountName TEXT,AccountLocation TEXT,AccountIdentifier TEXT,AccountSegmentID TEXT,AccountStatusID TEXT,AccountTypeID TEXT,ParentAccountID TEXT,IndustryName TEXT,Website TEXT,Turnover TEXT,NumberOfEmployees TEXT,CreditRatingID TEXT,CurrencyID TEXT,PrimaryContactName TEXT,Phone TEXT,Email TEXT,Fax TEXT,AddressLine1 TEXT,AddressLine2 TEXT,AddressLine3 TEXT,City TEXT,State TEXT,Country TEXT,PIN TEXT,TerritoryName TEXT,GPSCoordinates TEXT,LogoImagePath TEXT,LogoImageContent TEXT,LocalMediaPath TEXT,IsUploaded TEXT,TaxPayerIdentificationNumber TEXT,FreeTextField1 TEXT,FreeTextField2 TEXT,FreeTextField3 TEXT,Tags TEXT,MarketingContactID TEXT,CreatedBy TEXT,CreatedOn TEXT,ModifiedBy TEXT,ModifiedOn TEXT,DeviceIdentifier TEXT,ReferenceIdentifier TEXT,IsActive TEXT,Uid TEXT,AppUserID TEXT,AppUserGroupID TEXT,IsArchived TEXT,IsDeleted TEXT,LeadQualificationID TEXT,IsDirty TEXT,IsActive1 TEXT,IsDeleted1 TEXT,UpSyncMessage TEXT,DownSyncMessage TEXT,SCreatedOn TEXT,SModifiedOn TEXT,CreatedByUser TEXT,ModifiedByUser TEXT,UpSyncIndex INTEGER,OwnerUserID TEXT)
        ''');

        await db.execute(''' 
        
         CREATE TABLE $contactTable(Id INTEGER PRIMARY KEY AUTOINCREMENT,ContactID TEXT,ContactCode TEXT,Title TEXT,FirstName TEXT,MiddleName TEXT,LastName TEXT,ContactName TEXT,ContactIdentifier TEXT,AccountID TEXT,DepartmentName TEXT,Designation TEXT,RolesAndResponsibilities TEXT,ReportingManager TEXT,ReportingContactID TEXT,MobileNumber TEXT,AlternateMobileNumber TEXT,WorkPhone TEXT,ResidencePhone TEXT,Email TEXT,AlternateEmail TEXT,AddressLine1 TEXT,AddressLine2 TEXT,AddressLine3 TEXT,City TEXT,State TEXT,Country TEXT,PIN TEXT,GPSCoordinates TEXT,LinkedIn TEXT,PastAccounts TEXT,PastDesignations TEXT,DateOfBirth TEXT,RemindBirthday TEXT,ContactAlignmentID TEXT,Remarks TEXT,ReferenceHistory TEXT,IsPrimaryContact TEXT,Tags TEXT,FreeTextField1 TEXT,FreeTextField2 TEXT,FreeTextField3 TEXT,CompanyName TEXT,TaxPayerIdentificationNumber TEXT,SocialSecurityNumber TEXT,PassportNumber TEXT,DrivingLicenseNumber TEXT,VoterIDCardNumber TEXT,MarketingContactID TEXT,CreatedBy TEXT,CreatedOn TEXT,ModifiedBy TEXT,ModifiedOn TEXT,DeviceIdentifier TEXT,ReferenceIdentifier TEXT,IsActive TEXT,Uid TEXT,AppUserID TEXT,AppUserGroupID TEXT,IsArchived TEXT,IsDeleted TEXT,LeadQualificationID TEXT,IsDirty TEXT,IsActive1 TEXT,IsDeleted1 TEXT,UpSyncMessage TEXT,DownSyncMessage TEXT,SCreatedOn TEXT,SModifiedOn TEXT,CreatedByUser TEXT,ModifiedByUser TEXT,UpSyncIndex INTEGER,OwnerUserID TEXT)
        ''');

        await db.execute('''
        
            CREATE TABLE $contactTitle(Id INTEGER PRIMARY KEY AUTOINCREMENT,ContactTitleID TEXT,ContactTitleCode TEXT,ContactTitleName TEXT,CreatedOn TEXT,CreatedBy TEXT,ModifiedOn TEXT,ModifiedBy TEXT,IsActive TEXT,Uid TEXT,AppUserID TEXT,AppUserGroupID TEXT,IsArchived TEXT,IsDeleted TEXT,IsDirty TEXT,IsActive1 TEXT,IsDeleted1 TEXT,UpSyncMessage TEXT,DownSyncMessage TEXT,SCreatedOn TEXT,SModifiedOn TEXT,CreatedByUser TEXT,ModifiedByUser TEXT,UpSyncIndex INTEGER,OwnerUserID TEXT)
         ''');
      },
    );
  }
}
