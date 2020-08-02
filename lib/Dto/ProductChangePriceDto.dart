class ProductChangePriceDto {
  int id;
  double price;

  ProductChangePriceDto({this.id, this.price});

  ProductChangePriceDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    return data;
  }
}