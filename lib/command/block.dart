// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsBlockCommand {
  IpfsBlockCommand();

  /// Get a raw IPFS block.
  /// `/api/v0/block/get`
  ///
  /// Arguments:
  ///   - [blockCid] `String`: The CID of an existing block to get.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-block-get
  Future<Map<String, dynamic>> get({required String blockCid}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/block/get",
      queryParameters: {
        "arg": blockCid,
      },
    );

    return interceptDioResponse(res);
  }

  /// Store input as an IPFS block.
  /// `/api/v0/block/put`
  ///
  /// Optional arguments:
  ///   - [cidCodec] `String`: Multicodec to use in returned CID. Default: raw.
  ///   - [mhtype] `String`: Multihash hash function. Default: sha2-256.
  ///   - [mhlen] `int`: Multihash hash length. Default: -1.
  ///   - [pin] `bool`: Pin added blocks recursively. Default: false.
  ///   - [allowBigBlock] `bool`: Disable block size check and allow creation of blocks bigger than 1MiB. WARNING: such blocks won't be transferable over the standard bitswap. Default: false
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Key": "<string>",
  ///   "Size": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-block-put
  Future<Map<String, dynamic>> put(
      {String? cidCodec,
      String? mhtype,
      int? mhlen,
      bool? pin,
      bool? allowBigBlock}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/block/put",
      queryParameters: {
        if (cidCodec != null) "cid-codec": cidCodec,
        if (mhtype != null) "mhtype": mhtype,
        if (mhlen != null) "mhlen": mhlen,
        if (pin != null) "pin": pin,
        if (allowBigBlock != null) "allow-big-block": allowBigBlock,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove IPFS block(s) from the local datastore.
  /// `/api/v0/block/rm`
  ///
  /// Arguments:
  ///   - [blockCid] `String`: CIDs of block(s) to remove.
  ///
  /// Optional arguments:
  ///   - [force] `bool`: Ignore nonexistent blocks.
  ///   - [quiet] `bool`: Write minimal output.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Error": "<string>",
  ///   "Hash": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-block-rm
  Future<Map<String, dynamic>> rm(
      {required String blockCid, bool? force, bool? quiet}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/block/rm",
      queryParameters: {
        "arg": blockCid,
        if (force != null) "force": force,
        if (quiet != null) "quiet": quiet,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Print information of a raw IPFS block.
  /// `/api/v0/block/stat`
  ///
  /// Arguments:
  ///   - [blockCid] `String`: The CID of an existing block to stat.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Key": "<string>",
  ///   "Size": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-block-stat
  Future<Map<String, dynamic>> stat({required String blockCid}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/block/stat",
      queryParameters: {"arg": blockCid},
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
