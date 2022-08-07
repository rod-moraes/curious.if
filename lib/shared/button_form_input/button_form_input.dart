import 'package:flutter/material.dart';

import '../../app/core/core.dart';

class ButtonFormInput extends StatefulWidget {
  final Future<void> Function() onTap;
  final String text;
  const ButtonFormInput({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  State<ButtonFormInput> createState() => _ButtonFormInputState();
}

class _ButtonFormInputState extends State<ButtonFormInput> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            height: 60, child: Center(child: CircularProgressIndicator()))
        : Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  onPressed: () async {
                    isLoading = true;
                    if (mounted) setState(() {});
                    await widget.onTap();
                    isLoading = false;
                    if (mounted) {
                      setState(() {
                        FocusScope.of(context).unfocus();
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      widget.text,
                      style: AppTheme.textStyles.labelMediumSemiBold.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
