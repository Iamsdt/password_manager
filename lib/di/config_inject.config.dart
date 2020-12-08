// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../controller/app_controller.dart';
import '../repo/auth_layer.dart';
import '../controller/card/card_controller.dart';
import '../controller/categories/categories_controller.dart';
import '../controller/auth/check_master_pass_controller.dart';
import '../controller/home/home_controller.dart';
import '../controller/auth/login_controller.dart';
import '../controller/auth/master_pass_controller.dart';
import '../controller/auth/security_question_controller.dart';
import '../controller/recover/security_question_controller.dart';
import '../controller/auth/signup_controller.dart';
import '../db/store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<AuthLayer>(() => AuthLayer());
  gh.lazySingleton<SignupController>(() => SignupController(get<AuthLayer>()));
  gh.lazySingleton<Store>(() => Store());
  gh.lazySingleton<AppController>(() => AppController(get<Store>()));
  gh.lazySingleton<CardController>(() => CardController(get<Store>()));
  gh.lazySingleton<CategoriesController>(
      () => CategoriesController(get<Store>()));
  gh.lazySingleton<CheckMasterPassController>(
      () => CheckMasterPassController(get<Store>()));
  gh.lazySingleton<HomeController>(() => HomeController(get<Store>()));
  gh.lazySingleton<LoginController>(
      () => LoginController(get<AuthLayer>(), get<Store>()));
  gh.lazySingleton<MasterPassController>(
      () => MasterPassController(get<Store>()));
  gh.lazySingleton<RecoverQuestionController>(
      () => RecoverQuestionController(get<Store>()));
  gh.lazySingleton<SecurityQuestionController>(
      () => SecurityQuestionController(get<Store>()));
  return get;
}
