import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import '../../../domain/usecases/resend_email_verification_usecase.dart';
import '../../../domain/usecases/sign_in_with_email_usecase.dart';
import '../../../domain/usecases/sign_in_with_phone_number_usecase.dart';
import '../../../domain/usecases/sign_up_with_email_usecase.dart';
import '../../utils/error_message_provider.dart';

part 'email_auth_state.dart';

class EmailAuthCubit extends Cubit<EmailAuthState> {
  final SignUpWithEmailUseCase signUpWithEmailUseCase;
  final SignInWithEmailUseCase signInWithEmailUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final ResendEmailVerificationUseCase sendEmailVerificationUseCase;

  EmailAuthCubit({
    @required this.signUpWithEmailUseCase,
    @required this.isSignInUseCase,
    @required this.signInWithEmailUseCase,
    @required this.signInWithPhoneNumberUseCase,
    @required this.sendEmailVerificationUseCase,
  }) : super(EmailAuthInitial());

  Future<void> signUpWithEmail({@required UserEntity user}) async {
    emit(EmailAuthLoading());
    try {
      await signUpWithEmailUseCase.call(user);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    }

    final isSuccess = isSignInUseCase.call();
    if (isSuccess) {
      emit(EmailAuthSuccess());
    } else {
      emit(EmailAuthFailure());
    }
  }

  Future<void> signInWithEmail(
      {@required String email, @required String password}) async {
    emit(EmailAuthLoading());
    try {
      await signInWithEmailUseCase.call(email, password);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    }

    final isSuccess = isSignInUseCase.call();
    if (isSuccess) {
      emit(EmailAuthSuccess());
    } else {
      emit(EmailAuthFailure());
    }
  }

  Future<void> signInWithPhoneNumber(
      {@required String phone, @required String password}) async {
    emit(EmailAuthLoading());
    try {
      await signInWithPhoneNumberUseCase.call(phone, password);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    }

    final isSuccess = isSignInUseCase.call();
    if (isSuccess) {
      emit(EmailAuthSuccess());
    } else {
      emit(EmailAuthFailure());
    }
  }

  Future<void> sendEmailConfirmation() async {
    emit(EmailAuthLoading());
    try {
      await sendEmailVerificationUseCase.call();
      emit(EmailAuthSuccess());
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(EmailAuthFailure());
    }
  }
}
