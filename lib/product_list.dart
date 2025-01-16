import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as custom_badge;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> prodcutName = [
    'Apple',
    'Banana',
    'Chery',
    'Grapes',
    'Mango',
    'Orange',
    'Peach'
  ];
  List<String> prodcutUnit = ['KG', 'Dozen', 'KG', 'KG', 'KG', 'Dozen', 'KG'];
  List<String> prodcutPrice = ['100', '200', '300', '400', '500', '600', '700'];
  List<String> prodcutImage = [
    'https://github.com/qaisershameer/images/blob/main/apple.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Banana.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Cherry.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Grapes.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Mango.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Orange.jpg?raw=true',
    'https://github.com/qaisershameer/images/blob/main/Peach.jpg?raw=true'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        actions: const [
          custom_badge.Badge(
            badgeContent: Text(
              '123',
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
            // animationDuration: Duration(milliseconds: 300),
            child: Icon(Icons.shopping_bag_outlined),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: prodcutName.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Image(
                          //   height: 75,
                          //   width: 75,
                          //   image: NetworkImage(prodcutImage[index].toString()),
                          // ),

                          CircleAvatar(
                            radius: 40, // Half of the height/width to maintain the same size as before
                            backgroundImage: NetworkImage(
                              prodcutImage[index].toString(),
                            ),
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
                                  prodcutName[index].toString(),
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  prodcutUnit[index].toString() + " " +
                                      prodcutPrice[index].toString()
                                  +r"/-",
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal),
                                ),
                            
                                const SizedBox(
                                  height: 5,
                                ),
                            
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                      borderRadius: BorderRadius.circular(5),
                            
                                    ),
                                    child: const Center(
                                      child: Text('Add to Cart', style: TextStyle(color: Colors.white),),
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
