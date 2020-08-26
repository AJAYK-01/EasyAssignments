import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path/path.dart';

class SharePage extends StatefulWidget {
  final File shareFile;
  final String uname;
  SharePage(this.shareFile, this.uname);
  _SharePageState createState() => _SharePageState(this.shareFile, this.uname);
}

class _SharePageState extends State<SharePage> { 
  final File shareFile;
  final String uname;
  String fileName, ext, url, status;
  ProgressDialog pr;
  final CollectionReference datas = Firestore.instance.collection("clouddata");
  final FirebaseStorage _storage = FirebaseStorage.instance;
  _SharePageState(this.shareFile, this.uname);

  createRecord() async {
    await datas.add({
      'title': fileName,
      'Link': url,
      'time': Timestamp.now(),
    });
  }

  Future<dynamic> upload() async {
    if(shareFile!=null) { 
      setState(() {
        status = 'Uploading...';
      });
    }
    else{
      setState(() {
        status = 'Please Select a File First!!';
      });
    }
    if(shareFile != null) 
      ext = extension(basename(shareFile.path));
    fileName = "$fileName$ext";
    //passing your path with the filename to Firebase Storage Reference
    StorageReference reference =
          _storage.ref().child("Firstfewuploads/$fileName");

    //upload the file to Firebase Storage
    StorageUploadTask uploadTask = reference.putFile(shareFile);

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String urll = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      url = urll;
      if(urll!=null) {status = 'Upload Complete';}
    });
    createRecord();
    return status;
  }
  

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, isDismissible: false,);
    pr.style(
      message: '\t\tUploading...',
      progressWidget: Container(
        padding: EdgeInsets.all(9.5),
        child: CircularProgressIndicator(strokeWidth: 4.5,)),
    );
    return SafeArea(
     child: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        appBar: AppBar(title: Text('Upload Assignment', style: TextStyle(color: Colors.black)), 
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Subject",
                ),
                onChanged: (value) {
                  fileName = value+' $uname';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.05,
                color: Colors.blue,
                child: RawMaterialButton( 
                  child: Text("Upload", style: TextStyle(color: Colors.white, fontSize: 20),),
                  elevation: 10,
                  onPressed: () async {
                    await pr.show();
                    await upload();
                    await pr.hide();
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => _completeDialog(context),
                    );
                  },
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  )
                ),
                height: 50,
                width: MediaQuery.of(context).size.width/1.05,
                child: RawMaterialButton(
                  onPressed: () async {
                    await SystemNavigator.pop();
                  }, 
                  child: Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 20),),
                  elevation: 10,
                 )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _completeDialog(BuildContext context) {
    return AlertDialog(
      title: Center(
      child: Text("Upload Complete")
     ),
      actions: <Widget>[
        Center(
          child: FlatButton(
            onPressed: () async => await SystemNavigator.pop(), 
            child: Text("OK")
          ),
        )
      ],
    );
  }
}