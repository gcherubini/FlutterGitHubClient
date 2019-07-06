import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/Repository.dart';
import 'package:github_client/presenter/repository_details.dart';

class Repositories extends StatelessWidget {
  Repositories({Key key, this.title}) : super(key: key);

  final String title;

  static const routeName = '/repositoriesRoute';

  @override
  Widget build(BuildContext context) {
    const title = 'Repositories';
    final List<Repository> repositoryArgs =
        ModalRoute.of(context).settings.arguments;
    debugPrint('--> Repositories -> $repositoryArgs');

    Widget buildBody(int index) {
      return Text(repositoryArgs[index].title);
    }

    ListTile getRepositoryListItem(BuildContext context, int index) {
      final Repository repository = repositoryArgs[index];

      return ListTile(
        onTap: () {
          navigateToRepositoryDetails(context, repository);
        },
        title: Text(repository.title),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: repositoryArgs.length,
          itemBuilder: (BuildContext context, int index) =>
              getRepositoryListItem(context, index)),
    );
  }

  void navigateToRepositoryDetails(BuildContext context, Repository repo) {
    Navigator.pushNamed(
      context,
      RepositoryDetails.routeName,
      arguments: repo,
    );
  }
}
