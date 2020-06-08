import 'dart:io';
import 'package:cloud_storage/ViewAssmnts.dart';
import 'package:cloud_storage/ViewRequests.dart';
import 'package:flushbar/flushbar.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:cloud_storage/pages/rootpage.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//void main() => runApp(MyApp());

//final dbstorageRef = FirebaseDatabase.instance.reference();
final CollectionReference datas = Firestore.instance.collection("clouddata");

//Query lastQuery = dbstorageRef.limitToLast(1);

var name;
var ext;

class Upload extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<Upload> {
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
   //pick image   use ImageSource.camera for accessing camera. 
   //File image = await ImagePicker.pickImage(source: ImageSource.gallery);

   //basename() function will give you the filename
   //name = basename(file.path);

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
          children: <Widget> [
          Row(
            children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
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
                        }                        
                    }
                  },
                  child: Container(
                    color: hexToColor('#2929a3'),  
                    height: (MediaQuery.of(context).size.height)/2.45,
                      width:(MediaQuery.of(context).size.width)/2.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                          Icon(Icons.attach_file, color: Colors.white, size: 42),
                          Text("\nNew Assignment",style: TextStyle(color: Colors.white, fontSize: 19)),
                        ]
                      ),
                    ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRequests()));
                  },
                  child: Container(
                    color: hexToColor('#2929a3'),
                    height: (MediaQuery.of(context).size.height)/2.45,
                    width:(MediaQuery.of(context).size.width)/2.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chat, color: Colors.white, size: 42),
                      Text('\nView Requests',style: TextStyle(color: Colors.white, fontSize: 19)),
                    ],
                  ),
                )
              ),),
            )
            ],
          ),
          Row(
            children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>View()));
                  },
                  child: Container(
                    color: hexToColor('#2929a3'),
                  height: (MediaQuery.of(context).size.height)/2.45,
                    width:(MediaQuery.of(context).size.width)/2.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        
                        Icon(Icons.edit_location, color:Colors.white, size:42),
                        Text("\nManage Uploaded",style: TextStyle(color: Colors.white, fontSize: 17)),
                        Text("Files",style: TextStyle(color: Colors.white, fontSize: 17)),
                      ]
                    ),
                  ),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: Container(
                    color: hexToColor('#2929a3'),
                    height: (MediaQuery.of(context).size.height)/2.45,
                    width:(MediaQuery.of(context).size.width)/2.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Nothing here :(',style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
            ),),
              )
            ],
          ),
          ]
    ),
       )
      
      //  body: Center(child: Column(
      //    children: <Widget> [
      //      Padding(
      //        padding: const EdgeInsets.all(8.0),
      //        child: FloatingActionButton(heroTag: 'attach',
      //          onPressed: () async {  var x =await brwse();
      //           if(x!=null) { 
      //               showDialog(
      //                   barrierDismissible: false,
      //                   context: context,
      //                   builder: (BuildContext context) => _buildUploadDialog(context),
      //               );
      //           }
      //         },
      //          child: Icon(Icons.attach_file), backgroundColor: Colors.green,),
      //      ),
      //      Padding(
      //        padding: const EdgeInsets.all(8.0),
      //        child: FloatingActionButton(heroTag: 'uload',onPressed: upload, child:Icon(Icons.cloud_upload), backgroundColor: Colors.black,),
      //      ),
      //      Text(status),
      //    ]
      //  ),   
      // ),
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
           // autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Subject', 
            ),
            onChanged: (value) {
                setState(() {
                    name = value+ext;
                });
            },
          ),
          // TextFormField(
          //   keyboardType: TextInputType.datetime,
          //   decoration: InputDecoration(
          //     //hintText: 'Subject', 
          //   ) ,
          // ),
          // _buildAboutText(),
          // _buildLogoAttribution(),
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
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Upload'),
        )
      ],
    );
  }
}