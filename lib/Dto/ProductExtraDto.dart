class ProductExtraDto {
  int id;
  int restaurantId;
  int productId;
  String name;
  String notes;
  String price;
  String createdAt;
  String updatedAt;

  ProductExtraDto(
      {this.id,
      this.restaurantId,
      this.productId,
      this.name,
      this.notes,
      this.price,
      this.createdAt,
      this.updatedAt});

  ProductExtraDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    productId = json['product_id'];
    name = json['name'];
    notes = json['notes'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['notes'] = this.notes;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}