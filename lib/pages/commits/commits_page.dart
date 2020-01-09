import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test/bloc/commits_bloc.dart';
import 'package:github_test/bloc/nvigator_bloc.dart';
import 'package:github_test/models/commit_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitsPage extends StatefulWidget {
  @override
  _CommitsPageState createState() => _CommitsPageState();
}

class _CommitsPageState extends State<CommitsPage> {
  CommitsBloc commitsBloc;
  NavigatorBloc navigatorBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    commitsBloc = BlocProvider.of<CommitsBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Commits page',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: BlocBuilder<CommitsBloc, CommitsState>(
          builder: (context, state) {
            if (state is CommitsFailure) {
//              return Center(
//                child: Text('${state.error.toString()}',
//                    style: TextStyle(fontSize: 30, color: Colors.blue)),
//              );

              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${state.error.toString()}',
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        navigatorBloc.add(NavigatorBlocEvents.login);
                      },
                      child: Text('Try again', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              );
            }

            if (state.props.length == 0) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'In order for you to see the commits, you need to enter the name of the owner of the repository, and the name of the repository, on the repository settings page',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        navigatorBloc.add(NavigatorBlocEvents.login);
                      },
                      child: Text('To setup page', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              );
            }

            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Commit commit = state.props[index];
                  TextStyle titleStyle = TextStyle(fontSize: 22, color: Colors.white);
                  TextStyle textStyle = TextStyle(fontSize: 15, color: Colors.black);

                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text(
                              '${commit.author.name}',
                              style: titleStyle,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text('email: ${commit.author.email}'),
                          ),
                          ListTile(
                            leading: Icon(Icons.date_range),
                            title: Text('date: ${commit.author.date}'),
                          ),
                          ListTile(
                              leading: Icon(Icons.message),
                              title: Text('message: ${commit.message}')),
                          ListTile(
                            leading: Icon(Icons.link),
                            title: InkWell(
                              child: Text('repository link', style: textStyle),
                              onTap: () async {
                                String url = commit.htmlUrl;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.props.length,
              ),
            );
          },
        ));
  }
}
