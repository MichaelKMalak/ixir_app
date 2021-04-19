import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import '../../../domain/usecases/resend_phone_verification_usecase.dart';
import '../../../domain/usecases/sign_in_with_phone_number_usecase.dart';
import '../../../domain/usecases/sign_up_with_sms_verification_usecase.dart';
import '../../../domain/usecases/verify_phone_number_usecase.dart';
import '../../utils/error_message_provider.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final SignUpWithSmsVerificationUseCase signUpWithSmsVerificationUseCase;
  final ResendPhoneVerificationUseCase resendPhoneVerificationUseCase;
  final IsSignInUseCase isSignInUseCase;

  PhoneAuthCubit(
      {@required this.signInWithPhoneNumberUseCase,
      @required this.verifyPhoneNumberUseCase,
      @required this.signUpWithSmsVerificationUseCase,
      @required this.resendPhoneVerificationUseCase,
      @required this.isSignInUseCase})
      : super(PhoneAuthInitial());

  Future<void> signUpWithPhoneNumber({@required String phoneNumber}) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);

      final isSuccess = await verifyPhoneNumberUseCase.isSuccess();
      if (isSuccess) {
        emit(PhoneAuthSmsCodeReceived());
      } else {
        emit(PhoneAuthFailure());
      }
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode({UserEntity userEntity, String smsCode}) async {
    emit(PhoneAuthLoading());
    try {
      await signUpWithSmsVerificationUseCase.call(userEntity, smsCode);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    }

    final isSuccess = isSignInUseCase.call();
    if (isSuccess) {
      emit(PhoneAuthSuccess());
    } else {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> resendPhoneVerification(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await resendPhoneVerificationUseCase.call(phoneNumber);
      emit(PhoneAuthInitial());
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(PhoneAuthFailure());
    }
  }
}
