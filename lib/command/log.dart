// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsLogCommand {
  IpfsLogCommand();

  /// Change the logging level.
  /// `/api/v0/log/level`
  ///
  /// Arguments:
  ///   - [id] `String`: The subsystem logging identifier. Use 'all' for all subsystems.
  ///   - [level] `String`: The log level, with 'debug' the most verbose and 'fatal' the least verbose. One of: debug, info, warn, error, dpanic, panic, fatal.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Message": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-log-level
  Future<Map<String, dynamic>> level(
      {required String id, required String level}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/log/level",
      queryParameters: {
        "arg": id,
        "arg": level,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List the logging subsystems.
  /// `/api/v0/log/ls`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Strings": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-log-ls
  Future<Map<String, dynamic>> ls() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/log/ls");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Read the event log.
  /// `/api/v0/log/tail`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Text": "<text/plain response>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-log-tail
  Future<Map<String, dynamic>> tail() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/tail");
    return _interceptDioResponse(res);
  }
}
