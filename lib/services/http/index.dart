import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/services/http/api.dart';

class PopularTV extends Api {
  PopularTV();
  final api_key = dotenv.env["API_KEY"];
  final language = dotenv.env["LANGUAGE"];
  Future<List<Populartv_Model>> getPopularTv({required String page}) async {
     final res = await Api.get("$apiUrl/3/tv/popular?api_key=$api_key&language=$language&page=$page");
    return List<Populartv_Model>.from(res.data["results"].map((x) => Populartv_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<List<Populartv_Model>> getPopularTvSearch({required String page,required String query}) async {
     final res = await Api.get("$apiUrl/3/search/tv?api_key=$api_key&language=$language&page=$page&query=$query");
    return List<Populartv_Model>.from(res.data["results"].map((x) => Populartv_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  
}
