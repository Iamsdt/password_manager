// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../controller/app_controller.dart';
import '../controller/categories/categories_controller.dart';
import '../controller/home_controller.dart';
import '../db/store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<CategoriesController>(() => CategoriesController());
  gh.lazySingleton<HomeController>(() => HomeController());
  gh.lazySingleton<Store>(() => Store());
  gh.lazySingleton<AppController>(() => AppController(get<Store>()));
  return get;
}
