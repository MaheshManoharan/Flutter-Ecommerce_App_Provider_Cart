import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import '../models/slidedata.dart' as sl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<sl.Slider>> _sliderlist;

  @override
  void initState() {
    super.initState();
    _sliderlist = ApiService.getCarouselData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _buildAppBar2(),
        _buildCarouselSlider(),
      ]),
    );
  }

  _buildCarouselSlider() {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 200,
      child: FutureBuilder<List<sl.Slider>>(
          future: _sliderlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Carousel(
                showIndicator: false,
                images: snapshot.data
                    .map(
                      (e) => Container(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: e.image,
                          fit: BoxFit.cover,
                        ),
                        // child: Image.network(
                        //   e.image,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    )
                    .toList(),
              );
            }
            return Container();
          }),
    ));
  }
}

SliverAppBar _buildAppBar2() {
  /*
   builds appbar with search textfield
    */
  return SliverAppBar(
    stretch: true,
    toolbarHeight: 75.0 + kToolbarHeight,
    title: Column(
      children: [
        Text('OMAN PHONE'),
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search products...",
                border: InputBorder.none,
                icon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ),
            ),
          ),
        ),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.red,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () {},
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ],
    pinned: true,
  );
}
