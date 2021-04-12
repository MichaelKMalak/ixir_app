import '../entities/bracelet_entity.dart';
import '../repositories/firebase_repository.dart';

class RegisterBraceletUseCase {
  final FirebaseRepository repository;

  RegisterBraceletUseCase({this.repository});

  Future<bool> call(BraceletEntity braceletEntity) {
    return repository.registerBracelet(braceletEntity);
  }
}
