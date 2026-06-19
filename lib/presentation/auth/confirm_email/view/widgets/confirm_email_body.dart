import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_cubit.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_event.dart';
import 'package:jobify_project/presentation/auth/confirm_email/view_model/confirm_email_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:pinput/pinput.dart';

class ConfirmEmailBody extends StatefulWidget {
  final String email;

  const ConfirmEmailBody({super.key, required this.email});

  @override
  State<ConfirmEmailBody> createState() => _ConfirmEmailBodyViewState();
}

class _ConfirmEmailBodyViewState extends State<ConfirmEmailBody> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 56,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingSmall / 2,
      ),
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: theme.colorScheme.primary, width: 2),
      ),
    );

    return BlocBuilder<ConfirmEmailCubit, ConfirmEmailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  children: [
                    TextSpan(text: "${local.weHaveSentCode} \n"),
                    TextSpan(
                      text: widget.email.isNotEmpty ? widget.email : "your email",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              Center(
                child: Pinput(
                  controller: _otpController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  textInputAction: TextInputAction.done,
                  onCompleted: (pin) {
                    context.read<ConfirmEmailCubit>().doIntent(
                      ConfirmEmailSubmittedEvent(email: widget.email, otp: pin),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingExtraLarge),
              CustomElevatedButtonLoading(
                widthButton: double.infinity,
                heightButton: 56,
                textButton: local.done,
                isLoading: state.confirmEmailStatus.isLoading,
                onPressed: () {
                  if (_otpController.text.length == 6) {
                    context.read<ConfirmEmailCubit>().doIntent(
                      ConfirmEmailSubmittedEvent(
                        email: widget.email,
                        otp: _otpController.text,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
