class CartModel {
  final String _id;
  final String _productName;
  final int _quantity;
  final double _price;
  final String _imageName;

  CartModel(this._id, this._productName, this._quantity, this._price,
      this._imageName);

  String get id => _id;
  String get productName => _productName;
  int get quantity => _quantity;
  double get price => _price;
  String get imageName => _imageName;
}
