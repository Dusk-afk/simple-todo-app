import 'package:flutter/material.dart';
import 'package:todo_app/data/task.dart';

class TaskCard extends StatefulWidget {
  Task task;

  TaskCard({ Key? key, required this.task }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      width: double.infinity,
      height: 55,
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(500)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0, 4)
          )
        ]
      ),

      child: TextButton(
        onPressed: () {},
        child: Text(widget.task.title),
      ),
    );
  }
}