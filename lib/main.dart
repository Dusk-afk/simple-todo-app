import 'package:flutter/cupertino.dart';
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

class HomeScreen extends StatefulWidget {
  HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _controller = TextEditingController();

  List<Task> tasks_data = [
    Task("Create new project", false),
    Task("Working call", false),
    Task("Meet with doctor", false),
    Task("Go to the shop", true),
  ];

  void showAddTaskDialog() {
    _controller.text = "";

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Enter Task Name"),
        content: CupertinoTextField(
          controller: _controller,
          autofocus: true,
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.red
              ),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              if (_controller.text.isEmpty){
                return;
              }

              Navigator.pop(context);
              Task createdTask = Task(_controller.text, false);
              setState(() {
                tasks_data.add(createdTask);
              });
            },
            child: Text("Done"),
          )
        ],
      )
    );
  }

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
        onPressed: () {
          showAddTaskDialog();
        },
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
            onTap: () {
              setState(() {
                tasks_data[index].isCompleted = !tasks_data[index].isCompleted;
              });
            },
          );
        }),
      ),
    );
  }
}