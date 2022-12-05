// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as file_path;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart' as http_parser;

// Check scheme server
const String serverScheme = 'http';
const String serverSchemeSecure = 'https';
// Server URL Dev
const String serverAuthority = '';
// header Key for authorization
const String _authHeaderKey = 'Authorization';

class ServerApiClient {
  final NetworkInfoRepository networkInfoRepository;

  ServerApiClient({
    required this.networkInfoRepository,
  });

  final Map<String, String> _authHeader = {};
  Map<String, String> get authHeader => _authHeader;

  void setAccessToken({
    required String accessToken,
  }) {
    if (accessToken.isNotEmpty == true) {
      _authHeader[_authHeaderKey] = 'Bearer accessToken';
    }
  }

  Future<http.Response> get(
    path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final url = Uri(
      scheme: serverScheme,
      host: serverAuthority,
      path: path,
      queryParameters: queryParameters,
    );

    final Map<String, String> allHeaders = _authHeader;
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    if (!allHeaders.containsKey('Content-Type')) {
      allHeaders['Content-Type'] = 'application/json';
    }

    http.Response response;
    try {
      response =
          await http.get(url, headers: _authHeader..addAll(headers ?? {}));
    } catch (ex) {
      final check = await networkInfoRepository.hasConnection;
      if (!check) {
        // for check another event
      }
      rethrow;
    }

    if (kDebugMode) {
      log(_formatResponseLog(response));
    }

    return _processResponse(
      response: response,
      requestFunc: () =>
          get(path, queryParameters: queryParameters, headers: headers),
    );
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final url = Uri(
      scheme: serverScheme,
      host: serverAuthority,
      path: path,
      queryParameters: queryParameters,
    );

    final Map<String, String> allHeaders = _authHeader;
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    if (!allHeaders.containsKey('Content-Type')) {
      allHeaders['Content-Type'] = 'application/json';
    }

    http.Response response;
    try {
      response = await http.post(
        url,
        headers: allHeaders,
        body: jsonEncode(body),
        encoding: encoding,
      );
    } catch (e) {
      final check = await networkInfoRepository.hasConnection;
      if (!check) {
        // for check another event
      }
      rethrow;
    }
    if (kDebugMode) {
      log(_formatResponseLog(response, requestBody: body));
    }
    return _processResponse(
      response: response,
      requestFunc: () => post(
        path,
        queryParameters: queryParameters,
        headers: headers,
        body: body,
        encoding: encoding,
      ),
    );
  }

  Future<http.Response> patch(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final url = Uri(
      scheme: serverScheme,
      host: serverAuthority,
      path: path,
      queryParameters: queryParameters,
    );

    final Map<String, String> allHeaders = _authHeader;
    if (headers != null) {
      allHeaders.addAll(headers);
    }
    if (!allHeaders.containsKey('Content-Type')) {
      allHeaders['Content-Type'] = 'application/json';
    }

    http.Response response;
    try {
      response = await http.patch(
        url,
        headers: allHeaders,
        body: jsonEncode(body),
        encoding: encoding,
      );
    } catch (e) {
      final check = await networkInfoRepository.hasConnection;
      if (!check) {
        // for check another event
      }
      rethrow;
    }
    if (kDebugMode) {
      log(_formatResponseLog(response, requestBody: body));
    }
    return _processResponse(
      response: response,
      requestFunc: () => post(
        path,
        queryParameters: queryParameters,
        headers: headers,
        body: body,
        encoding: encoding,
      ),
    );
  }

  Future<http.Response> uploadFile(
    String path, {
    required File file,
    Map<String, String>? fields,
    Map<String, String>? queryParameters,
  }) async {
    final url = Uri(
      scheme: serverScheme,
      host: serverAuthority,
      path: path,
      queryParameters: queryParameters,
    );

    String? fileName;

    fileName = file_path.basename(file.path);

    http_parser.MediaType mediaMime =
        http_parser.MediaType.parse(mime(fileName) as String);

    final multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: fileName,
      contentType: mediaMime,
    );
    //
    final request = http.MultipartRequest('POST', url);

    if (fields != null) {
      final nonNullFields = Map.of(fields)
        ..removeWhere((key, value) => value.toString().isEmpty);

      request.fields.addAll(nonNullFields);
    }

    request.files.add(multipartFile);
    request.headers.addAll(_authHeader);
    request.headers['Accept'] =
        'application/json'; // else it returns multipart/form-data, same as we sent

    http.Response response;
    try {
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } catch (ex) {
      final check = await networkInfoRepository.hasConnection;
      if (!check) {
        // for check another event
      }
      rethrow;
    }
    if (kDebugMode) {
      log(_formatResponseLog(response, requestBody: fields));
    }

    return await _processResponse(
      response: (response),
      requestFunc: () => uploadFile(
        path,
        file: file,
        fields: fields,
        queryParameters: queryParameters,
      ),
    );
  }

  Future<T> _processResponse<T>({
    required http.Response response,
    required FutureOr<T> Function() requestFunc,
  }) async {
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return response as T;
    } else if (response.statusCode == 401) {
      // for check another event
      return response as T;
    } else {
      // for check another event
      return response as T;
    }
  }

  String _formatResponseLog(http.Response response, {Object? requestBody}) {
    final time = DateTime.now().toUtc().toIso8601String();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String formattedRequestBody =
        requestBody != null ? encoder.convert(requestBody) : '';
    String formattedBodyJson;
    try {
      final json = jsonDecode(response.body);
      formattedBodyJson = encoder.convert(json);
    } catch (e) {
      formattedBodyJson = response.body;
    }
    return '''
  $time
  Request: ${response.request}${formattedRequestBody.isNotEmpty == true ? '\n  Request body: $formattedRequestBody' : ''}
  Response code: ${response.statusCode}
  Body: $formattedBodyJson
  ''';
  }
}
