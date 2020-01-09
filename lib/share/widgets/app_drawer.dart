import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test/bloc/nvigator_bloc.dart';
import 'package:github_test/pages/Login/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    TextStyle title = TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
    TextStyle text = TextStyle(color: Colors.black, fontSize: 20);

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('GitHub Test', style: title),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Setup repository', style: text,),
            onTap: () {
              navigatorBloc.add(NavigatorBlocEvents.login);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Commits', style: text,),
            onTap: () {
              navigatorBloc.add(NavigatorBlocEvents.commits);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
