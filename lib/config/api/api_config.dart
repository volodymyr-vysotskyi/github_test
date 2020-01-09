class API {
  static const String BASE_URL = 'api.github.com';

  // Get Commits
  static const String GET_COMMITS_DEFAULT = '/repos/flutter/flutter/commits';
  static getCommitsByOwnerAndRepoName(String ownerName, String repoName) => '/repos/$ownerName/$repoName/commits';
}
