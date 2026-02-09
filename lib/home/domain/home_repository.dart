import 'package:http/http.dart' as http;
import '../../app_configs/server_address.dart';
import '../model/menu_model.dart';
import 'api_exceptions.dart';

class HomeRepository {
  static final String _url = ServerAddresses.menuUrl;

  Future<MenuModel> fetchMenu() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return menuModelFromMap(response.body);
    } else {
      throw ApiException('Server error (${response.statusCode}). Please try again later.',);
    }
  }
}

