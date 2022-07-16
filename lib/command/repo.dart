// ignore_for_file: equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsRepoCommand {
  IpfsRepoCommand();

  /// Perform a garbage collection sweep on the repo.
  /// `/api/v0/repo/gc`
  ///
  /// Optional arguments:
  ///   - [streamErrors] `bool`: Stream errors.
  ///   - [quiet] `bool`: Write minimal output.
  ///   - [silent] `bool`: Write no output.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Error": "<string>",
  ///   "Key": {
  ///     "/": "<cid-string>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-repo-gc
  Future<Map<String, dynamic>> gc(
      {bool? streamErrors, bool? quiet, bool? silent}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/repo/gc",
      queryParameters: {
        if (streamErrors != null) "stream-errors": streamErrors,
        if (quiet != null) "quiet": quiet,
        if (silent != null) "silent": silent,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Get stats for the currently used repo.
  /// `/api/v0/repo/stat`
  ///
  /// Optional arguments:
  ///   - [sizeOnly] `bool`: Only report RepoSize and StorageMax.
  ///   - [human] `bool`: Print sizes in human readable format (e.g., 1K 234M 2G).
  ///
  /// Response:
  /// ```json
  /// {
  ///   "NumObjects": "<uint64>",
  ///   "RepoPath": "<string>",
  ///   "SizeStat": {
  ///     "RepoSize": "<uint64>",
  ///     "StorageMax": "<uint64>"
  ///   },
  ///   "Version": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-repo-stat
  Future<Map<String, dynamic>> stat({bool? sizeOnly, bool? human}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/repo/stat",
      queryParameters: {
        if (sizeOnly != null) "size-only": sizeOnly,
        if (human != null) "human": human,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Verify all blocks in repo are not corrupted.
  /// `/api/v0/repo/verify`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Msg": "<string>",
  ///   "Progress": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-repo-verify
  Future<Map<String, dynamic>> verify() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/repo/verify");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Show the repo version.
  /// `/api/v0/repo/version`
  ///
  /// Optional arguments:
  ///   - [quiet] `bool`: Write minimal output.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Version": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-repo-version
  Future<Map<String, dynamic>> version({bool? quiet}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/repo/version",
      queryParameters: {
        if (quiet != null) "quiet": quiet,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
