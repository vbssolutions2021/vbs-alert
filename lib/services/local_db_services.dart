import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sos_vision/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'sos_vision_db.db'),
      onCreate: (db, version) {
        db.execute('''
    CREATE TABLE IF NOT EXISTS employees (
    employeeId INT PRIMARY KEY,
    companyId INT,
    firstname VARCHAR(255),
    password VARCHAR(255),
    lastname VARCHAR(255),
    phone_number VARCHAR(15),
    role VARCHAR(255),
    function VARCHAR(255),
    )
  ''');
      },
      version: 1,
    );
  }

  Future<int> addEmployee(Employee employee) async {
    final Database db = await database;

    return await db.insert(
      'employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateEmployee(Employee employee) async {
    final Database db = await database;
    await db.update("employees", employee.toMap(),
        where: "employeeId = ?", whereArgs: [employee.employeeId]);
  }

  void deleteEmployee(int id) async {
    final Database db = await database;
    db.delete("employees", where: "employeeId = ?", whereArgs: [id]);
  }

  Stream<List<Employee>> employeeList() async* {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    List<Employee> employeesList = List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });

    if (employeesList.isEmpty) {
      for (Employee employee in defaultEmployeeList) {
        addEmployee(employee);
      }
      employeesList = defaultEmployeeList;
    }

    yield employeesList;
  }

  List<Employee> defaultEmployeeList = [];
}
