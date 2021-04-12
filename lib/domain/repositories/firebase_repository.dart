import '../entities/bracelet_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> sendSmsVerification(String phoneNumber);
  Future<void> signUpWithEmail(UserEntity userEntity);
  Future<void> signInWithEmail(String email, String password);

  bool isSignIn();
  bool isEmailVerified();
  Stream<bool> isEmailVerifiedStream();
  Future<void> sendEmailVerification();

  Future<bool> isPhoneNumberValid();
  Future<void> signInWithPhoneNumber(String phone, String password);

  Future<void> signOut();
  String getCurrentUID();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<bool> signUpWithSmsCode(UserEntity user, String smsPinCode);
  Stream<UserEntity> getUserStream();
  Future<void> sendPhoneVerification(String phoneNumber);

  /// Bracelet
  Future<bool> isBraceletSerialValid(String id);
  Future<bool> registerBracelet(BraceletEntity bracelet);
}
