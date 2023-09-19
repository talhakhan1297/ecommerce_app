// ignore_for_file: strict_raw_type

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = Hive.box('cache');

  final Box _cache;

  static Future<void> initializeCache() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    Hive.init('$appDocPath/cache');
    // ignore: inference_failure_on_function_invocation
    await Hive.openBox('cache');
  }

  /// Writes the provide [key], [value] pair to the local storage cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache.put(key, value);
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache.get(key);
    if (value is T) return value;
    return null;
  }

  /// Deletes the value for the provided [key].
  void delete({required String key}) {
    _cache.delete(key);
  }

  Future<void> clear() async {
    await _cache.clear();
  }

  Future<void> close() async {
    await _cache.close();
  }
}
