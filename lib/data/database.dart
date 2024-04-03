import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

//run this method open the app first time
  void createInitialData() {
    toDoList = [
      ['make first', true],
      ['make sceond', false]
    ];
     _myBox.put('TODOLIST', toDoList);

  }

//Load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void UpdataDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
