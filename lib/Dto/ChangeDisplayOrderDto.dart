class ChangeDisplayOrderDto {
  int id1;
  int id2;

  ChangeDisplayOrderDto({this.id1, this.id2});

  ChangeDisplayOrderDto.fromJson(Map<String, dynamic> json) {
    id1 = json['id1'];
    id2 = json['id2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id1'] = this.id1;
    data['id2'] = this.id2;
    return data;
  }
}