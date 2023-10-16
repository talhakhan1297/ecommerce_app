// ignore_for_file: strict_raw_type, inference_failure_on_function_invocation

import 'package:ecommerce_app/common/cache_client/cache_client.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:test/test.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {}

const kApplicationDocumentsPath = 'applicationDocumentsPath';
const cachedString = 'cachedString';
const cacheKey = 'cacheKey';

void main() {
  final hive = MockHiveInterface();
  final box = MockHiveBox();
  PathProviderPlatform.instance = MockPathProviderPlatform();

  group('HiveCacheClient', () {
    when(() => hive.box(any())).thenReturn(box);
    when(() => hive.openBox(any())).thenAnswer((_) async => box);
    when(() => hive.init(any())).thenAnswer((_) {});
    when(() => PathProviderPlatform.instance.getApplicationDocumentsPath())
        .thenAnswer((_) async => kApplicationDocumentsPath);

    test('can be instantiated', () {
      expect(HiveCacheClient(hive: hive), isNotNull);
    });

    test('initialize cache client', () async {
      await HiveCacheClient.initializeCache(hive: hive);
      verify(() => hive.init(any())).called(1);
      verify(() => hive.openBox(any())).called(1);
    });

    test('initialize cache client with real hive', () async {
      await HiveCacheClient.initializeCache();
    });

    test('read successfully', () async {
      final client = HiveCacheClient(hive: hive);

      when(() => box.get(any())).thenReturn(cachedString);

      final value = client.read<String>(key: cacheKey);

      verify(() => box.get(any())).called(1);
      expect(value, cachedString);
    });

    test('read fails with null', () async {
      final client = HiveCacheClient(hive: hive);

      when(() => box.get(any())).thenReturn(cachedString);

      final value = client.read<int>(key: cacheKey);

      verify(() => box.get(any())).called(1);
      expect(value, null);
    });

    test('write to cache', () async {
      final client = HiveCacheClient(hive: hive);

      when(() => box.put(any(), any())).thenAnswer((_) async {});

      client.write<String>(key: cacheKey, value: cachedString);

      verify(() => box.put(any(), any())).called(1);
    });

    test('clear cache', () async {
      final client = HiveCacheClient(hive: hive);

      when(box.clear).thenAnswer((_) async => 1);

      await client.clear();

      verify(box.clear).called(1);
    });

    test('close cache', () async {
      final client = HiveCacheClient(hive: hive);

      when(box.close).thenAnswer((_) async {});

      await client.close();

      verify(box.close).called(1);
    });
  });
}
