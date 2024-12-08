extension DateTimeFormatting on DateTime {
  String formatTimestamp() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$hours:$minutes $period';
  }
} 