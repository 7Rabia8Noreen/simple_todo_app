import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class UserInput extends StatelessWidget {
  final Function insertFunction;
   UserInput({Key? key, required this.insertFunction}) : super(key: key);
   var textControllor=  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      color: const Color(0xFFDAB5FF),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child:  TextField(
                controller: textControllor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter new todo'
                ),
              ),
            )
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: (){
              var myTodo= Todo(
                title: textControllor.text,
                 creationDate: DateTime.now(),
                  isChecked: false);

                  insertFunction(myTodo);
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: const Text('Add',
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold
              ),
              ),

            ),
          )
        ],
      ),
    );
  }
}