// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsVersionCommand {
  IpfsVersionCommand();

  /// Show IPFS version information.
  /// `/api/v0/version`
  ///
  /// Optional arguments:
  ///   - [number] `bool`: Only show the version number.
  ///   - [commit] `bool`: Show the commit hash.
  ///   - [repo] `bool`: Show repo version.
  ///   - [all] `bool`: Show all version information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Commit": "<string>",
  ///   "Golang": "<string>",
  ///   "Repo": "<string>",
  ///   "System": "<string>",
  ///   "Version": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-version
  Future<Map<String, dynamic>> self(
      {bool? number, bool? commit, bool? repo, bool? all}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/version",
      queryParameters: {
        if (number != null) "number": number,
        if (commit != null) "commit": commit,
        if (repo != null) "repo": repo,
        if (all != null) "all": all,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Shows information about dependencies used for build.
  /// `/api/v0/version/deps`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Path": "<string>",
  ///   "ReplacedBy": "<string>",
  ///   "Sum": "<string>",
  ///   "Version": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-version-deps
  Future<Map<String, dynamic>> deps() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/version/deps");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
