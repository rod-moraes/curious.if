import 'package:curious_if/app/domain/auth/usecase/auth_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  late final IAuthUseCase _authUseCase;

  ReactionDisposer? disposer;

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

  void navigateHome() => Modular.to.navigate('/');

  void autoRun(void Function(String, bool) showSnackBar) {
    disposer = autorun((_) {
      if (state is AuthStateFailure) {
        String message = (state as AuthStateFailure).message;
        _modifyAuthState(AuthStateEmpty());
        showSnackBar(message, true);
      } else if (state is AuthStateSuccess) {
        UserModel user = (state as AuthStateSuccess).user;
        _modifyAuthState(AuthStateEmpty());
        showSnackBar("Logado com sucesso!!!", false);
        navigateHome();
      }
    });
  }

  void dispose() {
    _authUseCase.dispose();
    if (disposer != null) disposer!();
  }
}
