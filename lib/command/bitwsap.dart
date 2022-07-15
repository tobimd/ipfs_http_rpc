// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsBitswapCommand {
  IpfsBitswapCommand();

  /// Show the current ledger for a peer.
  /// `/api/v0/bitswap/ledger`
  ///
  /// Arguments:
  ///   - [peerId] `String`: The PeerID (B58) of the ledger to inspect.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Exchanged": "<uint64>",
  ///   "Peer": "<string>",
  ///   "Recv": "<uint64>",
  ///   "Sent": "<uint64>",
  ///   "Value": "<float64>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bitswap-ledger
  Future<Map<String, dynamic>> ledger({required String peerId}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/bitwsap/ledger",
      queryParameters: {
        "arg": peerId,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Trigger reprovider.
  /// `/api/v0/bitswap/reprovide`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bitswap-reprovide
  Future<Map<String, dynamic>> reprovide() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/bitswap/reprovide");
    return interceptDioResponse(res);
  }

  /// Show some diagnostic information on the bitswap agent.
  /// `/api/v0/bitswap/stat`
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///   - [human] `bool`: Print sizes in human readable format (e.g., 1K 234M 2G).
  ///
  /// Response:
  /// ```json
  /// {
  ///   "BlocksReceived": "<uint64>",
  ///   "BlocksSent": "<uint64>",
  ///   "DataReceived": "<uint64>",
  ///   "DataSent": "<uint64>",
  ///   "DupBlksReceived": "<uint64>",
  ///   "DupDataReceived": "<uint64>",
  ///   "MessagesReceived": "<uint64>",
  ///   "Peers": ["<string>", "..."],
  ///   "ProvideBufLen": "<int>",
  ///   "Wantlist": [
  ///     {
  ///       "/": "<cid-string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bitswap-stat
  Future<Map<String, dynamic>> stat({bool? verbose, bool? human}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/bitswap/stat",
      queryParameters: {
        if (verbose != null) "verbose": verbose,
        if (human != null) "human": human,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Show blocks currently on the wantlist.
  /// `/api/v0/bitswap/wantlist`
  ///
  /// Optional arguments:
  ///   - [peerId] `String`: Specify which peer to show wantlist for.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Keys": [
  ///     {
  ///       "/": "<cid-string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bitswap-wantlist
  Future<Map<String, dynamic>> wantList({String? peerId}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/bitswap/wantlist",
      queryParameters: {
        if (peerId != null) "peer": peerId,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
