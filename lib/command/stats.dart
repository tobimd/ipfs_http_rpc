// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsStatsCommand {
  IpfsStatsCommand();

  /// Show some diagnostic information on the bitswap agent.
  /// `/api/v0/stats/bitswap`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-stats-bitswap
  Future<Map<String, dynamic>> bitswap({bool? verbose, bool? human}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/stats/bitswap",
      queryParameters: {
        if (verbose != null) "verbose": verbose,
        if (human != null) "human": human,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Print IPFS bandwidth information.
  /// `/api/v0/stats/bw`
  ///
  /// Optional arguments:
  ///   - [peerId] `String`: Specify a peer to print bandwidth for.
  ///   - [proto] `String`: Specify a protocol to print bandwidth for.
  ///   - [poll] `bool`: Print bandwidth at an interval.
  ///   - [interval] `String`: Time interval to wait between updating output, if 'poll' is true. This accepts durations such as "300s", "1.5h" or "2h45m". Valid time units are: "ns", "us" (or "µs"), "ms", "s", "m", "h". Default: 1s.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "RateIn": "<float64>",
  ///   "RateOut": "<float64>",
  ///   "TotalIn": "<int64>",
  ///   "TotalOut": "<int64>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more:
  Future<Map<String, dynamic>> bw(
      {String? peerId, String? proto, bool? poll, String? interval}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/stats/bw",
      queryParameters: {
        if (peerId != null) "peer": peerId,
        if (proto != null) "proto": proto,
        if (poll != null) "poll": poll,
        if (interval != null) "interval": interval,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Returns statistics about the node's DHT(s).
  /// `/api/v0/stats/dht`
  ///
  /// Optional argument:
  ///   - [tables] `List<String>`: The DHT whose table should be listed (wanserver, lanserver, wan, lan). wan and lan refer to client routing tables. When using the experimental DHT client only WAN is supported. Defaults to wan and lan.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Buckets": [
  ///     {
  ///       "LastRefresh": "<string>",
  ///       "Peers": [
  ///         {
  ///           "AgentVersion": "<string>",
  ///           "Connected": "<bool>",
  ///           "ID": "<string>",
  ///           "LastQueriedAt": "<string>",
  ///           "LastUsefulAt": "<string>"
  ///         }
  ///       ]
  ///     }
  ///   ],
  ///   "Name": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more:
  Future<Map<String, dynamic>> dht({List<String>? tables}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/stats/dht",
      queryParameters: {
        if (tables != null) "arg": tables.join(","),
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Returns statistics about the node's (re)provider system.
  /// `/api/v0/stats/provide`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "AvgProvideDuration": "<duration-ns>",
  ///   "LastReprovideBatchSize": "<int>",
  ///   "LastReprovideDuration": "<duration-ns>",
  ///   "TotalProvides": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-stats-provide
  Future<Map<String, dynamic>> provide() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/stats/provide");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Get stats for the currently used repo.
  /// `/api/v0/stats/repo`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-stats-repo
  Future<Map<String, dynamic>> repo({bool? sizeOnly, bool? human}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/stats/repo",
      queryParameters: {
        if (sizeOnly != null) "size-only": sizeOnly,
        if (human != null) "human": human,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
