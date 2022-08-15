import 'package:flutter/material.dart';

import '../../../../../shared/button_form_input/button_form_input.dart';
import '../../../../../shared/text_form_input/text_form_input.dart';
import 'form_sign_up_controller.dart';

class FormSignUpWidget extends StatefulWidget {
  final Future Function(Map<String, dynamic>) onSaved;
  final String initialEmail;
  final String initialPassword;
  const FormSignUpWidget({
    Key? key,
    required this.onSaved,
    required this.initialEmail,
    required this.initialPassword,
  }) : super(key: key);

  @override
  State<FormSignUpWidget> createState() => _FormSignUpWidgetState();
}

class _FormSignUpWidgetState extends State<FormSignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final FormSignUpController controller = FormSignUpController();
  bool isLoading = false;
  Future? onTapCancel;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void modifyLoading(bool loading) {
    if (mounted) {
      isLoading = loading;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormInput(
            text: '',
            disable: isLoading,
            hintText: 'Nome',
            icon: const Icon(Icons.person_outline, size: 22),
            validate: controller.validateName,
            onSaved: controller.savedName,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: widget.initialEmail,
            disable: isLoading,
            hintText: 'E-mail',
            icon: Icon(Icons.email_outlined, size: 22),
            validate: controller.validateEmail,
            onSaved: controller.savedEmail,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: widget.initialPassword,
            disable: isLoading,
            hintText: 'Senha',
            icon: const Icon(Icons.lock_outline, size: 22),
            validate: controller.validatePassword,
            onSaved: controller.savedPassword,
            password: true,
          ),
          const SizedBox(height: 32),
          ButtonFormInput(
            text: "Cadastrar",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                modifyLoading(true);
                onTapCancel = await widget.onSaved({
                  "email": controller.email,
                  "name": controller.name,
                  "password": controller.password
                });
                _formKey.currentState!.reset();
                controller.reset();
                modifyLoading(false);
              }
            },
          ),
        ],
      ),
    );
  }
}
