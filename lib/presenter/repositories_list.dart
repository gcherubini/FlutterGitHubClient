import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/Repository.dart';
import 'package:github_client/presenter/repository_details.dart';

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
      RepositoryDetails.routeName,
      arguments: repo,
    );
  }

  ListTile _buildHeaderListTile(RepositoriesPageArgs args) {
    return ListTile(
      title: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(children: <Widget>[
            Image.network(
              'https://avatars.githubusercontent.com/${args.userName}',
              scale: 4.0,
            ),
            SizedBox(width: 20),
            Text(args.userName)
          ],
          ),
          SizedBox(height: 20),
          Divider()
        ],
      ),
    );
  }

  ListTile _buildRepositoryListTile(Repository repository, BuildContext context) {
    return ListTile(
      onTap: () {
        _navigateToRepositoryDetails(context, repository);
      },
      title: Text(repository.title),
    );
  }

  bool _isHeaderPosition(int index) => index == 0;

  ListTile _buildListTile(BuildContext context, RepositoriesPageArgs args, int index) {
    if(_isHeaderPosition(index)) {
      return _buildHeaderListTile(args);
    } else {
      final Repository repository = args.repositories[index - 1];
      return _buildRepositoryListTile(repository, context);
    }
  }

  ListView _buildListView(BuildContext context, RepositoriesPageArgs args) {
    return ListView.builder(
        itemCount: args.repositories.length + 1,
        itemBuilder: (BuildContext context, int index) =>
            _buildListTile(context, args, index));
  }

  @override
  Widget build(BuildContext context) {
    final RepositoriesPageArgs args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _buildListView(context, args),
    );
  }
}
