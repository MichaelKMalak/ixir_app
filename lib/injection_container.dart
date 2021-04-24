import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'data/datasource/firebase_remote_datasource.dart';
import 'data/datasource/firebase_remote_datasource_impl.dart';
import 'data/local_datasource/local_datasource.dart';
import 'data/repositories/firebase_repository_impl.dart';
import 'domain/repositories/firebase_repository.dart';
import 'domain/usecases/get_current_uid_usecase.dart';
import 'domain/usecases/get_current_user_usecase.dart';
import 'domain/usecases/is_bracelet_id_valid_usecase.dart';
import 'domain/usecases/is_email_verified_usecase.dart';
import 'domain/usecases/is_sign_in_usecase.dart';
import 'domain/usecases/register_bracelet_usecase.dart';
import 'domain/usecases/resend_email_verification_usecase.dart';
import 'domain/usecases/resend_phone_verification_usecase.dart';
import 'domain/usecases/sign_in_with_email_usecase.dart';
import 'domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/sign_up_with_email_usecase.dart';
import 'domain/usecases/sign_up_with_sms_verification_usecase.dart';
import 'domain/usecases/verify_phone_number_usecase.dart';
import 'presentation/bloc/auth/auth_cubit.dart';
import 'presentation/bloc/connect_bracelet/connect_bracelet_cubit.dart';
import 'presentation/bloc/email_auth/email_auth_cubit.dart';
import 'presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'presentation/bloc/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Futures bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        signOutUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentUidUseCase: sl.call(),
        isEmailVerifiedUseCase: sl.call(),
      ));
  sl.registerFactory<PhoneAuthCubit>(() => PhoneAuthCubit(
        signInWithPhoneNumberUseCase: sl.call(),
        verifyPhoneNumberUseCase: sl.call(),
        signUpWithSmsVerificationUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        resendPhoneVerificationUseCase: sl.call(),
      ));
  sl.registerFactory<EmailAuthCubit>(() => EmailAuthCubit(
        signUpWithEmailUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        signInWithEmailUseCase: sl.call(),
        signInWithPhoneNumberUseCase: sl.call(),
        sendEmailVerificationUseCase: sl.call(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCurrentUserUseCase: sl.call(),
      ));

  sl.registerFactory<ConnectBraceletCubit>(() => ConnectBraceletCubit(
        isBraceletIdValidUseCase: sl.call(),
        registerBraceletUseCase: sl.call(),
      ));

  /// useCase
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
      () => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
      () => VerifyPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpWithSmsVerificationUseCase>(
      () => SignUpWithSmsVerificationUseCase(repository: sl.call()));
  sl.registerLazySingleton<ResendEmailVerificationUseCase>(
      () => ResendEmailVerificationUseCase(repository: sl.call()));
  sl.registerLazySingleton<ResendPhoneVerificationUseCase>(
      () => ResendPhoneVerificationUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpWithEmailUseCase>(
      () => SignUpWithEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsEmailVerifiedUseCase>(
      () => IsEmailVerifiedUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithEmailUseCase>(
      () => SignInWithEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsBraceletIdValidUseCase>(
      () => IsBraceletIdValidUseCase(repository: sl.call()));
  sl.registerLazySingleton<RegisterBraceletUseCase>(
      () => RegisterBraceletUseCase(repository: sl.call()));

  /// repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  /// remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(
            auth: sl.call(),
            fireStore: sl.call(),
          ));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
