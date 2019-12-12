import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/login.dart';
import 'package:flutter_app_bilal_node_js/tasks.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_bilal_node_js/todoListScreen.dart';
import 'package:email_validator/email_validator.dart';



class Register extends StatelessWidget {
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

  final usernameController=TextEditingController();
  final passwordController=TextEditingController();
  final emailController=TextEditingController();

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
                height: 60,
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
              Text("Register for free",
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 100,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: TextField(
                    controller: usernameController,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.red[300],
                      filled: true,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.perm_identity,
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.red[300],
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
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
              ),SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: new TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.red[300],
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
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
                onTap:() async {
                  String em = emailController.text.toString();
                  String pass = passwordController.text.toString();
                  String user = usernameController.text.toString();
                  if(em==null||pass==null||user==null||
                      em==''||pass==''||user==''||!EmailValidator.validate(em)){
                    Flushbar(
                    messageText: Center(
                    child: Text('entre a valide data',
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                    leftBarIndicatorColor: Colors.amber,
                    icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                    )..show(context);
                  }
                  else{
                    Task.taskList.clear();
                    pr.show();
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('tokenapp','');
                    await Task.sendInfo(em, pass, user);
                    pr.hide();
                    var pre =  prefs.getString('tokenapp');
                    if(pre != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screenTodoList(),),
                      );
                    }
                    else{
                      Flushbar(
                        messageText: Center(
                            child: Text('Erreur',
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                        ),
                        backgroundColor: Colors.amber,
                        duration: Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.amber,
                        icon: Icon(Icons.announcement,color: Colors.black,size: 25,),
                      )..show(context);
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
                        'REGISTER',
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
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You have an account?",
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  FlatButton(
                    child: Text(
                      'Log In Now',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
