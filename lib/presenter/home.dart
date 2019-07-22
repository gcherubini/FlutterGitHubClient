import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/Repository.dart';
import 'package:github_client/data/network/github_service.dart';
import 'package:github_client/presenter/repositories_list.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';
  bool isButtonEnabled = false;

  void _getRepositories() {
    debugPrint('--> GET REPOS for $username');

    final Future<List<Repository>> future =
        GitHubService().fetchUserRepositories(username);
    future.then((List<Repository> repositories) {
      if (repositories == null) {
        _showingError('Error', 'User $username not found!');
      } else if (repositories.isEmpty) {
        _showingError(
            'Warning', 'The user $username has no public repositorys!');
      } else {
        _navigateToRepositories(username, repositories);
      }
    });
  }

  Future<void> _showingError(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToRepositories(String userName, List<Repository> repositories) {
    debugPrint('navigateToRepositories');
    Navigator.pushNamed(
      context,
      RepositoriesPage.routeName,
      arguments: RepositoriesPageArgs(userName, repositories),
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
                setState(() {
                  isButtonEnabled = isValid(username);
                });
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
