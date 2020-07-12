import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {

  final void Function(String value) onChanged;
  final void Function(String value) onFieldSubmitted;
  final FocusNode focusNode;
  InputEmail({this.onChanged, this.onFieldSubmitted, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          focusNode: focusNode,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
          onChanged: (value) => onChanged(value),
          onFieldSubmitted: (value) => onFieldSubmitted(value),
        ),
      ),
    );
  }
}