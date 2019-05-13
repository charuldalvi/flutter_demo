class Product {

  final String p_id;

  final String p_name;

  final String p_cost;

  final String p_imgurl;

  Product({this.p_id,this.p_name,this.p_cost,this.p_imgurl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      p_id: json['p_id'] as String,
      p_name: json['p_name'] as String,
      p_cost: json['p_cost'] as String,
      p_imgurl: json['p_imgurl'] as String,
    );
  }

}