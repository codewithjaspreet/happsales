import 'dart:io';

import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final path = join(documentsDirectory.path, 'HappSales.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Contacts ('
          'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'ContactID TEXT,'
          'ContactCode TEXT,'
          'Title TEXT,'
          'FirstName TEXT,'
          'MiddleName TEXT,'
          'LastName TEXT,'
          'ContactName TEXT,'
          'AccountName TEXT,'
          'Email TEXT,'
          'AlternateEmail TEXT,'
          'PIN TEXT,'
          'MobileNumber TEXT,'
          'ContactIdentifier TEXT,'
          'AccountID INTEGER,'
          'ContactCategoryID TEXT,'
          'DepartmentName TEXT,'
          'RolesAndResponsibilities TEXT,'
          'ReportingManager TEXT,'
          'ReportingContactID INTEGER,'
          'AlternateMobileNumber TEXT,'
          'WorkPhone TEXT,'
          'ResidencePhone TEXT,'
          'AddressLine1 TEXT,'
          'AddressLine2 TEXT,'
          'AddressLine3 TEXT,'
          'City TEXT,'
          'State TEXT,'
          'Country TEXT,'
          'GPSCoordinates TEXT,'
          'LinkedIn TEXT,'
          'PastAccounts TEXT,'
          'PastDesignations TEXT,'
          'DateOfBirth TEXT,'
          'RemindBirthday TEXT,'
          'ContactAlignmentID TEXT,'
          'FreeTextField1 TEXT,'
          'FreeTextField2 TEXT,'
          'FreeTextField3 TEXT,'
          'TaxPayerIdentificationNumber TEXT,'
          'SocialSecurityNumber TEXT,'
          'PassportNumber TEXT,'
          'DrivingLicenseNumber TEXT,'
          'VoterIDCardNumber TEXT,'
          'MarketingContactID TEXT,'
          'CreatedBy TEXT,'
          'CreatedOn TEXT'
          'AppUserID TEXT'
          ')');

      await db.execute('CREATE TABLE Account ('
          'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'AccountID TEXT,'
          'AccountCode TEXT,'
          'AccountName TEXT,'
          'AccountLocation TEXT,'
          'AccountIdentifier TEXT,'
          'AccountSegmentID TEXT,'
          'AccountStatusID TEXT,'
          'AccountTypeID TEXT,'
          'ParentAccountID TEXT,'
          'IndustryName TEXT,'
          'Website TEXT,'
          'Turnover TEXT,'
          'NumberOfEmployees TEXT,'
          'CreditRatingID INTEGER,'
          'CurrencyID TEXT,'
          'PrimaryContactName TEXT,'
          'Phone TEXT,'
          'Email TEXT,'
          'Fax INTEGER,'
          'AlternateMobileNumber TEXT,'
          'WorkPhone TEXT,'
          'ResidencePhone TEXT,'
          'AddressLine1 TEXT,'
          'AddressLine2 TEXT,'
          'AddressLine3 TEXT,'
          'City TEXT,'
          'State TEXT,'
          'Country TEXT,'
          'PIN TEXT,'
          'TerritoryName TEXT,'
          'GPSCoordinates TEXT,'
          'LogoImagePath TEXT,'
          'LogoImageContent TEXT,'
          'LocalMediaPath TEXT,'
          'IsUploaded TEXT,'
          'TaxPayerIdentificationNumber TEXT,'
          'FreeTextField1 TEXT,'
          'FreeTextField2 TEXT,'
          'FreeTextField3 TEXT,'
          'Tags TEXT,'
          'MarketingContactID TEXT,'
          'CreatedBy TEXT,'
          'CreatedOn TEXT,'
          'ModifiedBy TEXT,'
          'ModifiedOn TEXT,'
          'DeviceIdentifier TEXT'
          'ReferenceIdentifier TEXT'
          'IsActive TEXT'
          'Uid TEXT'
          'AppUserID TEXT'
          'AppUserGroupID TEXT'
          'IsArchived TEXT'
          'IsDeleted TEXT'
          'LeadQualificationID TEXT'
          'IsDirty TEXT'
          'IsActive1 TEXT'
          'IsDeleted1 TEXT'
          'UpSyncMessage TEXT'
          'DownSyncMessage TEXT'
          'SCreatedOn TEXT'
          'SModifiedOn TEXT'
          'CreatedByUser TEXT'
          'ModifiedByUser TEXT'
          'UpSyncIndex TEXT'
          'OwnerUserID INTEGER'
          ')');

    });
  }

  createEmployee(Contact newEmployee) async {
    final db = await database;


    final res = await db.insert('Contacts', newEmployee.toJson(),

        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Inserting $newEmployee");

    print("Inserted $res IN THE DATABASE");

    return res;
  }


  createAccount(Account newEmployee) async {
    final db = await database;


    final res = await db.insert('Account', newEmployee.toJson(),

        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Inserting $newEmployee");

    print("Inserted $res IN THE DATABASE");

    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Employee');

    return res;
  }

  Future<List<Contact>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery("SELECT DISTINCT contactID, * FROM CONTACTS");

    List<Contact> list = res.isNotEmpty
        ? res.map((c) => Contact.fromJson(c)).toList()
        : [];

    return list;
  }


  Future<List<Account>> getAllAccounts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT DISTINCT accountID, * FROM Account");

    List<Account> list =
        res.isNotEmpty ? res.map((c) => Account.fromJson(c)).toList() : [];

    return list;
  }
}
