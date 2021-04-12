import 'dart:async';

import '../../domain/entities/bracelet_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasource/firebase_remote_datasource.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({this.remoteDataSource});
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.addUser(user);

  @override
  String getCurrentUID() => remoteDataSource.getCurrentUID();

  @override
  bool isSignIn() => remoteDataSource.isSignIn();

  @override
  bool isEmailVerified() => remoteDataSource.isEmailVerified();

  @override
  Stream<bool> isEmailVerifiedStream() =>
      remoteDataSource.isEmailVerifiedStream();

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> sendSmsVerification(String phoneNumber) async =>
      remoteDataSource.signUpWithPhoneNumber(phoneNumber);

  @override
  Stream<UserEntity> getUserStream() => remoteDataSource.getUserStream();

  @override
  Future<bool> signUpWithSmsCode(UserEntity user, String smsPinCode) async {
    final successSms = await remoteDataSource.signUpVerifySms(smsPinCode, user);
    return successSms;
  }

  @override
  Future<void> signUpWithEmail(UserEntity userEntity) =>
      remoteDataSource.signUpWithEmail(userEntity);

  @override
  Future<void> signInWithEmail(String email, String password) =>
      remoteDataSource.signInWithEmail(email, password);

  @override
  Future<void> signInWithPhoneNumber(String phone, String password) =>
      remoteDataSource.signInWithPhoneNumber(phone, password);

  @override
  Future<bool> isBraceletSerialValid(String id) =>
      remoteDataSource.isBraceletSerialValid(id);

  @override
  Future<bool> registerBracelet(BraceletEntity bracelet) =>
      remoteDataSource.registerBracelet(bracelet);

  @override
  Future<bool> isPhoneNumberValid() async {
    final completer = Completer<bool>();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final isValid = remoteDataSource.isPhoneNumberValid();
      if (isValid) {
        timer.cancel();
        completer.complete(true);
      }
      if (timer.tick > 60) {
        timer.cancel();
        completer.complete(false);
      }
    });

    return completer.future;
  }

  @override
  Future<void> sendEmailVerification() =>
      remoteDataSource.sendEmailVerification();

  @override
  Future<void> sendPhoneVerification(String phoneNumber) =>
      remoteDataSource.sendPhoneVerification(phoneNumber);
}
