import 'package:oman_phone_2/models/product.dart';
import '../models/slidedata.dart';
import 'package:http/http.dart' as http;
import '../models/similar_list.dart' as sim;

class URLS {
  ///base url
  static const String BASE_URL = 'http://omanphone.smsoman.com';
  static const String MEDIA_URL =
      'http://omanphone.smsoman.com/pub/media/catalog/product/';
}

/*
This class helps us to get data from
 api
 */
class ApiService {
  /*
  getCarouselData() gets slider images from api
   */
  static Future<List<Slider>> getCarouselData() async {
    var response = await http.get('${URLS.BASE_URL}/api/configuration');
    try {
      if (response.statusCode == 200) {
        final slideData = slideDataFromJson(response.body);

        final sliders = slideData.data.slider;

        return sliders;
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<List<Item>> getGridProducts() async {
    var response = await http.get('${URLS.BASE_URL}/api/homepage');

    try {
      if (response.statusCode == 200) {
        final gridProducts = productFromJson(response.body);
        return gridProducts[0].data.items;
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<List<sim.Item>> getSimilarProducts(int id) async {
    var response = await http.get('${URLS.BASE_URL}/api/upsellproducts?id=$id');

    try {
      if (response.statusCode == 200) {
        print(response.body);
        final similarProductModel = sim.similarListFromJson(response.body);

        return similarProductModel.items;
      }
    } catch (error) {}
  }
}
