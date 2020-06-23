class SuccessfulRegisterDto {
  String email;
  String updatedAt;
  String createdAt;
  int id;
  String token;

  SuccessfulRegisterDto(
      {this.email, this.updatedAt, this.createdAt, this.id, this.token});

  SuccessfulRegisterDto.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}