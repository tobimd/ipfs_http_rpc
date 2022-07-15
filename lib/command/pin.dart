// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class _IpfsPinRemoteServiceSubcommand {
  _IpfsPinRemoteServiceSubcommand();

  /// Add remote pinning service.
  /// `/api/v0/pin/remote/service/add`
  ///
  /// Arguments:
  ///   - [name] `String`: Service name.
  ///   - [endpoint] `String`: Service endpoint.
  ///   - [key] `String`: Service key.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-remote-service-add
  Future<Map<String, dynamic>> add(
      {required String name,
      required String endpoint,
      required String key}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/service/add",
      queryParameters: {
        "arg": name,
        "arg": endpoint,
        "arg": key,
      },
    );

    return interceptDioResponse(res);
  }

  /// List remote pinning services.
  /// `/api/v0/pin/remote/service/ls`
  ///
  /// Optional arguments:
  ///   - [stat] `bool`: Try to fetch and display current pin count on remote service (queued/pinning/pinned/failed). Default: false.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "RemoteServices": [
  ///     {
  ///       "ApiEndpoint": "<string>",
  ///       "Service": "<string>",
  ///       "Stat": {
  ///         "PinCount": {
  ///           "Failed": "<int>",
  ///           "Pinned": "<int>",
  ///           "Pinning": "<int>",
  ///           "Queued": "<int>"
  ///         },
  ///         "Status": "<string>"
  ///       }
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-remote-service-ls
  Future<Map<String, dynamic>> ls({bool? stat}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/service/ls",
      queryParameters: {
        if (stat != null) "stat": stat,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove remote pinning service.
  /// `/api/v0/pin/remote/service/rm`
  ///
  /// Arguments:
  ///   - [name] `String`: Name of remote pinning service to remove.
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
  /// See more:
  Future<Map<String, dynamic>> rm({required String name}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/service/rm",
      queryParameters: {
        "arg": name,
      },
    );

    return interceptDioResponse(res);
  }
}

class _IpfsPinRemoteSubcommand {
  final _IpfsPinRemoteServiceSubcommand service =
      _IpfsPinRemoteServiceSubcommand();

  _IpfsPinRemoteSubcommand();

