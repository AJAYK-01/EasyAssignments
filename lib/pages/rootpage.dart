import 'package:cloud_storage/WelcomeViewer.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_storage/Uploads.dart';
import 'package:provider/provider.dart';

import 'login.page.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final usr = Provider.of<User>(context);
    // return LoginPage() or Upload() depending on auth 
    if(usr == null)
        return LoginPage();
    else if(usr.uid == '#############################') // Replace with the UID of Uploader
        return Upload();
    else if(usr.uid == '############################') // Replace with UID of Viewer
        return WelcomeViewer(); 
    return LoginPage(); 
  }
}
