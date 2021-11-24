const String imageAssetRoot = 'assets/images/';

final String patientHomeHeader = _getImagePath('home_samp.png');
final String maImage =
    _getImagePath('ma_image.png'); //TO BE CHANGE: katong gihimo ni H
final String blankProfile = _getImagePath('blank_profile.png');
final String grayBlank = _getImagePath('gray_blank.jpg');
final String icons8 = _getImagePath('icons8.png');
final String flaticon = _getImagePath('flaticon.png');
final String freepik = _getImagePath('freepik.png');
final String doctorDefault = _getImagePath('doctor_pic.png');
final String logo = _getImagePath('davnormedicare.png');
final String davnormedicare = _getImagePath('davnormedicare_cover.jpg');

final String earacheIcon = _getImagePath('earache.png');
final String heartburnIcon = _getImagePath('gerd.png');
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
