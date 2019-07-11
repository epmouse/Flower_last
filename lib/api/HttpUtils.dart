import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class HttpUtils {
  static final HttpUtils _singleton = HttpUtils._init();
  Dio _dio;
  BaseOptions _options = _getDefaultOptions();

  static HttpUtils getInstance() {
    return _singleton;
  }

  setInterceptor(Interceptors interceptors) {}

  setBaseUrl(String baseUrl) {
    if (_options == null) {
      _options = BaseOptions();
    }
    _options.baseUrl = baseUrl;
    return this;
  }

  HttpUtils._init() {
    _dio = new Dio(_options);
  }

  static Future getToday(String url) async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(url);
    return response.data;
  }

  get(String url,
      {Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    Response response = await _dio.get(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok) {
      try {
        return handleResponse(response);
      } catch (e) {
        return Future(e);
      }
    }
  }

  Future post(String url,
      {data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken}) async {
    Response response = await _dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok) {
      try {
        return handleResponse(response);
      } catch (e) {
        return Future(e);
      }
    }
  }

//处理网络返回
  handleResponse(Response response) {
    if (response.data is Map) {
      return response.data;
    } else {
      if (response == null ||
          response.data == null ||
          response.data.toString().isEmpty) {
        return Map();
      }
      return json.decode(response.data.toString());
    }
  }

  static BaseOptions _getDefaultOptions() {
    BaseOptions baseOptions = BaseOptions();
    baseOptions.contentType = ContentType.parse(
        "application/x-www-form-urlencoded"); //设置为这个dio会自动编码请求体，不设置默认是ContentType.JSON
    baseOptions.connectTimeout = 1000 * 30;
    baseOptions.receiveTimeout = 1000 * 30;
    return baseOptions;
  }

  addInterceptor(Interceptor interceptor) {
    _dio?.interceptors?.add(interceptor);
  }
}
