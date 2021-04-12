import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class SignUpWithEmailUseCase {
  final FirebaseRepository repository;

  SignUpWithEmailUseCase({this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signUpWithEmail(user);
  }
}
