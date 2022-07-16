// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsCidCommand {
  IpfsCidCommand();

  /// Convert CIDs to Base32 CID version 1.
  /// `/api/v0/cid/base32`
  ///
  /// Arguments:
  ///   - [cid] `String`: CIDs to convert.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "CidStr": "<string>",
  ///   "ErrorMsg": "<string>",
  ///   "Formatted": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cid-base32
  Future<Map<String, dynamic>> base32({required String cid}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/cid/base32",
      queryParameters: {
        "arg": cid,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List available multibase encodings.
  /// `/api/v0/cid/bases`

  /// Optional arguments:
  ///   - [prefix] `bool`: Also include the single letter prefixes in addition to the code.
  ///   - [numeric] `bool`: Also include numeric codes.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Code": "<int>",
  ///   "Name": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cid-bases
  Future<Map<String, dynamic>> bases({bool? prefix, bool? numeric}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/cid/bases",
      queryParameters: {
        if (prefix != null) "prefix": prefix,
        if (numeric != null) "numeric": numeric,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List available CID multicodecs.
  /// `/api/v0/cid/codecs`
  ///
  /// Optional arguments:
  ///   - [numeric] `bool`: Also include numeric codes.
  ///   - [supported] `bool`: List only codecs supported by go-ipfs commands.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Code": "<int>",
  ///   "Name": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cid-codecs
  Future<Map<String, dynamic>> codecs({bool? numeric, bool? supported}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/cid/codecs",
      queryParameters: {
        if (numeric != null) "numeric": numeric,
        if (supported != null) "supported": supported,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Format and convert a CID in various useful ways.
  /// `/api/v0/cid/format`
  ///
  /// Arguments:
  ///   - [cid] `String`: CIDs to format.
  ///
  /// Optional arguments:
  ///   - [formatString] `String`: Printf style format string. Default: %s.
  ///   - [version] `String`: CID version to convert to.
  ///   - [multicodec] `String`: CID multicodec to convert to.
  ///   - [multibase] `String`: Multibase to display CID in.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "CidStr": "<string>",
  ///   "ErrorMsg": "<string>",
  ///   "Formatted": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cid-format
  Future<Map<String, dynamic>> format(
      {required String cid,
      String? formatString,
      String? version,
      String? multicodec,
      String? multibase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/cid/format",
      queryParameters: {
        "arg": cid,
        if (formatString != null) "f": formatString,
        if (version != null) "v": version,
        if (multicodec != null) "mc": multicodec,
        if (multibase != null) "b": multibase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List available multihashes.
  /// `/api/v0/cid/hashes`
  ///
  /// Optional arguments:
  ///   - [numeric] `bool`: Also include numeric codes.
  ///   - [supported] `bool`: List only codecs supported by go-ipfs commands.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Data": [
  ///     {
  ///       "Code": "<int>",
  ///       "Name": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cid-hashes
  Future<Map<String, dynamic>> hashes({bool? numeric, bool? supported}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/cid/hashes",
      queryParameters: {
        if (numeric != null) "numeric": numeric,
        if (supported != null) "supported": supported,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
