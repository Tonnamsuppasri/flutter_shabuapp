import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food order list',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Information as of 18:44.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildOrderCard(
                  orderNumber: 1,
                  status: 'Completed',
                  statusColor: Colors.green,
                  items: [
                    {
                      'name': 'Sliced pork',
                      'quantity': 3,
                      'image': 'assets/images/pork.jpg',
                    },
                    {
                      'name': 'Sliced beef',
                      'quantity': 2,
                      'image': 'assets/images/beef.jpg',
                    },
                  ],
                ),
                _buildOrderCard(
                  orderNumber: 2,
                  status: 'Making',
                  statusColor: Colors.orange,
                  items: [
                    {
                      'name': 'Mixed Vegetables',
                      'quantity': 1,
                      'image': 'assets/images/vegetables.jpg',
                    },
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 60,
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long),
                  SizedBox(width: 10),
                  Text('Food bill'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required int orderNumber,
    required String status,
    required Color statusColor,
    required List<Map<String, dynamic>> items,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$orderNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children:
                  items.map((item) {
                    return ListTile(
                      leading: Image.asset(
                        item['image'],
                        width: 40,
                        height: 40,
                      ),
                      title: Text(item['name']),
                      trailing: Text('X ${item['quantity']}'),
                    );
                  }).toList(),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total ${items.fold<int>(0, (sum, item) => sum + (item['quantity'] as int))} items',
              ),
            ),
          ],
        ),
      ),
    );
  }
}