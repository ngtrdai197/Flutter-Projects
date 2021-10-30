import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function handlerCb;
  final String btnName;

  Answer({this.handlerCb, this.btnName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(btnName),
        onPressed: handlerCb,
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          onPrimary: Colors.white
        ),
        // style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.blue[700])),

      ),
    );
  }
}
