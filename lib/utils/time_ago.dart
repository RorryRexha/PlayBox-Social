class TimeAgo {
  static String format(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return "Hace unos segundos";
    } else if (diff.inMinutes < 60) {
      return "Hace ${diff.inMinutes} min";
    } else if (diff.inHours < 24) {
      return "Hace ${diff.inHours} h";
    } else if (diff.inDays == 1) {
      return "Ayer";
    } else if (diff.inDays < 7) {
      return "Hace ${diff.inDays} días";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}