import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  final log = getLogger('Url Launcher Service');

  Future<void> launchURL(String url) async {
    log.i('launchURL | Launching $url');
    await canLaunch(url)
        ? await launch(url)
        : showErrorDialog(errorTitle: 'Could not launch $url');
  }
}
