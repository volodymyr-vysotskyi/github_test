import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test/models/commit_model.dart';
import 'package:github_test/services/http/http_commits_service.dart';
import 'package:meta/meta.dart';

abstract class CommitsEvent extends Equatable {
  const CommitsEvent();
}

class GetDefaultCommits extends CommitsEvent {
  @override
  List<Object> get props => null;
}

class GetCommitsByOwnerAndRepoName extends CommitsEvent {
  final String ownerName;
  final String repoName;

  GetCommitsByOwnerAndRepoName({@required this.ownerName, @required this.repoName});

  @override
  List<Object> get props => [ownerName, repoName];

  @override
  String toString() => 'GetCommitsByOwnerAndRepoName { ownerName: $ownerName, repoName: $repoName }';
}

abstract class CommitsState extends Equatable {
  const CommitsState();

  @override
  List<Object> get props => [];
}

class CommitsInitial extends CommitsState {}

class CommitsLoading extends CommitsState {
  final List<Commit> commits;

  const CommitsLoading({this.commits});

  CommitsLoading copyWith({List<Commit> commits}) {
    return CommitsLoading(commits: commits ?? this.commits);
  }

  @override
  List<Commit> get props => commits;

  @override
  String toString() => 'commits.length  ${commits.length} ';
}

class CommitsFailure extends CommitsState {
  final String error;

  const CommitsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CommitsFailure { error: $error }';
}

class CommitsBloc extends Bloc<CommitsEvent, CommitsState> {
  CommitsBloc({@required HttpCommitsService httpService})
      : assert(httpService != null),
        _httpService = httpService;

  final HttpCommitsService _httpService;

  @override
  CommitsState get initialState => CommitsInitial();

  @override
  Stream<CommitsState> mapEventToState(CommitsEvent event) async* {
    
    if (event is GetDefaultCommits) {
      yield* _getDefaultCommits(event);
    }

    if (event is GetCommitsByOwnerAndRepoName) {
      yield* _getCommitsByOwnerAndRepoName(event);
    }
  }

  Stream<CommitsState> _getDefaultCommits(GetDefaultCommits event) async* {
    try {
      List<Commit> commits =
          await _httpService.getCommits();
      yield CommitsLoading(commits: commits);
      return;
    } catch (error) {
      yield CommitsFailure(error: error.message);
    }
  }

  Stream<CommitsState> _getCommitsByOwnerAndRepoName(GetCommitsByOwnerAndRepoName event) async* {
    try {
      List<Commit> commits =
      await _httpService.getCommitsByOwnerAndRepoName(event.ownerName, event.repoName);
      yield CommitsLoading(commits: commits);
      return;
    } catch (error) {
      yield CommitsFailure(error: error.message);
    }
  }
}
