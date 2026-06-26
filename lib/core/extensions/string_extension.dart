import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

extension ChatTimeFormatter on String {
  String toModernChatTime(BuildContext context) {
    if (isEmpty) return "";
    
    // Check if it's our dummy "Just Now" sent from cubit
    if (this == 'Just Now') return context.l10n.justNow;
    
    DateTime? dateTime;
    
    final intTime = int.tryParse(this);
    if (intTime != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(intTime);
    } else {
      dateTime = DateTime.tryParse(this);
    }

    if (dateTime == null) {
      // It might already be dummy string like '08:50 AM' or something unrecognizable
      return this;
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Modern relative time logic
    if (difference.inSeconds < 60 && difference.inSeconds > -60) {
      return context.l10n.justNow;
    } else if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      return DateFormat.jm().format(dateTime); // e.g. 5:08 PM
    } else if (difference.inDays < 7 && difference.inDays >= 0) {
      return DateFormat('EEEE, h:mm a').format(dateTime); // e.g. Monday, 5:08 PM
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime); // e.g. Jun 26, 5:08 PM
    }
  }
}
