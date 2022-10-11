class Cart {
  int? shopId;
  int? id;
  int? basketId;
  int? cnt;
  String? title;
  String? content;
  String? image;

  Cart(
      {this.shopId,
        this.id,
        this.basketId,
        this.cnt,
        this.title,
        this.content,
        this.image});

  Cart.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    id = json['id'];
    basketId = json['basket_id'];
    cnt = json['cnt'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['id'] = id;
    data['basket_id'] = basketId;
    data['cnt'] = cnt;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    return data;
  }
}