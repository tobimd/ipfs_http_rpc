# ipfs_http_rpc

A full implementation for [IPFS HTTP RPC](https://docs.ipfs.io/reference/http/api/).

## Features

- Contains all HTTP RPC [commands listed in reference](https://docs.ipfs.io/reference/http/api/)
- Experimental commands are also added
- All commands have documentation and ease of access.
- Standardized responses.

## Usage

```dart
import 'package:ipfs_http_rpc/ipfs.dart';

// Defaults to: Ipfs(url: "http://127.0.0.1:5001/api/v0").
Ipfs ipfs = Ipfs();
```

### Access all commands with guaranteed responses

```dart
// Successful request
Map<String, dynamic> response = await ipfs.add(path: "/my/local/file.txt", wrapWithDirectory: true);

// response = {
//     "StatusCode": "200",
//     "StatusMessage": "OK"
//     "Name": "file.txt",
//     "Hash": "QmRDebtk...",
//     "Size": "281",
// }
```

```dart
// Unsuccessful request
Map<String, dynamic> response = await ipfs.filestore.ls();

// response = {
//     StatusCode: 500,
//     StatusMessage: Internal Server Error,
//     Message: filestore is not enabled, see https://git.io/vNItf,
//     Code: 0, 
//     Type: error
// }
```

Some commands (like `ipfs refs`), should technically be callable from `ipfs.refs()`. However, because this command also contains subcommands (`ipfs refs local`), it can only be called with `ipfs.refs.self()` as a way to solve the naming conflict:

```dart
    // Does not work:
    ipfs.refs();    
    ipfs.refs.local();

    // DOES work
    ipfs.refs.self();
    ipfs.refs.local();
```

This applies to other commands and subcommands (`bootstrap`, `diag`, etc.).
