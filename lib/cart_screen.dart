import 'package:apple/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apple/cart_provider.dart';
import 'package:apple/cart_model.dart';
import 'package:badges/badges.dart' as custom_badge;
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DBHelper cN = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart List'),
        centerTitle: true,
        actions: [
          custom_badge.Badge(
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
          const SizedBox(width: 20.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   // Show a loading indicator while the future is resolving
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else if (snapshot.hasError) {
                //   // Handle error state
                //   return Center(
                //     child: Text(
                //       'An error occurred: ${snapshot.error}',
                //       style: const TextStyle(color: Colors.red),
                //     ),
                //   );
                // } else
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // If data exists and is not empty
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                      backgroundImage: AssetImage(snapshot.data![index].image.toString()),

                                      // backgroundImage: CachedNetworkImageProvider(
                                      //   snapshot.data![index].image.toString(),
                                      // ),
                                      // child: CachedNetworkImage(
                                      //   imageUrl: snapshot.data![index].image.toString(),
                                      //   placeholder: (context, url) =>const CircularProgressIndicator(color: Colors.green,),
                                      //   errorWidget: (context, url, error) =>const Icon(Icons.error,),
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data![index].productName.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red),
                                              ),

                                              InkWell(
                                                onTap: () {
                                                  cN.delete(snapshot.data![index].id!);
                                                  cart.removeCounter();
                                                  cart.removeTotalAmount(double.parse(snapshot.data![index].productPrice.toString()));
                                                },
                                                child: const Icon(Icons.delete, color: Colors.red,)),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),

                                          Text(
                                            '${snapshot.data![index].qty.toString()} ${snapshot.data![index].unitTag.toString()} @ ${snapshot.data![index].productPrice.toString()} = ${snapshot.data![index].productAmount.toString()}',
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
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  InkWell(
                                                      onTap: () {

                                                        int qty = snapshot.data![index].qty!;
                                                        int price = snapshot.data![index].productPrice!;
                                                        qty--;
                                                        int? totalAmount = qty * price;

                                                        if(qty > 0 ) {
                                                          cN.updateQty(Cart(
                                                              id: snapshot.data![index].id!,
                                                              productId: snapshot.data![index].productId!,
                                                              productName: snapshot.data![index].productName!.toString(),
                                                              productPrice: snapshot.data![index].productPrice!,
                                                              productAmount: totalAmount,
                                                              qty: qty,
                                                              unitTag: snapshot.data![index].unitTag.toString(),
                                                              image: snapshot.data![index].image.toString()),
                                                          ).then((value) {

                                                            print('Product is added to Cart Successfully.');

                                                            qty = 0;
                                                            totalAmount = 0;
                                                            cart.removeCounter();
                                                            cart.removeTotalAmount(double.parse(snapshot.data![index].productPrice!.toString()));

                                                          }).onError((error, stackTrace) {
                                                            print(error.toString());
                                                          });
                                                        }

                                                      },
                                                      child: const Icon(Icons.remove, color: Colors.white,)),

                                                  Text(
                                                    snapshot.data![index].qty.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),

                                                  InkWell(
                                                    onTap: () {

                                                      int qty = snapshot.data![index].qty!;
                                                      int price = snapshot.data![index].productPrice!;
                                                      qty++;
                                                      int? totalAmount = qty * price;

                                                      cN.updateQty(Cart(
                                                          id: snapshot.data![index].id!,
                                                          productId: snapshot.data![index].productId!,
                                                          productName: snapshot.data![index].productName!.toString(),
                                                          productPrice: snapshot.data![index].productPrice!,
                                                          productAmount: totalAmount,
                                                          qty: qty,
                                                          unitTag: snapshot.data![index].unitTag.toString(),
                                                          image: snapshot.data![index].image.toString()),
                                                      ).then((value) {

                                                        print('Product is added to Cart Successfully.');

                                                        qty = 0;
                                                        totalAmount = 0;
                                                        cart.addCounter();
                                                        cart.addTotalAmount(double.parse(snapshot.data![index].productPrice!.toString()));

                                                      }).onError((error, stackTrace) {
                                                        print(error.toString());
                                                      });

                                                    },
                                                    child: const Icon(Icons.add, color: Colors.white,)),
                                                ],
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
                    ),
                  );
                } else {
                  // Handle the case where the data is empty
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage('images/cart.png')),
                      const SizedBox(height: 20.0,),
                      Center(
                        child: Text(
                          'No Products available in Cart.',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.getTotalAmount().toStringAsFixed(2) == "0.00" ? false : true,
                  child: Column(
                    children: [
                      ReusableWidget(
                        title: 'Sub Total',
                        value: value.getTotalAmount().toStringAsFixed(2),
                      ),
                      ReusableWidget(
                        title: 'Discount 5%',
                        value: (value.getTotalAmount() * 0.05).toStringAsFixed(2),
                      ),
                      ReusableWidget(
                        title: 'Net Bill',
                        value: (value.getTotalAmount() - (value.getTotalAmount() * 0.05)).toStringAsFixed(2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          Text(value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
