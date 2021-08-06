class WallpaperModel {
  String? id;
  SrcModel? src;

  WallpaperModel({this.id, this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      id: jsonData["id"],
      src: SrcModel.fromMap(jsonData["urls"]),
    );
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;
  SrcModel({this.original, this.small, this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        original: jsonData["regular"],
        small: jsonData["small"],
        portrait: jsonData["thumb"]);
  }
}
