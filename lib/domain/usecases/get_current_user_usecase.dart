import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class GetCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCurrentUserUseCase({this.repository});

  Stream<UserEntity> call() {
    return repository.getUserStream();
  }
}
