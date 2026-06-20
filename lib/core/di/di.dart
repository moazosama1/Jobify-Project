import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:jobify_project/objectbox.g.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class ObjectBoxModule {
  @preResolve
  Future<Store> get store => openStore();
}
