import '../repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({this.repository});

  String call() {
    return repository.getCurrentUID();
  }
}
