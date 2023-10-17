import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'hive_cache_client.dart';

/// {@template cache_client}
/// A simple cache client.
/// {@endtemplate}
abstract class CacheClient {
  /// Writes the provide [key], [value] pair to the cache.
  void write<T extends Object>({required String key, required T value});

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key});

  /// Deletes the value for the provided [key].
  /// Does nothing if no value exists for the provided key.
  Future<void> delete<T extends Object>({required String key});

  /// Clears all the cached data.
  Future<void> clear();

  /// Closes and dispose the cache client.
  Future<void> close();
}
