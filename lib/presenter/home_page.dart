import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_client/domain/model/repository.dart';
import 'package:github_client/data/network/github_service.dart';
import 'package:github_client/presenter/repositories_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const kRouteName = '/home';
  static const _kAppBarTitle = 'GitHub Client';
  static const _kEnterYourUserText = 'Enter your GitHub User:';
  static const _kAlertOkButtonText = 'OK';
  static const _kFloatingContinueButtonTooltip = 'Continue Button';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  bool isButtonEnabled = false;

  Future<void> _showAlert(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(HomePage._kAppBarTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(HomePage._kAlertOkButtonText),
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
    Navigator.pushNamed(
      context,
      RepositoriesPage.routeName,
      arguments: RepositoriesPageArgs(userName, repositories),
    );
  }

  void _getRepositories() {
    debugPrint('--> GET REPOS for $username');

    final Future<List<Repository>> future =
        GitHubService().fetchUserRepositories(username);
    future.then((List<Repository> repositories) {
      if (repositories == null) {
        _showAlert('Not Found', 'User $username not found!');
      } else if (repositories.isEmpty) {
        _showAlert('Warning', 'The user $username has no public repositorys!');
      } else {
        _navigateToRepositories(username, repositories);
      }
    });
  }

  bool _isUsernameValid(String userName) {
    return userName != null && userName.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage._kAppBarTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(HomePage._kEnterYourUserText),
              TextField(
                onChanged: (username) {
                  this.username = username;
                  setState(() {
                    isButtonEnabled = _isUsernameValid(username);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isButtonEnabled ? Colors.blue : Colors.grey,
        onPressed: isButtonEnabled ? _getRepositories : null,
        tooltip: HomePage._kFloatingContinueButtonTooltip,
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
