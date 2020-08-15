class PaymentsMethod {
  int id;
  String name;
  Null iconCode;
  Null createdAt;
  Null updatedAt;
  

  PaymentsMethod(
      {this.id,
      this.name,
      this.iconCode,
      this.createdAt,
      this.updatedAt,
     });

  PaymentsMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconCode = json['iconCode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iconCode'] = this.iconCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    
    return data;
  }
}

