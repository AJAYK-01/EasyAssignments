// //import 'package:cloud_storage/main1.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// final dbRef = FirebaseDatabase.instance.reference();

// class MyApp extends StatefulWidget {
//   MyAppState createState() => new MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "CloudStore",
//       home: Scaffold(
//         appBar: AppBar(shape: ShapeBorder.lerp(null, null, 0.8), title: Text("Cloud Database"),),
//         body: Center(
//           child: Container(child: Center(
//             child: ListView(children: <Widget>[
//                     RaisedButton(child: Text("Create Record"),onPressed: createRecord,),
//                     RaisedButton(child: Text("View Record"),onPressed: getData,),
//                     RaisedButton(child: Text("Update Record"),onPressed: updateData,),
//                     RaisedButton(child: Text("Delete Record"),onPressed: deleteData,),
//             ],)
//           ),),
//         ),
//       ),
//     );
//   }

//   void createRecord(){
//     dbRef.child("1").set({
//       'sl no': 1,
//       'title': 'First Record',
//       'description': 'Oh yeah!'
//     });
//     dbRef.child("3").set({
//       'title': 'Flutter in Action',
//       'description': 'Yayayaaayyyy!!'
//     });
//   }

//   void getData(){
//     dbRef.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//     });
//   }

//   void updateData(){
//     dbRef.child('1').update({
//       'description': 'Updates be like ;)'
//     });
//   }

//   void deleteData(){
//     dbRef.child('1').remove();
//   }
  
// }