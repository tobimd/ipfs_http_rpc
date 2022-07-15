// ignore_for_file: library_private_types_in_public_api, equal_keys_in_map

import 'package:dio/dio.dart';
import 'package:ipfs_http_rpc/ipfs.dart';

class _IpfsCmdsSubcommand {
  _IpfsCmdsSubcommand();

  /// List commands run on this IPFS node.
  /// `/api/v0/diag/cmds`
  ///
  /// Optional arguments:
  ///   - [verbose] `bool`: Print extra information.
  ///
  /// Response:
  /// ```json
  /// {
  ///   "Data": [
  ///     {
  ///       "Active": "<bool>",
  ///       "Args": ["<string>", "..."],
  ///       "Command": "<string>",
  ///       "EndTime": "<timestamp>",
  ///       "ID": "<int>",
  ///       "Options": {
  ///         "<string>": "<object>"
  ///       },
  ///       "StartTime": "<timestamp>"
  ///     }
  ///   ],
  ///   "StatusCode": "<statusCode>",
  ///   "StatusMessage": "<statusMessage>"
  /// }
  /// ```
  ///
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-diag-cmds
  Future<Map<String, dynamic>> self({bool? verbose}) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/diag/cmds",
      queryParameters: {
        if (verbose != null) "verbose": verbose,
      },
    );

    return interceptDioResponse(res, expectsResponseBody: true);
  }

  /// Clear inactive requests from the log.
  /// `/api/v0/diag/cmds/clear`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-diag-cmds-clear
  Future<Map<String, dynamic>> clear() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/diag/cmds/clear");
    return interceptDioResponse(res);
  }

  /// Set how long to keep inactive requests in the log.
  /// `/api/v0/diag/cmds/set-time`
  ///
  /// Arguments:
  ///   - [time] `String`: Time to keep inactive requests in log.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-diag-cmds-set-time
  Future<Map<String, dynamic>> setTime({required String time}) async {
    Response? res = await post(Ipfs.dio,
        url: "${Ipfs.url}/diag/cmds/set-time", queryParameters: {"arg": time});
    return interceptDioResponse(res);
  }
}

class IpfsDiagCommand {
  /// List commands run on this IPFS node.
  final _IpfsCmdsSubcommand cmds = _IpfsCmdsSubcommand();

  IpfsDiagCommand();

  /// Collect a performance profile for debugging.
  /// `/api/v0/diag/profile`
  ///
  /// Optional arguments:
  ///   - [output] `String`: The path where the output .zip should be stored. Default: ./ipfs-profile-[timestamp].zip.
  ///   - [collectors] `List`: The list of collectors to use for collecting diagnostic data. Default: [goroutines-stack, goroutines-pprof, version, heap, bin, cpu, mutex, block].
  ///   - [profileTime] `String`: The amount of time spent profiling. If this is set to 0, then sampling profiles are skipped. Default: 30s.
  ///   - [mutexProfileFraction] `int`: The fraction 1/n of mutex contention events that are reported in the mutex profile. Default: 4.
  ///   - [blockProfileRate] `String`: The duration to wait between sampling goroutine-blocking events for the blocking profile. Default: 1ms.
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-diag-profile
  Future<Map<String, dynamic>> profile({
    String? output,
    List<String>? collectors,
    String? profileTime,
    int? mutexProfileFraction,
    String? blockProfileRate,
  }) async {
    Response? res = await post(
      Ipfs.dio,
      url: "${Ipfs.url}/diag/profile",
      queryParameters: {
        if (output != null) "output": output,
        if (collectors != null) "collectors": "[${collectors.join(" ")}]",
        if (profileTime != null) "profile-time": profileTime,
        if (mutexProfileFraction != null)
          "mutex-profile-fraction": mutexProfileFraction,
        if (blockProfileRate != null) "block-profile-rate": blockProfileRate,
      },
    );

    return interceptDioResponse(res);
  }

  /// Print system diagnostic information.
  /// `/api/v0/diag/sys`
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
  /// See more: https://docs.ipfs.io/reference/http/api/#api-v0-diag-sys
  Future<Map<String, dynamic>> sys() async {
    Response? res = await post(Ipfs.dio, url: "${Ipfs.url}/diag/sys");
    return interceptDioResponse(res);
  }
}
