// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_example_annotaion.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterHash() => r'94c0f59fca83b5dd9caa740ea78e52da3df92e54';

/// See also [counter].
@ProviderFor(counter)
final counterProvider = AutoDisposeProvider<int>.internal(
  counter,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CounterRef = AutoDisposeProviderRef<int>;
String _$userDataHash() => r'9e9b2afc8149816c61e632cd777ef551c911f2ca';

/// See also [userData].
@ProviderFor(userData)
final userDataProvider = AutoDisposeFutureProvider<String>.internal(
  userData,
  name: r'userDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDataRef = AutoDisposeFutureProviderRef<String>;
String _$nameHash() => r'1c9f6aac63803c49938a658304bcb650a0956fc7';

/// See also [Name].
@ProviderFor(Name)
final nameProvider = AutoDisposeNotifierProvider<Name, String>.internal(
  Name.new,
  name: r'nameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Name = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
