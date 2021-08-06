import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';

class CallApi {
  List<WallpaperModel> walpapers = [];

  getTrendingWallpapers(int pageIndex) async {
    String curatedImageUrl =
        "$baseUrl/photos/?client_id=$apikey&per_page=$perPage&orientation=$orientation&page=$pageIndex";

    var response = await http.get(Uri.parse(curatedImageUrl));

    List jsonData = jsonDecode(response.body);

    jsonData.forEach((element) {
      WallpaperModel walpaperModel = new WallpaperModel();
      walpaperModel = WallpaperModel.fromMap(element);
      walpapers.add(walpaperModel);
    });

    return walpapers;
  }

  getSearchedWallpapers(String quary, int pageIndex) async {
    String curatedImageUrl =
        "$baseUrl/search/photos/?client_id=$apikey&per_page=$perPage&orientation=$orientation&query=$quary&page=$pageIndex";

    var response = await http.get(Uri.parse(curatedImageUrl));

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData['results'].forEach((element) {
      WallpaperModel walpaperModel = new WallpaperModel();
      walpaperModel = WallpaperModel.fromMap(element);
      walpapers.add(walpaperModel);
    });
    return walpapers;
  }
}
