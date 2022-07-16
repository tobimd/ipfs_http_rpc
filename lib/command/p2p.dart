// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsP2pStreamSubcommand {
  IpfsP2pStreamSubcommand();

  /// # [ EXPERIMENTAL ]
  ///
  /// Close active p2p stream.
  /// `/api/v0/p2p/stream/close`
  ///
  /// Optional arguments:
  ///   - [streamId] `String`: Stream identifier.
  ///   - [all] `bool`: Close all streams.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-stream-close
  Future<Map<String, dynamic>> close({String? streamId, bool? all}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/stream/close",
      queryParameters: {
        if (streamId != null) "arg": streamId,
        if (all != null) "all": all,
      },
    );
    return _interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  ///List active p2p streams.
  /// `/api/v0/p2p/stream/ls`
  ///
  /// Optional arguments:
  ///   - [headers] `bool`: Print table headers (ID, Protocol, Local, Remote).
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Streams": [
  ///     {
  ///       "HandlerID": "<string>",
  ///       "OriginAddress": "<string>",
  ///       "Protocol": "<string>",
  ///       "TargetAddress": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-stream-ls
  Future<Map<String, dynamic>> ls({bool? headers}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/stream/ls",
      queryParameters: {
        if (headers != null) "headers": headers,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsP2pCommand {
  final IpfsP2pStreamSubcommand x = IpfsP2pStreamSubcommand();
  IpfsP2pCommand();

  /// # [ EXPERIMENTAL ]
  ///
  /// Stop listening for new connections to forward.
  /// `/api/v0/p2p/close`
  ///
  /// Optional arguments:
  ///   - [all] `bool`: Close all listeners.
  ///   - [protocol] `String`: Match protocol name.
  ///   - [listenAddress] `String`: Match listen address.
  ///   - [targetAddress] `String`: Match target address.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Data": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-close
  Future<Map<String, dynamic>> close(
      {bool? all,
      String? protocol,
      String? listenAddress,
      String? targetAddress}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/close",
      queryParameters: {
        if (all != null) "all": all,
        if (protocol != null) "protocol": protocol,
        if (listenAddress != null) "listen-address": listenAddress,
        if (targetAddress != null) "target-address": targetAddress,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// # [ EXPERIMENTAL ]
  ///
  //  Forward connections to lib2p2 service.
  /// `/api/v0/p2p/forward`
  ///
  /// Arguments:
  ///   - [protocol] `String`: Protocol name.
  ///   - [listen] `String`: Listening endpoint.
  ///   - [target] `String`: Target endpoint.
  ///
  /// Optional arguments:
  ///   - [allowCustomProtocol] `bool`: Dont require /x/ prefix.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-forward
  Future<Map<String, dynamic>> forward(
      {required String protocol,
      required String listen,
      required String target,
      bool? allowCustomProtocol}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/forward",
      queryParameters: {
        "arg": protocol,
        "arg": listen,
        "arg": target,
        if (allowCustomProtocol != null)
          "allow-custom-protocol": allowCustomProtocol,
      },
    );

    return _interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Create libp2p service.
  /// `/api/v0/p2p/listen`
  ///
  /// Arguments:
  ///   - [protocol] `String`: Protocol name.
  ///   - [target] `String`: Target endpoint.
  ///
  /// Optional arguments:
  ///   - [allowCustomProtocol] `bool`: Dont require /x/ prefix.
  ///   - [reportPeerId] `bool`: Send remote base58 peerId to target when a new connection is established.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-listen
  Future<Map<String, dynamic>> listen(
      {required String protocol,
      required String target,
      bool? allowCustomProtocol,
      bool? reportPeerId}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/listen",
      queryParameters: {
        "arg": protocol,
        "arg": target,
        if (allowCustomProtocol != null)
          "allow-custom-protocol": allowCustomProtocol,
        if (reportPeerId != null) "report-peer-id": reportPeerId,
      },
    );

    return _interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// List active p2p listeners.
  /// `/api/v0/p2p/ls`
  ///
  /// Optional arguments:
  ///   - [headers] `bool`: Print table headers (Protocol, Listen, Target).
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Listeners": [
  ///     {
  ///       "ListenAddress": "<string>",
  ///       "Protocol": "<string>",
  ///       "TargetAddress": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-p2p-ls
  Future<Map<String, dynamic>> ls({bool? headers}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/p2p/ls",
      queryParameters: {
        if (headers != null) "headers": headers,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
