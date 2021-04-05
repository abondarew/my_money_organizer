import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/validator/base_validator.dart';

class ValidatorContainer {
  final List<_ContainerValidatorItem> _validators = [];

  Future<bool> isValid() async {
    print('1');
    List<Future<bool>> lst = [];
    _validators.forEach((element) async{
      print('2');
      lst.add(element.validator.isValid(element.value));
    });
    print('3');

    bool res = false;
    List l = await Future.wait(lst);//.then((value){
      print('4');
      res = !l.any((element) => !element);
      print('5');
    //});
    print('res cont= $res');

    return res;
  }

  /*Future<bool> isValid() async {
    bool result = true;
    print('1');
    List<bool> lst = [];
    *//*_validators.forEach((element) async{
      print('2');
      lst.add(element.validator.isValid(element.value));
    });*//*
    for(_ContainerValidatorItem item in _validators){
      print('2');
      lst.add(await item.validator.isValid(item.value));
    }
    print('3');

    bool res = false;
    //List l = await Future.wait(lst);//.then((value){
    print('4');
    res = !lst.any((element) => !element);
    print('5');
    //});
    print('res cont= $res');

    return res;
  }*/

  /*Future<bool> isValid() async {
    bool res = true;
    print('1');
    for (_ContainerValidatorItem item in _validators){
      print('2');
      print('res b = $res');
      res &= await item.validator.isValid(item.value);
      print('res e = $res');
      print('3');
    }
    print('4');
    print('res = $res');
    return res;
  }*/

  void add(BaseValidator validator, dynamic value) {
    this._validators.add(_ContainerValidatorItem(validator: validator, value: value));
  }
}

class _ContainerValidatorItem {
  final BaseValidator validator;

  final dynamic value;

  const _ContainerValidatorItem({@required this.validator, @required this.value});
}
