class HttpResponseModel{
  String responseCode;
  String responseStatus;
  Object response;
  String responseMessage;

  HttpResponseModel.fromJson(dynamic obj) {
    this.responseCode = obj['responseCode'];
    this.responseStatus = obj['responseStatus'];
    this.response = obj['response'];
    this.responseMessage = obj['responseMsg'];
  }
}