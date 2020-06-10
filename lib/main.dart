import 'package:cloud_storage/pages/rootpage.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:cloud_storage/services/subjects.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_storage/pages/login.page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User>.value(value: AuthServ().usr),
          StreamProvider<List<Uploaders>>.value(value: Uploaders('uploader').streamOfUsers()),
          StreamProvider<List<Subjects>>.value(value: Subjects().subjectsList())
        ],
        child:  MaterialApp(
              title: 'Easy Assignments',
              home: Root(), //should be RootPage
              debugShowCheckedModeBanner: false,
            ),
    );
  }
}

