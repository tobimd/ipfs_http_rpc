// ignore_for_file: library_private_types_in_public_api
part of ipfs_http_rpc;

class IpfsBootstrapAddSubcommand {
  IpfsBootstrapAddSubcommand();

  /// Add peers to the bootstrap list.
  /// `/api/v0/bootstrap/add`
  ///
  /// Optional arguments:
  ///   - [peerId] `String`: A peer to add to the bootstrap list (in the format '<multiaddr>/<peerID>').
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bootstrap-add
  Future<Map<String, dynamic>> self({String? peerId}) async {
    Response? res = await _post(Ipfs.dio,
        url: "${Ipfs.url}/bootstrap/add",
        queryParameters: {
          if (peerId != null) "arg": peerId,
        });
    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Add default peers to the bootstrap list.
  /// `/api/v0/bootstrap/add/default`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bootstrap-add-default
  Future<Map<String, dynamic>> defaults() async {
    Response? res =
        await _post(Ipfs.dio, url: "${Ipfs.url}/bootstrap/add/default");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsBootstrapRmSubcommand {
  IpfsBootstrapRmSubcommand();

  /// Remove peers from the bootstrap list.
  /// `/api/v0/bootstrap/rm`
  ///
  /// Optional arguments:
  ///   - [peerId] `String`: A peer to add to the bootstrap list (in the format '<multiaddr>/<peerID>').
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bootstrap-rm
  Future<Map<String, dynamic>> self({String? peerId}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/bootstrap/rm",
      queryParameters: {
        if (peerId != null) "arg": peerId,
      },
    );
    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove all peers from the bootstrap list.
  /// `/api/v0/bootstrap/rm/all`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bootstrap-rm-all
  Future<Map<String, dynamic>> all() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/bootstrap/rm/all");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}

class IpfsBootstrapCommand {
  /// Add peers to the bootstrap list.
  final IpfsBootstrapAddSubcommand add = IpfsBootstrapAddSubcommand();

  /// Remove peers from the bootstrap list.
  final IpfsBootstrapRmSubcommand rm = IpfsBootstrapRmSubcommand();

  IpfsBootstrapCommand();

  /// Show or edit the list of bootstrap peers.
  /// `/api/v0/bootstrap`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-bootstrap
  Future<Map<String, dynamic>> self() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/bootstrap");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Show peers in the bootstrap list.
  /// `/api/v0/bootstrap/list`
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Peers": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more:
  Future<Map<String, dynamic>> list() async {
    Response? res = await _post(Ipfs.dio, url: "${Ipfs.url}/bootstrap/list");
    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
