class SuccessfulLogin {
  String accessToken;
  String tokenType;
  int expiresIn;

  SuccessfulLogin({this.accessToken, this.tokenType, this.expiresIn});

  SuccessfulLogin.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
