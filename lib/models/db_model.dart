import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_model.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnect{
  static Database? _db;
 // Database? _database;
// late Database _db;


Future<Database?> get db async{
  if(_db != null)
  {
    return _db;
  }
   
   _db= await initDatabase();
   return _db;
}

initDatabase() async {
  io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  String path= join(documentDirectory.path, 'tododb.db');
  var db= await openDatabase(path, version: 1, onCreate:_createDB );
  return db;
}
  // Future<void> init() async {
  //   io.Directory applicationDirectory =
  //       await getApplicationDocumentsDirectory();
  //   String dbPath = path.join(applicationDirectory.path, "todo.db");

  //   bool dbExists = await io.File(dbPath).exists();
  //   if (!dbExists) {
  //     ByteData data =
  //         await rootBundle.load(path.join("assets", "todo.db"));
  //     List<int> bytes =
  //         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //     await io.File(dbPath).writeAsBytes(bytes, flush: true);
  //   } else {}
  //   _db = await openDatabase(dbPath, onCreate:_createDB );
  //   print("connected to db");
  // }

  // Future<Database> get database async{
  //   final dbPath= await getDatabasesPath();

  //   const dbName= 'todo.db';

  //   final path= join(dbPath, dbName);

  //   _database= await openDatabase(path, version: 1, onCreate: _createDB);

  //   return _database!;
  // }

  


  Future<void> _createDB(Database db, int version) async{
    
    await db.execute(
        'CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, creationDate TEXT, isChecked INTEGER)'
    );
  }

  Future<void> insertTodo(Todo todo) async{
    var dB= await db;

    await dB!.insert(
      'todo', 
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );
  }

  Future<void> deleteTodo(Todo todo) async{
      var dB= await db;

    await dB!.delete(
      'todo',
       where: 'id==?',
       whereArgs: [todo.id]
    );
  }

  Future<List<Todo>> getTodo() async {
      var dB= await db;

    List<Map<String, dynamic>> items= await dB! .query(
        'todo',
        orderBy: 'id DESC'
    );

    return List.generate(
      items.length,
       (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'], 
        creationDate: DateTime.parse(items[i]['creationDate']), 
        isChecked: items[i]['isChecked'] == 1? true: false
        )
      );
  }
}