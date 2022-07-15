// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class IpfsFilesCommand {
  IpfsFilesCommand();

  /// Change the CID version or hash function of the root node of a given path.
  /// `/api/v0/files/chcid`
  ///
  /// Arguments:
  ///   -
  ///
  /// Optional arguments:
  ///   - [path] `String`: Path to change. Default: '/'.
  ///   - [cidVersion] `int`: Cid version to use. (experimental).
  ///   - [hash] `String`: Hash function to use. Will set Cid version to 1 if used. (experimental).
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-chcid
  Future<Map<String, dynamic>> chcid({
    String? path,
    int? cidVersion,
    String? hash,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/chcid",
      queryParameters: {
        if (path != null) "arg": path,
        if (cidVersion != null) "cid-version": cidVersion,
        if (hash != null) "hash": hash,
      },
    );

    return interceptDioResponse(res);
  }

  /// Add references to IPFS files and directories in MFS (or copy within MFS).
  /// ``
  ///
  /// Arguments:
  ///   - [src] `String`: Source IPFS or MFS path to copy.
  ///   - [dst] `String`: Destination within MFS.
  ///
  /// Optional arguments:
  ///   - [parents] `bool`: Make parent directories as needed.
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
  Future<Map<String, dynamic>> cp({
    required String src,
    required String dst,
    bool? parents,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/cp",
      queryParameters: {
        "arg": src,
        "arg": dst,
        if (parents != null) "parents": parents,
      },
    );

    return interceptDioResponse(res);
  }

  /// Flush a given path's data to disk.
  /// `/api/v0/files/flush`
  ///
  /// Optional arguments:
  ///   - [path] `String`: Path to flush. Default '/'.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Cid": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-flush
  Future<Map<String, dynamic>> flush({String? path}) async {
    Response? res =
        await post(Ipfs.dio, url: "${Ipfs.url}/files/flush", queryParameters: {
      if (path != null) "arg": path,
    });
    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List directories in the local mutable namespace.
  /// `/api/v0/files/ls`
  ///
  /// Optional arguments:
  ///   - [path] `String`: Path to show listing for. Defaults to '/'.
  ///   - [long] `bool`: Use long listing format.
  ///   - [doNotSort] `bool`: Do not sort; list entries in directory order.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Entries": [
  ///     {
  ///       "Hash": "<string>",
  ///       "Name": "<string>",
  ///       "Size": "<int64>",
  ///       "Type": "<int>"
  ///     },
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-ls
  Future<Map<String, dynamic>> ls({
    String? path,
    bool? long,
    bool? doNotSort,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/ls",
      queryParameters: {
        if (path != null) "arg": path,
        if (long != null) "long": long,
        if (doNotSort != null) "U": doNotSort,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Make directories.
  /// `/api/v0/files/mkdir`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to dir to make.
  ///
  /// Optional arguments:
  ///   - [parents] `bool`: No error if existing, make parent directories as needed.
  ///   - [cidVersion] `int`: Cid version to use. (experimental).
  ///   - [hash] `String`: Hash function to use. Will set Cid version to 1 if used. (experimental).
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-mkdir
  Future<Map<String, dynamic>> mkdir({
    required String path,
    bool? parents,
    int? cidVersion,
    String? hash,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/mkdir",
      queryParameters: {
        "arg": path,
        if (parents != null) "parents": parents,
        if (cidVersion != null) "cid-version": cidVersion,
        if (hash != null) "hash": hash,
      },
    );

    return interceptDioResponse(res);
  }

  /// Move files.
  /// `/api/v0/files/mv`
  ///
  /// Arguments:
  ///   - [src] `String`: Source file to move.
  ///   - [dst] `String`: Destination path for file to be moved to.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-mv
  Future<Map<String, dynamic>> mv({
    required String src,
    required String dst,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/mv",
      queryParameters: {
        "arg": src,
        "arg": dst,
      },
    );

    return interceptDioResponse(res);
  }

  /// Read a file in a given MFS.
  /// `/api/v0/files/read`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to file to be read.
  ///
  /// Optional arguments:
  ///   - [offset] `int`: Byte offset to begin reading from.
  ///   - [count] `int`: Maximum number of bytes to read.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-read
  Future<Map<String, dynamic>> read({
    required String path,
    int? offset,
    int? count,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/read",
      queryParameters: {
        "arg": path,
        if (offset != null) "offset": offset,
        if (count != null) "count": count,
      },
    );

    return interceptDioResponse(res);
  }

  /// Remove a file.
  /// ``
  ///
  /// Arguments:
  ///   - [path] `String`: Path to file to be read.
  ///
  /// Optional arguments:
  ///   - [recursive] `bool`: Recursively remove directories.
  ///   - [force] `bool`: Forcibly remove target at path; implies -r for directories.
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
  Future<Map<String, dynamic>> rm({
    required String path,
    bool? recursive,
    bool? force,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/rm",
      queryParameters: {
        "arg": path,
        if (recursive != null) "recursive": recursive,
        if (force != null) "force": force,
      },
    );

    return interceptDioResponse(res);
  }

  /// Display file status.
  /// `/api/v0/files/stat`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to node to stat.
  ///
  /// Optional arguments:
  ///   - [format] `String`: Print statistics in given format. Allowed tokens: <hash> <size> <cumulsize> <type> <childs>. Conflicts with other format options. Default: `<hash> Size: <size> CumulativeSize: <cumulsize> ChildBlocks: <childs> Type: <type>`.
  ///   - [hash] `bool`: Print only hash. Implies '--format=<hash>'. Conflicts with other format options.
  ///   - [size] `bool`: Print only size. Implies '--format=<cumulsize>'. Conflicts with other format options.
  ///   - [withLocal] `bool`: Compute the amount of the dag that is local, and if possible the total size.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Blocks": "<int>",
  ///   "CumulativeSize": "<uint64>",
  ///   "Hash": "<string>",
  ///   "Local": "<bool>",
  ///   "Size": "<uint64>",
  ///   "SizeLocal": "<uint64>",
  ///   "Type": "<string>",
  ///   "WithLocality": "<bool>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-stat
  Future<Map<String, dynamic>> stat({
    required String path,
    String? format,
    bool? hash,
    bool? size,
    bool? withLocal,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/stat",
      queryParameters: {
        "arg": path,
        if (format != null) "format": format,
        if (hash != null) "hash": hash,
        if (size != null) "size": size,
        if (withLocal != null) "with-local": withLocal,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Write to a mutable file in a given filesystem.
  /// `/api/v0/files/write`
  ///
  /// Arguments:
  ///   - [path] `String`: Path to write to.
  ///   - [data] `String`: Content to write into the path.
  ///
  /// Optional arguments:
  ///   - [offset] `int`: Byte offset to begin writing at.
  ///   - [create] `bool`: Create the file if it does not exist.
  ///   - [parents] `bool`: Make parent directories as needed.
  ///   - [truncate] `bool`: Truncate the file to size zero before writing.
  ///   - [count] `int`: Maximum number of bytes to read.
  ///   - [rawLeaves] `bool`: Use raw blocks for newly created leaf nodes. (experimental).
  ///   - [cidVersion] `int`: Cid version to use. (experimental).
  ///   - [hash] `String`: Hash function to use. Will set Cid version to 1 if used. (experimental).
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-files-write
  Future<Map<String, dynamic>> write({
    required String path,
    required String data,
    int? offset,
    bool? create,
    bool? parents,
    bool? truncate,
    int? count,
    bool? rawLeaves,
    int? cidVersion,
    String? hash,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/files/write",
      data: contentFormData(data),
      queryParameters: {
        "arg": path,
        if (offset != null) "offset": offset,
        if (create != null) "create": create,
        if (parents != null) "parents": parents,
        if (truncate != null) "truncate": truncate,
        if (count != null) "count": count,
        if (rawLeaves != null) "raw-leaves": rawLeaves,
        if (cidVersion != null) "cid-version": cidVersion,
        if (hash != null) "hash": hash,
      },
    );

    return interceptDioResponse(res);
  }
}
