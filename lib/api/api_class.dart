import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flower_last/api/HttpUtils.dart';
import 'package:flower_last/api/MyHttpDefaultException.dart';

abstract class IApi {
  getBaseUrl();

  getReturnCodeKey();

  getReturnMsgKey();

  getResult();

  //判断是否是正确的返回码
  bool isNormalResponse(dynamic responseCode);
  //返回results字段对应的数据
  Future getRequestForResults(String url,
      {Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) {
    return HttpUtils.getInstance()
        .setBaseUrl(getBaseUrl())
        .get(url,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((data) {
      return performData(data);
    }).catchError((e) {
      handleException(e);
    });
  }

  Future postRequestForResult(String url,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) {
    return HttpUtils.getInstance()
        .setBaseUrl(getBaseUrl())
        .post(url,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((data) {
      return performData(data);
    }).catchError((e) {
      handleException(e);
    });
  }
  //提取result字段对应的数据
  performData(data) {
    if (isNormalResponse(data[getReturnCodeKey()])) {
      return data[getResult()];
    } else {
      throw MyHttpDefaultException(data[getReturnMsgKey()],
          errorCode: data[getReturnCodeKey()]);
    }
  }
  //返回response.data数据
  Future getRequestForResponseData(String url,
      {Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken}) {
    return HttpUtils.getInstance()
        .setBaseUrl(getBaseUrl())
        .get(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken)
        .then((data) {
      if (isNormalResponse(data[getReturnCodeKey()])) {
        return data;
      } else {
        throw MyHttpDefaultException(data[getReturnMsgKey()],
            errorCode: data[getReturnCodeKey()]);
      }
    }).catchError((e) {
      handleException(e);
    });
  }

  void handleException(e);
}

class FlowerApi extends IApi {
  static final String _returnCodeKey = "returnCode";
  static final String _returnMsgKey = "errorMessage";
  static final String _result = "results";
  static final String _baseUrl = "http://119.27.187.182:8980/";

  @override
  getBaseUrl() => _baseUrl;

  @override
  getResult() => _result;

  @override
  getReturnCodeKey() => _returnCodeKey;

  @override
  getReturnMsgKey() => _returnMsgKey;

  @override
  void handleException(e) {
    //todo - 统一错误处理,根据每个项目返回的错误码处理

  }

  @override
  bool isNormalResponse(responseCode) {
    return responseCode == "01";
  }
}

class GankApi extends IApi {
  static final String _returnCodeKey = "error";
  static final String _result = "results";
  static final String _baseUrl = "http://gank.io/api/";

  @override
  getBaseUrl() => _baseUrl;

  @override
  getResult() => _result;

  @override
  getReturnCodeKey() => _returnCodeKey;

  @override
  String getReturnMsgKey() => null;

  @override
  void handleException(e) {}

  @override
  bool isNormalResponse(responseCode) {
    return !responseCode;
  }

}
