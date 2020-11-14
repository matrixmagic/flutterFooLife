class FavouriteDto {
  dynamic restaurantId;
  String date;
  dynamic customerId;
  String updatedAt;
  String createdAt;
  dynamic id;
  dynamic favourite;

  FavouriteDto(
      {this.restaurantId,
      this.date,
      this.customerId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.favourite});

  FavouriteDto.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    date = json['date'];
    customerId = json['customer_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['date'] = this.date;
    data['customer_id'] = this.customerId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['favourite'] = this.favourite;
    return data;
  }
}