// import 'package:flutter/material.dart';
// import 'package:cloud_storage/services/auth.dart';


// class InputEmail extends StatefulWidget {
//   @override
//   InputEmailState createState() => InputEmailState();
// }

// class InputEmailState extends State<InputEmail> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
//       child: Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         child: TextFormField(
//           keyboardType: TextInputType.text,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             fillColor: Colors.lightBlueAccent,
//             labelText: 'Name',
//             labelStyle: TextStyle(
//               color: Colors.white70,
//             ),
//           ),
//           onChanged: (value) { setState(() {
//               if(value.isNotEmpty)
//               {    unam = '$value@gmail.com'.trim();
//                   print(getusrnm()); }
//               else{ 
//                   print(getusrnm());
//                   print('Error');
//               }
//           }); },
//          // validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//          // onSaved: (value) {usrnm = '$value@gmail.com'.trim(); }//print(usrnm);,
//         ),
//       ),
//     );
//   }
// }