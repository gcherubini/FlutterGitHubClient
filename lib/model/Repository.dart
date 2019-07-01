class Repository {
  final String title;
  final String description;

  Repository(this.title, this.description);

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      json['name'],
      json['description'],
    );
  }
}