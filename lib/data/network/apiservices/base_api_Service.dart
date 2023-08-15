import 'package:dio/dio.dart';

import '../dio_client.dart';

class BaseApiService {
  BaseApiService(this.client);
  final DioClient client;
}

Options getBroKingHeader({userId}) {
  Options options = Options();
  Map<String, dynamic> headers = Map();
  headers['API-KEY'] = r'BR!D$@!@#$';
  headers['userId'] = userId;
  options.headers = headers;
  return options;
}
