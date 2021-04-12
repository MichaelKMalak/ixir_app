import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ixir_app/domain/usecases/is_sign_in_usecase.dart';
import 'package:ixir_app/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:ixir_app/presentation/utils/error_message_provider.dart';

import '../../../domain/entities/bracelet_entity.dart';
import '../../../domain/usecases/is_bracelet_id_valid_usecase.dart';
import '../../../domain/usecases/register_bracelet_usecase.dart';

part 'connect_bracelet_state.dart';

class ConnectBraceletCubit extends Cubit<ConnectBraceletState> {
  final IsBraceletIdValidUseCase isBraceletIdValidUseCase;
  final RegisterBraceletUseCase registerBraceletUseCase;

  ConnectBraceletCubit({
    @required this.isBraceletIdValidUseCase,
    @required this.registerBraceletUseCase,
  }) : super(ConnectBraceletInitial());

  Future<void> isBraceletIdValid({@required String braceletId}) async {
    emit(ConnectBraceletLoading());
    bool isSuccess = false;
    try {
      isSuccess = await isBraceletIdValidUseCase.call(braceletId);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(ConnectBraceletFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(ConnectBraceletFailure());
    }

    if (isSuccess) {
      emit(ConnectBraceletSerialConfirmed());
    }
  }

  Future<void> registerBracelet({@required BraceletEntity bracelet}) async {
    emit(ConnectBraceletLoading());
    bool isSuccess = false;
    try {
      isSuccess = await registerBraceletUseCase.call(bracelet);
    } on SocketException catch (e) {
      ErrorMessageProvider.show(e);
      emit(ConnectBraceletFailure());
    } catch (e) {
      ErrorMessageProvider.show(e);
      emit(ConnectBraceletFailure());
    }

    if (isSuccess) {
      emit(ConnectBraceletSuccess());
    }
  }
}
