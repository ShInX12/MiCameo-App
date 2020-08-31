import 'dart:async';
import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/repository/search_repository.dart';
import 'package:mi_cameo/src/models/user_model.dart';

class TalentsByCategoryBloc {
  StreamController _talentsByCategoryController;
  SearchRepository _searchRepository;

  StreamSink<ApiResponse<List<Talent>>> get talentsByCategorySink => _talentsByCategoryController.sink;
  Stream<ApiResponse<List<Talent>>> get talentsByCategoryStream => _talentsByCategoryController.stream;

  int page = 0;
  bool _loading = false;
  bool _finish = false;
  List<Talent> talents = [];

  TalentsByCategoryBloc() {
    _talentsByCategoryController = StreamController<ApiResponse<List<Talent>>>();
    _searchRepository = SearchRepository();
  }

  Future<void> fetchTalentList(String category, bool replace) async {
    if (replace) {
      page = 0;
      _finish = false;
    }
    if (page == 0) talentsByCategorySink.add(ApiResponse.loading('Cargando talentos'));
    try {
      if (!_loading && !_finish) {
        _loading = true;
        page++;
        List<Talent> talents = await _searchRepository.searchTalent(category, page);
        if (talents.length > 0) {
          if (replace) {
            this.talents = talents;
          } else {
            this.talents.addAll(talents);
          }
          talentsByCategorySink.add(ApiResponse.completed(this.talents));
        } else {
          if (page == 1) talentsByCategorySink.add(ApiResponse.completed([]));
          _finish = true;
        }
        _loading = false;
      }
    } catch (e) {
      talentsByCategorySink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _talentsByCategoryController?.close();
  }
}
