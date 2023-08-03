import 'package:bloc_cfl/data/provider/network/api_endpoint.dart';
import 'package:bloc_cfl/data/provider/network/api_provider.dart';

class AuthRepository {
  late APIProvider _apiProvider;

  AuthRepository() {
    _apiProvider = APIProvider();
  }

  login({required String username, required String password}) async {
    Map<String, dynamic>? map = await _apiProvider.baseGetAPI(
        "${APIEndpoint.login}?Username=$username&Password=$password&BranchCode=1",
        false);
    return map;
  }
}
