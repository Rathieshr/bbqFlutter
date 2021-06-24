class Menu {
  int iId;
  String menuName;
  String category;
  int categoryId;
  int price;
  int iV;

  Menu(
      {this.iId,
      this.menuName,
      this.category,
      this.categoryId,
      this.price,
      this.iV});

  Menu.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    menuName = json['menuName'];
    category = json['category'];
    categoryId = json['categoryId'];
    price = json['price'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['menuName'] = this.menuName;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['price'] = this.price;
    data['__v'] = this.iV;
    return data;
  }
}
