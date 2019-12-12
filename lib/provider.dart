import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/tasks.dart';

class counter with ChangeNotifier{
  bool ctn;
  danecheck(var idtodo,bool val,int index) async {
    await Task.updateCheck(Task.taskList[index].id,val,index);
    await Task.getTask();
    notifyListeners();
  }
}