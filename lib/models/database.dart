import 'dart:io';

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
              'MobileNumber TEXT,'
              'AlternateMobileNumber TEXT,'
              'WorkPhone TEXT,'
              'ResidencePhone TEXT,'
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
              'CreatedOn TEXT,'
              ')');
    });
  }

  createEmployee(Contact newEmployee) async {
    final db = await database;

    final res = await db.insert('Contacts', newEmployee.toJson());
    print("Inserting $newEmployee");

    print("Inserted $res IN THE DATABASE"  );

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
    final res = await db.rawQuery("SELECT * FROM CONTACTS");

    List<Contact> list =
        res.isNotEmpty ? res.map((c) => Contact.fromJson(c)).toList() : [];

    return list;
  }
}
