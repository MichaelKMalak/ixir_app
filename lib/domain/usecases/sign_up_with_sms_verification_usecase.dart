import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class SignUpWithSmsVerificationUseCase {
  final FirebaseRepository repository;

  SignUpWithSmsVerificationUseCase({this.repository});

  Future<bool> call(UserEntity user, String smsPinCode) async {
    return repository.signUpWithSmsCode(user, smsPinCode);
  }
}
