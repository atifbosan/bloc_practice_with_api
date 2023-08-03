import 'package:bloc_cfl/data/provider/network/api_endpoint.dart';
import 'package:bloc_cfl/data/provider/network/api_provider.dart';

class HomeRepository {
  late APIProvider apiProvider;

  HomeRepository() {
    apiProvider = APIProvider();
  }
  getUserProjects() async {
    Map<String, dynamic>? data = await apiProvider.baseGetAPI(
        '${APIEndpoint.getUserProjects}?BranchCode=1&UserId=2', false);
    return data;
  }

  getAllBranchList() async {
    Map<String, dynamic>? data =
        await apiProvider.baseGetAPI(APIEndpoint.getAllBranchList, false);
    return data;
  }

  getComment({required int page}) async {
    Map<String, dynamic>? data = await apiProvider.baseGetAPI(null, false,
        fullUrl: 'https://dummyjson.com/comments?skip=$page&limit=10');
    return data;
  }
}
