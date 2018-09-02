class CateResp {
  bool error;
  List<dynamic> results;

  CateResp(this.error, this.results);

  CateResp.fromJson(Map<String, dynamic> json) {
    this.error = json['error'];
    this.results = json['results'];
  }

  @override
  String toString() {
    return 'error $error,' + 'results $results';
  }
}
