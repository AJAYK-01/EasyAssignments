import 'dart:async';
import 'dart:io';

import 'package:cloud_storage/pages/sharepage.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../pages/uploaderspage.dart';

class Share extends StatefulWidget {
  final String uname;
  Share(this.uname);
  @override
  _ShareState createState() => _ShareState(this.uname);
}

class _ShareState extends State<Share> {

  StreamSubscription _intentDataStreamSubscription;
  SharedMediaFile _shareFile;
  var path;
  String ext;
  final String uname;
  _ShareState(this.uname);

  @override
  void initState() {
    super.initState();

    // For sharing files coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
          .listen((List<SharedMediaFile> value) {
        setState(() {
          _shareFile = value.first;
          print("Shared: $_shareFile.path");
          path = _shareFile.path;
        });
      }, onError: (err) {
        print("getIntentDataStream error: $err");
      });

      // For sharing files coming from outside the app while the app is closed
      ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
        setState(() {
          _shareFile = value.first;
          print("Shared: $_shareFile");
          path = _shareFile.path;
        });
      });
  }

  void dispose() {
    _intentDataStreamSubscription.cancel();
    _shareFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(path == null) {
      return Upload(this.uname);
    }
    else {
      return SharePage(File(path), this.uname);
    }
  }
}