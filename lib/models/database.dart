import 'dart:io';

import 'package:happsales_crm/models/contact.dart';
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

    const String contactTable = "Contact";
    const String contactId = "contactId";
    const String firstName = "firstName";
    const String lastName = "lastName";

    var tempDb = await openDatabase(path, version: 5, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $contactTable("
              "$contactId INTEGER PRIMARY KEY, "
              "$firstName TEXT, "
              "$lastName TEXT )");
        });
    // print("DB )
    var result = await tempDb.rawQuery("SELECT * FROM $contactTable");
    return tempDb;
  }

  // insert employee
  createEmployee(Map<String, dynamic> newEmployee) async {
    conflictAlgorithm:
    ConflictAlgorithm.replace;

    final db = await database;
    final int? contactId = newEmployee['contactId'];
    final String? firstName = newEmployee['firstName'];
    final String? lastName = newEmployee['lastName'];

    try {
      final res = await db.rawInsert(
          "INSERT INTO Contact (contactId, firstName, lastName) VALUES ($contactId, $firstName, $lastName)");



      return res;
    } catch (e) {
      // check if the value is already in the database
      final res = await db
          .rawQuery("SELECT * FROM Contact WHERE contactId = $contactId");

      if (res.isNotEmpty) {
        print("Already in database =  $res");
      } else {
        print("Failed to insert $contactId  | $firstName | $lastName");
        // print(e);
        // print("\n");
      }
      // print("Failed to insert $contactId  | $contactName | $accountName");
      // print(e);
      // print("\n");
    }
  }

  // get all employees

  Future<List<Contact>> getAllEmployees() async {
    final db = await database;
    final res = await db.query('Contact');
    // print("Replay from db =>$res");

    List<Contact> list =
    res.isNotEmpty ? res.map((c) => Contact.fromJson(c)).toList() : [];

    for (var item in list) {
      print(item.contactId);
      print(item.firstName);
      print(item.lastName);
    }

    // print("Made Employee List => ");
    // list.forEach((element) {
    //   print(element.accountName);
    //   print("\n\n\n");
    // });
    return list;
  }

  // get employee by id

  Future<Contact> getEmployeeById(int id) async {
    final db = await database;
    final res =
    await db.query('Contact', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? Contact.fromJson(res.first) : Contact();
  }

  Future<int> updateEmployee(Contact newEmployee) async {
    final db = await database;
    final res = await db.update('Contact', newEmployee.toJson(),
        where: 'id = ?', whereArgs: [newEmployee.contactId]);

    return res;
  }

  // delete employee

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    final res =
    await db.delete('Contact', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  // delete all employees

  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Contact');

    return res;
  }
}