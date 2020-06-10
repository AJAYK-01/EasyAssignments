//import 'package:cloud_storage/ViewAssmnts.dart';
//import 'package:cloud_storage/WelcomeViewer.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:cloud_storage/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:cloud_storage/Uploads.dart';
import 'package:provider/provider.dart';

import 'login.page.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final usr = Provider.of<User>(context);
    final upldrs = Provider.of<List<Uploaders>>(context);
    bool key = false;
    if(usr!=null) {
      for (var upldr in upldrs) {
        if(usr.uid == upldr.id) {
          key = true;
          break;
        }
      }
    }
    // return LoginPage() or Upload() depending on auth 
    if(usr == null)
        return LoginPage();
    else if(key)
        return Upload(usr.uname);
    else if(!key)
        return NotificationHandler(); 
    return LoginPage(); 
  }
}