import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/models/product.dart';
import 'package:oman_phone_2/providers/cart_provider.dart';
import 'package:oman_phone_2/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'screens.dart';

import '../models/similar_list.dart' as sim;

class DetailScreen extends StatefulWidget {
  final Item item;

  DetailScreen({this.item});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<List<sim.Item>> _similarItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _similarItems = ApiService.getSimilarProducts(
      int.parse(widget.item.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final item = widget.item;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _detailBody(item),
      bottomNavigationBar: _buildNavigationBar(cart, context),
    );
  }

  SingleChildScrollView _detailBody(Item item) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 4.0,
          ),
          _topImage(item),
          SizedBox(
            height: 8.0,
          ),
          _titleAndContent(item),
          _priceAndSpecialPrice(item),
          _specifics(item),
          _specifics2(item),
          Card(
            child: Container(
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'About Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'View  details...',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              height: 230,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Similar Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder<List<sim.Item>>(
                      future: _similarItems,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshot.data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  //return Text(snapshot.data[index].name);

                                  return SimilarGridItem(
                                      item: snapshot.data[index]);
                                }),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Row _specifics2(Item item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(
              Icons.memory_rounded,
            ),
            Text('8GB')
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.screenshot_sharp,
            ),
            Text('6.1')
          ],
        ),
      ],
    );
  }

  Padding _specifics(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.memory),
              if (item.storage != false) Text(item.storage),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.battery_full,
              ),
              Text('5000mah'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.camera),
              Text('20 MP'),
            ],
          ),
        ],
      ),
    );
  }

  Padding _priceAndSpecialPrice(Item item) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          if (item.specialPrice != null)
            Row(
              children: [
                Text('OMR${item.specialPrice.roundToDouble()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          Text(
            'OMR ${item.price.roundToDouble()}',
            style: TextStyle(
              decoration: item.specialPrice != null
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              fontWeight: item.specialPrice != null
                  ? FontWeight.normal
                  : FontWeight.bold,
              //color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  ListTile _titleAndContent(Item item) {
    return ListTile(
      title: Text(
        item.name,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: item.rating != null ? Text(item.rating) : Text(''),
    );
  }

  Stack _topImage(Item item) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 250,
        child: CachedNetworkImage(imageUrl: '${URLS.MEDIA_URL}${item.image}'),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: Heart(),
      ),
    ]);
  }

  Container _buildNavigationBar(CartProvider cart, BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (cart.cartItems.containsKey(widget.item.id)) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CartScreen();
                  }));
                } else {
                  cart.addToCart(
                    widget.item.id.toString(),
                    widget.item.name,
                    1,
                    widget.item.price,
                    widget.item.image,
                  );
                  setState(() {});
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: cart.cartItems.containsKey(widget.item.id)
                    ? Text(
                        'GO TO CART',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'ADD TO CART',
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Item Details'),
      actions: [
        Consumer<CartProvider>(
          builder: (_, cartprovider, ch) => Badge(
            child: ch,
            value: cartprovider.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return CartScreen();
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
