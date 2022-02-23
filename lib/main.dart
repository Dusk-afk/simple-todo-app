import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/data/task.dart';
import 'package:todo_app/widgets/more_options.dart';
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
  late File tasksFile;

  List<Task> tasks_data = [];

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void getTasks() async {
    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Make the file path from documents path
    String filePath = documentsDirectory.path + "/tasks.json";

    // Get the file from path and create if it doesn't exist
    tasksFile = await File(filePath).create(recursive: true);

    // Read the file data as string
    String fileData = await tasksFile.readAsString();

    // If the data is empty
    if (fileData == ""){

      // Make it "[]" (Array)
      fileData = "[]";

      // Write the edited data to file
      await tasksFile.writeAsString(fileData);
    }

    // Decode the json from file data
    List<dynamic> json = jsonDecode(fileData);

    // Iterate through every item in json (A Map<String, dynamic> object)
    for (dynamic item in json) {

      // Make a task object from this map item
      Task task = Task(
        item["title"],
        item["isCompleted"]
      );

      // Add this task to tasks_data list
      tasks_data.add(task);
    }

    // Refresh the screen
    setState(() {});
  }

  void showAddTaskDialog() {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enter Task Name"),
        content: TextField(
          controller: _controller,
          autofocus: true,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.blue
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.text.isEmpty){
                return;
              }

              Navigator.pop(context);
              Task createdTask = Task(_controller.text, false);
              setState(() {
                tasks_data.add(createdTask);
              });
              addTaskToFile(createdTask);
            },
            color: Colors.blue,
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      )
    );
  }

  void addTaskToFile(Task task) async {
    Map<String, dynamic> taskMap = {
      "title": task.title,
      "isCompleted": task.isCompleted
    };

    String fileData = await tasksFile.readAsString();

    List<dynamic> json = jsonDecode(fileData);
    json.add(taskMap);

    String finalData = jsonEncode(json);
    tasksFile.writeAsString(finalData);
  }

  void showOptions(Task task) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => MoreOptions(
        delete: () {
          deleteTask(task);
        },
        edit: () => showEditTaskDialog(task),
      )
    );
  }

  void deleteTask(Task task) {
    setState(() {
      tasks_data.remove(task);
    });
    dumpJsonData();
  }

  void dumpJsonData() async {
    List<Map<String, dynamic>> finalData = [];

    for (Task task in tasks_data){
      finalData.add(
        {
          "title": task.title,
          "isCompleted": task.isCompleted
        }
      );
    }

    String json = jsonEncode(finalData);
    tasksFile.writeAsString(json);
  }

  void showEditTaskDialog(Task task) {
    TextEditingController _controller = TextEditingController();
    _controller.text = task.title;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task ${task.title}"),
        content: TextField(
          controller: _controller,
          autofocus: true,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.blue
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_controller.text.isEmpty){
                return;
              }

              Navigator.pop(context);
              Task createdTask = Task(_controller.text, false);
              setState(() {
                int index = tasks_data.indexOf(task);
                tasks_data[index].title = _controller.text;
              });
            },
            color: Colors.blue,
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.white
              ),
            ),
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
            onLongPress: () => showOptions(tasks_data[index]),
          );
        }),
      ),
    );
  }
}