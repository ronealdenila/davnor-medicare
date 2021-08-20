final String imageAssetRoot = 'assets/images/';

final String authHeader = _getImagePath('auth_header.png');
final String logo = _getImagePath('logo.png');

String _getImagePath(String fileName) {
  return imageAssetRoot + fileName;
}
