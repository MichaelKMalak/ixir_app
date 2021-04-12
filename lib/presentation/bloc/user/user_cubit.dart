import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ixir_app/presentation/utils/error_message_provider.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  UserCubit({
    this.getCurrentUserUseCase,
  }) : super(UserInitial());

  Future<void> getUsers() async {
    try {
      final userStreamData = getCurrentUserUseCase.call();
      userStreamData.listen((user) {
        if (user.braceletId == null) {
          emit(UserNotConnectedBracelet());
        } else {
          emit(UserLoaded(user));
        }
      });
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(UserFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(UserFailure());
    }
  }
}
