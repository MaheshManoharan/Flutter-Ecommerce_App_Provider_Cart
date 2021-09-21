import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:oman_phone_2/api/rest_api.dart';
import 'package:oman_phone_2/config/size_config.dart';
import 'package:oman_phone_2/models/product.dart';
import 'package:oman_phone_2/widgets/grid_item.dart';
import '../models/slidedata.dart' as sl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<sl.Slider>> _sliderlist;
  Future<List<Item>> _griditems;
  Future<String> _banner;
  Future<List<Item>> _newArrivalItems;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _sliderlist = ApiService.getCarouselData();
    _griditems = ApiService.getGridProducts();
    _banner = ApiService.getBanner();
    _newArrivalItems = ApiService.getNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: CustomScrollView(slivers: [
        //appbar
        _buildAppBar3(),
        //carousel slider
        _buildCarouselSlider(),
//empty space
        _buildSizedBox(),
//mobile phones view all
        _buildMobileViewall(),
//gridview
        _buildGridView(),
//iphone banner,
        _buildBanner(),
        // new arrivals grid
        _buildNewArrivals(),
//new arrivals
        _buildGridView2(),
      ]),
      //bottombar
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  SliverToBoxAdapter _buildBanner() {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _banner,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CachedNetworkImage(imageUrl: snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  FutureBuilder<List<Item>> _buildGridView2() {
    return FutureBuilder<List<Item>>(
      future: _newArrivalItems,
      builder: (context, snapshot) => !snapshot.hasData
          ? SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SliverGrid(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GridItem(item: snapshot.data[index]);
                },
                childCount: snapshot.data.length,
              ),
            ),
    );
  }

  FutureBuilder<List<Item>> _buildGridView() {
    return FutureBuilder<List<Item>>(
      future: _griditems,
      builder: (context, snapshot) => !snapshot.hasData
          ? SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SliverGrid(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GridItem(item: snapshot.data[index]);
                },
                childCount: snapshot.data.length,
              ),
            ),
    );
  }

  SliverToBoxAdapter _buildNewArrivals() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Arrivals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('VIEW  ALL'),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMobileViewall() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mobile Phones',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('VIEW  ALL'),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSizedBox() {
    return SliverToBoxAdapter(
      child: SizedBox(height: SizeConfig.blockSizeVertical * 2),
    );
  }
  

  BottomNavigationBar _buildBottomBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
        ]);
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  _buildCarouselSlider() {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: SizeConfig.blockSizeVertical * 28,
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

SliverAppBar _buildAppBar3() {
  return SliverAppBar(
    stretch: true,
    toolbarHeight: SizeConfig.blockSizeVertical * 8 + kToolbarHeight,
    title: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Text('OMAN PHONE'),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            // left: 4.0,
            // right: 4.0,
          ),
          child: Container(
            height: SizeConfig.blockSizeVertical * 6,
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
    pinned: true,
  );
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
