const String imageAssetRoot = 'assets/images/';

final String authHeader = _getImagePath('auth_header.png');
final String logo = _getImagePath('logo.png');
final String patientHomeHeader = _getImagePath('home_samp.png');
final String maImage = _getImagePath('ma_image.png');
final String blankProfile = _getImagePath('blank_profile.png');

//Cons Form
final String earIconPath = _getImagePath('ear.png');
final String heartIconPath = _getImagePath('heart.png');
final String kidneyIconPath = _getImagePath('kidney.png');
final String liverIconPath = _getImagePath('liver.png');
final String lungsIconPath = _getImagePath('lungs.png');
final String noseIconPath = _getImagePath('nose.png');
final String skinIconPath = _getImagePath('skin.png');
final String stomachIconPath = _getImagePath('stomach.png');
final String throatIconPath = _getImagePath('throat.png');

String _getImagePath(String fileName) {
  return imageAssetRoot + fileName;
}
