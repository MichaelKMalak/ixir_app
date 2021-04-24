import '../repositories/firebase_repository.dart';

class ResendPhoneVerificationUseCase {
  final FirebaseRepository repository;

  ResendPhoneVerificationUseCase({this.repository});

  Future<void> call(String phoneNumber) async {
    return repository.sendPhoneVerification(phoneNumber);
  }
}
