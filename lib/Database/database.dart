import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_cubit_database/Database/taskmodel.dart';

class DatabaseHelper {
//variable
  static String dbName = 'taskDB.db';
  static int dbVersion = 1;
  static String dbTable = 'todotask';
  // Columns
  static String colId = 'id';
  static String colTitle = 'title';
  static String colCompleted = 'completed';
//constructor
  DatabaseHelper._();
  static DatabaseHelper instance = DatabaseHelper._();
//initialize Db
  Database? db;
  Future<Database> inilDb() async { 
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, dbName);
    _oncreate(Database db, int version) {
      var autoincrementType = 'integer primary key autoincrement not null';
      var stringType = 'text not null';
      var intType = 'integer not null';
      db.execute('''
CREATE TABLE $dbTable(
  $colId $autoincrementType,
  $colTitle $stringType,
  $colCompleted $intType
  )
''');
    }
    return await openDatabase(path, version: dbVersion, onCreate: _oncreate);
  }
// get Db
  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    } else {
      return inilDb();
    }
  }

  Future<bool> createTask(TaskModel model) async {
    var db = await getDb();
    var rowEffected = await db.insert(dbTable, model.toMap());
    return rowEffected > 0;
  }

  Future<List<TaskModel>> fatchData() async {
    var db = await getDb();
    List<TaskModel> arrdata = [];
    var data = await db.query(dbTable);
    for (Map<String, dynamic> eachdata in data) {
      var taskmodel = TaskModel.fromMap(eachdata);
      arrdata.add(taskmodel);
    }
    return arrdata;
  }

  Future<bool> deleteTask(int id) async {
    var db = await getDb();
    var rowEffected = await db.delete(dbTable, where: "$colId = ${id}");
    return rowEffected > 0;
  }

  Future<bool> updateTask(TaskModel model) async {
    var db = await getDb();
    var rowEffected = await db.update(dbTable, model.toMap(),
        where: "$colId = ${model.modelId}");
    return rowEffected > 0;
  }

  updatecheck(int id, int newcompleted) async {
    var db = await getDb();
    db.update(dbTable, {colCompleted: newcompleted}, where: "$colId = $id");
  }
}
