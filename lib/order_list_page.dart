import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class OrderListPage extends StatelessWidget {
    const OrderListPage({super.key});

    @override
    Widget build(BuildContext context) {
        final cartProvider = Provider.of<CartProvider>(context);
        final List<Map<String, dynamic>> orders = 
            List<Map<String, dynamic>>.from(cartProvider.orders.whereType<Map<String, dynamic>>());

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
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                'Information as of ${TimeOfDay.now().format(context)}.',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                        ),
                    ),
                    Expanded(
                        child: orders.isEmpty
                            ? const Center(child: Text("No orders yet"))
                            : ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                    final order = orders[index];
                                    final List<Map<String, dynamic>>? items = 
                                        (order['items'] is List) 
                                            ? List<Map<String, dynamic>>.from(order['items'].whereType<Map<String, dynamic>>())
                                            : null;
                                    final status = 'Making';
                                    final statusColor = Colors.orange;

                                    if (items != null) {
                                        return _buildOrderCard(
                                            orderNumber: index + 1,
                                            status: status,
                                            statusColor: statusColor,
                                            items: items,
                                        );
                                    } else {
                                        return const ListTile(title: Text('Invalid order data'));
                                    }
                                },
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
                                minimumSize: const Size(double.infinity, 60),
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
                            children: items.map((item) {
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
