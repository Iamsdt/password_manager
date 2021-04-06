// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../controller/app_controller.dart' as _i6;
import '../controller/auth/check_master_pass_controller.dart' as _i9;
import '../controller/auth/login_controller.dart' as _i11;
import '../controller/auth/master_pass_controller.dart' as _i12;
import '../controller/auth/security_question_controller.dart' as _i13;
import '../controller/auth/signup_controller.dart' as _i4;
import '../controller/card/card_controller.dart' as _i7;
import '../controller/categories/categories_controller.dart' as _i8;
import '../controller/home/home_controller.dart' as _i10;
import '../controller/recover/security_question_controller.dart' as _i14;
import '../db/store.dart' as _i5;
import '../repo/auth_layer.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthLayer>(() => _i3.AuthLayer());
  gh.lazySingleton<_i4.SignupController>(
      () => _i4.SignupController(get<_i3.AuthLayer>()));
  gh.lazySingleton<_i5.Store>(() => _i5.Store());
  gh.lazySingleton<_i6.AppController>(
      () => _i6.AppController(get<_i5.Store>()));
  gh.lazySingleton<_i7.CardController>(
      () => _i7.CardController(get<_i5.Store>()));
  gh.lazySingleton<_i8.CategoriesController>(
      () => _i8.CategoriesController(get<_i5.Store>()));
  gh.lazySingleton<_i9.CheckMasterPassController>(
      () => _i9.CheckMasterPassController(get<_i5.Store>()));
  gh.lazySingleton<_i10.HomeController>(
      () => _i10.HomeController(get<_i5.Store>()));
  gh.lazySingleton<_i11.LoginController>(
      () => _i11.LoginController(get<_i3.AuthLayer>(), get<_i5.Store>()));
  gh.lazySingleton<_i12.MasterPassController>(
      () => _i12.MasterPassController(get<_i5.Store>()));
  gh.lazySingleton<_i13.RecoverQuestionController>(
      () => _i13.RecoverQuestionController(get<_i5.Store>()));
  gh.lazySingleton<_i14.SecurityQuestionController>(
      () => _i14.SecurityQuestionController(get<_i5.Store>()));
  return get;
}
