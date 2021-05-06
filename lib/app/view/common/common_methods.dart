import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

List<Color> getColorsList(){
  List<Color> ret = [];
  ret.addAll(Colors.primaries);
  ret.addAll(Colors.accents);
  return ret;
}