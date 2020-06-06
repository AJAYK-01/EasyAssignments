import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewRequests extends StatefulWidget {
  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {

  final CollectionReference rqstData = Firestore.instance.collection("requests");
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: hexToColor('#340072') , title: Text('Requests for You'),),
      body: StreamBuilder<QuerySnapshot> (
          stream: rqstData.orderBy('time').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var docs = snapshot.data.documents.reversed;
            List<Widget> doclist = [];
            for(var doc in docs) {
              final title = doc.data['title'];
              final docid = doc.documentID;
              final count = doc.data['number'];
              delete() async {
                setState(() async {
                     await rqstData.document(docid).delete();
                });
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
                        child: ListTile(title: Text(title+'\t\t\t$count\tRequests'), trailing: Icon(Icons.done), onTap: delete, ))
                    )
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
          }
        )     
    );
    
  }
}