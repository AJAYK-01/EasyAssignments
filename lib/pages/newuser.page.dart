// import 'package:flutter/material.dart';
// import 'package:cloud_storage/widget/buttonNewUser.dart';
// import 'package:cloud_storage/widget/newEmail.dart';
// import 'package:cloud_storage/widget/newName.dart';
// import 'package:cloud_storage/widget/password.dart';
// import 'package:cloud_storage/widget/singup.dart';
// import 'package:cloud_storage/widget/textNew.dart';
// import 'package:cloud_storage/widget/userOld.dart';

// class NewUser extends StatefulWidget {
//   @override
//   _NewUserState createState() => _NewUserState();
// }

// class _NewUserState extends State<NewUser> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [Colors.brown, Colors.black26]),
//         ),
//         child: ListView(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     SingUp(),
//                     TextNew(),
//                   ],
//                 ),
//                 NewNome(),
//                 NewEmail(),
//                 PasswordInput(),
//                 ButtonNewUser(),
//                 UserOld(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
