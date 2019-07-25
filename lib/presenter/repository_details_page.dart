import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/repository.dart';

class RepositoryDetailsPage extends StatelessWidget {
  RepositoryDetailsPage({Key key}) : super(key: key);

  static const kRouteName = '/detailsRoute';
  static const _kUnknownDescriptionText = 'Repository without description';

  bool _isDescriptionUnknown(String description) {
    return description != null && description.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final Repository repositoryArgs = ModalRoute.of(context).settings.arguments;
    final repositoryName = repositoryArgs.title;
    final repositoryDescription =
        (_isDescriptionUnknown(repositoryArgs.description))
            ? repositoryArgs.description
            : _kUnknownDescriptionText;

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
}
