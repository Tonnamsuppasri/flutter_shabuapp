import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_page.dart';
import 'order_cart_page.dart';
import 'cart_provider.dart'; // Import ไฟล์ provider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OrderPage(),
      routes: {
        '/orderCart': (context) => const OrderCartPage(),
      },
    );
  }
}
