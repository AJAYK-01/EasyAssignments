// import 'package:flutter/material.dart';
// import 'package:cloud_storage/widget/button.dart';

// class PasswordInput extends StatefulWidget {
//   @override
//   PasswordInputState createState() => PasswordInputState();
// }

// class PasswordInputState extends State<PasswordInput> {

//   String pwd;
//   String get password {
//       return pwd;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
//       child: Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         child: TextFormField(
//           style: TextStyle(
//             color: Colors.white,
//           ),
//           obscureText: true,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             labelText: 'Password',
//             labelStyle: TextStyle(
//               color: Colors.white70,
//             ),
//           ),
//           // onChanged: (value) { setState(() {
//           //   if(value.isNotEmpty)
//           //       pwd = '$value'.trim();
//           //   else
//           //       print('Error');
//           // }); },
//           validator: (value) => value.isEmpty ? 'Please enter password!' : null,
//           onSaved: (value) => pwd = '$value'.trim(),
//         ),
//       ),
//     );
//   }
// }