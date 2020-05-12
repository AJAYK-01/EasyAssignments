import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storage/ViewAssmnts.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:flutter/material.dart';

class WelcomeViewer extends StatefulWidget {
  @override
  _WelcomeViewerState createState() => _WelcomeViewerState();
}

class _WelcomeViewerState extends State<WelcomeViewer> {
  
  final CollectionReference rqData = Firestore.instance.collection("requests");
  final AuthServ _auths = AuthServ();
  var rqst;
  logout () async {
    await _auths.singOut();
  }
  createRequest(request) async {
    await rqData.add({
      'title': request,
      'time': DateTime.now(),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.brown, title: Text("Welcome"), actions: <Widget>[FlatButton.icon(textColor: Colors.white , onPressed: logout, icon: Icon(Icons.exit_to_app), label: Text('Logout'))]),
        body: Column(
          children: <Widget>[
              Card(
                child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>View()));
                },
                child: Container(
                  height: (MediaQuery.of(context).size.height)/2.4,
                  width:(MediaQuery.of(context).size.width)/0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                        Icon(Icons.view_headline),
                        Text("\t\tView Assignments"),
                      ]
                    ),
                  )
                ),
              ),
              Card(
                child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => _buildRqstDialog(context),
                    );
                },
                child: Container(
                  height: (MediaQuery.of(context).size.height)/2.4,
                  width:(MediaQuery.of(context).size.width)/0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment. center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                        Icon(Icons.chat),
                        Text("\t\tRequest an Assignment"),
                      ]
                    ),
                  )
                ),
              ),
          ],
        ),
    );
  }

  Widget _buildRqstDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Submit a Request'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Assignment Name', 
            ),
            onChanged: (value) {
                setState(() {
                    rqst = value;
                });
            },
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
            await createRequest(rqst);
            rqst = null;
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Send Request'),
        )
      ],
    );
  }

}