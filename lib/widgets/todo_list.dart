import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/db_model.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  final Function insertFunction;
  final Function deleteFunction;
   TodoList({super.key, required this.insertFunction, required this.deleteFunction});

  var db= DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: [],
        builder: ( BuildContext context,AsyncSnapshot<List>  snapshot) {
          var data= snapshot.data;
          var dataLength= data!.length;

          return dataLength== 0 ? Center(
            child: Text('No data found'),
          ) : ListView.builder(
            itemCount: dataLength, 
             itemBuilder: (context, i) => 
             TodoCard(
              id: data[i].id, 
              title: data[i].title,
               creationDate: data[i].creationDate, 
               insertFunction:insertFunction,
                deleteFunction: deleteFunction,
                 isChecked: data[i].isChecked)
             );

        }
        ),
    );
  }
}