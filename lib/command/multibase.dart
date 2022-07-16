// ignore_for_file: equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsMultibaseCommand {
  IpfsMultibaseCommand();

  /// Decode multibase string.
  /// `/api/v0/multibase/decode`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to encoded local file.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-multibase-decode
  Future<Map<String, dynamic>> decode({required String path}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/multibase/decode",
      data: await fileFormData(path),
    );

    return interceptDioResponse(res);
  }

  /// Encode data into multibase string.
  /// `/api/v0/multibase/encode`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///
  /// Optional arguments:
  ///   - [encoding] `String`: Multibase encoding. Default base64url.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-multibase-encode
  Future<Map<String, dynamic>> encode(
      {required String path, String? encoding}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/multibase/encode",
      data: await fileFormData(path),
      queryParameters: {
        if (encoding != null) "b": encoding,
      },
    );

    return interceptDioResponse(res);
  }

  /// List available multibase encodings.
  /// `/api/v0/multibase/list`
  ///
  /// Optional arguments:
  ///   - [prefix] `bool`: also include the single letter prefixes in addition to the code.
  ///   - [numeric] `bool`: also include numeric codes.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Data": [
  ///     {
  ///       "Code": "<int>",
  ///       "Name": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-multibase-list
  Future<Map<String, dynamic>> list({bool? prefix, bool? numeric}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/multibase/list",
      queryParameters: {
        if (prefix != null) "prefix": prefix,
        if (numeric != null) "numeric": numeric,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Transcode multibase string between bases.
  /// `/api/v0/multibase/transcode`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///
  /// Optional arguments:
  ///   - [encoding] `String`: Multibase encoding. Default base64url.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-multibase-transcode
  Future<Map<String, dynamic>> transcode(
      {required String path, String? encoding}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/multibase/transcode",
      data: await fileFormData(path),
      queryParameters: {
        if (encoding != null) "b": encoding,
      },
    );

    return interceptDioResponse(res);
  }
}
