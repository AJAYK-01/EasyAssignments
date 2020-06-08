import 'package:cloud_storage/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//void main() => runApp(MyApp());

class View extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<View> {
  final CollectionReference datas = Firestore.instance.collection("clouddata");
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
      return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
  var del = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(backgroundColor: hexToColor('#340072') , title: Text('View Assignments'),),
          body: StreamBuilder<QuerySnapshot> (
          stream: datas.orderBy('time').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final usr = Provider.of<User>(context);
            final upldrs = Provider.of<List<Uploaders>>(context);
            bool key = false;
            if(usr != null) { 
              for(var upldr in upldrs) {
                if(usr.uid == upldr.id) {
                    key = true;
                    break;
                }
              }
            }
            Icon icon;
            if(key)
            {
                icon = Icon(Icons.delete);
            }
            else {
                icon = Icon(Icons.arrow_downward);
            }
            var docs = snapshot.data.documents.reversed;
            List<Widget> doclist = [];
            for(var doc in docs) {
              final title = doc.data['title'];
              final url = doc.data['Link'];
              final docid = doc.documentID;
              dload() async {
                  var urll = url;
                  if (await canLaunch(urll)) {
                    await launch(urll);
                  } 
                  else {
                    throw 'Could not launch ';
                  }
              }
              delete() {
                setState(() async {
                   await datas.document(docid).delete();
                });
              }
              dloadOrDel() async {
                  if(usr.uid == 'NrZKC0phLnfqJh48OQfowSdZSp82')
                  {
                      await showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => _delDialog(context),
                      );
                      if(del == true)
                      { 
                          delete();
                          setState(() {
                              del = false;
                          });
                      }
                  }
                  else {
                      dload();
                  }
              }
              doclist.add(
                Column(
                  children: <Widget> [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      color: hexToColor('#2929a3'),
                      child: ListTileTheme(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        child: ListTile(title: Text(title), trailing: icon, onTap: dloadOrDel, ))
                    ),
                  ]
                )
              );
            }

            return MaterialApp( 
              home: Scaffold(
                backgroundColor: hexToColor('#111133'),
                body: ListView(
                    children: doclist,
                  ),
              )
            ); 
          },
      ),
    );
  }
  Widget _delDialog(BuildContext context) {
    return AlertDialog(
    title: Text('Are you sure to Delete?'),
    actions: <Widget>[
    FlatButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    textColor: Theme.of(context).primaryColor,
    child: Text('No'),
    ),
    FlatButton(
      onPressed: () {
        del = true;
        Navigator.of(context).pop();
      },
      textColor: Theme.of(context).primaryColor,
      child: Text('Yes'),
      )
     ],
   );
  }
}