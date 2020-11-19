import 'package:flutter_clean_architecture/di/config_inject.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(generateForDir: ["lib/di", "lib"])
void configureDependencies() => $initGetIt(getIt);
