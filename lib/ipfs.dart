library ipfs_http_rpc;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

part 'command/bitwsap.dart';
part 'command/block.dart';
part 'command/bootstrap.dart';
part 'command/cid.dart';
part 'command/commands.dart';
part 'command/config.dart';
part 'command/dag.dart';
part 'command/dht.dart';
part 'command/diag.dart';
part 'command/files.dart';
part 'command/filestore.dart';
part 'command/key.dart';
part 'command/log.dart';
part 'command/multibase.dart';
part 'command/name.dart';
part 'command/p2p.dart';
part 'command/pin.dart';
part 'command/pubsub.dart';
part 'command/refs.dart';
part 'command/repo.dart';
part 'command/stats.dart';
part 'command/swarm.dart';
part 'command/version.dart';

/// Generate a `FormData` with `MultipartFile` content (files or directories to upload to IPFS).
Future<FormData> _fileFormData(String path,
    {String? ipfsPath, String key = "file"}) async {
  return FormData.fromMap({
    key: await MultipartFile.fromFile(path, filename: ipfsPath),
  });
}

/// Generate a `FormData` with `MultipartFile` content.
FormData _contentFormData(String content,
    {String? ipfsPath, String key = "file"}) {
  return FormData.fromMap(
      {key: MultipartFile.fromString(content, filename: ipfsPath)});
}

/// Catch [Dio] errors and print them.
dynamic _interceptDioError(DioError error) {
  // The request was made and the server responded with a status code that falls out of the range of 2xx and is also not 304.
  if (error.response != null) {
    final res = error.response;

    debugPrint(res?.data.toString());
    debugPrint(res?.headers.toString());
    debugPrint(res?.requestOptions.toString());
    return res!;
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    debugPrint(error.requestOptions.toString());
    debugPrint(error.message);
    return null;
  }
}

/// Intercept and restructure the [Dio] response object (add some consistency to the responses).
///
/// If [expectsResponseBody] is `false`, then a "Text" key is added with the response's data even if it's an empty string. Otherwise, an attempt is made to add every `Map<String, dynamic>` entry from the response.
///
/// ```json
/// {
///   // Allways present
///   "StatusCode": "<statusCode>",
///   "StatusMessage": "<statusMessage>",
///
///   // If expectsResponseBody is false
///   // (option in `_interceptDioResponse` of Ipfs methods)
///   "Text": "<response.data>",
///
///   // Otherwise, insert response.data contiguously if possible
///   <response.data key/value pairs>,
/// }
/// ```
///
/// An empty `Map<String, dynamic>` object is returned when incoming `Response` is also `null`. This is to avoid using `null` checks for all methods and instead use [.isEmpty()].
Map<String, dynamic> _interceptDioResponse(Response? response,
    {bool expectsResponseBody = false}) {
  if (response != null) {
    Map<String, dynamic> ret = {
      "StatusCode": response.statusCode,
      "StatusMessage": response.statusMessage,
    };

    if (expectsResponseBody && response.data != null) {
      final data = response.data;

      if (data is Iterable<MapEntry<String, dynamic>>) {
        ret.addEntries(data);
      } else if (data is Map<String, dynamic>) {
        ret.addAll(data);
      } else {
        ret.addAll({"Data": data});
      }
    } else {
      ret.addAll({"Text": response.data});
    }

    return ret;
  }

  return {};
}

/// Create a POST request using [Dio].
Future<Response?> _post(
  Dio dio, {
  required String url,
  Map<String, dynamic>? queryParameters,
  dynamic data,
  Options? options,
}) async {
  try {
    return await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  } on DioError catch (e) {
    return _interceptDioError(e);
  }
}

/// IPFS HTTP RPC service implementation
///
/// Responses are like the following:
/// ```json
/// {
///   // Allways present
///   "StatusCode": "<statusCode>",
///   "StatusMessage": "<statusMessage>",
///
///   // If expectsResponseBody is false
///   // (option in `_interceptDioResponse` of Ipfs methods)
///   "Text": "<response.data>",
///
///   // Otherwise, insert response.data contiguously if possible
///   <response.data key/value pairs>,
/// }
/// ```
///
/// Example:
/// ```dart
/// Map<String, dyanmic> response = Ipfs().files.ls();
/// print(response);
///
/// //
/// ```
class Ipfs {
  static final Ipfs _instance = Ipfs._internal();

  /// Get the global instance of this class.
  ///
  /// Calling with new parameters will update these values.
  factory Ipfs({String url = "http://127.0.0.1:5001/api/v0"}) {
    _instance._url = url;
    return _instance;
  }

