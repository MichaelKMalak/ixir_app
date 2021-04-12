import '../repositories/firebase_repository.dart';

class IsBraceletIdValidUseCase {
  final FirebaseRepository repository;

  IsBraceletIdValidUseCase({this.repository});

  Future<bool> call(String id) {
    return repository.isBraceletSerialValid(id);
  }
}
