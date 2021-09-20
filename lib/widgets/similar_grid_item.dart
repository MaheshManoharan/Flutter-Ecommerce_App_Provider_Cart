import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/models/similar_list.dart';

class SimilarGridItem extends StatelessWidget {
  final Item item;

  SimilarGridItem({this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //when the grid item taps, moves to detailscreen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) {
        //     return DetailScreen(item: item);
        //   }),
        // );
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
