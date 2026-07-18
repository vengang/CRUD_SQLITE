import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> openDB() async {
    final path = join(await getDatabasesPath(), 'employee.db');
    //create data base
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        //Active
        return db.execute(
          "Create table employee(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, salary REAL) ",
        );
      },
    );
  }

  // write data into sqlite
  static Future<int> insertEmployee(String username, double salary) async {
    final db = await openDB();
    //fun insert(table, value(Map))
    return db.insert("employee", {'username': username, 'salary': salary});
  }

  // read sqlite
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await openDB();
    return db.query('employee');
  }

  // deleter sqlite
  static Future<int> dateleEmployee(int id) async {
    final db = await openDB();
    return db.delete('employee', where: 'id = ?', whereArgs: [id]);
  }
}

/* On mobile app
1. path is the place to store local storage

for create
- the first step need to crate path
- fun to get default path get database path, 'name'

// when with local store db api return as map
//static no need create obj just take name of class to use
*/
