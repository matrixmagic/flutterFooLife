class StatisticDto {
  String date;
  int count;


  StatisticDto(
      {this.date,
      this.count});

  StatisticDto.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    count = json['count'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['count'] = this.count;

    return data;
  }
}