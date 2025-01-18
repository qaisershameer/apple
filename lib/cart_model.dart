class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final int? productAmount;
  final int? qty;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productAmount,
    required this.qty,
    required this.unitTag,
    required this.image,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        productPrice = res['productPrice'],
        productAmount = res['productAmount'],
        qty = res['qty'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productAmount': productAmount,
      'qty': qty,
      'unitTag': unitTag,
      'image': image,
    };
  }

}
