class TodayResp {
  List<dynamic> category;
  bool error;
  Map<String, dynamic> results;

  TodayResp(this.category, this.error, this.results);

  TodayResp.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    category = json['category'];
    results = json['results'];
  }
}
