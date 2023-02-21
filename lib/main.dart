import 'package:broking/environment.dart';
import 'package:broking/main_common.dart';

Future<void> main() async {
  await mainCommon(Environment.PROD);
}

