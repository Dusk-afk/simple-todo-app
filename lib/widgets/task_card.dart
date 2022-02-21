import 'package:flutter/material.dart';
import 'package:todo_app/data/task.dart';

class TaskCard extends StatelessWidget {
  Task task;
  Function onTap;

  TaskCard({ Key? key, required this.task, required this.onTap }) : super(key: key);

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
        onPressed: () {
          onTap();
        },
        child: Row(
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontSize: 16,
                color: task.isCompleted? Colors.grey[400] : Colors.grey[600],
                decoration: task.isCompleted? TextDecoration.lineThrough : null
              ),
            ),
            Spacer(),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: task.isCompleted? Colors.green : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(500)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    blurRadius: 4,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 18,
              ),
            )
          ],
        ),

        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(500))
          ),
          padding: EdgeInsets.symmetric(horizontal: 20)
        ),
      ),
    );
  }
}