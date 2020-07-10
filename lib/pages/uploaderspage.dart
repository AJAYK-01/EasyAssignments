import 'dart:io';
import 'package:cloud_storage/pages/ViewAssmnts.dart';
import 'package:cloud_storage/pages/ViewRequests.dart';
import 'package:flushbar/flushbar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// final CollectionReference datas = Firestore.instance.collection("clouddata");

var name;
var ext;

class Upload extends StatefulWidget {
  final String uname;
  Upload(this.uname);
  MyAppState createState() => MyAppState(this.uname);
}

class MyAppState extends State<Upload> {
  final String uname;
  MyAppState(this.uname);
  final CollectionReference datas = Firestore.instance.collection("clouddata");
  File file;
  String url;
  String status = '';
  FirebaseStorage _storage = FirebaseStorage.instance;
  final AuthServ _auths = AuthServ();
  ProgressDialog pr;
  bool success = false;
  
  createRecord() async {
    await datas.add({
      'title': name,
      'Link': url,
      'time': Timestamp.now(),
    });
  }
  brwse() async {
     file = await FilePicker.getFile(type: FileType.any);
     String extension(String path) => context.extension(path);
     if(file != null) 
        ext = extension(basename(file.path));
     return file;
  }
  Future<dynamic> upload() async {
    if(file!=null) { 
      setState(() {
        status = 'Uploading...';
      });
    }
    else{
      setState(() {
        status = 'Please Select a File First!!';
      });
    }

   //passing your path with the filename to Firebase Storage Reference
   StorageReference reference =
        _storage.ref().child("Firstfewuploads/$name");

   //upload the file to Firebase Storage
   StorageUploadTask uploadTask = reference.putFile(file);

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
  logout () async {
    await _auths.singOut();
  }
  
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
      return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
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
    return Scaffold(
      backgroundColor: hexToColor('#111133'),
       appBar: AppBar(backgroundColor:hexToColor('#340072'),title: Text('Welcome 10 Pointer'), actions: <Widget>[FlatButton.icon(textColor: Colors.white , onPressed: logout, icon: Icon(Icons.exit_to_app), label: Text('Logout'))],), 
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
          Center(
            child:
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                children: <Widget>[
                  ImageButton(
                      children: <Widget>[],
                      height: 91,
                      width: 91,
                      pressedImage: Image.asset('images/upload-bg.png'),
                      unpressedImage: Image.asset('images/upload-bg.png'),
                      onTap: () async {  
                        var x =await brwse();
                        if(x!=null) { 
                            await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => _buildUploadDialog(context),
                            );
                            if(success) {
                              await pr.show();
                              var x = await upload();
                              ext = null;
                              if(x != null) {
                                  await pr.hide();
                                  Flushbar(
                                    message: 'Lorem Ipsum',
                                    backgroundColor: Colors.white,
                                    icon: Icon(Icons.check_circle),
                                    messageText: Text('Uploaded Succesfully', style: TextStyle(fontSize: 14),),
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                              }
                              success = false;
                              name = null;
                            }                        
                        }
                      },
                    ),
                    Text("\nNew Assignment", style: TextStyle(color: Colors.white, fontSize: 15.5)),
                ],
              ),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
             Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: <Widget> [
                  ImageButton(
                    children: <Widget>[],
                    height: 91,
                    width: 91,
                    unpressedImage: Image.asset('images/request-bg.png'),
                    pressedImage: Image.asset('images/request-bg.png'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRequests()));
                    },
                  ),
                  Text("\nView Requests", style: TextStyle(color: Colors.white, fontSize: 15.5)),
                  Text(" ")
                ]
              )
            ),  
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: <Widget>[
                  ImageButton(
                    children: <Widget>[],
                    height: 91,
                    width: 91,
                    pressedImage: Image.asset('images/manage-bg.png'),
                    unpressedImage: Image.asset('images/manage-bg.png'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>View(true)));
                    },          
                  ),
                  Text("\nManage Uploaded", style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text("Files", style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
         ]
      ),
     )
    );
  }
  Widget _buildUploadDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Upload File?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Assignment Title:", style: TextStyle(color: Colors.blue),),
          TextFormField(
           autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Subject', 
            ),
            onChanged: (value) {
                setState(() {
                    name = value+' $uname'+ext;
                    if(value == null) {
                      name = 'Untitled $uname$ext';
                    }
                });
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            file = null;
            ext = null;
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () async {
            success = true;
            if(name == null) {
              name = 'Untitled $uname$ext';
            }
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Upload'),
        )
      ],
    );
  }
}