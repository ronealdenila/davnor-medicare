const String imageAssetRoot = 'assets/images/';

final String authHeader = _getImagePath('auth_header.png');
final String logo = _getImagePath('logo.png');
final String patientHomeHeader = _getImagePath('home_samp.png');
final String maImage = _getImagePath('ma_image.png');
final String blankProfile = _getImagePath('blank_profile.png');
final String icons8 = _getImagePath('icons8.png');

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

//new Set
final String earacheIcon = _getImagePath('earache.png');
final String heartburnIcon = _getImagePath('heartburn.jpg');
final String vomitingIcon = _getImagePath('vomiting.png');
final String diarrheaIcon = _getImagePath('diarrhea.png');
final String abdominalpainIcon = _getImagePath('abdominal_pain.png');
final String sinusitisIcon = _getImagePath('sinusitis.png');
final String coughIcon = _getImagePath('cough.png');
final String hypertensionIcon = _getImagePath('hypertension.png');
final String backpainIcon = _getImagePath('backpain.png');
final String conjunctivitisIcon = _getImagePath('conjunctivitis.png');
final String diabetesIcon = _getImagePath('diabetes.png');
final String asthma = _getImagePath('asthma.png');
final String foodallergyIcon = _getImagePath('foodallergy.png');
final String sorethroatIcon = _getImagePath('sore_throat.png');
final String pneomoniaIcon = _getImagePath('pneumonia.png');

String _getImagePath(String fileName) {
  return imageAssetRoot + fileName;
}
