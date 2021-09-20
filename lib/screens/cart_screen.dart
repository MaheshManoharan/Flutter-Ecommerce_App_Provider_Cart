import 'package:flutter/material.dart';
import 'package:oman_phone_2/providers/cart_provider.dart';
import 'package:oman_phone_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: _appBar(cartProvider),
      body: _buildBody(),
      bottomNavigationBar: _buildNavigationBar(cartProvider),
    );
  }

  Container _buildNavigationBar(CartProvider cartProvider) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    'TOTAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    '${cartProvider.totalAmount.roundToDouble()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: Text(
                  'CHECKOUT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Consumer<CartProvider> _buildBody() {
    return Consumer<CartProvider>(
      child: Center(
        child: Text('No items in your cart'),
      ),
      builder: (context, cart, ch) {
        return cart.cartItems.length <= 0
            ? ch
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cart.cartItems.values.toList()[index];

                  return CartItem(
                    id: cart.cartItems.keys.toList()[index],
                    cartItemName: item.productName,
                    quantity: item.quantity,
                    price: item.price,
                    imageName: item.imageName,
                  );
                },
              );
      },
    );
  }

  AppBar _appBar(CartProvider cartProvider) {
    return AppBar(
      centerTitle: true,
      title: cartProvider.itemCount == 0
          ? Text('My Cart')
          : Text('My Cart (${cartProvider.itemCount})'),
    );
  }
}
