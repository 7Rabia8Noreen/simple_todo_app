import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoCard extends StatefulWidget {
  final int id;
 final  String title;
  final DateTime creationDate;
    bool isChecked;

   final Function insertFunction;
   final Function deleteFunction;
 TodoCard({Key? key, required this.id, required this.title, required this.creationDate, required this.insertFunction, required this.deleteFunction, required this.isChecked}) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {



  @override
  Widget build(BuildContext context) {
    var anotherTodo= Todo(
      id: widget.id,
      title: widget.title,
       creationDate: widget.creationDate, 
       isChecked: widget.isChecked);
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Checkbox(
              value: widget.isChecked, 
              onChanged: (bool? value){
                setState(() {
                  widget.isChecked= value!;
                });

                 anotherTodo.isChecked= value!;
                 //anotherTodo.title=' yes';
                 widget.insertFunction(anotherTodo);
              }

              ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.creationDate.toString(),
                style: TextStyle(
                  fontSize: 18,
                color: Color(0xFF8f8f8f),
                fontWeight: FontWeight.bold
                ),
                )
              ],
            )
             ),
             IconButton(onPressed: (){
              widget.deleteFunction(anotherTodo);
             }, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}