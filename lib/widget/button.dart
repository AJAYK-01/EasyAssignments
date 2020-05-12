// //import 'package:cloud_storage/main3.dart';
// import 'package:cloud_storage/widget/inputEmail.dart';
// import 'package:cloud_storage/widget/password.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_storage/main1.dart';
// import 'package:cloud_storage/services/auth.dart';
// // import 'package:cloud_storage/widget/password.dart';



// class ButtonLogin extends StatefulWidget {
//   @override
//   _ButtonLoginState createState() => _ButtonLoginState();
// }

// class _ButtonLoginState extends State<ButtonLogin> {

//   final AuthServ _auth = AuthServ();
//   var username = InputEmailState().getusrnm();
//   var password = PasswordInputState().password;

//   login() async {
//     //get uname and pwd here
//     dynamic result = await _auth.singInEmailPwd(username,password);
//     print(username);

//     if(result == null)
//     {
//         print("Sed");
//     }
//     else{
//         print(result);
//         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Upload()));
//    }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
//       child: Container(
//         alignment: Alignment.bottomRight,
//         height: 50,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.brown[300],
//               blurRadius: 10.0, // has the effect of softening the shadow
//               spreadRadius: 1.0, // has the effect of extending the shadow
//               offset: Offset(
//                 5.0, // horizontal, move right 10
//                 5.0, // vertical, move down 10
//               ),
//             ),
//           ],
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: FlatButton(
//           onPressed: login,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'OK',
//                 style: TextStyle(
//                   color: Colors.brown,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward,
//                 color: Colors.brown,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
