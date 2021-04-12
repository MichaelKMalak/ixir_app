import '../repositories/firebase_repository.dart';

class IsEmailVerifiedUseCase {
  final FirebaseRepository repository;

  IsEmailVerifiedUseCase({this.repository});

  bool call() {
    return repository.isEmailVerified();
  }
}
