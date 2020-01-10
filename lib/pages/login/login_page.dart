import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test/bloc/commits_bloc.dart';
import 'package:github_test/bloc/nvigator_bloc.dart';
import 'package:github_test/config/api/api_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController repoNameController = TextEditingController();
  final FocusNode ownerNameFocus = FocusNode();
  final FocusNode repoNameFocus = FocusNode();
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
          'Setup repository',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: ownerNameController,
                    textInputAction: TextInputAction.next,
                    focusNode: ownerNameFocus,
                    onSubmitted: (value) {
                      _fieldFocusChange(context, ownerNameFocus, repoNameFocus);
                    },
                    onChanged: (v) => ownerNameController.value = ownerNameController.value
                        .copyWith(
                            text: v, selection: TextSelection(baseOffset: -1, extentOffset: null)),
                    decoration: InputDecoration(
                      labelText: 'Owner name',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: repoNameController,
                    textInputAction: TextInputAction.done,
                    focusNode: repoNameFocus,
                    onSubmitted: (value) => _apply(),
                    onChanged: (v) => repoNameController.value = repoNameController.value.copyWith(
                        text: v, selection: TextSelection(baseOffset: -1, extentOffset: null)),
                    decoration: InputDecoration(
                      labelText: "Repository name",
                    )),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () => _apply(),
                child: Text('Apply', style: TextStyle(color: Colors.white, fontSize: 17)),
              )
            ],
          ),
        ),
      ),
    );
  }

  _apply() {
    if (ownerNameController.text.length != 0 && repoNameController.text.length != 0) {
      commitsBloc.add(GetCommitsByOwnerAndRepoName(
          ownerName: ownerNameController.text, repoName: repoNameController.text));
      navigatorBloc.add(NavigatorBlocEvents.commits);
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
