import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    DateTime dateOfBirth,
    String braceletId,
    String uid,
    String password,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          braceletId: braceletId,
          uid: uid,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data();
    return UserModel(
      email: data['email'] as String,
      phoneNumber: data['phone_number'] as String,
      uid: data['uid'] as String,
      lastName: data['last_name'] as String,
      braceletId: data['bracelet_id'] as String,
      dateOfBirth: DateTime.parse(data['date_of_birth'] as String)?.toLocal(),
      firstName: data['first_name'] as String,
    );
  }

  Map<String, String> toDocument() {
    return {
      'email': email,
      'phone_number': phoneNumber,
      'uid': uid,
      'last_name': lastName,
      'bracelet_id': braceletId,
      'date_of_birth': dateOfBirth?.toUtc()?.toIso8601String(),
      'first_name': firstName,
    };
  }

  UserModel.fromEntity(UserEntity user)
      : super(
            firstName: user.firstName,
            lastName: user.lastName,
            phoneNumber: user.phoneNumber,
            dateOfBirth: user.dateOfBirth,
            braceletId: user.braceletId,
            email: user.email,
            uid: user.uid);

  UserModel copyWith({
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    DateTime dateOfBirth,
    String braceletId,
    String uid,
    String password,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      braceletId: braceletId ?? this.braceletId,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
      password: password ?? this.password,
    );
  }
}
