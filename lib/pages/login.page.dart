import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

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
  String _loading = "OK ";
  IconData _buttonIcon = Icons.arrow_forward;

  final AuthServ _auth = AuthServ();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();
  final Flushbar _msgBar = Flushbar(
          message: 'Lorem Ipsum',
          backgroundColor: Colors.white,
          icon: Icon(Icons.warning),
          messageText: Text('Login Failed', style: TextStyle(fontSize: 14),),
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 2),
        );
  
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
      return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  Future<bool> login() async {
    //get uname and pwd here
    setState(() {
      _loading = "Loading...";
      _buttonIcon = null;
    });
    dynamic result = await _auth.singInEmailPwd(_email,_password);
    setState(() {
      _loading = "OK ";
      _buttonIcon = Icons.arrow_forward;
    });
    print(_email);

    if(result == null)
    {
        return true;
    }
    else{
        print(result);
        _password = '######################';
        _email = '#############';
   }
   return false;
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
                        }
                      else{ 
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
                  onFieldSubmitted: (value) async {
                    _pwdFocus.unfocus();
                    bool _failed = await login();
                    if(_failed) {
                      _msgBar.show(context);
                      FocusScope.of(context).requestFocus(_emailFocus);
                    }
                  },
                ),
                ButtonLogin(
                  onTap: () async {
                    bool _failed = await login();
                    if(_failed == true) {
                      _msgBar.show(context);
                      FocusScope.of(context).requestFocus(_emailFocus);
                    }
                  },
                  buttonText: _loading,
                  buttonIcon: _buttonIcon,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}