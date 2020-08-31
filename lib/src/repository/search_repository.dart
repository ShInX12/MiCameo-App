import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/talent_search_model.dart';
import 'package:mi_cameo/src/models/user_model.dart';

class SearchRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  bool next = true;
  Map mapResponse = {};

  Future<List<Talent>> searchTalent(String keyword, int page) async {
    if (page == 1) next = true;
    if (next) {
      mapResponse = await _helper.get(
        url: 'api/talents/',
        params: {'search': keyword, 'page': '$page'},
      );
      final response = TalentSearchResponse.fromJson(mapResponse);
      if (response.links.next == null) this.next = false;
      return TalentSearchResponse.fromJson(mapResponse).talents;
    }
    return [];
  }
}
