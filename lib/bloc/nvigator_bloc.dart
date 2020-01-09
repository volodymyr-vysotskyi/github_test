import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigatorBlocEvents {
  login,
  commits
}

class NavigatorBloc extends Bloc<NavigatorBlocEvents, NavigatorBlocEvents> {
  @override
  NavigatorBlocEvents get initialState => NavigatorBlocEvents.login;

  @override
  Stream<NavigatorBlocEvents> mapEventToState(NavigatorBlocEvents event) async* {
    switch(event) {
      case NavigatorBlocEvents.login:
        yield NavigatorBlocEvents.login;
        break;
      case NavigatorBlocEvents.commits:
        yield NavigatorBlocEvents.commits;
    }

  }

}
