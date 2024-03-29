import 'dart:convert';

import 'package:github_client/domain/model/repository.dart';
import 'package:http/http.dart';

class GitHubService {
  Future<List<Repository>> fetchUserRepositories(String username) async {
    final response = await get('https://api.github.com/users/$username/repos');

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      var repositories =
          list.map((dynamic model) => Repository.fromJson(model)).toList();
      return repositories;
    } else {
      return null;
    }
  }
}
