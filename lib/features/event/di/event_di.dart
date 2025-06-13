import 'package:event_admin/features/event/cubit/event_cubit.dart';
import 'package:event_admin/features/event/data/data_source/event_remote_data_source.dart';
import 'package:event_admin/features/event/data/repository/event_repository_impl.dart';
import 'package:event_admin/features/event/domain/repository/event_repository.dart';
import 'package:event_admin/features/event/domain/usecase/create_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/delete_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/load_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/update_event_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> eventInit(GetIt sl) async {
  sl.registerFactory(() => EventCubit(sl(),sl(),sl(),sl()));
  sl.registerLazySingleton(() => LoadEventUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteEventUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateEventUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateEventUsecase(repository: sl()));




  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(client: sl(),dbService: sl()),
  );
}
