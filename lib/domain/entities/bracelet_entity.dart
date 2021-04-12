import 'package:equatable/equatable.dart';

class BraceletEntity extends Equatable {
  final bool isBraceletForOtherUser;
  final String holderFirstName;
  final String holderLastName;
  final DateTime holderDateOfBirth;
  final double holderHeight;
  final double holderWeight;
  final String holderCardiovascularDiseaseHistory;
  final String holderBloodPressureConditionHistory;
  final String holderEmergencyContact;

  final String id;
  final String userId;

  const BraceletEntity({
    this.holderFirstName,
    this.holderLastName,
    this.holderDateOfBirth,
    this.holderHeight,
    this.holderWeight,
    this.holderCardiovascularDiseaseHistory,
    this.holderBloodPressureConditionHistory,
    this.holderEmergencyContact,
    this.isBraceletForOtherUser = true,
    this.id,
    this.userId,
  });

  String get holderFullName => '$holderFirstName $holderLastName';

  @override
  List<Object> get props => [
        holderFirstName,
        holderLastName,
        holderDateOfBirth,
        holderHeight,
        holderWeight,
        holderCardiovascularDiseaseHistory,
        holderBloodPressureConditionHistory,
        holderEmergencyContact,
        id,
        userId,
        isBraceletForOtherUser
      ];

  BraceletEntity copyWith({
    String holderFirstName,
    String holderLastName,
    DateTime holderDateOfBirth,
    double holderHeight,
    double holderWeight,
    String holderCardiovascularDiseaseHistory,
    String holderBloodPressureConditionHistory,
    String holderEmergencyContact,
    String braceletId,
    String userId,
    bool isBraceletForOtherUser,
  }) {
    return BraceletEntity(
      holderFirstName: holderFirstName ?? this.holderFirstName,
      holderLastName: holderLastName ?? this.holderLastName,
      holderDateOfBirth: holderDateOfBirth ?? this.holderDateOfBirth,
      holderHeight: holderHeight ?? this.holderHeight,
      holderWeight: holderWeight ?? this.holderWeight,
      holderCardiovascularDiseaseHistory: holderCardiovascularDiseaseHistory ??
          this.holderCardiovascularDiseaseHistory,
      holderBloodPressureConditionHistory:
          holderBloodPressureConditionHistory ??
              this.holderBloodPressureConditionHistory,
      holderEmergencyContact:
          holderEmergencyContact ?? this.holderEmergencyContact,
      id: braceletId ?? id,
      userId: userId ?? this.userId,
      isBraceletForOtherUser:
          isBraceletForOtherUser ?? this.isBraceletForOtherUser,
    );
  }
}
