// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsNamePubsubSubcommand {
  IpfsNamePubsubSubcommand();

  /// # [ EXPERIMENTAL ]
  ///
  /// Cancel a name subscription.
  /// `/api/v0/name/pubsub/cancel`
  ///
  /// Arguments:
  ///   - [name] `String`: Name to cancel the subscription for.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Canceled": "<bool>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-name-pubsub-cancel
  Future<Map<String, dynamic>> cancel({required String name}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/name/pubsub/cancel",
      queryParameters: {
        "arg": name,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Query the state of IPNS pubsub.
  /// `/api/v0/name/pubsub/state`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Enabled": "<bool>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-name-pubsub-state
  Future<Map<String, dynamic>> state() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/name/pubsub/state");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Show current name subscriptions.
  /// `/api/v0/name/pubsub/subs`
  ///
  /// Arguments:
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-name-pubsub-subs
  Future<Map<String, dynamic>> subs({String? ipnsBase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/name/pubsub/subs",
      queryParameters: {
        if (ipnsBase != null) "ipns-base": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsNameCommand {
  IpfsNameCommand();

  /// # [ EXPERIMENTAL ]
  ///
  /// IPNS pubsub management
  ///
  /// Manage and inspect the state of the IPNS pubsub resolver.
  /// Note: this command is experimental and subject to change as the system is refined
  final IpfsNamePubsubSubcommand pubsub = IpfsNamePubsubSubcommand();

  /// Publish IPNS names.
  /// `/api/v0/name/publish`
  ///
  /// Arguments:
  ///   - [path] `String`: IPFS path of the object to be published.
  ///
  /// Optional arguments:
  ///   - [resolve] `bool`: Check if the given path can be resolved before publishing. Default: true.
  ///   - [lifetime] `String`: Time duration that the record will be valid for. This accepts durations such as "300s", "1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h". Default: 24h.
  ///   - [allowOffline] `bool`: When offline, save the IPNS record to the the local datastore without broadcasting to the network instead of simply failing.
  ///   - [ttl] `String`: Time duration this record should be cached for. Uses the same syntax as the lifetime option. (caution: experimental).
  ///   - [key] `String`: Name of the key to be used or a valid PeerID, as listed by 'ipfs key list -l'. Default: self.
  ///   - [quieter] `bool`: Write only final hash.
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Name": "<string>",
  ///   "Value": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-name-publish
  Future<Map<String, dynamic>> publish({
    required String path,
    bool? resolve,
    String? lifetime,
    bool? alllowOffline,
    String? ttl,
    String? key,
    bool? quieter,
    String? ipnsBase,
  }) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/name/publish",
      queryParameters: {
        "arg": path,
        if (resolve != null) "resolve": resolve,
        if (lifetime != null) "lifetime": lifetime,
        if (alllowOffline != null) "allow-alllowOffline": alllowOffline,
        if (ttl != null) "ttl": ttl,
        if (key != null) "key": key,
        if (quieter != null) "quieter ": quieter,
        if (ipnsBase != null) "ipns-ipnsBase": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Resolve IPNS names.
  /// `/api/v0/name/resolve`
  ///
  /// Optional arguments:
  ///   - [name] `String`: The IPNS name to resolve. Defaults to your node's peerID.
  ///   - [recursive] `bool`: Resolve until the result is not an IPNS name. Default: true.
  ///   - [noCache] `bool`: Do not use cached entries.
  ///   - [dhtRecordCount] `int`: Number of records to request for DHT resolution.
  ///   - [dhtTimeout] `String`: Max time to collect values during DHT resolution eg "30s". Pass 0 for no timeout.
  ///   - [stream] `bool`: Stream entries as they are found.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Path": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-name-resolve
  Future<Map<String, dynamic>> resolve({
    String? name,
    bool? recursive,
    bool? noCache,
    int? dhtRecordCount,
    String? dhtTimeout,
    bool? stream,
  }) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/name/resolve",
      queryParameters: {
        if (name != null) "arg": name,
        if (recursive != null) "recursive": recursive,
        if (noCache != null) "nocache": noCache,
        if (dhtRecordCount != null) "dht-record-count": dhtRecordCount,
        if (dhtTimeout != null) "dht-dhtTimeout": dhtTimeout,
        if (stream != null) "stream": stream,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