  Ipfs._internal() {
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        logPrint: ((object) => debugPrint("[D/Dio] $object")),
      ));
    }
  }

  String _url = "http://127.0.0.1:5001/api/v0";
  static String get url => _instance._url;
  static set url(String value) => _instance._url = value;

  static final Dio dio = Dio();

  /// Interact with the bitswap agent.
  final IpfsBitswapCommand bitswap = IpfsBitswapCommand();

  /// Interact with raw IPFS blocks.
  ///
  /// 'ipfs block' is a plumbing command used to manipulate raw IPFS blocks.
  /// Reads from stdin or writes to stdout. A block is identified by a Multihash
  /// passed with a valid CID.
  final IpfsBlockCommand block = IpfsBlockCommand();

  /// Show or edit the list of bootstrap peers.
  ///
  /// Running 'ipfs bootstrap' with no arguments will run 'ipfs bootstrap list'.
  ///
  /// SECURITY WARNING:
  ///
  /// The bootstrap command manipulates the "bootstrap list", which contains
  /// the addresses of bootstrap nodes. These are the *trusted peers* from
  /// which to learn about other peers in the network. Only edit this list
  /// if you understand the risks of adding or removing nodes from this list.
  final IpfsBootstrapCommand bootstrap = IpfsBootstrapCommand();

  /// Convert and discover properties of CIDs.
  final IpfsCidCommand cid = IpfsCidCommand();

  /// List all available commands.
  ///
  /// Lists all available commands (and subcommands).
  final IpfsCommandsCommand commands = IpfsCommandsCommand();

  /// Get and set IPFS config values.
  /// 'ipfs config' controls configuration variables. It works
  /// much like 'git config'. The configuration values are stored in a config
  /// file inside your IPFS repository (IPFS_PATH).
  final IpfsConfigCommand config = IpfsConfigCommand();

  /// Interact with IPLD DAG objects.
  ///
  /// 'ipfs dag' is used for creating and manipulating DAG objects/hierarchies.
  final IpfsDagCommand dag = IpfsDagCommand();

  /// Issue commands directly through the DHT.
  final IpfsDhtCommand dht = IpfsDhtCommand();

  /// Generate diagnostic reports.
  final IpfsDiagCommand diag = IpfsDiagCommand();

  /// Files is an API for manipulating IPFS objects as if they were a Unix
  /// filesystem.
  ///
  /// The files facility interacts with MFS (Mutable File System). MFS acts as a
  /// single, dynamic filesystem mount. MFS has a root CID that is transparently
  /// updated when a change happens (and can be checked with "ipfs files stat /").
  final IpfsFilesCommand files = IpfsFilesCommand();

  /// Interact with filestore objects.
  final IpfsFilestoreCommand filestore = IpfsFilestoreCommand();

  /// Create and list IPNS name keypairs
  ///
  /// 'ipfs key gen' generates a new keypair for usage with IPNS and 'ipfs name
  /// publish'.
  ///
  ///   > ipfs key gen --type=rsa --size=2048 mykey
  ///   > ipfs name publish --key=mykey QmSomeHash
  ///
  /// 'ipfs key list' lists the available keys.
  ///
  ///   > ipfs key list
  ///   self
  ///   mykey
  final IpfsKeyCommand key = IpfsKeyCommand();

  /// Interact with the daemon log output.
  final IpfsLogCommand log = IpfsLogCommand();

  /// Encode and decode files or stdin with multibase format
  final IpfsMultibaseCommand multibase = IpfsMultibaseCommand();

  /// Publish and resolve IPNS names.
  ///
  /// IPNS is a PKI namespace, where names are the hashes of public keys, and
  /// the private key enables publishing new (signed) values. In both publish
  /// and resolve, the default name used is the node's own PeerID,
  /// which is the hash of its public key.
  ///
  /// You can use the 'ipfs key' commands to list and generate more names and their
  /// respective keys.
  final IpfsNameCommand name = IpfsNameCommand();

  /// Pin (and unpin) objects to local storage, remote or remote services.
  final IpfsPinCommand pin = IpfsPinCommand();

  /// List links (references) from an object.
  ///
  /// Lists the hashes of all the links an IPFS or IPNS object(s) contains,
  /// with the following format: `<link base58 hash>`
  final IpfsRefsCommand refs = IpfsRefsCommand();

  /// Manipulate the IPFS repo.
  final IpfsRepoCommand repo = IpfsRepoCommand();

  /// Interact with the swarm.
  /// Query IPFS statistics.
  ///
  /// 'ipfs stats' is a set of commands to help look at statistics
  /// for your IPFS node.
  final IpfsStatsCommand stats = IpfsStatsCommand();

  ///
  /// 'ipfs swarm' is a tool to manipulate the network swarm. The swarm is the
  /// component that opens, listens for, and maintains connections to other
  /// ipfs peers in the internet.
  final IpfsSwarmCommand swarm = IpfsSwarmCommand();

  /// Show IPFS version information.
  ///
  /// Returns the current version of IPFS.
  final IpfsVersionCommand version = IpfsVersionCommand();

  /// Add a file or directory to IPFS.
  /// `/api/v0/add`
  ///
  /// Arguments:
  ///   - [path] `String`: Absolute pth to the local file.
  ///
  /// Optional arguments:
  ///   - [ipfsPath] `String`: Path hierarchy for IPFS to add the file onto.
  ///   - [quiet] `bool`: Write minimal output.
  ///   - [quieter] `bool`: Write only final hash.
  ///   - [silent] `bool`: Write no output.
  ///   - [progress] `bool`: Stream progress data.
  ///   - [trickle] `bool`: Use trickle-dag format for dag generation.
  ///   - [only-hash] `bool`: Only chunk and hash - do not write to disk.
  ///   - [wrapWithDirectory] `bool`: Wrap files with a directory object.
  ///   - [chunker] `String`: Chunking algorithm, size-[bytes], rabin-[min]-[avg]-[max] or buzhash. Default: size-262144.
  ///   - [pin] `bool`: Pin this object when adding. Default: true.
  ///   - [rawLeaves] `bool`: Use raw blocks for leaf nodes.
  ///   - [cidVersion] `int`: CID version. Defaults to 0 unless an option that depends on CIDv1 is passed. Passing version 1 will cause the raw-leaves option to default to true.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Bytes": "<int64>",
  ///   "Hash": "<string>",
  ///   "Name": "<string>",
  ///   "Size": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-add
  Future<Map<String, dynamic>> add({
    required String path,
    String? ipfsPath,
    bool? quiet,
    bool? quieter,
    bool? silent,
    bool? progress,
    bool? trickle,
    bool? onlyHash,
    bool? wrapWithDirectory,
    String? chunker,
    bool? pin,
    bool? rawLeaves,
    int? cidVersion,
  }) async {
    Response? res = await _post(
      dio,
      url: "$url/add",
      data: await _fileFormData(path, ipfsPath: ipfsPath),
      queryParameters: {
        if (quiet != null) "quiet": quiet,
        if (quieter != null) "quieter": quieter,
        if (silent != null) "silent": silent,
        if (progress != null) "progress": progress,
        if (trickle != null) "trickle": trickle,
        if (onlyHash != null) "only-hash": onlyHash,
        if (wrapWithDirectory != null) "wrap-with-directory": wrapWithDirectory,
        if (chunker != null) "chunker": chunker,
        if (pin != null) "pin": pin,
        if (rawLeaves != null) "raw-leaves": rawLeaves,
        if (cidVersion != null) "cid-version": cidVersion,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Show IPFS object data.
  /// `/api/v0/cat`
  ///
  /// Arguments:
  ///   - [path] `String`: The path to the IPFS object(s) to be outputted.
  ///
  /// Optional arguments:
  ///   - [offset] `int`: Byte offset to begin reading from.
  ///   - [length] `int`: Maximum number of bytes to read.
  ///   - [progress] `bool`: Stream progress data. Default: true.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-cat
  Future<Map<String, dynamic>> cat(
      {required String path, int? offset, int? length, bool? progress}) async {
    Response? res = await _post(
      dio,
      url: "$url/cat",
      queryParameters: {
        "arg": path,
        if (offset != null) "offset": offset,
        if (length != null) "length": length,
        if (progress != null) "progress": progress,
      },
    );

    return _interceptDioResponse(res);
  }

  /// Download IPFS objects.
  /// `/api/v0/get`
  ///
  /// Arguments:
  ///   - [path] `String`: The path to the IPFS object(s) to be outputted.
  ///
  /// Optional arguments:
  ///   - [output] `String`: The path where the output should be stored.
  ///   - [archive] `bool`: Output a TAR archive.
  ///   - [compress] `bool`: Compress the output with GZIP compression.
  ///   - [compressionLevel] `int`: The level of compression (1-9).
  ///   - [progress] `bool`: Stream progress data. Default: true.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-get
  Future<Map<String, dynamic>> get(
      {required String path,
      String? output,
      bool? archive,
      bool? compress,
      int? compressionLevel,
      bool? progress}) async {
    Response? res = await _post(
      dio,
      url: "$url/get",
      queryParameters: {
        "arg": path,
        if (output != null) "output": output,
        if (archive != null) "archive": archive,
        if (compress != null) "compress": compress,
        if (compressionLevel != null) "compression-level": compressionLevel,
        if (progress != null) "progress": progress,
      },
    );

    return _interceptDioResponse(res);
  }

  /// Show IPFS node id info.
  /// `/api/v0/id`
  ///
  /// Optional arguments:
  ///   - [peerId] `String`: Peer ID of node to look up.
  ///   - [format] `String`: Optional output format.
  ///   - [peerIdBase] `String`: Encoding used for peer IDs: Can either be a multibase encoded CID or a base58btc encoded multihash. Takes {b58mh|base36|k|base32|b...}. Default: b58mh.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Addresses": ["<string>", "..."],
  ///   "AgentVersion": "<string>",
  ///   "ID": "<string>",
  ///   "ProtocolVersion": "<string>",
  ///   "Protocols": ["<string>", "..."],
  ///   "PublicKey": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-id
  Future<Map<String, dynamic>> id(
      {String? peerId, String? format, String? peerIdBase}) async {
    Response? res = await _post(
      dio,
      url: "$url/id",
      queryParameters: {
        "arg": peerId,
        if (format != null) "format": format,
        if (peerIdBase != null) "peerid-base": peerIdBase,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// List directory contents for Unix filesystem objects.
  /// `/api/v0/ls`
  ///
  /// Arguments:
  ///   - [path] `String`: The path to the IPFS object(s) to list links from.
  ///
  /// Optional arguments:
  ///   - [headers] `bool`: Print table headers (Hash, Size, Name).
  ///   - [resolveType] `bool`: Resolve linked objects to find out their types. Default: true.
  ///   - [size] `bool`: Resolve linked objects to find out their file size. Default: true.
  ///   - [stream] `bool`: Enable experimental streaming of directory entries as they are traversed.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Objects": [
  ///     {
  ///       "Hash": "<string>",
  ///       "Links": [
  ///         {
  ///           "Hash": "<string>",
  ///           "Name": "<string>",
  ///           "Size": "<uint64>",
  ///           "Target": "<string>",
  ///           "Type": "<int32>"
  ///         }
  ///       ]
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-ls
  Future<Map<String, dynamic>> ls({
    required String path,
    bool? headers,
    bool? resolveType,
    bool? size,
    bool? stream,
  }) async {
    Response? res = await _post(
      dio,
      url: "$url/ls",
      queryParameters: {
        "arg": path,
        if (headers != null) "headers": headers,
        if (resolveType != null) "resolve-type": resolveType,
        if (size != null) "size": size,
        if (stream != null) "stream": stream,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Send echo request packets to IPFS hosts.
  /// `/api/v0/ping`
  ///
  /// Arguments:
  ///   - [peerId] `String`: ID of peer to be pinged.
  ///
  /// Optional arguments:
  ///   - [count] `int`: Number of ping messages to send. Default: 10.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Success": "<bool>",
  ///   "Text": "<string>",
  ///   "Time": "<duration-ns>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-ping
  Future<Map<String, dynamic>> ping(
      {required String peerId, int? count}) async {
    Response? res = await _post(
      dio,
      url: "$url/ping",
      queryParameters: {
        "arg": peerId,
        if (count != null) "count": count,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Resolve the value of names to IPFS or DAG path.
  /// `/api/v0/resolve`
  ///
  /// Arguments:
  ///   - [path] `String`: The name to resolve.
  ///
  /// Optional arguments:
  ///   - [recursive] `bool`: Resolve until the result is an IPFS name. Default: true.
  ///   - [dhtRecordCount] `int`: Number of records to request for DHT resolution.
  ///   - [dhtTimeout] `String`: Max time to collect values during DHT resolution eg "30s". Pass 0 for no timeout.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-resolve
  Future<Map<String, dynamic>> resolve({
    required String path,
    bool? recursive,
    int? dhtRecordCount,
    String? dhtTimeout,
  }) async {
    Response? res = await _post(
      dio,
      url: "$url/resolve",
      queryParameters: {
        "arg": path,
        if (recursive != null) "recursive": recursive,
        if (dhtRecordCount != null) "dht-record-count": dhtRecordCount,
        if (dhtTimeout != null) "dht-timeout": dhtTimeout,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Shut down the IPFS daemon.
  /// `/api/v0/shutdown`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-shutdown
  Future<Map<String, dynamic>> shutdown() async {
    Response? res = await _post(dio, url: "$url/shutdown");
    return _interceptDioResponse(res);
  }

  /// # [ EXPERIMENTAL ]
  ///
  /// Mounts IPFS to the filesystem (read-only).
  /// `/api/v0/mount`
  ///
  /// Optional arguments:
  ///   - [ipfsPath] `String`: The path where IPFS should be mounted.
  ///   - [ipnsPath] `String`: The path where IPNS should be mounted.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "FuseAllowOther": "<bool>",
  ///   "IPFS": "<string>",
  ///   "IPNS": "<string>",
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-mount
  Future<Map<String, dynamic>> mount(
      {String? ipfsPath, String? ipnsPath}) async {
    Response? res = await _post(
      Ipfs.dio,
      url: "${Ipfs.url}/mount",
      queryParameters: {
        if (ipfsPath != null) "ipfs-path": ipfsPath,
        if (ipnsPath != null) "ipns-path": ipnsPath,
      },
    );

    return _interceptDioResponse(res, expectsResponseBody: true);
  }
}
