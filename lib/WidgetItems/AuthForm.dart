import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WidgetItems/Imageselector.dart';
import '../WidgetItems/Form.dart';


class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(height:494,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(color: Colors.white,borderRadius:
        BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50) ,
            )),
        child: Column(
          children: [
            SizedBox(height: 20,),
            FormItem()
            //form for the page
          ],
        ),),
    );
  }
}
