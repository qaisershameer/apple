import 'package:apple/cart_model.dart';
import 'package:apple/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {

  DBHelper cN = DBHelper();

  int _counter = 0;
  int get counter => _counter;

  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;

  late Future<List<Cart>> _cartList;
  Future<List<Cart>> get cart => _cartList;

  Future<List<Cart>> getData () async {
    _cartList = cN.getCartList();
    return _cartList;
  }

  void setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_Amount', _totalAmount);
    notifyListeners();
  }

  void getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalAmount = prefs.getDouble('total_Amount') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    getPrefItems();
    return _counter;
  }

  void addTotalAmount(double productPrice) {
    _totalAmount = _totalAmount + productPrice;
    setPrefItems();
    notifyListeners();
  }

  void removeTotalAmount(double productPrice) {
    _totalAmount = _totalAmount - productPrice;
    setPrefItems();
    notifyListeners();
  }

  double getTotalAmount() {
    getPrefItems();
    return _totalAmount;
  }

}