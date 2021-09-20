import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/models/product.dart';
import 'package:oman_phone_2/screens/screens.dart';

class GridItem extends StatelessWidget {
  final Item item;

  GridItem({this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //when the grid item taps, moves to detailscreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return DetailScreen(item: item);
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    child: CachedNetworkImage(
                      imageUrl: '${URLS.MEDIA_URL}${item.image}',
                      //  fit: BoxFit.cover,
                    ),
                  ),
                  if (item.storage != false)
                    Positioned(
                      right: 1,
                      bottom: 30,
                      child: Text(
                        item.storage,
                        style: TextStyle(
                          backgroundColor: Colors.white,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  item.rating != null
                      ? Positioned(
                          left: 1,
                          bottom: 30,
                          child: Container(
                            // height: 30,
                            // width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.black,
                            ),
                            child: Text(
                              '🌟${item.rating}',
                              style: TextStyle(
                                  backgroundColor: Colors.yellow,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                item.name,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              item.price.toString(),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
