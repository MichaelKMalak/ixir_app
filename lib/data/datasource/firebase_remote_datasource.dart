import '../../domain/entities/bracelet_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  /// Email Auth
  Future<void> signUpWithEmail(UserEntity userEntity);
  Future<void> sendEmailVerification();
  Future<void> signInWithEmail(String email, String password);

  /// Phone Auth
  Future<void> signUpWithPhoneNumber(String phoneNumber);
  Future<bool> signUpVerifySms(String smsPinCode, UserEntity user);
  void addUser(UserEntity user);
  Stream<bool> isEmailVerifiedStream();
  Future<void> signInWithPhoneNumber(String phone, String password);
  bool isPhoneNumberValid();
  Future<void> sendPhoneVerification(String phoneNumber);

  /// Auth
  String getCurrentUID();
  bool isSignIn();
  bool isEmailVerified();
  Future<void> signOut();
  Stream<UserEntity> getUserStream();

  /// Bracelet
  Future<bool> isBraceletSerialValid(String id);
  Future<bool> registerBracelet(BraceletEntity bracelet);
}
