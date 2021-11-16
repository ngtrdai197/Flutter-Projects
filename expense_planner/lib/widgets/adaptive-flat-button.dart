import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback onHandler;
  final String btnName;
  AdaptiveFlatButton({this.btnName, this.onHandler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(btnName),
            onPressed: onHandler,
          )
        : ElevatedButton(
            child: Text((btnName)),
            onPressed: onHandler,
          );
  }
}
