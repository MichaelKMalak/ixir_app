import '../repositories/firebase_repository.dart';

class SignInWithPhoneNumberUseCase {
  final FirebaseRepository repository;

  SignInWithPhoneNumberUseCase({this.repository});

  Future<void> call(String phone, String password) async {
    return repository.signInWithPhoneNumber(phone, password);
  }
}
