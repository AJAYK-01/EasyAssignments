import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storage/ViewAssmnts.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:cloud_storage/services/subjects.dart';
import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';

class WelcomeViewer extends StatefulWidget {
  @override
  _WelcomeViewerState createState() => _WelcomeViewerState();
}

class _WelcomeViewerState extends State<WelcomeViewer> {
  
  final CollectionReference rqData = Firestore.instance.collection("requests");
  final AuthServ _auths = AuthServ();
  var rqst, showSuccess = false;
  logout () async {
    await _auths.singOut();
  }
  createRequest(request) async {
    await rqData.document(request).setData({
      'title': request,
      'time': Timestamp.now(),
      'number': FieldValue.increment(1),
     },merge: true,
    );
  }
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: hexToColor('#111133'),
          appBar: AppBar(backgroundColor: hexToColor('#340072'), title: Text("Welcome"), actions: <Widget>[FlatButton.icon(textColor: Colors.white , onPressed: logout, icon: Icon(Icons.exit_to_app), label: Text('Logout'))]),
          body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: Column(
                        children: <Widget>[
                          ImageButton(
                            height: 100,
                            width: 100,
                            children: <Widget> [], 
                            unpressedImage: Image.asset('images/download-bg.png'), 
                            pressedImage: Image.asset('images/download-bg.png'),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>View(false)));
                            },
                          ),
                          Text("\nDownload Assignments", style: TextStyle(color: Colors.white, fontSize: 15.5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(68.0),
                      child: Column(
                        children: <Widget>[
                          ImageButton(
                            height: 100,
                            width: 100,
                            children: <Widget> [], 
                            unpressedImage: Image.asset('images/request-bg.png'), 
                            pressedImage: Image.asset('images/request-bg.png'),
                            onTap: () async {
                              await showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) => _buildRqstDialog(context),
                                  );
                                  if(showSuccess) {                                  
                                    Flushbar(
                                      message: 'Lorem Ipsum',
                                      backgroundColor: Colors.white,
                                      icon: Icon(Icons.check_circle),
                                      messageText: Text('Request Sent', style: TextStyle(fontSize: 14),),
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                    showSuccess = false;
                                  }
                            },
                          ),
                          Text("\nRequest an Assignment", style: TextStyle(color: Colors.white, fontSize: 15.5)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildRqstDialog(BuildContext context) {
    final subList = Provider.of<List<Subjects>>(context);
    return AlertDialog(
      title: Text('Submit a Request', style: TextStyle(color: Colors.white),),
      backgroundColor: hexToColor('#111133'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Theme(
              data: Theme.of(context).copyWith(canvasColor: hexToColor('#380080')),
              child: DropdownButtonFormField(
              hint: Text("Select Subject", style: TextStyle(color: Colors.white),),
              isDense: true,
              decoration: InputDecoration(
                fillColor: hexToColor('#111133'),
                filled: true,
              ),
              items: subList.map((listItem) {
                return DropdownMenuItem(
                value: listItem,
                child: Row(
                  children: <Widget>[
                    Text(listItem.id, style: TextStyle(color: Colors.white),),
                  ],
                )
                );
              }).toList(),
              onChanged: (value) {
                  setState(() {
                      rqst = value;
                  });
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            rqst = null;
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () async {
            if(rqst!=null) { 
              await createRequest(rqst);
              rqst = null;
              showSuccess = true;
              Navigator.of(context).pop();
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Send Request'),
        )
      ],
    );
  }

}