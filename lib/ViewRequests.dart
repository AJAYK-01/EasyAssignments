import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewRequests extends StatefulWidget {
  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {

  final CollectionReference rqstData = Firestore.instance.collection("requests");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown , title: Text('Requests for You'),),
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
                      color: Colors.brown,
                      child: ListTileTheme(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        child: ListTile(title: Text(title), trailing: Icon(Icons.done), onTap: delete, ))
                    )
                  ]
                )
              );
            }
            return MaterialApp( 
              home: Scaffold(
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