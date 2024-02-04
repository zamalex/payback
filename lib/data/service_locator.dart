import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:payback/data/repository/auth_repo.dart';
import 'package:payback/data/repository/home_repo.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import 'preferences.dart';
import 'http/dio_client.dart';
import 'http/urls.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Http
  sl.registerLazySingleton(() => DioClient(Url.BASE_URL, sl(),
      loggingInterceptor: sl(), token: Url.TOKEN));

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => PrettyDioLogger());

  //utills

  sl.registerLazySingleton(() => PreferenceUtils());

  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => HomeRepository());

}
