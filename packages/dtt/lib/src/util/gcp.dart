import 'dart:io';

Future<String?> resolveGcloudAuthToken() async {
  final adcTokenRes = await Process.run('gcloud', [
    'auth',
    'application-default',
    'print-access-token',
  ]);
  if (adcTokenRes.exitCode == 0) {
    final token = (adcTokenRes.stdout as String).trim();
    if (token.isNotEmpty) {
      return token;
    }
  }
  return null;
}
