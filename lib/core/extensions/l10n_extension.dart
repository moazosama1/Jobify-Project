import 'package:flutter/material.dart';
import 'package:jobify_project/generated/l10n.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
