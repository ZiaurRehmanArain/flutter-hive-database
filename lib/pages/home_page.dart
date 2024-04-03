import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/dialog_box.dart';
import 'package:todoapp/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box('mybox');
  // List toDoList = [
  //   ['make first', true],
  //   ['make sceond', false]
  // ];
  ToDoDataBase db = ToDoDataBase();
  TextEditingController controller = TextEditingController();

  void checkBoxValue(bool? value, index) {
    setState(() {
      db.toDoList[index][1] = value;
    });
    db.UpdataDataBase();
  }

  void saveNewTask() {
    db.toDoList.add([controller.text, false]);
    setState(() {});
    db.UpdataDataBase();
    Navigator.pop(context);
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.UpdataDataBase();
  }

  @override
  void initState() {
    super.initState();
    if (_box.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                deleteItem: (context) => deleteTask(index),
                onChanged: (value) => checkBoxValue(value, index));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
