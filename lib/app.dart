import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test/bloc/commits_bloc.dart';
import 'package:github_test/pages/commits/commits_page.dart';
import 'package:github_test/pages/login/login_page.dart';
import 'package:github_test/services/http/http_commits_service.dart';
import 'package:github_test/share/widgets/app_drawer.dart';

import 'bloc/nvigator_bloc.dart';

class App extends StatelessWidget {

  final List<BlocProvider> providers = [
    BlocProvider<NavigatorBloc>(create: (context) => NavigatorBloc()),
    BlocProvider<CommitsBloc>(create: (context) => CommitsBloc(httpService: HttpCommitsService()))
  ];

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: providers,
        child: Scaffold(
          appBar: AppBar(title: Text('GitHub Test')),
          drawer: AppDrawer(),
          body: BlocBuilder<NavigatorBloc, NavigatorBlocEvents>(
            builder: (context, state) {
              return _setPage(state);
            },
          ),
        ),
      );
  }

  Widget _setPage(NavigatorBlocEvents rout) {
    switch(rout) {
      case NavigatorBlocEvents.login:
        return LoginPage();
      case NavigatorBlocEvents.commits:
        return CommitsPage();
      default:
        return LoginPage();
    }
  }
}
