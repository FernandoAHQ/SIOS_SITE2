import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

mostrarAlerta( BuildContext context, String title, String subtitle ) {


  if( Platform.isAndroid ){
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text( title ),
        content: Text( subtitle ),
        actions: [
          MaterialButton(
            child: const Text( 'Ok' ),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ]
      )
    );
  } 

  showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog(
      title: Text( title ),
      content: Text( subtitle ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Ok'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop( context ),
        )
      ],
    )
  );
  

}