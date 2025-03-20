import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedCategory = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, List<Map<String, String>>> menuItems = {
    'All': [
      {'name': 'Sliced pork', 'quantity': '4pc', 'image': 'assets/images/pork.jpg', 'price': '0'},
      {'name': 'Sliced beef', 'quantity': '4pc', 'image': 'assets/images/beef.jpg', 'price': '0'},
      {'name': 'Mixed Vegetables', 'quantity': '1pc', 'image': 'assets/images/vegetables.jpg', 'price': '0'},
      {'name': 'Shrimp Balls', 'quantity': '2pc', 'image': 'assets/images/shrimp.jpg', 'price': '0'},
    ],
    'Meat': [
      {'name': 'Sliced pork', 'quantity': '4pc', 'image': 'assets/images/pork.jpg', 'price': '0'},
      {'name': 'Sliced beef', 'quantity': '4pc', 'image': 'assets/images/beef.jpg', 'price': '0'},
    ],
    'Vegetables': [
      {'name': 'Mixed Vegetables', 'quantity': '1pc', 'image': 'assets/images/vegetables.jpg', 'price': '0'},
    ],
    'Ready to eat': [
      {'name': 'Shrimp Balls', 'quantity': '2pc', 'image': 'assets/images/shrimp.jpg', 'price': '0'},
    ]
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
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        // TODO: ใส่โค้ดเพื่อแสดงรายละเอียด Table 4
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
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.language, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.note, color: Colors.black), // ไอคอนกระดาษโน้ต
                        onPressed: () {
                          // TODO: ใส่โค้ดเพื่อไปยังหน้าบิลการสั่งอาหาร
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.black),
                        onPressed: () {},
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
                      children: ['All', 'Meat', 'Vegetables', 'Ready to eat'].map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                    fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal,
                                    color: selectedCategory == category ? Colors.blue : Colors.black,
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
              children: menuItems[selectedCategory]!.map((item) {
                return _buildMenuItem(item['name']!, item['quantity']!, item['image']!);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String quantity, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover),
        title: Text(name),
        subtitle: Text(quantity),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.red),
          onPressed: () {},
        ),
      ),
    );
  }
}