import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/AnimationNotifier.dart';
import '../Provider/AnimationNotifier.dart';
class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo>  with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<RelativeRect>  _animationRect;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  void initState() {
    _animationController=AnimationController(duration: Duration(milliseconds: 500),vsync: this);
    _animation=Tween<double>(begin: 0,end: 1).animate(_animationController);
    _animationRect=Tween<RelativeRect>(begin: RelativeRect.fromLTRB(0, 0, 0, 0),end:
    RelativeRect.fromLTRB(0, 0, 0, 0) ).animate(_animationController);
    // TODO: implement initState
    super.initState();

  }


  Widget smallContainers(){
    return Container(
      height: 30,
      width: 30,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(30),
          gradient:
          LinearGradient(colors: [Colors.purple[300],Colors.blueAccent[100]]
              ,begin: Alignment.centerLeft,
              end: Alignment.centerRight,stops: [0.0,1])),);
  }
  Widget rotatingContainer(){
    return InkWell(onTap: (){
      _animationController.stop();

    },onDoubleTap: (){
      _animationController.repeat();
    },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [smallContainers(),
            Row(
              children: [
                SizedBox(width: 30,),
                smallContainers(),
                SizedBox(width: 20,),
                smallContainers()],),


            SizedBox(width: 30,),
            smallContainers(),],),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var animationValue =Provider.of<AnimationNotifier>(context);
    animationValue.start?_animationController.repeat():_animationController.stop();
    return  Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context,child)=>Transform.rotate(
                angle: _animation.value*6.28,
                child: child,
              ),
              child: rotatingContainer()
            ),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(140,),
                gradient: LinearGradient(colors: [Colors.purple[300],Colors.blueAccent[100]],begin: Alignment.centerLeft,
                end: Alignment.centerRight,stops: [0.0,1])),
            margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
            height: 140,width: 140,
          ),
        ));
  }
}

