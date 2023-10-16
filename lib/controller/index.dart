import 'package:test/model/populartv_model.dart';
import 'package:test/services/http/index.dart';

class PopularTVController {
  PopularTV api = PopularTV();

  PopularTVController();
  Future<List<Populartv_Model>> getPopularTv(String page) async {
    return await api.getPopularTv(page:page);
  }
  Future<List<Populartv_Model>> getPopularTvSearch(String page,String query) async {
    return await api.getPopularTvSearch(page:page,query:query);
  }
}
