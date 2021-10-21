import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(String dateString, DateTime dt) {
    final notificationDate = DateFormat('dd-MM-yyyy h:mma').parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 48) {
      return DateFormat.yMMMMd().add_jm().format(dt);
    } else if (difference.inDays > 8 && difference.inDays <= 48) {
      final count = (difference.inDays / 7).floor();
      final title = count > 1 ? 'weeks' : 'week';
      return '$count $title ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return '1 hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inMinutes >= 1) {
      return '1 min ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
