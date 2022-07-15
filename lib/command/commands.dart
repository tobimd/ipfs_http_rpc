// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class _IpfsCompletionSubcommand {
  _IpfsCompletionSubcommand();

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
        await post(Ipfs.dio, url: "${Ipfs.url}/commands/completion/bash");
    return interceptDioResponse(res);
  }
}

class IpfsCommandsCommand {
  /// Generate shell completions.
  final _IpfsCompletionSubcommand completion = _IpfsCompletionSubcommand();

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
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/commands",
      queryParameters: {if (flags != null) "flags": flags},
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
