import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/config/size_config.dart';
import 'package:oman_phone_2/models/product.dart';
import 'package:oman_phone_2/screens/screens.dart';

class GridItem extends StatelessWidget {
  final Item item;

  GridItem({this.item});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              height: SizeConfig.blockSizeVertical * 14,
              child: Stack(
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 25, //90
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
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 5, //10
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
                              '⭐${item.rating}',
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
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0),
              child: Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Row(
              mainAxisAlignment: item.specialPrice == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: item.specialPrice == null
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                if (item.specialPrice != null)
                  Text(
                    'OMR ${item.specialPrice.toDouble()}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                  'OMR ${item.price.toDouble()}',
                  style: item.specialPrice != null
                      ? TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        )
                      : TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
