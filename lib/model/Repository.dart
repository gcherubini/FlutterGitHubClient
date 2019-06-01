class Repository {
  final String title;

  Repository(this.title);

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      json['name'],
    );
  }
}