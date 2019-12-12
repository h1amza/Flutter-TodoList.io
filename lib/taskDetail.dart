import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/tasks.dart';
import 'package:flutter_app_bilal_node_js/todoListScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class screenTodoListDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/ALL': (context) => screenTodoList(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController=TextEditingController();
  String date='Date';

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(
        context,type: ProgressDialogType.Normal);
    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'ToDo',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' TaSk',
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child:  TextField(
                    controller: titleController,
                    style: new TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Title',
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.assignment,
                        size: 28,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white30, width: 1.0),
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                       showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2050),
                        onChanged: (dt) {
                          setState(() {
                           date= dt.toString();
                          });
                        },
                        onConfirm: (dt) {
                          setState(() {
                            date = dt.toString();
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en);
                  },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 62,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.7),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Icon(Icons.calendar_today),
                                  ),
                                  Text(
                                      date,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                  Container()
                                ],
                              ),
                        ),
                  ),
                      ),
              ),
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      setState(() {
                        Task.getTask();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screenTodoList(),),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {

                      if(titleController.text.toString() !='' && date != ''&&date!="Date"){
                        pr.show();
                        await Task.addTask(titleController.text.toString(),
                            date);
                        await Task.getTask();
                        pr.hide();
                        Flushbar(
                          messageText: Center(
                              child: Text('Task Add',
                                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                          ),
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 1),
                          leftBarIndicatorColor: Colors.white,
                          icon: Icon(Icons.announcement,color: Colors.white,size: 25,),
                        )..show(context);
                      }
                      else{
                        Flushbar(
                          messageText: Center(
                              child: Text('No data entre',
                                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                          ),
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 1),
                          leftBarIndicatorColor: Colors.white,
                          icon: Icon(Icons.announcement,color: Colors.white,size: 25,),
                        )..show(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'ADD TASK',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
