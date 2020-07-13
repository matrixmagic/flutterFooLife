class AuthDto {
  int roleId;
  String email;
  String password;
  String passwordConfirmation;
  String phoneNumber;

  AuthDto(
      {this.roleId,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.phoneNumber});

  AuthDto.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}