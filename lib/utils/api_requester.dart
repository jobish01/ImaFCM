import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:requester/requester.dart';
import '../utils/app_constants.dart';

class ApiRequest extends Request {
  ApiRequest(String requestType, String url, {Map jsonbody, String token})
      : super(requestType, Uri.parse(url)) {
    this.headers['Content-Type'] = 'application/json';
    this.headers['Authorization'] = token;
    this.body = jsonEncode(jsonbody);
  }
}
class RequestMiddleware extends BaseMiddleware {
  RequestMiddleware();
}

class ApiRequester {
  Future sendRequest(
      dynamic requestType, String apiUrl, Map requestBody) async {
    var client = new Client();
    var requester = new Requester(client);
    var token = "";
    requester.addMiddleware(new RequestMiddleware());
    var request = new ApiRequest(
        requestType, Uri.parse(Constants.baseUrl + apiUrl).toString(),
        jsonbody: requestBody, token: token);
    var response = await requester.send(request);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw new FetchDataException(
          "Error [StatusCode:$response.statusCode, Error:${response.reasonPhrase}]");
    }
  }

  Future apiRequest(String requestType, String apiUrl,
      {Map requestBody, String token}) async {
    var client = new Client();
    var requester = new Requester(client);
    var tokenHeader = token != null ? "Bearer " + token : " ";
    requester.addMiddleware(new RequestMiddleware());
    var request = new ApiRequest(
        requestType, Uri.parse(Constants.baseUrl + apiUrl).toString(),
        jsonbody: requestBody, token: tokenHeader);
    var response = await requester.send(request);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw new FetchDataException(
          "Error [StatusCode:$response.statusCode, Error:${response.reasonPhrase}]");
    }
  }

  Future postRequest(Map requestBody, String apiUrl) async {
    final response = await post(
      Uri.parse(Constants.oldUrl + apiUrl),
      body: requestBody,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw "Exception : ${response.reasonPhrase}";
    }
  }

  Future testRequest(String requestType, String apiUrl,
      {Map requestBody, String token}) async {
    var client = new Client();
    var requester = new Requester(client);
    var tokenHeader = token != null ? "Bearer " + token : " ";
    requester.addMiddleware(new RequestMiddleware());
    var request = new ApiRequest(
        requestType, Uri.parse(Constants.oldUrl + apiUrl).toString(),
        jsonbody: requestBody, token: tokenHeader);
    var response = await requester.send(request);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw new FetchDataException(
          "Error [StatusCode:$response.statusCode, Error:${response.reasonPhrase}]");
    }
  }
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  String toString() {
    return "Exception : $message";
  }
}
