// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsPubsubCommand {
  IpfsPubsubCommand();

  /// # [ EXPERIMENTAL ]
  ///
  /// List subscribed topic by name.
  /// `/api/v0/pubsub/ls`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pubsub-ls
  Future<Map<String, dynamic>> ls() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/pupsub/ls");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// List peers we are currently pubsubbing with.
  /// `/api/v0/pubsub/peers`
  ///
  /// Optional arguments:
  ///   - [topic] `String`: Topic to list connected peers of.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pubsub-peers
  Future<Map<String, dynamic>> peers({String? topic}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pubsub/peers",
      queryParameters: {
        if (topic != null) "arg": topic,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Publish data to a given pubsub topic.
  /// `/api/v0/pubsub/pub`
  ///
  /// Arguments:
  ///   - [topic] `String`: Topic to publish to (multibase encoded when sent over HTTP RPC).
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pubsub-pub
  Future<Map<String, dynamic>> pub(
      {required String topic, required String path}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pubsub/pub",
      data: await fileFormData(path),
      queryParameters: {
        "arg": topic,
      },
    );

    return interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Subscribe to messages on a given topic.
  /// `/api/v0/pubsub/sub`
  ///
  /// Arguments:
  ///   - [topic] `String`: Topic to publish to (multibase encoded when sent over HTTP RPC).
  ///
  /// Response:
  /// ```json
  /// {
  ///   "data": "<string>",
  ///   "from": "<string>",
  ///   "seqno": "<string>",
  ///   "topicIDs": [
  ///     "<string>"
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pubsub-sub
  Future<Map<String, dynamic>> sub({required String topic}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pubsub/sub",
      queryParameters: {
        "arg": topic,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
