import 'package:cloud_storage/WelcomeViewer.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../ViewAssmnts.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationHandler extends StatefulWidget {
  @override
  _NotificationHandlerState createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  //final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

    @override
    void initState() {
        _fcm.subscribeToTopic('clouddata');
        _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
                        ),
                        actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(),
                        ),
                    ],
                ),
            );
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>View(false)));
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    return WelcomeViewer();
  }
}