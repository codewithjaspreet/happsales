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

    const String accountTable = "Account";

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $accountTable(Id INTEGER PRIMARY KEY AUTOINCREMENT,AccountID TEXT,AccountCode TEXT,AccountName TEXT,AccountLocation TEXT,AccountIdentifier TEXT,AccountSegmentID TEXT,AccountStatusID TEXT,AccountTypeID TEXT,ParentAccountID TEXT,IndustryName TEXT,Website TEXT,Turnover TEXT,NumberOfEmployees TEXT,CreditRatingID TEXT,CurrencyID TEXT,PrimaryContactName TEXT,Phone TEXT,Email TEXT,Fax TEXT,AddressLine1 TEXT,AddressLine2 TEXT,AddressLine3 TEXT,City TEXT,State TEXT,Country TEXT,PIN TEXT,TerritoryName TEXT,GPSCoordinates TEXT,LogoImagePath TEXT,LogoImageContent TEXT,LocalMediaPath TEXT,IsUploaded TEXT,TaxPayerIdentificationNumber TEXT,FreeTextField1 TEXT,FreeTextField2 TEXT,FreeTextField3 TEXT,Tags TEXT,MarketingContactID TEXT,CreatedBy TEXT,CreatedOn TEXT,ModifiedBy TEXT,ModifiedOn TEXT,DeviceIdentifier TEXT,ReferenceIdentifier TEXT,IsActive TEXT,Uid TEXT,AppUserID TEXT,AppUserGroupID TEXT,IsArchived TEXT,IsDeleted TEXT,LeadQualificationID TEXT,IsDirty TEXT,IsActive1 TEXT,IsDeleted1 TEXT,UpSyncMessage TEXT,DownSyncMessage TEXT,SCreatedOn TEXT,SModifiedOn TEXT,CreatedByUser TEXT,ModifiedByUser TEXT,UpSyncIndex INTEGER,OwnerUserID TEXT)
        ''');
      },
    );
    


  }

  // insert employee
  createEmployee(Map<String, dynamic> newEmployee) async {
    conflictAlgorithm:
    ConflictAlgorithm.replace;

    final db = await database;
    final int? contactId = newEmployee['ContactID'];
    final String? contactName = newEmployee['ContactName'];
    final String? accountName = newEmployee['AccountName'];

    try {
      final res = await db.rawInsert(
          "INSERT INTO categoryTable (contactId, contactName, accountName) VALUES ($contactId, '$contactName', '$accountName')");
      return res;
    } catch (e) {
      // check if the value is already in the database
      final res = await db
          .rawQuery("SELECT * FROM categoryTable WHERE contactId = $contactId");
      if (res.isNotEmpty) {
        print("Already in database =  $res");
      } else {
        print("Failed to insert $contactId  | $contactName | $accountName");
        // print(e);
        // print("\n");
      }
      // print("Failed to insert $contactId  | $contactName | $accountName");
      // print(e);
      // print("\n");
    }
  }
}
