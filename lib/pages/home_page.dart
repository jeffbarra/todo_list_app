import 'package:flutter/material.dart';
import '../components/dialog_box.dart';
import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text Controller
  final _controller = TextEditingController();

  // List of tasks
  List toDoList = [
    ["Go to gym", false],
    ["Grocery shopping", false],
  ];

  // Checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][
          1]; // toDoList[index][1] is currently "false" SO it will change state to the opposite (true)
    });
  }

  // Save new task (onSave)
  void SaveNewTask() {
    setState(() {
      // sets new state
      toDoList.add([
        // adds to the toDoList
        _controller.text, // text within the text field using controller
        false // sets the checkbox to false (unchecked)
      ]);
      _controller.clear(); // clears the text field on save
    });
    Navigator.of(context).pop(); // closes dialog box on save
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller, // gives us access to text field input
          onSave: SaveNewTask,
          onCancel: () =>
              Navigator.of(context).pop(), // dismisses the dialog box
        );
      },
    );
  }

  // Delete Task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,

// APP BAR //

      appBar: AppBar(
        title: Text('To Do List'),
        // elevation: 0,
      ),

// FLOATING ACTION BUTTON //

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
