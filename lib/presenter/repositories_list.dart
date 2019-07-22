import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/Repository.dart';
import 'package:github_client/presenter/repository_details.dart';

class Repositories extends StatelessWidget {
  Repositories({Key key}) : super(key: key);

  static const routeName = '/repositoriesRoute';
  static const _appBarTitle = 'Repositories';

  void _navigateToRepositoryDetails(BuildContext context, Repository repo) {
    Navigator.pushNamed(
      context,
      RepositoryDetails.routeName,
      arguments: repo,
    );
  }

  ListTile _buildListTile(BuildContext context, List<Repository> repositoryArgs, int index) {
    final Repository repository = repositoryArgs[index];
    return ListTile(
      onTap: () {
        _navigateToRepositoryDetails(context, repository);
      },
      title: Text(repository.title),
    );
  }

  ListView _buildListView(BuildContext context, List<Repository> repositoryArgs) {
    return ListView.builder(
        itemCount: repositoryArgs.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildListTile(context, repositoryArgs, index));
  }

  @override
  Widget build(BuildContext context) {
    final List<Repository> repositoryArgs =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _buildListView(context, repositoryArgs),
    );
  }
}
