import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../shared/button_form_input/button_form_input.dart';
import '../../../../../shared/text_form_input/text_form_input.dart';
import '../../../../core/core.dart';
import 'form_login_controller.dart';

class FormLoginWidget extends StatefulWidget {
  final String initialEmail;
  final Future Function(Map<String, dynamic>) onSaved;
  const FormLoginWidget({
    Key? key,
    required this.initialEmail,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final controller = Modular.get<FormLoginController>();
  bool isLoading = false;

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormInput(
            text: widget.initialEmail,
            disable: isLoading,
            hintText: 'E-mail',
            icon: const Icon(Icons.email_outlined, size: 22),
            validate: controller.validateEmail,
            onSaved: controller.savedEmail,
          ),
          const SizedBox(height: 12),
          TextFormInput(
            text: '',
            disable: isLoading,
            hintText: 'Senha',
            icon: const Icon(Icons.lock_outline, size: 22),
            validate: controller.validatePassword,
            onSaved: controller.savedPassword,
            password: true,
          ),
          const SizedBox(height: 48),
          ButtonFormInput(
            text: "Login",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                modifyLoading(true);
                await widget.onSaved({
                  "email": controller.email,
                  "password": controller.password
                });

                _formKey.currentState!.reset();
                controller.reset();
                modifyLoading(false);
              }
            },
          ),
          const SizedBox(height: 10),
          Text(
            "Ainda n??o possui uma conta?",
            textAlign: TextAlign.center,
            style: AppTheme.textStyles.labelMediumSemiBold
                .copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: 6),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              _formKey.currentState!.save();
              controller.register();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Cadastre-se",
                textAlign: TextAlign.center,
                style: AppTheme.textStyles.labelMediumSemiBold
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
