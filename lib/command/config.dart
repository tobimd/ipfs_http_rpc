// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class _IpfsProfileSubcommand {
  _IpfsProfileSubcommand();

  /// Apply profile to config.
  /// `/api/v0/config/profile/apply`
  ///
  /// Arguments:
  ///   - [profile] `String`: The profile to apply to the config.
  ///
  /// Optional arguments:
  ///   - [dryRun] `bool`: Print difference between the current config and the config that would be generated.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "NewCfg": {
  ///     "<string>": "<object>"
  ///   },
  ///   "OldCfg": {
  ///     "<string>": "<object>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-config-profile-apply
  Future<Map<String, dynamic>> function(
      {required String profile, bool? dryRun}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/config/profile/apply",
      queryParameters: {
        "arg": profile,
        if (dryRun != null) "dry-run": dryRun,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsConfigCommand {
  /// Apply profiles to config.
  final _IpfsProfileSubcommand profile = _IpfsProfileSubcommand();

  IpfsConfigCommand();

  /// Get and set IPFS config values.
  /// `/api/v0/config`
  ///
  /// Arguments:
  ///   - [key] `String`: The key to the config entry (e.g. "Addresses.API").
  ///
  /// Optional arguments:
  ///   - [value] `String`: The value to set the config entry to.
  ///   - [setBool] `bool`: Set a boolean value.
  ///   - [json] `bool`: Parse stringified JSON.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Key": "<string>",
  ///   "Value": "<object>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-config
  Future<Map<String, dynamic>> self(
      {required String key, String? value, bool? setBool, bool? json}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/config",
      queryParameters: {
        "arg": key,
        if (value != null) "arg": value,
        if (setBool != null) "bool": setBool,
        if (json != null) "json": json,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Open the config file for editing in $EDITOR.
  /// `/api/v0/config/edit`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-config-edit
  Future<Map<String, dynamic>> edit() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/config/edit");
    return interceptDioResponse(res);
  }

  /// Replace the config with <file>.
  /// `/api/v0/config/replace`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-config-replace
  Future<Map<String, dynamic>> replace({required String path}) async {
    Response? res = await post(Ipfs.dio,
        url: "${Ipfs.url}/config/replace", data: await fileFormData(path));
    return interceptDioResponse(res);
  }

  /// Output config file contents.
  /// `/api/v0/config/show`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "<string>": "<object>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-config-show
  Future<Map<String, dynamic>> show() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/config/show");
    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
