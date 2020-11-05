
import 'package:flutter/material.dart';

class AnimationNotifier with ChangeNotifier{
  bool _start = false;
  bool _reverse =false;
  bool _pause = true;
  bool _repeat =false;

  bool get start{
    return _start;
  }
  bool get end{
    return _reverse;
  }
  bool get pause{
    return _pause;
  }
  bool get repeat{
    return _repeat;
  }
  void createMotion(){
    _start=true;
    notifyListeners();
  }
  void stopMotion(){
    _start=false;
    notifyListeners();
  }
  void repeatMotion(){
    _repeat=true;
    notifyListeners();
  }
  void pauseMotion(){
    _pause=true;
    _repeat=false;
    notifyListeners();
  }

}