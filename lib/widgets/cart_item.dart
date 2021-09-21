import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String cartItemName;
  final int quantity;
  final double price;
  final String imageName;
  CartItem({
    this.id,
    this.cartItemName,
    this.quantity,
    this.price,
    @required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Card(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cartItemName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 200,
                  width: 100,
                  child: CachedNetworkImage(
                      imageUrl: '${URLS.MEDIA_URL}$imageName'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'OMR: $price',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cart.removeItem(id);
                  },
                  icon: Icon(Icons.delete),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        cart.reduceItem(
                            id.toString(), cartItemName, quantity, price);
                      },
                      icon: Icon(
                        Icons.minimize,
                      ),
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      onPressed: () {
                        cart.addItem(
                          id.toString(),
                          cartItemName,
                          price,
                        );
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
