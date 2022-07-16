// ignore_for_file: equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsFilestoreCommand {
  IpfsFilestoreCommand();

  /// List blocks that are both in the filestore and standard block storage.
  /// `/api/v0/filestore/dups`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Err": "<string>",
  ///   "Ref": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-filestore-dups
  Future<Map<String, dynamic>> dups() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/filestore/dups");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List objects in filestore.
  /// `/api/v0/filestore/ls`
  ///
  /// Optional arguments:
  ///   - [cid] `String`: Cid of objects to list.
  ///   - [fileOrder] `bool`: Sort the results based on the path of the backing file.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "ErrorMsg": "<string>",
  ///   "FilePath": "<string>",
  ///   "Key": {
  ///     "/": "<cid-string>"
  ///   },
  ///   "Offset": "<uint64>",
  ///   "Size": "<uint64>",
  ///   "Status": "<int32>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-filestore-ls
  Future<Map<String, dynamic>> ls({String? cid, bool? fileOrder}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/filestore/ls",
      queryParameters: {
        if (cid != null) "arg": cid,
        if (fileOrder != null) "file-order": fileOrder,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Verify objects in filestore.
  /// `/api/v0/filestore/verify`
  ///
  /// Optional arguments:
  ///   - [cid] `String`: Cid of objects to verify.
  ///   - [fileOrder] `bool`: Sort the results based on the path of the backing file.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "ErrorMsg": "<string>",
  ///   "FilePath": "<string>",
  ///   "Key": {
  ///     "/": "<cid-string>"
  ///   },
  ///   "Offset": "<uint64>",
  ///   "Size": "<uint64>",
  ///   "Status": "<int32>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-filestore-verify
  Future<Map<String, dynamic>> verify({String? cid, bool? fileOrder}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/filestore/verify",
      queryParameters: {
        if (cid != null) "arg": cid,
        if (fileOrder != null) "file-order": fileOrder,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
