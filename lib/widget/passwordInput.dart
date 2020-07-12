import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {

  final void Function(String value) onChanged;
  final void Function(String value) onFieldSubmitted;
  final FocusNode focusNode;
  PasswordInput({this.onChanged, this.onFieldSubmitted, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
          onChanged: (value) => onChanged(value),
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFieldSubmitted(value),
        ),
      ),
    );
  }
}
