// ignore_for_file: library_private_types_in_public_ap
part of ipfs_http_rpc;

class IpfsDhtCommand {
  IpfsDhtCommand();

  /// Find the multiaddresses associated with a Peer ID.
  /// `/api/v0/dht/findpeer`
  ///
  /// Arguments:
  ///   - [peerId] `String`: The ID of the peer to search for.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-findpeer
  Future<Map<String, dynamic>> findPeer(
      {required String peerId, bool? verbose}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/findpeer",
      queryParameters: {
        "arg": peerId,
        if (verbose != null) "verbose": verbose,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Find peers that can provide a specific value, given a key.
  /// `/api/v0/dht/findprovs`
  ///
  /// Arguments:
  ///   - [key] `String`: The key to find providers for.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///   - [numProviders] `int`: The number of providers to find. Default: 20.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-findprovs
  Future<Map<String, dynamic>> findProvs(
      {required String key, bool? verbose, int? numProviders}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/findprovs",
      queryParameters: {
        "arg": key,
        if (verbose != null) "verbose": verbose,
        if (numProviders != null) "num-providers": numProviders,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Given a key, query the routing system for its best value.
  /// `/api/v0/dht/get`
  ///
  /// Arguments:
  ///   - [key] `String`: The key to find providers for.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-get
  Future<Map<String, dynamic>> get({required String key, bool? verbose}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/get",
      queryParameters: {
        "arg": key,
        if (verbose != null) "verbose": verbose,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Announce to the network that you are providing given values.
  /// `/api/v0/dht/provide`
  ///
  /// Arguments:
  ///   - [key] `String`: The key[s] to send provide records for.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-provide
  Future<Map<String, dynamic>> provide(
      {required String keys, bool? verbose, bool? recursive}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/provide",
      queryParameters: {
        "arg": keys,
        if (verbose != null) "verbose": verbose,
        if (recursive != null) "recursive": recursive,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Write a key/value pair to the routing system.
  /// `/api/v0/dht/put`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to local file.
  ///   - [key] `String`: The key to store the value at.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-put
  Future<Map<String, dynamic>> put(
      {required String path, required String key, bool? verbose}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/put",
      data: await _fileFormData(path),
      queryParameters: {
        "arg": key,
        if (verbose != null) "verbose": verbose,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Find the closest Peer IDs to a given Peer ID by querying the DHT.
  /// `/api/v0/dht/query`
  ///
  /// Arguments:
  ///   - [peerId] `String`: The ID of the peer to run the query against.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Extra": "<string>",
  ///   "ID": "<peer-id>",
  ///   "Responses": [
  ///     {
  ///       "Addrs": ["<multiaddr-string>", "..."],
  ///       "ID": "peer-id"
  ///     }
  ///   ],
  ///   "Type": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-dht-query
  Future<Map<String, dynamic>> query(
      {required String peerId, bool? verbose}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/dht/query",
      queryParameters: {
        "arg": peerId,
        if (verbose != null) "verbose": verbose,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
