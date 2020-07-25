class UserDto {
  int id;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  String createdAt;
  String updatedAt;
  String token;

  UserDto(
      {this.id,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.token});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}