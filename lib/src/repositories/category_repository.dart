import 'package:paropkar/src/models/category/category_listing_models.dart';
import 'package:paropkar/src/services_new/get_http_request.dart';
import 'package:paropkar/src/utills/constants.dart';

class CategoryRepository {
  Future<CategoriesListModel> fetchCategories() async {
    try {
      var response = await getHttpRequest(
        url: AppUrl.category,
      );
      return CategoriesListModel.fromJson(response);
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}


// try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization':
//               'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Bhcm9wa2FyLmpldGRpZ2l0YWwuaW4vYXBpL3Bvc3Rfb3RwX2xvZ2luIiwiaWF0IjoxNzI2OTA3NDYyLCJleHAiOjE3MjY5MTEwNjIsIm5iZiI6MTcyNjkwNzQ2MiwianRpIjoiaXdPeFNPbGRNSDNrYmZFTCIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.WZ-7SWQXwyor2fEWm2oyEGHIkqXGEg0X7RkPt1Hpxd4',
//           'Accept': 'application/json'
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         return CategoriesListModel.fromJson(jsonResponse);
//       } else {
//         throw Exception('Failed to load categories');
//       }
//     } catch (error) {
//       throw Exception('Error fetching categories: $error');
//     }
//   }