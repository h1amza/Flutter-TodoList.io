import 'package:flutter/material.dart';
import 'package:flutter_app_bilal_node_js/login.dart';

void main() => runApp(
    MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
        }
    )
);
