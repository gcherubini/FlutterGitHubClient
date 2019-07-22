import 'package:flutter/material.dart';
import 'package:github_client/presenter/repositories_list.dart';
import 'package:github_client/presenter/repository_details.dart';
import 'package:github_client/presenter/home.dart';

/*
* GithubClient application
* First screen: Input Github username
* Second screen: Show user repositories_list.dart inside a list
* Third screen: Show repository details
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
        '/': (BuildContext context) => Home(title: 'GitHub Client'),
        '/repositoriesRoute': (BuildContext context) => RepositoriesPage(),
        '/detailsRoute': (BuildContext context) => RepositoryDetails(),
      },
    );
  }
}
