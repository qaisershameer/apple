import 'package:flutter/material.dart';
import 'package:apple/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductList(),
    );
  }
}

// https://www.youtube.com/watch?v=dnHI6gVJf-U&list=PLFyjjoCMAPtz9TKMIz1Wty1DQXs8mEsMm&index=6
