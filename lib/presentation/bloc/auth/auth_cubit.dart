import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/get_current_uid_usecase.dart';
import '../../../domain/usecases/is_email_verified_usecase.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';
import '../../utils/error_message_provider.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final IsEmailVerifiedUseCase isEmailVerifiedUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    @required this.isSignInUseCase,
    @required this.signOutUseCase,
    @required this.getCurrentUidUseCase,
    @required this.isEmailVerifiedUseCase,
  }) : super(AuthInitial());

  void checkAuth() {
    try {
      final bool isSignIn = isSignInUseCase.call();
      final bool isEmailVerified = isEmailVerifiedUseCase.call();

      if (isSignIn) {
        final uid = getCurrentUidUseCase.call();
        if (isEmailVerified) {
          emit(Authenticated(uid: uid));
        } else {
          emit(AuthenticatedEmailNotVerified(uid: uid));
        }
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(UnAuthenticated());
    }
  }

  Future<void> logOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (e) {
      ErrorMessageProvider.show(e);
    }
  }
}
