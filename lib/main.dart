import 'package:flutter/material.dart';
import 'order_page.dart'; // ตรวจสอบให้แน่ใจว่าไฟล์นี้ถูก import ถูกต้อง

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // เอา banner debug ออก
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OrderPage(),
    );
  }
}
