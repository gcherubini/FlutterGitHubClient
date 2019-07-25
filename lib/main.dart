import 'package:flutter/material.dart';
import 'package:github_client/presenter/repositories_list_page.dart';
import 'package:github_client/presenter/repository_details_page.dart';
import 'package:github_client/presenter/home_page.dart';

/*
* GithubClient application
* First screen: Input Github username
* Second screen: Show user repositories_list_page.dart inside a list
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
        '/': (BuildContext context) => HomePage(),
        '/repositoriesRoute': (BuildContext context) => RepositoriesPage(),
        '/detailsRoute': (BuildContext context) => RepositoryDetailsPage(),
      },
    );
  }
}
