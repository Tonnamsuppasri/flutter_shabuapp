import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, dynamic>> _orders = []; // เพิ่มรายการการสั่งซื้อ

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, dynamic>> get orders => _orders; // เพิ่ม getter สำหรับ orders

  void addItem(Map<String, dynamic> newItem) {
    int index = _cartItems.indexWhere((item) => item['name'] == newItem['name']);
    if (index != -1) {
      _cartItems[index]['quantity'] += newItem['quantity'];
    } else {
      _cartItems.add(newItem);
    }
    notifyListeners();
  }

  void updateQuantity(int index, int change) {
    _cartItems[index]['quantity'] += change;
    if (_cartItems[index]['quantity'] < 1) {
      _cartItems[index]['quantity'] = 1;
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  int getTotalQuantity() {
    return _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int? ?? 0));
  }

  void clearCart() {
    _cartItems.clear(); // ล้างข้อมูลในตะกร้า
    notifyListeners();
  }

  void addOrder() {
    // เพิ่มข้อมูลการสั่งซื้อจากตะกร้าไปที่ orders และล้างตะกร้า
    if (_cartItems.isNotEmpty) {
      _orders.add({
        'orderDate': DateTime.now(),
        'items': List.from(_cartItems),
      });
      clearCart(); // ล้างข้อมูลหลังการสั่งซื้อ
    }
    notifyListeners();
  }
}
