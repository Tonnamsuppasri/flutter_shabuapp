import 'package:flutter/material.dart';
import 'package:flutter_shabuapp/order_cart_page.dart';
import 'package:flutter_shabuapp/order_list_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'cart_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedCategory = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showQrCode = false;

  final Map<String, List<Map<String, String>>> menuItems = {
    'All': [
      {
        'name': 'Sliced pork',
        'quantity': '4pc',
        'image': 'assets/images/pork.jpg',
        'price': '0',
      },
      {
        'name': 'Sliced beef',
        'quantity': '4pc',
        'image': 'assets/images/beef.jpg',
        'price': '0',
      },
      {
        'name': 'Mixed Vegetables',
        'quantity': '1pc',
        'image': 'assets/images/vegetables.jpg',
        'price': '0',
      },
      {
        'name': 'Shrimp Balls',
        'quantity': '2pc',
        'image': 'assets/images/shrimp.jpg',
        'price': '0',
      },
    ],
    'Meat': [
      {
        'name': 'Sliced pork',
        'quantity': '4pc',
        'image': 'assets/images/pork.jpg',
        'price': '0',
      },
      {
        'name': 'Sliced beef',
        'quantity': '4pc',
        'image': 'assets/images/beef.jpg',
        'price': '0',
      },
    ],
    'Vegetables': [
      {
        'name': 'Mixed Vegetables',
        'quantity': '1pc',
        'image': 'assets/images/vegetables.jpg',
        'price': '0',
      },
    ],
    'Ready to eat': [
      {
        'name': 'Shrimp Balls',
        'quantity': '2pc',
        'image': 'assets/images/shrimp.jpg',
        'price': '0',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  'Categories',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ...['All', 'Meat', 'Vegetables', 'Ready to eat'].map((category) {
              return ListTile(
                title: Text(category),
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/shabupic.jpg',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 20,
                left: 10,
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
                Positioned(
                top: 20,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                  children: [
                    Text(
                    'Table 4',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      _showTableDetails();
                    },
                    ),
                  ],
                  ),
                ),
                ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/engflag.jpg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/bill.png',
                              width: 24,
                              height: 24,
                              ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderListPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderCartPage(),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${Provider.of<CartProvider>(context).getTotalQuantity()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
                SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          ['All', 'Meat', 'Vegetables', 'Ready to eat'].map((
                            category,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight:
                                            selectedCategory == category
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color:
                                            selectedCategory == category
                                                ? Colors.blue
                                                : Colors.black,
                                      ),
                                    ),
                                    if (selectedCategory == category)
                                      Container(
                                        margin: EdgeInsets.only(top: 4),
                                        height: 3,
                                        width: 30,
                                        color: Colors.blue,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children:
                  menuItems[selectedCategory]!.map((item) {
                    return _buildMenuItem(
                      item['name']!,
                      item['quantity']!,
                      item['image']!,
                      item['price']!,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String name,
    String quantity,
    String imagePath,
    String price,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // เพิ่มขอบมลให้รูปภาพ
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(name, style: TextStyle(fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('($quantity)', style: TextStyle(fontSize: 14)),
            Text(
              '฿$price',
              style: TextStyle(fontSize: 12),
            ), // ปรับขนาดตัวอักษร), // แสดง price ที่นี่
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.red),
            onPressed: () {
              _showOrderDetails(context, name, quantity, imagePath, price);
            },
          ),
        ),
      ),
    );
  }

  void _showTableDetails() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    title: Text('MAGIN YAKINIKU'),
                    trailing: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _showQrCode = false;
                        });
                      },
                    ),
                  ),
                  Divider(),
                  if (_showQrCode)
                    Column(
                      children: [
                        Text('TABLE 4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        QrImageView(
                          data: 'TABLE 4',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        SizedBox(height: 10),
                        Text('SCAN FOR MENU', style: TextStyle(fontSize: 16)),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ListTile(
                          title: Text('Buffet Shabu'),
                          subtitle: Text('4 persons'),
                          trailing: Text('18:38 - --:-- min'),
                        ),
                        Divider(),
                        ListTile(title: Text('Terms of Service')),
                        Divider(),
                        ListTile(
                          title: Text('Share QR Code with Friends'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            setState(() {
                              _showQrCode = true;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showOrderDetails(
  BuildContext context,
  String name,
  String quantity,
  String imagePath,
  String price,
) {
  int _quantity = 1;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath, width: 150, height: 150),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$name ($quantity)'),
                    Text('฿$price'),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const Text('Detail'),
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).addItem({
                          'name': name,
                          'quantity': _quantity,
                          'price': price,
                          'image': imagePath,
                        });

                        Navigator.pop(context);
                      },
                      label: const Text('ADD'),
                      icon: const Icon(Icons.shopping_cart, color: Colors.red),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_up),
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                        ),
                        Text('$_quantity'),
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}
