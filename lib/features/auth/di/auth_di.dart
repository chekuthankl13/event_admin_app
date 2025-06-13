import 'package:event_admin/features/auth/cubit/login_cubit.dart';
import 'package:event_admin/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:event_admin/features/auth/data/repository/auth_repository_impl.dart';
import 'package:event_admin/features/auth/domain/repository/auth_repository.dart';
import 'package:event_admin/features/auth/domain/usecase/login_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> authInit(GetIt sl) async {
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(),dbService: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
}
