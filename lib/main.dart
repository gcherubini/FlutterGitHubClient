import 'package:flutter/material.dart';
import 'model/Repository.dart';
import 'network/github_service.dart';
import 'package:flutter/foundation.dart';

/*
* GithubClient application dos GURI
* First screen: input github username
* Github API = https://api.github.com/
* fetch user repos = /username/repos
* // GitHub = GET repositories with username
* Second screen: show user repositories inside a list
* // GitHub = GET repository details with repositoryID
* Third screen: show repository details
* */
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHubClient',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomeRoute(title: 'GitHub Client dos Guri'),
        "/repositoriesRoute": (context) => RepositoriesRoute(),
        '/detailsRoute': (context) => RepositoryDetailsRoute(),
      },
    );
  }
}

class MyHomeRoute extends StatefulWidget {
  MyHomeRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeRouteState createState() => _MyHomeRouteState();
}


class _MyHomeRouteState extends State<MyHomeRoute>{
  String username = "";
  bool isButtonEnabled = false;

  void _getRepositories() {
    debugPrint("--> GET REPOS for $username");

    var future = GitHubService().fetchUserRepositories(username);
    future.then((repositories) {
      if(repositories == null) {
        debugPrint("--> Some error happened");
      } else if (repositories.isEmpty) {
        debugPrint("--> User does not have repositories");
      } else {
        _navigateToRepostories(repositories);
      }
    });
  }

  void _navigateToRepostories(List<Repository> repositories) {
    debugPrint("navigateToRepositories");
    Navigator.pushNamed(
      context,
      RepositoriesRoute.routeName,
      arguments: repositories,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your GitHub User:',
            ),
            TextField(
              onChanged: (username) {
                this.username = username;
                isButtonEnabled = isValid(username);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isButtonEnabled ? Colors.blue : Colors.grey,
        onPressed: isButtonEnabled ? _getRepositories : null,
        tooltip: 'Continue',
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool isValid(String userName) {
    return userName != null && userName.isNotEmpty;
  }
}

class RepositoriesRoute extends StatelessWidget {
  RepositoriesRoute({Key key, this.title}) : super(key: key);

  final String title;

  static const routeName = '/repositoriesRoute';

  @override
  Widget build(BuildContext context) {
    final title = 'Repositories';
    final List<Repository> repositoryArgs = ModalRoute.of(context).settings.arguments;
    debugPrint("--> Repositories -> $repositoryArgs");

    Widget buildBody(int index) {
      return new Text(repositoryArgs[index].title);
    }
    ListTile getRepositoryListItem(BuildContext context, int index) {
      Repository repository = repositoryArgs[index];

      return ListTile(
        onTap: (){
          navigateToRepositoryDetails(context, repository);
        },
        title: Text(repository.title),
      );
    }


    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: new ListView.builder(
            itemCount: repositoryArgs.length,
            itemBuilder: (BuildContext context, int index) => getRepositoryListItem(context, index)
        ),
      );

  }

  void navigateToRepositoryDetails(BuildContext context, Repository repo) {
    Navigator.pushNamed(
      context,
      RepositoryDetailsRoute.routeName,
      arguments: repo,
    );
  }
}

class RepositoryDetailsRoute extends StatelessWidget {
  RepositoryDetailsRoute({Key key, this.title}) : super(key: key);

  static const routeName = '/detailsRoute';

  final String title;

  @override
  Widget build(BuildContext context) {
    final Repository repositoryArgs = ModalRoute
        .of(context)
        .settings
        .arguments;
//    final Repository repositoryArgs = Repository('title');
    final repositoryName = repositoryArgs.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryName),
      ),
      body: Text(
          'Details'
      ),
    );
  }
}

