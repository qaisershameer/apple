import 'package:apple/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:apple/product_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          title: 'Apple',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}

// https://www.youtube.com/watch?v=e6FaXSEqQYg&list=PLFyjjoCMAPtz9TKMIz1Wty1DQXs8mEsMm&index=8
