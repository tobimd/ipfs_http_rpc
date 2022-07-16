// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsSwarmPeeringSubcommand {
  IpfsSwarmPeeringSubcommand();

  /// Add peers into the peering subsystem.
  /// `/api/v0/swarm/peering/add`
  ///
  /// Arguments:
  ///   - [peerAddr] `String`: Address of peer to add into the peering subsystem.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "ID": "<peer-id>",
  ///   "Status": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-peering-add
  Future<Map<String, dynamic>> add({required String peerAddr}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/peering/add",
      queryParameters: {
        "arg": peerAddr,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List peers registered in the peering subsystem.
  /// `/api/v0/swarm/peering/ls`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "<peer-id>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-peering-ls
  Future<Map<String, dynamic>> ls() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/swarm/peering/ls");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove a peer from the peering subsystem.
  /// `/api/v0/swarm/peering/rm`
  ///
  /// Arguments:
  ///   - [peerId] `String`: ID of peer to remove from the peering subsystem.
  ///
  /// ```json
  /// {
  ///   "ID": "<peer-id>",
  ///   "Status": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-peering-rm
  Future<Map<String, dynamic>> rm({required String peerId}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/peering/rm",
      queryParameters: {
        "arg": peerId,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsSwarmFiltersSubcommand {
  IpfsSwarmFiltersSubcommand();

  /// Manipulate address filters.
  /// `/api/v0/swarm/filters`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-filters
  Future<Map<String, dynamic>> self() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/swarm/filters");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Add an address filter.
  /// `/api/v0/swarm/filters/add`
  ///
  /// Arguments:
  ///   - [addr] `String`: Multiaddr to filter.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-filters-add
  Future<Map<String, dynamic>> add({required String addr}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/filters/add",
      queryParameters: {
        "arg": addr,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove an address filter.
  /// `/api/v0/swarm/filters/rm`
  ///
  /// Arguments:
  ///   - [addr] `String`: Multiaddr filter to remove.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-filters-rm
  Future<Map<String, dynamic>> rm({required String addr}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/filters/rm",
      queryParameters: {
        "arg": addr,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsSwarmAddrSubcommand {
  IpfsSwarmAddrSubcommand();

  /// List known addresses. Useful for debugging.
  /// `/api/v0/swarm/addrs`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Addrs": {
  ///     "<string>": ["<string>", "..."]
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-addrs
  Future<Map<String, dynamic>> self() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/swarm/addrs");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List interface listening addresses.
  /// `/api/v0/swarm/addrs/listen`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-addrs-listen
  Future<Map<String, dynamic>> listen() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/swarm/addrs/listen");
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List local addresses.
  /// `/api/v0/swarm/addrs/local`
  ///
  /// Optional arguments:
  ///   - [id] `bool`: Show peer ID in addresses.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-addrs-local
  Future<Map<String, dynamic>> local({String? id}) async {
    Response? res = await post(Ipfs.dio,
        url: "${Ipfs.url}/swarm/addrs/local",
        queryParameters: {
          if (id != null) "id": id,
        });

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsSwarmCommand {
  final IpfsSwarmAddrSubcommand addr = IpfsSwarmAddrSubcommand();
  final IpfsSwarmFiltersSubcommand filters = IpfsSwarmFiltersSubcommand();
  final IpfsSwarmPeeringSubcommand peering = IpfsSwarmPeeringSubcommand();

  IpfsSwarmCommand();

  /// Open connection to a given address.
  /// `/api/v0/swarm/connect`
  ///
  /// Arguments:
  ///   - [peerAddr] `String`: Address of peer to connect to.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-connect
  Future<Map<String, dynamic>> connect({required String peerAddr}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/connect",
      queryParameters: {
        "arg": peerAddr,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Close connection to a given address.
  /// `/api/v0/swarm/disconnect`
  ///
  /// Arguments:
  ///   - [peerAddr] `String`: Address of peer to disconnect from.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-disconnect
  Future<Map<String, dynamic>> disconnect({required String peerAddr}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/disconnect",
      queryParameters: {
        "arg": peerAddr,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List peers with open connections.
  /// `/api/v0/swarm/peers`
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Display all extra information.
  ///   - [streams] `bool`: Also list information about open streams for each peer.
  ///   - [latency] `bool`: Also list information about latency to each peer.
  ///   - [direction] `bool`: Also list information about the direction of connection.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": [
  ///     {
  ///       "Addr": "<string>",
  ///       "Direction": "<int>",
  ///       "Latency": "<string>",
  ///       "Muxer": "<string>",
  ///       "Peer": "<string>",
  ///       "Streams": [
  ///         {
  ///           "Protocol": "<string>"
  ///         },
  ///       ]
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-peers
  Future<Map<String, dynamic>> peers(
      {bool? verbose, bool? streams, bool? latency, bool? direction}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/peers",
      queryParameters: {
        if (verbose != null) "verbose": verbose,
        if (streams != null) "streams": streams,
        if (latency != null) "latency": latency,
        if (direction != null) "direction": direction,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Get or set resource limits for a scope.
  /// `/api/v0/swarm/limit`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///   - [scope] `String`: Scope of the limit.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-limit
  Future<Map<String, dynamic>> limit(
      {required String path, required String scope}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/limit",
      data: await fileFormData(path),
      queryParameters: {
        "arg": scope,
      },
    );

    return interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Report resource usage for a scope.
  /// `/api/v0/swarm/stats`
  ///
  /// Arguments:
  ///   - [scope] `String`: Scope of the stat report.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-swarm-limit
  Future<Map<String, dynamic>> stats({required String scope}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/swarm/limit",
      queryParameters: {
        "arg": scope,
      },
    );

    return interceptDioResponse(res);
  }
}
