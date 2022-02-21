import 'package:flutter/material.dart';
import 'package:todo_app/data/task.dart';
import 'package:todo_app/widgets/task_card.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    )
  );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({ Key? key }) : super(key: key);

  List<Task> tasks_data = [
    Task("Create new project", false),
    Task("Working call", false),
    Task("Meet with doctor", false),
    Task("Go to the shop", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background Color: #FDFDFD
      appBar: AppBar(
        title: Text(
          'All Tasks',
          style: TextStyle(
            color: Colors.grey[600]
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,

        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.manage_search,
            color: Colors.blue,
            size: 30,
          ),
          splashRadius: 20,
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: ListView.builder(
        itemCount: tasks_data.length,
        itemBuilder: ((context, index) {
          return TaskCard(
            task: tasks_data[index],
          );
        }),
      ),
    );
  }
}