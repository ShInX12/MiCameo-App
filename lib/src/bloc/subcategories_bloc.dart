import 'dart:async';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/repository/subcategories_repository.dart';
import 'package:mi_cameo/src/models/subcategory_model.dart';

class SubcategoriesBloc {
  StreamController _subcategoriesListController;
  SubcategoriesRepository _subcategoriesRepository;

  StreamSink<ApiResponse<List<Subcategory>>> get subcategoriesListSink => _subcategoriesListController.sink;
  Stream<ApiResponse<List<Subcategory>>> get subcategoriesListStream => _subcategoriesListController.stream;

  SubcategoriesBloc() {
    _subcategoriesListController = StreamController<ApiResponse<List<Subcategory>>>();
    _subcategoriesRepository = SubcategoriesRepository();
    fetchSubcategorylist();
  }

  Future<void> fetchSubcategorylist() async {
    subcategoriesListSink.add(ApiResponse.loading('Cargando categorías'));
    try {
      List<Subcategory> subcategories = await _subcategoriesRepository.fetchCategories();
      subcategoriesListSink.add(ApiResponse.completed(subcategories));
    } catch (e) {
      subcategoriesListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _subcategoriesListController?.close();
  }
}
