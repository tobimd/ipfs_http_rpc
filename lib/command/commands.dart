// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsCompletionSubcommand {
  IpfsCompletionSubcommand();

  /// Generate bash shell completions.
  /// `/api/v0/commands/completion/bash`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-commands-completion-bash
  Future<Map<String, dynamic>> bash() async {
    Response? res =
        await _post(Ipfs.dio, url: "${Ipfs.url}/commands/completion/bash");
    return _interceptDioResponse(res);
  }
}

class IpfsCommandsCommand {
  /// Generate shell completions.
  final IpfsCompletionSubcommand completion = IpfsCompletionSubcommand();

  /// List all available commands.
  /// `/api/v0/commands`
  ///
  /// Optional arguments:
  ///   - [flags] `bool`: Show command flags.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Name": "<string>",
  ///   "Options": [
  ///     {
  ///       "Names": ["<string>", "..."]
  ///     }
  ///   ],
  ///   "Subcommands": [
  ///     {
  ///       "Name": "<string>",
  ///       "Options": [
  ///         {
  ///           "Names": ["<string>", "..."]
  ///         }
  ///       ],
  ///       "Subcommands": ["..."]
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-commands
  Future<Map<String, dynamic>> self({bool? flags}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/commands",
      queryParameters: {if (flags != null) "flags": flags},
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
