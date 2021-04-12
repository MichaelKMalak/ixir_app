part of 'email_auth_cubit.dart';

abstract class EmailAuthState extends Equatable {
  const EmailAuthState();
}

class EmailAuthInitial extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthLoading extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthSuccess extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthFailure extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthConfirmed extends EmailAuthState {
  @override
  List<Object> get props => [];
}
