import '../repositories/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;

  IsSignInUseCase({this.repository});

  bool call() {
    return repository.isSignIn();
  }
}
