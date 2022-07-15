// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsDagCommand {
  IpfsDagCommand();

  /// Streams the selected DAG as a .car stream on stdout.
  /// `/api/v0/dag/export`
  ///
  /// Arguments:
  ///   - [cid] `String`: CID of a root to recusively export.
  ///
  /// Optional arguments:
  ///   - [progress] `bool`: Display progress on CLI.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-export
  Future<Map<String, dynamic>> export(
      {required String cid, bool? progress}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dag/export",
      queryParameters: {
        "arg": cid,
        if (progress != null) "progress": progress,
      },
    );

    return interceptDioResponse(res);
  }

  /// Get a DAG node from IPFS.
  /// `/api/v0/dag/get`
  ///
  /// Arguments:
  ///   - [object] `String`: The object to get.
  ///
  /// Optional arguments:
  ///   - [outputCodec] `String`: Format that the object will be encoded as. Default: dag-json.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-get
  Future<Map<String, dynamic>> get(
      {required String object, String? outputCodec}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dag/get",
      queryParameters: {
        "arg": object,
        if (outputCodec != null) "output-codec": outputCodec,
      },
    );

    return interceptDioResponse(res);
  }

  /// Import the contents of .car files
  /// `/api/v0/dag/import`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///
  /// Optional arguments:
  ///   - [pinRoots] `bool`: Pin optional roots listed in the .car headers after importing. Default: true.
  ///   - [silent] `bool`: No output.
  ///   - [stats] `bool`: Output stats.
  ///   - [allowBigBlock] `bool`: Disable block size check and allow creation of blocks bigger than 1MiB. WARNING: such blocks won't be transferable over the standard bitswap. Default: false.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Root": {
  ///     "Cid": {
  ///       "/": "<cid-string>"
  ///     },
  ///     "PinErrorMsg": "<string>"
  ///   },
  ///   "Stats": {
  ///     "BlockBytesCount": "<uint64>",
  ///     "BlockCount": "<uint64>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-import
  Future<Map<String, dynamic>> import(
      {required String path,
      bool? pinRoots,
      bool? silent,
      bool? stats,
      bool? allowBigBlock}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dag/import",
      data: await fileFormData(path),
      queryParameters: {
        if (pinRoots != null) "pin-roots": pinRoots,
        if (silent != null) "silent": silent,
        if (stats != null) "stats": stats,
        if (allowBigBlock != null) "allow-big-block": allowBigBlock,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Add a DAG node to IPFS.
  /// `/api/v0/dag/put`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///
  /// Optional arguments:
  ///   - [storeCodec] `String`: Codec that the stored object will be encoded with. Default: dag-cbor.
  ///   - [inputCodec] `String`: Codec that the input object is encoded in. Default: dag-json.
  ///   - [pin] `bool`: Pin this object when adding.
  ///   - [hash] `String`: Hash function to use.
  ///   - [allowBigBlock] `bool`: Disable block size check and allow creation of blocks bigger than 1MiB. WARNING: such blocks won't be transferable over the standard bitswap. Default: false.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Cid": {
  ///     "/": "<cid-string>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-put
  Future<Map<String, dynamic>> put(
      {required String path,
      String? storeCodec,
      String? inputCodec,
      bool? pin,
      String? hash,
      bool? allowBigBlock}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dat/put",
      data: await fileFormData(path),
      queryParameters: {
        if (storeCodec != null) "store-codec": storeCodec,
        if (inputCodec != null) "input-codec": inputCodec,
        if (pin != null) "pin": pin,
        if (hash != null) "hash": hash,
        if (allowBigBlock != null) "allow-big-block": allowBigBlock,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Resolve IPLD block.
  /// `/api/v0/dag/resolve`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///
  /// Response:
  /// ```json
  /// {
  ///
  ///   "Cid": {
  ///     "/": "<cid-string>"
  ///   },
  ///   "RemPath": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-resolve
  Future<Map<String, dynamic>> resolve({required String path}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dag/resolve",
      queryParameters: {
        "arg": path,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Gets stats for a DAG.
  /// `/api/v0/dag/stat`
  ///
  /// Arguments:
  ///   - [cid] `String`: CID of a DAG root to get statistics for
  ///
  /// Optional arguments:
  ///   - [progress] `bool`: Return progressive data while reading through the DAG. Default: true.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "NumBlocks": "<int64>",
  ///   "Size": "<uint64>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dag-stat
  Future<Map<String, dynamic>> stat(
      {required String cid, bool? progress}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/dag/stat",
      queryParameters: {
        "arg": cid,
        if (progress != null) "progress": progress,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
