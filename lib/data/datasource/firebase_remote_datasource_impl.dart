import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/bracelet_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../model/bracelet_model.dart';
import '../model/user_model.dart';
import 'firebase_remote_datasource.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  String _verificationId;
  int _resendToken;

  FirebaseRemoteDataSourceImpl({this.auth, this.fireStore});

  @override
  bool isPhoneNumberValid() => _verificationId != null;

  @override
  void addUser(UserEntity user) {
    final uid = getCurrentUID();
    final userCollection = fireStore.collection('users');

    userCollection.doc(uid).get().then((userDoc) {
      if (!userDoc.exists) {
        final newUser =
            UserModel.fromEntity(user).copyWith(uid: uid).toDocument();
        userCollection.doc(uid).set(newUser);
      } else {
        throw Exception('User already exists');
      }
    }).catchError((e) {
      throw Exception(e.toString());
    });
  }

  @override
  Future<bool> registerBracelet(BraceletEntity bracelet) async {
    final uid = getCurrentUID();
    final braceletId = bracelet.id;
    final doc = fireStore.collection('bracelets').doc(braceletId);

    await doc.get().then((braceletDoc) async {
      if (!braceletDoc.exists) {
        throw Exception('Bracelet Id is not valid');
      } else if (braceletDoc.data()['user_id'] != null) {
        throw Exception('Bracelet is Connected to Another User');
      }

      final registeredBracelet =
          BraceletModel.fromEntity(bracelet.copyWith(userId: uid)).toDocument();
      doc.set(registeredBracelet);

      final userCollection = fireStore.collection('users');

      await userCollection.doc(uid).get().then((userDoc) {
        if (userDoc.exists) {
          userCollection.doc(uid).update({'bracelet_id': braceletId});
        } else {
          throw Exception("User doesn't exist");
        }
      }).catchError((e) {
        throw Exception(e.toString());
      });
    }).catchError((e) {
      throw Exception(e.toString());
    });

    return true;
  }

  @override
  String getCurrentUID() => auth.currentUser.uid;

  @override
  bool isSignIn() => auth?.currentUser?.uid != null;

  @override
  bool isEmailVerified({User user}) {
    final currentUser = user ?? auth.currentUser;
    return currentUser?.phoneNumber != null ||
        (auth.currentUser?.phoneNumber == null &&
            auth.currentUser?.emailVerified != null &&
            auth.currentUser.emailVerified);
  }

  @override
  Future<bool> signUpVerifySms(
      String smsCode, UserEntity userWithoutEmail) async {
    try {
      final phoneCredentials = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);
      final user = UserModel.fromEntity(userWithoutEmail).copyWith(
        email: 'phone${userWithoutEmail.phoneNumber}@phone-ixir.com',
        password: userWithoutEmail.password,
      );
      final emailCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      await emailCredentials.user.linkWithCredential(phoneCredentials);
      addUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      throw Exception('An Error has occurred. Try again later.');
    }
    return true;
  }

  @override
  Future<void> signInWithPhoneNumber(String phone, String password) async {
    await signInWithEmail('phone$phone@phone-ixir.com', password);
  }

  @override
  Future<void> signOut() async {
    if (isSignIn()) {
      await auth.signOut();
    }
  }

  @override
  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    await signOut();
    _verificationId = null;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        _verificationId = credential.verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          throw Exception('The provided phone number is not valid.');
        }
        throw Exception(e.message);
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Stream<UserEntity> getUserStream() {
    final uid = getCurrentUID();
    final userStream = fireStore.collection('users').doc(uid).snapshots();
    return userStream.map((event) {
      //TODO: if (!event.exists) auth.delete?
      return UserModel.fromSnapshot(event);
    });
  }

  @override
  Future<void> signUpWithEmail(UserEntity user) async {
    try {
      await signOut();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      addUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw Exception('Invalid User Credentials');
      }
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = auth?.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> sendPhoneVerification(String phoneNumber) async {
    await signOut();
    _verificationId = null;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        _verificationId = credential.verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          throw Exception('The provided phone number is not valid.');
        }
        throw Exception(e.message);
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Stream<bool> isEmailVerifiedStream() =>
      auth.authStateChanges().map((user) => isEmailVerified(user: user));

  @override
  Future<bool> isBraceletSerialValid(String id) async {
    final DocumentSnapshot bracelet = await fireStore
        .collection('bracelets')
        .doc(id)
        .get()
        .catchError((e) => throw Exception(e.toString()));

    if (!bracelet.exists) {
      throw Exception('Bracelet Id is not valid');
    } else if (bracelet.data()['user_id'] != null) {
      throw Exception('Bracelet is Connected to Another User');
    }

    return true;
  }
}
