import 'package:flutter/material.dart';

import 'package:cloud_storage/widget/emailInput.dart';
import 'package:cloud_storage/widget/passwordInput.dart';
import 'package:cloud_storage/services/auth.dart';
import 'package:cloud_storage/widget/loginButton.dart';
import 'package:cloud_storage/widget/textLogin.dart';
import 'package:cloud_storage/widget/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();
  
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
      return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  final AuthServ _auth = AuthServ();

  login() async {
    //get uname and pwd here
    dynamic result = await _auth.singInEmailPwd(_email,_password);
    print(_email);

    if(result == null)
    {
        print("Sed");
    }
    else{
        print(result);
        _password = '######################';
        _email = '#############';
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [hexToColor('#5600d8'), hexToColor('#340072')]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(
                  onChanged: (value) { 
                    setState(() {
                      if(value.isNotEmpty)
                      {    _email = '$value@gmail.com'.trim();
                        // print(getusrnm()); 
                        }
                      else{ 
                          // print(getusrnm());
                          print('Error');
                      }
                    }); 
                  },
                  focusNode: _emailFocus,
                  onFieldSubmitted: (value) {
                    _emailFocus.unfocus();
                    FocusScope.of(context).requestFocus(_pwdFocus);
                  }
                ),
                PasswordInput(
                  onChanged: (value) { setState(() {
                      if(value.isNotEmpty)
                          _password = '$value'.trim();
                      else
                          print('Error');
                    }); 
                  },
                  focusNode: _pwdFocus,
                  onFieldSubmitted: (value) {
                    _pwdFocus.unfocus();
                    login();
                  },
                ),
                ButtonLogin(
                  onTap: login,
                ),
                //FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}