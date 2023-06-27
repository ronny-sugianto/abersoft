part of 'base_api_client.dart';

class ApiClient extends BaseApiClient {
  ApiClient._();
  static final ApiClient _instance = ApiClient._();
  factory ApiClient({Alice? alice}) {
    if (alice != null) {
      _instance._dio.interceptors.add(alice.getDioInterceptor());
    }

    // Set default configs
    _instance._dio.options.baseUrl = EnvConfig.baseUrl;

    return _instance;
  }

  final Dio _dio = Dio();

  @override
  Future get(
    String url, {
    String? token,
    responseType,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> tempHeaders = <String, dynamic>{};

    headers?.forEach((k, v) => tempHeaders[k] = v);

    if (token != null) tempHeaders['Authorization'] = 'Bearer $token';

    _dio.options.connectTimeout = Duration(milliseconds: msTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: msTimeout);

    try {
      final response = await _dio.get(
        EnvConfig.baseUrl + url,
        options: Options(headers: tempHeaders, responseType: responseType),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future post(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> tempHeaders = <String, dynamic>{};

    headers?.forEach((k, v) => tempHeaders[k] = v);

    if (token != null) tempHeaders['Authorization'] = 'Bearer $token';
    tempHeaders['Content-Type'] = contentType;

    _dio.options.connectTimeout = Duration(milliseconds: msTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: msTimeout);

    try {
      final response = await _dio.post(
        EnvConfig.baseUrl + url,
        options: Options(headers: tempHeaders),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future put(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> tempHeaders = <String, dynamic>{};

    headers?.forEach((k, v) => tempHeaders[k] = v);

    if (token != null) tempHeaders['Authorization'] = 'Bearer $token';
    tempHeaders['Content-Type'] = contentType;

    _dio.options.connectTimeout = Duration(milliseconds: msTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: msTimeout);

    try {
      final response = await _dio.put(
        EnvConfig.baseUrl + url,
        options: Options(headers: tempHeaders),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future patch(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> tempHeaders = <String, dynamic>{};

    headers?.forEach((k, v) => tempHeaders[k] = v);

    if (token != null) tempHeaders['Authorization'] = 'Bearer $token';
    tempHeaders['Content-Type'] = contentType;

    _dio.options.connectTimeout = Duration(milliseconds: msTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: msTimeout);

    try {
      final response = await _dio.patch(
        EnvConfig.baseUrl + url,
        options: Options(headers: tempHeaders),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future delete(
    String url, {
    data,
    String? token,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> tempHeaders = <String, dynamic>{};

    headers?.forEach((k, v) => tempHeaders[k] = v);

    if (token != null) tempHeaders['Authorization'] = 'Bearer $token';
    tempHeaders['Content-Type'] = contentType;

    _dio.options.connectTimeout = Duration(milliseconds: msTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: msTimeout);

    try {
      final response = await _dio.delete(
        EnvConfig.baseUrl + url,
        options: Options(headers: tempHeaders),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  _returnResponse(Response? response) {
    if (response == null) throw FetchDataException(response?.data['error']);

    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 204:
        return response;
      case 400:
        throw BadRequestException(response.data['error']);
      case 401:
        throw UnauthorizedException(response.data['error']);
      case 403:
        throw ForbiddenException(response.data['error']);
      case 404:
        throw NotFoundException(response.data['error']);
      case 500:
        throw InternalServerErrorException(response.data['error']);
      case 503:
        throw ServiceUnavailableException(response.data['error']);
      case 504:
        throw TimeoutException(response.data['error']);
      default:
        throw FetchDataException(response.data['error']);
    }
  }
}
