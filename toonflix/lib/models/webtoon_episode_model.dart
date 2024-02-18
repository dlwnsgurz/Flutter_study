class WebtoonEpisodeModel {
  final String title, id, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : date = json["date"],
        title = json["title"],
        id = json["id"],
        rating = json["rating"];
}
