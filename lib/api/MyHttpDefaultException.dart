import 'package:flutter/material.dart';

class MyHttpDefaultException {
  final String _errorMsg;
  final String errorCode;

  const MyHttpDefaultException(this._errorMsg, {this.errorCode});

  String get errCode => errorCode;

  String get errMsg => _errorMsg;
}
