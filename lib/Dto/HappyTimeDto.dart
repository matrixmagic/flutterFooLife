class HappyTimeDto {
  int categoryId;
  String from;
  String to;
  String amount;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  List<int> productIds;

  HappyTimeDto(
      {this.categoryId,
      this.from,
      this.to,
      this.amount,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.productIds});

  HappyTimeDto.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    from = json['from'];
    to = json['to'];
    amount = json['amount'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    productIds =
        json['product_ids'] != null ? json['product_ids'].cast<int>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['amount'] = this.amount;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;

    if (this.productIds != null) {
      data['product_ids'] = this.productIds.map((v) => v).toList();
      return data;
    }
  }
}
