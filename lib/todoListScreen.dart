import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/taskDetail.dart';
import 'package:flutter_app_bilal_node_js/tasks.dart';
import 'package:date_format/date_format.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter_app_bilal_node_js/login.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider.dart';

class screenTodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => counter(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Task.getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Provid = Provider.of<counter>(context);
    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Center(
                        child: Text(
                      'All Tasks',
                      style: TextStyle(fontSize: 25, color: Colors.redAccent),
                    )),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Center(
                        child: IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title:  Text('Log out ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child:Text('No',style: TextStyle(
                                            color: Colors.pink
                                        ),),
                                        onPressed: (){return Navigator.pop(context);},
                                        color: Colors.black,
                                      ),
                                      FlatButton(
                                        color:Colors.black,
                                        child:Text('Yes',style: TextStyle(
                                          color: Colors.white
                                        ),),
                                        onPressed: ()async{
                                          final prefs =
                                          await SharedPreferences.getInstance();
                                          prefs.setString('tokenapp', '');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ),
                                          );
                                        },

                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            icon: Icon(Icons.device_unknown),
                            color: Colors.redAccent)),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.grey[50],
                    Colors.grey[100],
                    Colors.grey[200],
                    Colors.grey[300],
                  ],
                ),
              ),
              child: ListView.builder(
                  itemCount: Task.taskList == null ? 0 : Task.taskList.length,
                  itemBuilder: (ctxt, index) {
                    if (Task.taskList != null) {
                      return Dismissible(
                        key: Key(Task.taskList[index].id),
                        background: back(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (d) async {
                          pr.show();
                          await Task.deleteTask(Task.taskList[index].id);
                          await Task.getTask();
                          pr.hide();
                          setState(() {
                            Task.getTask();
                          });
                          Flushbar(
                            messageText: Center(
                                child: Text(
                              'Task deleted',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                            backgroundColor: Colors.amber,
                            duration: Duration(seconds: 1),
                            leftBarIndicatorColor: Colors.amber,
                            icon: Icon(
                              Icons.announcement,
                              color: Colors.black,
                              size: 25,
                            ),
                          )..show(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: InkWell(
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Container(
                                // height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: CircularCheckBox(
                                          value: Task.taskList[index].dane,
                                          activeColor: Colors.red,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          onChanged: (bool x) async {
                                            pr.show();
                                            await Provid.danecheck(
                                                Task.taskList[index].id,
                                                x,
                                                index);
                                            pr.hide();
                                          }),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, top: 20),
                                        child: Text(
                                          '${Task.taskList[index].title}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(
                                          (formatDate(Task.taskList[index].date,
                                              [d, ' /', M])),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Card(child: Text('Noting to show'));
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screenTodoListDetail()),
              );
            },
            backgroundColor: Colors.red,
            child: Icon(
              Icons.add,
              size: 45,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget back() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(45)),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
