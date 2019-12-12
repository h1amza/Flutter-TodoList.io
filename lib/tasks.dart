import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Task{
  String id;
  String title;
  DateTime date;
  bool dane;

  Task(this.id,this.title,this.date,this.dane);
  static List<Task> taskList=new List();


  static Future sendInfo(String em,String pass,String user)async{
    String url='https://my-todo-list-app-api.herokuapp.com/auth/';
    Map<String,String> he={"Content-type": "application/json"};
    String json = '{"email": "$em", "name": "$user", "password": "$pass"}';
    http.Response r = await http.post('${url}register', headers: he, body: json);

    var data = jsonDecode(r.body);
    String t = data['body']['token'];
    if(true){
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenapp',t);
      var pre =  prefs.getString('tokenapp');
    }

  }

  static Future addTask(String ti,String da)async{
    final prefs = await SharedPreferences.getInstance();
    String pre =  prefs.getString('tokenapp');
    String url='https://my-todo-list-app-api.herokuapp.com/todo/';
    Map<String,String> he={"Content-type": "application/json","auth-token":"$pre"};
    String json = '{"title": "$ti",  "date": "$da"}';

    http.Response r = await http.post('$url', headers: he, body: json);

  }
  static Future updateCheck(var idtodo,bool val,int index)async{
    final prefs = await SharedPreferences.getInstance();
    String pre = prefs.getString('tokenapp');
    var id=idtodo;
    String url = 'https://my-todo-list-app-api.herokuapp.com/todo/$id';
    Map<String, String> header = {
      "Content-type": "application/json",
      "auth-token":
      "$pre",
    };
    String json = '{"done":"$val"}';

    var r = await http.put(
        ('$url'),
        headers: header,
        body: json
    );
    taskList[index].dane=val;
  }
  static Future deleteTask(var idtodo)async{
    final prefs = await SharedPreferences.getInstance();
    String pre = prefs.getString('tokenapp');
    var id=idtodo;
    String url = 'https://my-todo-list-app-api.herokuapp.com/todo/$id';
    Map<String, String> header = {
      "Content-type": "application/json",
      "auth-token":
      "$pre",
    };
    var r = await http.delete(
      ('$url'),
      headers: header,
    );
  }

  static Future getTask()async{
    List data;
    final prefs = await SharedPreferences.getInstance();
    String pre = prefs.getString('tokenapp');
    String url = 'https://my-todo-list-app-api.herokuapp.com/todo/';
    Map<String, String> header = {
      "Content-type": "application/json",
      "auth-token":"$pre"
    };

    var r = await http.get(
      ('$url'),
      headers: header,
    );
    var t = await jsonDecode(r.body);

    data = t['body']['todos'];
    if (data != null) {
      Task.taskList.clear();
      for (int i = 0; i < data.length; i++) {
        Task.taskList.add(
            Task(
                (data[i]['_id']),
                (data[i]['title']),
                (DateTime.parse(data[i]['date'])),
                (data[i]['done']))
        );
      }
    }
  }

  static Future gettoken(String us,String pas) async {

    print('gettoken entre 1');
    re=false;
    String url='https://my-todo-list-app-api.herokuapp.com/auth/';
    Map<String,String> he={"Content-type": "application/json"};
    String json = '{"email": "$us",  "password": "$pas"}';
    print('gettoken entre 2');

    try{
      http.Response r = await http.post('${url}login', headers: he, body: json);
      print(r.body);

      print('gettoken entre 3');
      var data = jsonDecode(r.body);
      String t = data['body']['token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenapp',t);
      String pre =  prefs.getString('tokenapp');
      print('gettoken entre 4');

      if(pre != null){
        re=true;
        await getTask();
      }
      else re = false;
    }catch(e){
      print('exe: $e');

    }
  }
  static bool re=false;

  void fx(){
    for(int i=0;i<taskList.length;i++){

    }
  }

}