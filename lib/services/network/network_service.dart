import 'dart:io';

import 'package:github_test/config/api/api_config.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final http.Client client;

  NetworkService(this.client);

  Future<http.Response> post(String rout, Map body, [String methodName = '']) async {
    print('\nPOST request by method: $methodName');
    http.Response response = await client.post(Uri.https(API.BASE_URL, rout), body: body);
    print('\nPOST response by the method $methodName');

    return response;
  }

  Future<http.Response> get(String rout, [String methodName = '']) async {
    print('\nGET request by the method: $methodName');
    http.Response response = await client.get(
      Uri.https(API.BASE_URL, rout)
    );
    print('\nGET response by the method: $methodName\n');

    return response;
  }
}
