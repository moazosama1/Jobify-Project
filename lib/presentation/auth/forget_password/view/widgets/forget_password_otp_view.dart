import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_elevated_button_loading.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_cubit.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_event.dart';
import 'package:jobify_project/presentation/auth/forget_password/view_model/forget_password_state.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordOtpView extends StatefulWidget {
  const ForgetPasswordOtpView({super.key});

  @override
  State<ForgetPasswordOtpView> createState() => _ForgetPasswordOtpViewState();
}

class _ForgetPasswordOtpViewState extends State<ForgetPasswordOtpView> {
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
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMeasurements.paddingSmall,
      ),
      textStyle: theme.textTheme.headlineMedium?.copyWith(
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

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        return Column(
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
                    text: state.email.isNotEmpty ? state.email : "your email",
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
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                textInputAction: .done,
                onCompleted: (pin) {
                  // Optionally trigger automatically
                },
              ),
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),
            CustomElevatedButtonLoading(
              widthButton: double.infinity,
              heightButton: 56,
              textButton: local.resetNow,
              isLoading: state.isLoading,
              onPressed: () {
                context.read<ForgetPasswordCubit>().doIntent(
                  VerifyOtpEvent(_otpController.text),
                );
              },
            ),
            const SizedBox(height: AppMeasurements.paddingLarge),
            Center(
              child: RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  children: [
                    TextSpan(text: "${local.getCodeIn} 0:57 "), // Mock timer
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: InkWell(
                        onTap: () {
                          context.read<ForgetPasswordCubit>().doIntent(
                            ResendOtpEvent(),
                          );
                        },
                        child: Text(
                          local.resend,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
