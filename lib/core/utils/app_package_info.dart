import 'package:package_info_plus/package_info_plus.dart';

class AppPackageInfo {
  AppPackageInfo._();

  static final AppPackageInfo instance = AppPackageInfo._();

  static late final PackageInfo _packageInfo;

  static Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get versionString => _packageInfo.version;
  static String get buildNumber => _packageInfo.buildNumber;
  static String get appName => _packageInfo.appName;
}
