class RestaurantServicesDto {
  int id;
  int restaurantId;
  int accessible;
  int childfriendly;
  int gamepad;
  int wifi;
  int power;
  int pets;
  String createdAt;
  String updatedAt;

  RestaurantServicesDto(
      {this.id,
      this.restaurantId,
      this.accessible,
      this.childfriendly,
      this.gamepad,
      this.wifi,
      this.power,
      this.pets,
      this.createdAt,
      this.updatedAt});

  RestaurantServicesDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    accessible = json['accessible'];
    childfriendly = json['childfriendly'];
    gamepad = json['gamepad'];
    wifi = json['wifi'];
    power = json['power'];
    pets = json['pets'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['accessible'] = this.accessible;
    data['childfriendly'] = this.childfriendly;
    data['gamepad'] = this.gamepad;
    data['wifi'] = this.wifi;
    data['power'] = this.power;
    data['pets'] = this.pets;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}