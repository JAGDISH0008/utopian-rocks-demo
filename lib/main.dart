import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:utopian_rocks_mobile/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_mobile/blocs/information_bloc.dart';
import 'package:utopian_rocks_mobile/components/information_drawer.dart';
import 'package:utopian_rocks_mobile/components/list_page.dart';
import 'package:utopian_rocks_mobile/models/github_api.dart';
import 'package:utopian_rocks_mobile/models/rocks_api.dart';
import 'package:utopian_rocks_mobile/providers/contribution_provider.dart';
import 'package:utopian_rocks_mobile/providers/information_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      contributionBloc: ContributionBloc(
        RocksApi(),
      ),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = ContributionProvider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Utopian Rocks Mobile',
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.rate_review),
                    text: 'Waiting for Review',
                  ),
                  Tab(
                    icon: Icon(Icons.hourglass_empty),
                    text: 'Waiting on Upvote',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ListPage('unreviewed', contributionBloc),
                ListPage('pending', contributionBloc),
              ],
            ),
            endDrawer: InformationProvider(
              informationBloc: InformationBloc(
                PackageInfo.fromPlatform(),
                GithubApi(),
              ),
              child: InformationDrawer(),
            )),
      ),
    );
  }
}
