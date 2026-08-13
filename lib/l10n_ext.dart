import 'package:flutter/widgets.dart';

import 'l10n/app_localizations.dart';

/// Estensione per accedere facilmente alle stringhe localizzate.
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
