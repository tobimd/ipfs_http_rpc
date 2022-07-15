// ignore_for_file: avoid_print

import 'package:ipfs_http_rpc/ipfs.dart';

void main() async {
  Ipfs ipfs = Ipfs();

  print(await ipfs.filestore.ls());
}
