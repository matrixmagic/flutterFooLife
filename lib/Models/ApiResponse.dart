class ApiResponse {
  bool success;
  dynamic data;
  String msg;
  String codeMsg;
  int status;

  ApiResponse({this.success, this.data, this.msg, this.codeMsg, this.status});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    msg = json['msg'];
    codeMsg = json['codeMsg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['msg'] = this.msg;
    data['codeMsg'] = this.codeMsg;
    data['status'] = this.status;
    return data;
  }
}
