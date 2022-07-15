// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsRefsCommand {
  IpfsRefsCommand();

  /// List links (references) from an object.
  /// ` /api/v0/refs`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to the object(s) to list refs from.
  ///
  /// Optional arguments:
  ///   - [format] `String`: Emit edges with given format. Available tokens: <src> <dst> <linkname>. Default: <dst>. Default: <dst>.
  ///   - [edges] `bool`: Emit edge format: &lt;from&gt; -&gt; &lt;to&gt;.
  ///   - [unique] `bool`: Omit duplicate refs from output.
  ///   - [recursive] `bool`: Recursively list links of child nodes.
  ///   - [maxDepth] `int`: Only for recursive refs, limits fetch and listing to the given depth. Default: -1.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-refs
  Future<Map<String, dynamic>> self({
    required String path,
    String? format,
    bool? edges,
    bool? unique,
    bool? recursive,
    int? maxDepth,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/refs",
      queryParameters: {
        "arg": path,
        if (format != null) "format": format,
        if (edges != null) "edges": edges,
        if (unique != null) "unique": unique,
        if (recursive != null) "recursive": recursive,
        if (maxDepth != null) "max-depth": maxDepth,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List all local references.
  /// `/api/v0/refs/local`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-refs-local
  Future<Map<String, dynamic>> local() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/refs/local");
    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
