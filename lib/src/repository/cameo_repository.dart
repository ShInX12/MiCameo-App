import 'package:mi_cameo/src/helpers/api_base_helper.dart';
import 'package:mi_cameo/src/models/cameo_model.dart';
import 'package:mi_cameo/src/preferences/user_preferences.dart';

class CameoRepository {

  final _helper = ApiBaseHelper();
  final prefs = UserPreferences();

  Future<List<Cameo>> fetchCameos() async {
    Map<String, String> headers = {'Authorization': 'Bearer ${prefs.accessToken}'};
    final List response = await _helper.get(url: 'api/orders/cameo/client', headers: headers);
    return response.map((e) => Cameo.fromJson(e)).toList();
  }

  
}