import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/register.dart';
import 'package:flutter_app_bilal_node_js/tasks.dart';
import 'package:flutter_app_bilal_node_js/todoListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  String txt;
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();
  void waitforlogin()async{
    final prefs = await SharedPreferences.getInstance();
    txt=prefs.getString('tokenapp');
    if(txt != null && txt != ""){
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
      pr.show();
      await Task.getTask();
      print(txt);
      pr.hide();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screenTodoList(),),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    waitforlogin();
  }
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.red[300],
              Colors.red[400],
              Colors.red[500],
              Colors.red[700],
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(65),
                    topRight: Radius.circular(65),
                    bottomRight: Radius.circular(65),
                    bottomLeft: Radius.circular(65),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.assignment,
                    size: 150,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                    text: 'ToDo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'LiSt.APP',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              Text("Let's get Started",
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child:  TextFormField(
                    controller: usernameController,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.red[300],
                      filled: true,
                      hintText: 'email',
                      focusColor: Colors.red,
                      hoverColor: Colors.red,
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        size: 28,
                        color: Colors.red[700],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.white30, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.white30, width: 1.0),
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: TextField(
                    controller: passwordController,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.red[300],
                      focusColor: Colors.red,
                      hoverColor: Colors.red,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.lock_open,
                        size: 28,
                        color: Colors.red[700],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.white30, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.white30, width: 1.0),
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  String em=usernameController.text.toString();
                  String pas=passwordController.text.toString();
                  if(em==null||pas==null||em==''||pas==''){
                    Flushbar(
                      messageText: Center(
                          child: Text('Invalide mail or password',
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                      ),
                      backgroundColor: Colors.amber,
                      duration: Duration(seconds: 2),
                      leftBarIndicatorColor: Colors.amber,
                      icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                    )..show(context);
                  }
                  else{
                    if(!EmailValidator.validate(em)){
                      Flushbar(
                        messageText: Center(
                            child: Text('form email not valide',
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                        ),
                        backgroundColor: Colors.amber,
                        duration: Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.amber,
                        icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                      )..show(context);
                    }
                    else {

                      pr.show();
                      Task.taskList.clear();
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('tokenapp','');
                      print('token 9dim kwito:${prefs.get('tokenapp').toString()}');
                      await Task.gettoken(
                          usernameController.text.toString(),
                          passwordController.text.toString()
                      );
                      print('mzn');

                      if(Task.re==true){
                        print('wa akhiran');

                        pr.hide();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => screenTodoList(),),
                        );
                      }
                      else{
                        pr.hide();

                        print('ok asidi hana nxof xno kayan');
                        Flushbar(
                          messageText: Center(
                              child: Text('Invalide mail or password',
                                style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                          ),
                          backgroundColor: Colors.amber,
                          duration: Duration(seconds: 2),
                          leftBarIndicatorColor: Colors.amber,
                          icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                        )..show(context);
                      }
                      pr.hide();
                    }
                    }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?",
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  FlatButton(
                    child: Text(
                      'Sign Up Now',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
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
