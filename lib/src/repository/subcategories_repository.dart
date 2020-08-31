import 'package:mi_cameo/src/models/subcategory_model.dart';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';

class SubcategoriesRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Subcategory>> fetchCategories() async {
    final Map response = await _helper.get(url: 'api/sub-categories/');
    return SubcategoriesResponse.fromJson(response).subcategories;
  }
}