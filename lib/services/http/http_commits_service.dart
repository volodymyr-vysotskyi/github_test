import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_test/config/api/api_config.dart';
import 'package:github_test/models/commit_model.dart';
import 'package:github_test/services/network/network_service.dart';
import 'package:http/http.dart' as http;

class HttpCommitsService {
  @protected
  final NetworkService networkService = NetworkService(http.Client());

  Future<List<Commit>> getCommits() async {
    List<Commit> result = [];

    final response = await networkService.get(API.GET_COMMITS_DEFAULT, 'getCommits');
    var responseBody = json.decode(response.body);
    if (responseBody == null || response.statusCode != 200) {
      throw new Exception([responseBody]);
    }

    responseBody.forEach((item) {
      Commit commit = Commit.fromJson(item['commit']);
      commit.htmlUrl = item['html_url'];
      result.add(commit);
    });

    return result;
  }

  Future<List<Commit>> getCommitsByOwnerAndRepoName(String ownerName, String repoName) async {
    List<Commit> result = [];

    final response = await networkService.get(API.getCommitsByOwnerAndRepoName(ownerName, repoName), 'getCommitsByOwnerAndRepoName');
    var responseBody = json.decode(response.body);
    if (responseBody == null || response.statusCode != 200) {
      throw new Exception(responseBody['message']);
    }

    responseBody.forEach((item) {
      Commit commit = Commit.fromJson(item['commit']);
      commit.htmlUrl = item['html_url'];
      result.add(commit);
    });

    return result;
  }
}
