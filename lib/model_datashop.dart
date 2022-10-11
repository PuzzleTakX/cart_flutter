class DataShopModel {
  int? shopId;
  String? shopTitle;

  DataShopModel({this.shopId, this.shopTitle});

  DataShopModel.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopTitle = json['shop_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['shop_title'] = shopTitle;
    return data;
  }
}