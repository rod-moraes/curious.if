import 'package:curious_if/app/domain/auth/usecase/auth_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../domain/auth/model/auth_model.dart';
import '../../domain/auth/model/user_model.dart';
import 'auth_state.dart';

part 'auth_store.g.dart';

class AuthStore extends _AuthStoreBase with _$AuthStore {
  AuthStore(IAuthUseCase authUseCase) {
    _authUseCase = authUseCase;
  }
}

abstract class _AuthStoreBase with Store {
  late IAuthUseCase _authUseCase;

  late ReactionDisposer disposer;

  @observable
  AuthState state = AuthStateEmpty();

  Future<void> _modifyAuthState(AuthState state) async => this.state = state;

  @action
  Future<void> auth({required AuthModel authModel}) async {
    try {
      await _modifyAuthState(AuthStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      UserModel user = await _authUseCase.auth(authModel);
      await _modifyAuthState(AuthStateSuccess(user: user));
    } catch (e) {
      await _modifyAuthState(AuthStateFailure(message: e.toString()));
      if (kDebugMode) print(e);
    }
  }

  void dispose() {
    _authUseCase.dispose();
    disposer.reaction.dispose();
  }
}
