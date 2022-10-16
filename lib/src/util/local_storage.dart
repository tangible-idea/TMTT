
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// LS == LocalStorage
class LocalStorage {

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> deleteAll() async {
    await _storage.deleteAll(
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  static Future<void> put(String key, Object? value) async {

    var _value = '';

    if (value == null) {
      await _storage.delete(
          key: key,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions()
      );
    }
    else if (value is String) {
      _value = value.toString();
    }
    else if (value is int) {
      _value = value.toString();
    }
    else if (value is bool) {
      _value = value.toString();
    }
    else if (value is double) {
      _value = value.toString();
    } else {
      return;
    }

    await _storage.write(
        key: key,
        value: _value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  static Future<T> get<T>(String key, T defaultValue) async {

    var value = await _storage.read(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );

    if (value == null) {
      return defaultValue;
    }

    if (defaultValue is String) {
      return value.toString() as T;
    }
    else if (defaultValue is int) {
      return int.parse(value) as T;
    }
    else if (defaultValue is bool) {
      return (value == '1' || value == 'true') as T;
    }
    else if (defaultValue is double) {
      return double.parse(value) as T;
    }
    else {
      return defaultValue;
    }
  }

  static IOSOptions _getIOSOptions() => const IOSOptions(
    accountName: "ios local storage",
  );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
}
