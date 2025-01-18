import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apple/cart_provider.dart';
import 'package:apple/cart_model.dart';
import 'package:apple/cart_screen.dart';
import 'package:apple/db_helper.dart';
import 'package:badges/badges.dart' as custom_badge;
import 'package:cached_network_image/cached_network_image.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  DBHelper cN = DBHelper();

  List<String> productName = [
    'Apple',
    'Banana',
    'Chery',
    'Grapes',
    'Mango',
    'Orange',
    'Peach'
  ];
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'KG', 'KG', 'KG', 'KG'];
  List<int> productPrice = [200, 150, 800, 400, 300, 100, 300];
  List<String> productImage = [
    // 'https://github.com/qaisershameer/images/blob/main/apple.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Banana.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Cherry.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Grapes.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Mango.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Orange.jpg?raw=true',
    // 'https://github.com/qaisershameer/images/blob/main/Peach.jpg?raw=true',

    'images/apple.jpg',
    'images/Banana.jpg',
    'images/Cherry.jpg',
    'images/Grapes.jpg',
    'images/Mango.jpg',
    'images/Orange.jpg',
    'images/Peach.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Center(
              child: custom_badge.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    );
                  },
                ),
                // animationDuration: Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: productName.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          CircleAvatar(
                            radius: 40, // Half of the height/width to maintain the same size as before
                            backgroundImage: AssetImage(productImage[index].toString()),

                            // CachedNetworkImageProvider(
                            //   productImage[index].toString(),
                            // ),
                            // child: CachedNetworkImage(
                            //   imageUrl: productImage[index].toString(),
                            //   placeholder: (context, url) =>const CircularProgressIndicator(color: Colors.green,),
                            //   errorWidget: (context, url, error) =>const Icon(Icons.error_outline,),
                            //   // To avoid showing both placeholder/error widget inside the avatar, remove the `child` if it's not needed.
                            // ),

                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName[index].toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${productUnit[index]} ${productPrice[index]}/-',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.teal),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      cN
                                          .insert(
                                        Cart(
                                            id: index,
                                            productId: index.toString(),
                                            productName:
                                                productName[index].toString(),
                                            productPrice: productPrice[index],
                                            productAmount: productPrice[index],
                                            qty: 1,
                                            unitTag:
                                                productUnit[index].toString(),
                                            image:
                                                productImage[index].toString()),
                                      ).then((value) {
                                        print('Product is added to Cart Successfully.');
                                        cart.addCounter();
                                        cart.addTotalAmount(double.parse(
                                            productPrice[index].toString()));
                                      }).onError((error, stackTrace) {
                                        print(error.toString());
                                      });
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
