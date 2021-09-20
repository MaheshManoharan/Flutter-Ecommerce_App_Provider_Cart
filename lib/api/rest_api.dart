import '../models/slidedata.dart';
import 'package:http/http.dart' as http;

class URLS 
{
  ///base url
  static const String BASE_URL = 'http://omanphone.smsoman.com';
}

/*
This class helps us to get data from
 api
 */
class ApiService 
{


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
}
