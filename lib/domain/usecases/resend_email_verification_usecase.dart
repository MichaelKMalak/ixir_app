import '../repositories/firebase_repository.dart';

class ResendEmailVerificationUseCase {
  final FirebaseRepository repository;

  ResendEmailVerificationUseCase({this.repository});

  Future<void> call() async {
    return repository.sendEmailVerification();
  }
}
