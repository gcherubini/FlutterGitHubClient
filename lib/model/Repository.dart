class Repository {
  final String title;
  final String detail;

  Repository(this.title, this.detail);

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      json['name'],
      json['description'],
    );
  }
}