  /// Pin object to remote pinning service.
  /// `/api/v0/pin/remote/add`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to object(s) to be pinned.
  ///
  /// Optional arguments:
  ///   - [service] `String`: Name of the remote pinning service to use (mandatory).
  ///   - [name] `String`: An optional name for the pin.
  ///   - [background] `bool`: Add to the queue on the remote service and return immediately (does not wait for pinned status). Default: false.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Cid": "<string>",
  ///   "Name": "<string>",
  ///   "Status": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-remote-add
  Future<Map<String, dynamic>> add(
      {required String path,
      String? service,
      String? name,
      bool? background}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/add",
      queryParameters: {
        "arg": path,
        if (service != null) "service": service,
        if (name != null) "name": name,
        if (background != null) "background": background,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List objects pinned to remote pinning service.
  /// `/api/v0/pin/remote/ls`
  ///
  /// Optional arguments:
  ///   - [service] `String`: Name of the remote pinning service to use (mandatory).
  ///   - [name] `String`: Return pins with names that contain the value provided (case-sensitive, exact match).
  ///   - [cid] `List<String>`: Return pins for the specified CIDs.
  ///   - [status] `List<String>`: Return pins with the specified statuses (queued,pinning,pinned,failed). Default: [pinned].
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Cid": "<string>",
  ///   "Name": "<string>",
  ///   "Status": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-remote-ls
  Future<Map<String, dynamic>> ls(
      {String? service,
      String? name,
      List<String>? cid,
      List<String>? status}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/ls",
      queryParameters: {
        if (service != null) "service": service,
        if (name != null) "name": name,
        if (cid != null) "cid": cid.join(","),
        if (status != null) "status": status.join(","),
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove pins from remote pinning service.
  /// `/api/v0/pin/remote/rm`
  ///
  /// Optional arguments:
  ///   - [service] `String`: Name of the remote pinning service to use (mandatory).
  ///   - [name] `String`: Remove pins with names that contain provided value (case-sensitive, exact match).
  ///   - [cid] `List<String>`: Remove pins for the specified CIDs.
  ///   - [status] `List<String>`: Remove pins with the specified statuses (queued,pinning,pinned,failed). Default: [pinned].
  ///   - [force] `bool`: Allow removal of multiple pins matching the query without additional confirmation. Default: false.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-remote-ls
  Future<Map<String, dynamic>> rm(
      {String? service,
      String? name,
      List<String>? cid,
      List<String>? status,
      bool? force}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/remote/rm",
      queryParameters: {
        if (service != null) "service": service,
        if (name != null) "name": name,
        if (cid != null) "cid": cid.join(","),
        if (status != null) "status": status.join(","),
        if (force != null) "force": force,
      },
    );

    return interceptDioResponse(res);
  }
}

class IpfsPinCommand {
  final _IpfsPinRemoteSubcommand remote = _IpfsPinRemoteSubcommand();
  IpfsPinCommand();

  /// Pin objects to local storage.
  /// `/api/v0/pin/remote/service/add`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to object(s) to be pinned.
  ///
  /// Optional arguments:
  ///   - [recursive] `bool`: Recursively pin the object linked to by the specified object(s). Default: true.
  ///   - [progress] `bool`: Show progress.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Pins": [
  ///     "<string>"
  ///   ],
  ///   "Progress": "<int>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-add
  Future<Map<String, dynamic>> add(
      {required String path, bool? recursive, bool? progress}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/add",
      queryParameters: {
        "arg": path,
        if (recursive != null) "recursive": recursive,
        if (progress != null) "progress": progress,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List objects pinned to local storage.
  /// `/api/v0/pin/ls`
  ///
  /// Optional arguments:
  ///   - [path] `String`: Path to object(s) to be listed.
  ///   - [type] `String`: The type of pinned keys to list. Can be "direct", "indirect", "recursive", or "all". Default: all.
  ///   - [quiet] `bool`: Write just hashes of objects.
  ///   - [stream] `bool`: Enable streaming of pins as they are discovered.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "PinLsList": {
  ///     "Keys": {
  ///       "<string>": {
  ///         "Type": "<string>"
  ///       }
  ///     }
  ///   },
  ///   "PinLsObject": {
  ///     "Cid": "<string>",
  ///     "Type": "<string>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-ls
  Future<Map<String, dynamic>> ls(
      {String? path, String? type, bool? quiet, bool? stream}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/ls",
      queryParameters: {
        if (path != null) "arg": path,
        if (type != null) "type": type,
        if (quiet != null) "quiet": quiet,
        if (stream != null) "stream": stream,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Remove object from pin-list.
  /// `/api/v0/pin/rm`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to object(s) to be unpinned.
  ///
  /// Optional arguments:
  ///   - [recursive] `bool`: Recursively pin the object linked to by the specified object(s). Default: true.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Pins": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-rm
  Future<Map<String, dynamic>> rm(
      {required String path, bool? recursive}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/rm",
      queryParameters: {
        "arg": path,
        if (recursive != null) "recursive": recursive,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Update a recursive pin.
  /// `/api/v0/pin/update`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to old object.
  ///   - [newPath] `String`: Path to a new object to be pinned.
  ///
  /// Optional arguments:
  ///   - [unpin] `bool`: Remove the old pin. Default: true.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Pins": ["<string>", "..."],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-update
  Future<Map<String, dynamic>> update(
      {required String path, required String newPath, bool? unpin}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/update",
      queryParameters: {
        "arg": path,
        "arg": newPath,
        if (unpin != null) "unpin": unpin,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Verify that recursive pins are complete.
  /// `/api/v0/pin/verify`
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Also write the hashes of non-broken pins.
  ///   - [quiet] `bool`: Write just hashes of broken pins.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Cid": "<string>",
  ///   "PinStatus": {
  ///     "BadNodes": [
  ///       {
  ///         "Cid": "<string>",
  ///         "Err": "<string>"
  ///       }
  ///     ],
  ///     "Ok": "<bool>"
  ///   },
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-pin-verify
  Future<Map<String, dynamic>> verify({bool? verbose, bool? quiet}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/pin/verify",
      queryParameters: {
        if (verbose != null) "verbose": verbose,
        if (quiet != null) "quiet": quiet,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }
}
