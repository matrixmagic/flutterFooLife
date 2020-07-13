class MutiSelectDataSourceDto {
  int value;
  String display;

  MutiSelectDataSourceDto({this.value, this.display});

  MutiSelectDataSourceDto.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['display'] = this.display;
    return data;
  }
}