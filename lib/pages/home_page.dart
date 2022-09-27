import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/db_model.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/todo_card.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:todo_app/widgets/user_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var db= DatabaseConnect();
   
  void addItem(Todo todo) async
  {
     await db.insertTodo(todo);
     setState(() {
       
     });
  }

  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E8FF),
      appBar: AppBar(
        title: Text('Simple Todo App'),
      ),
      body: Column(
        children: [
       TodoList(insertFunction: addItem, deleteFunction: deleteItem,),
          UserInput(insertFunction: addItem,)
        ],
      ),
    );
  }
}