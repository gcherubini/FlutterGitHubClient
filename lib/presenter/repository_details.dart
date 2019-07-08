import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/Repository.dart';

class RepositoryDetails extends StatelessWidget {
  RepositoryDetails({Key key, this.title}) : super(key: key);

  static const routeName = '/detailsRoute';

  final String title;

  @override
  Widget build(BuildContext context) {
    final Repository repositoryArgs = ModalRoute.of(context).settings.arguments;
    final repositoryName = repositoryArgs.title;
    final repositoryDescription = (isValid(repositoryArgs.description))
        ? repositoryArgs.description
        : 'Repository without description';

    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            repositoryDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23.0),
          ),
        ),
      ),
    );
  }

  bool isValid(String description) {
    return description != null && description.isNotEmpty;
  }
}
