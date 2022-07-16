// ignore_for_file: equal_keys_in_map
part of ipfs_http_rpc;

class IpfsKeyCommand {
  IpfsKeyCommand();

  /// Export a keypair
  /// `/api/v0/key/export`
  ///
  /// Arguments:
  ///   - [name] `String`: Name of key to export.
  ///
  /// Optional arguments:
  ///   - [output] `String`: THe path where the output should be stored.
  ///   - [format] `String`: The format of the exported private key, libp2p-protobuf-cleartext or pem-pkcs8-cleartext. Default: libp2p-protobuf-cleartext.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-export
  Future<Map<String, dynamic>> export(
      {required String name, String? output, String? format}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/export",
      queryParameters: {
        "arg": name,
        if (output != null) "output": output,
        if (format != null) "format": format,
      },
    );

    return _interceptDioResponse(res);
  }

  /// Create a new keypair.
  /// `/api/v0/key/gen`
  ///
  /// Arguments:
  ///   - [name] `String`: Name of key to create.
  ///
  /// Optional arguments:
  ///   - [type] `String`: Type of the key to create: rsa, ed25519. Default: ed25519.
  ///   - [size] `int`: Size of the key to generate.
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Id": "<string>",
  ///   "Name": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-gen
  Future<Map<String, dynamic>> gen(
      {required String name, String? type, int? size, String? ipnsBase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/gen",
      queryParameters: {
        "arg": name,
        if (type != null) "type": type,
        if (size != null) "size": size,
        if (ipnsBase != null) "ipns-base": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Import a key and prints imported key id
  /// `/api/v0/key/import`
  ///
  /// Arguments:
  ///   - [name] `String`: Name to associate with key in keychain.
  ///
  /// Optional arguments:
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///   - [format] `String`: The format of the private key to import, libp2p-protobuf-cleartext or pem-pkcs8-cleartext. Default: libp2p-protobuf-cleartext.
  ///   - [allowAnyKeyType] `bool`: Allow importing any key type. Default: false.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Id": "<string>",
  ///   "Name": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-import
  Future<Map<String, dynamic>> import(
      {required String name,
      required String path,
      String? base,
      String? format,
      bool? allowAnyKeyType}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/import",
      data: await _fileFormData(path),
      queryParameters: {
        "arg": name,
        if (base != null) "ipns-base": base,
        if (format != null) "format": format,
        if (allowAnyKeyType != null) "allow-any-key-type": allowAnyKeyType,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List all local keypairs.
  /// `/api/v0/key/list`
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Show extra information about keys.
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Keys": [
  ///     {
  ///       "Id": "<string>",
  ///       "Name": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-list
  Future<Map<String, dynamic>> list({bool? verbose, String? ipnsBase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/list",
      queryParameters: {
        if (verbose != null) "l": verbose,
        if (ipnsBase != null) "ipns-ipnsBase": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Rename a keypair.
  /// `/api/v0/key/rename`
  ///
  /// Arguments:
  ///   - [name] `String`: Name of key to rename.
  ///   - [newName] `String`: New name of the key.
  ///
  /// Optional arguments:
  ///   - [force] `bool`: Allow to overwrite an existing key.
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Id": "<string>",
  ///   "Now": "<string>",
  ///   "Overwrite": "<bool>",
  ///   "Was": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-rename
  Future<Map<String, dynamic>> rename(
      {required String name,
      required String newName,
      bool? force,
      String? ipnsBase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/rename",
      queryParameters: {
        "arg": name,
        "arg": newName,
        if (force != null) "force": force,
        if (ipnsBase != null) "ipns-ipnsBase": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove a keypair.
  /// `/api/v0/key/rm`
  ///
  /// Arguments:
  ///   - [names] `List<String`: Names of keys to remove.
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Show extra information about keys.
  ///   - [ipnsBase] `String`: Encoding used for keys: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: base36.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Keys": [
  ///     {
  ///       "Id": "<string>",
  ///       "Name": "<string>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-rm
  Future<Map<String, dynamic>> rm(
      {required List<String> names, bool? verbose, String? ipnsBase}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/rm",
      queryParameters: {
        "arg": names.join(","),
        if (verbose != null) "l": verbose,
        if (ipnsBase != null) "ipns-ipnsBase": ipnsBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Rotates the IPFS identity.
  /// `/api/v0/key/rotate`
  ///
  /// Optional arguments:
  ///   - [oldKey] `String`: Keystore name to use for backing up your existing identity.
  ///   - [type] `String`: Type of the key to create: rsa, ed25519. Default: ed25519.
  ///   - [size] `int`: Size of the key to generate.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-key-rotate
  Future<Map<String, dynamic>> rotate(
      {String? oldKey, String? type, int? size}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/key/rotate",
      queryParameters: {
        if (oldKey != null) "oldkey": oldKey,
        if (type != null) "type": type,
        if (size != null) "size": size,
      },
    );

    return _interceptDioResponse(res);
  }
}
