import '../repositories/firebase_repository.dart';

class VerifyPhoneNumberUseCase {
  final FirebaseRepository repository;

  VerifyPhoneNumberUseCase({this.repository});

  Future<void> call(String phoneNumber) async {
    return repository.sendSmsVerification(phoneNumber);
  }

  Future<bool> isSuccess() => repository.isPhoneNumberValid();
}
