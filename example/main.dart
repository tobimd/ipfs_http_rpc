// ignore_for_file: avoid_print
import 'package:ipfs_http_rpc/ipfs.dart';

void main() async {
  // Defaults to: Ipfs(url: "http://127.0.0.1:5001/api/v0").
  Ipfs ipfs = Ipfs();

  // Add a file that is locally stored.
  Map<String, dynamic> response = await ipfs.add(path: "example/file.txt");

  // If successful, response will have "Hash" key, but
  // it's also possible to check for "StatusMessage" or other
  // keys depending on the command.
  if (response.containsKey("Hash")) {
    final fileName = response["Name"];
    final fileHash = response["Hash"];

    print("Successfully added file '$fileName' to IPFS!");
    print("The file's hash is $fileHash");

    // Try to read the file's contents.
    Map<String, dynamic> catResponse = await ipfs.cat(path: "/ipfs/$fileHash");

    print(catResponse);
    // Should print:
    // {StatusCode: 200, StatusMessage: OK, Text: Hello!}
  } else {
    print("Couldn't add file to IPFS.");
    print("Response: $response");
  }
}
