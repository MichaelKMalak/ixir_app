import '../repositories/firebase_repository.dart';

class SignInWithEmailUseCase {
  final FirebaseRepository repository;

  SignInWithEmailUseCase({this.repository});

  Future<void> call(String email, String password) async {
    return repository.signInWithEmail(email, password);
  }
}
