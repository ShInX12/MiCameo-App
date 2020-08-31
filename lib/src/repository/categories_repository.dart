import 'package:mi_cameo/src/models/category_model.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';

class CategoriesRespository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Category>> fetchCategories() async {
    final Map response = await _helper.get(url: 'api/categories/');
    return CategoriesResponse.fromJson(response).categories;
  }
}