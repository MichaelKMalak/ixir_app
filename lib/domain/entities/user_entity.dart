import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String braceletId;
  final String uid;

  final String password; //only used in sign up

  String get fullName => '$firstName $lastName';

  const UserEntity({
    this.firstName,
    this.password,
    this.dateOfBirth,
    this.braceletId,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.uid,
  });

  @override
  List<Object> get props => [
        firstName,
        password,
        dateOfBirth,
        braceletId,
        lastName,
        email,
        phoneNumber,
        uid,
      ];
}
