class FileUploaded {
  String path;
  bool isMain;
  String extension;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  FileUploaded(
      {this.path,
      this.isMain,
      this.extension,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  FileUploaded.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    isMain = json['isMain'];
    extension = json['extension'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['isMain'] = this.isMain;
    data['extension'] = this.extension;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}