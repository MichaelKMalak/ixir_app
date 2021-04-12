import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/bracelet_entity.dart';

class BraceletModel extends BraceletEntity {
  const BraceletModel({
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
  }) : super(
            holderFirstName: holderFirstName,
            holderLastName: holderLastName,
            holderDateOfBirth: holderDateOfBirth,
            holderHeight: holderHeight,
            holderWeight: holderWeight,
            holderCardiovascularDiseaseHistory:
                holderCardiovascularDiseaseHistory,
            holderBloodPressureConditionHistory:
                holderBloodPressureConditionHistory,
            holderEmergencyContact: holderEmergencyContact,
            id: braceletId,
            userId: userId,
            isBraceletForOtherUser: isBraceletForOtherUser);

  factory BraceletModel.fromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data();
    final isBraceletForOtherUser =
        snapshot.data()['is_bracelet_for_other_user'] as bool ?? true;
    if (isBraceletForOtherUser) {
      return BraceletModel(
        isBraceletForOtherUser: isBraceletForOtherUser,
        holderHeight: snapshot.data()['holder_height'] as double,
        holderWeight: snapshot.data()['holder_weight'] as double,
        holderCardiovascularDiseaseHistory:
            snapshot.data()['holder_cardiovascular_disease_history'] as String,
        holderBloodPressureConditionHistory: snapshot
            .data()['holder_blood_pressure_condition_history'] as String,
        holderEmergencyContact:
            snapshot.data()['holder_emergency_contact'] as String,
        braceletId: snapshot.data()['bracelet_id'] as String,
        userId: snapshot.data()['user_id'] as String,
      );
    }
    return BraceletModel(
      isBraceletForOtherUser: isBraceletForOtherUser,
      holderFirstName: snapshot.data()['holder_first_name'] as String,
      holderLastName: snapshot.data()['holder_last_name'] as String,
      holderDateOfBirth:
          DateTime.parse(data['holder_date_of_birth'] as String)?.toLocal(),
      holderHeight: snapshot.data()['holder_height'] as double,
      holderWeight: snapshot.data()['holder_weight'] as double,
      holderCardiovascularDiseaseHistory:
          snapshot.data()['holder_cardiovascular_disease_history'] as String,
      holderBloodPressureConditionHistory:
          snapshot.data()['holder_blood_pressure_condition_history'] as String,
      holderEmergencyContact:
          snapshot.data()['holder_emergency_contact'] as String,
      braceletId: snapshot.data()['bracelet_id'] as String,
      userId: snapshot.data()['user_id'] as String,
    );
  }

  Map<String, String> toDocument() {
    if (isBraceletForOtherUser) {
      return {
        'is_bracelet_for_other_user': isBraceletForOtherUser.toString(),
        'holder_height': holderHeight?.toString(),
        'holder_weight': holderWeight?.toString(),
        'bracelet_id': id,
        'holder_cardiovascular_disease_history':
            holderCardiovascularDiseaseHistory,
        'holder_blood_pressure_condition_history':
            holderBloodPressureConditionHistory,
        'holder_emergency_contact': holderEmergencyContact,
        'user_id': userId,
      };
    }
    return {
      'is_bracelet_for_other_user': isBraceletForOtherUser.toString(),
      'holder_first_name': holderFirstName,
      'holder_last_name': holderLastName,
      'holder_height': holderHeight?.toString(),
      'holder_weight': holderWeight?.toString(),
      'bracelet_id': id,
      'holder_date_of_birth': holderDateOfBirth?.toUtc()?.toIso8601String(),
      'holder_cardiovascular_disease_history':
          holderCardiovascularDiseaseHistory,
      'holder_blood_pressure_condition_history':
          holderBloodPressureConditionHistory,
      'holder_emergency_contact': holderEmergencyContact,
      'user_id': userId,
    };
  }

  BraceletModel.fromEntity(BraceletEntity bracelet)
      : super(
            holderFirstName: bracelet.holderFirstName,
            holderLastName: bracelet.holderLastName,
            holderDateOfBirth: bracelet.holderDateOfBirth,
            holderHeight: bracelet.holderHeight,
            holderWeight: bracelet.holderWeight,
            holderCardiovascularDiseaseHistory:
                bracelet.holderCardiovascularDiseaseHistory,
            holderBloodPressureConditionHistory:
                bracelet.holderBloodPressureConditionHistory,
            holderEmergencyContact: bracelet.holderEmergencyContact,
            id: bracelet.id,
            userId: bracelet.userId,
            isBraceletForOtherUser: bracelet.isBraceletForOtherUser);
}
