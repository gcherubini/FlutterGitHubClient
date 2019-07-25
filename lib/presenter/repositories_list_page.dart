import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/repository.dart';
import 'package:github_client/presenter/repository_details_page.dart';

class RepositoriesPageArgs {
  final String userName;
  final List<Repository> repositories;

  RepositoriesPageArgs(this.userName, this.repositories);
}

class RepositoriesPage extends StatelessWidget {
  RepositoriesPage({Key key}) : super(key: key);

  static const routeName = '/repositoriesRoute';
  static const _appBarTitle = 'Repositories';

  void _navigateToRepositoryDetails(BuildContext context, Repository repo) {
    Navigator.pushNamed(
      context,
      RepositoryDetailsPage.kRouteName,
      arguments: repo,
    );
  }

  ListTile _buildRepositoryListTile(
      Repository repository, BuildContext context) {
    return ListTile(
      onTap: () {
        _navigateToRepositoryDetails(context, repository);
      },
      title: Text(repository.title),
    );
  }

  ListTile _buildListTile(
      BuildContext context, RepositoriesPageArgs args, int index) {
    final Repository repository = args.repositories[index];
    return _buildRepositoryListTile(repository, context);
  }

  ListView _buildListView(BuildContext context, RepositoriesPageArgs args) {
    return ListView.builder(
        itemCount: args.repositories.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildListTile(context, args, index));
  }

  @override
  Widget build(BuildContext context) {
    final RepositoriesPageArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Image.network(
                  'https://avatars.githubusercontent.com/${args.userName}',
                  width: 100.0,
                  height: 100.0,
                ),
                SizedBox(width: 20),
                Text(args.userName)
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(child: _buildListView(context, args)),
          ],
        )
        //_buildListView(context, args),
        );
  }
}
