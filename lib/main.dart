

import 'package:flutter/material.dart';
import 'package:todo_app/models/db_model.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> opne() async{
    var db=  DatabaseConnect();
  await db.insertTodo(
    Todo(
      id: 1,
      title: 'This is the sample todo ',
       creationDate: DateTime.now(), 
       isChecked: false)
  );

  print(await db.getTodo());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

