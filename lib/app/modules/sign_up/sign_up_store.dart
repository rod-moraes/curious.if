import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../core/core.dart';
import '../../domain/signup/model/sign_up_model.dart';
import '../../domain/signup/usecase/sign_up_usecase.dart';
import 'sign_up_state.dart';

part 'sign_up_store.g.dart';

class SignUpStore extends _SignUpStoreBase with _$SignUpStore {
  SignUpStore(ISignUpUseCase signUpUseCase) {
    _signUpUseCase = signUpUseCase;
  }
}

abstract class _SignUpStoreBase with Store {
  late ISignUpUseCase _signUpUseCase;

  late ReactionDisposer disposer;

  @observable
  SignUpState state = SignUpStateEmpty();

  @action
  Future<void> _modifySignUpState(SignUpState state) async =>
      this.state = state;

  @action
  Future<void> signUp({required SignUpModel signUpModel}) async {
    try {
      await _modifySignUpState(SignUpStateLoading());
      await Future.delayed(const Duration(seconds: 4));
      String email = await _signUpUseCase.signUp(signUpModel);
      await _modifySignUpState(SignUpStateSuccess(email: email));
    } catch (e) {
      await _modifySignUpState(SignUpStateFailure(message: e.toString()));
      if (kDebugMode) print(e);
    }
  }

  void navigateSuccess(String email) => Modular.to
      .navigate('./${AppRoutes.signupSuccess}', arguments: {"email": email});

  void autoRun(void Function(String, bool) showSnackBar) {
    disposer = autorun((_) {
      if (state is SignUpStateFailure) {
        String message = (state as SignUpStateFailure).message;
        _modifySignUpState(SignUpStateEmpty());
        showSnackBar(message, true);
      } else if (state is SignUpStateSuccess) {
        String email = (state as SignUpStateSuccess).email;
        _modifySignUpState(SignUpStateEmpty());
        showSnackBar("Conta criada com sucesso!!!", false);
        navigateSuccess(email);
      }
    });
  }

  void dispose() {
    _signUpUseCase.dispose();
    disposer();
  }
}
