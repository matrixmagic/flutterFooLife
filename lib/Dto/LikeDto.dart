class LikeDto {
  dynamic productId;
  dynamic restaurantId;
  String date;
  dynamic customerId;
  String updatedAt;
  String createdAt;
  dynamic id;
  dynamic like;

  LikeDto(
      {this.productId,
      this.restaurantId,
      this.date,
      this.customerId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.like});

  LikeDto.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    restaurantId = json['restaurant_id'];
    date = json['date'];
    customerId = json['customer_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['restaurant_id'] = this.restaurantId;
    data['date'] = this.date;
    data['customer_id'] = this.customerId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['like'] = this.like;
    return data;
  }
}