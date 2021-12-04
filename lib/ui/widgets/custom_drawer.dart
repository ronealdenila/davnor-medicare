import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    required this.accountName,
    required this.accountEmail,
    required this.userProfile,
    required this.onProfileTap,
    this.onCurrentConsultTap,
    this.onConsultHisoryTap,
    this.onMedicalHistoryTap,
    this.onSettingsTap,
    required this.onLogoutTap,
    this.forDoctorDrawer = false,
  });

  final String? accountName;
  final String? accountEmail;
  final Widget? userProfile;
  final bool forDoctorDrawer;
  final void Function()? onProfileTap;
  final void Function()? onCurrentConsultTap;
  final void Function()? onConsultHisoryTap;
  final void Function()? onMedicalHistoryTap;
  final void Function()? onSettingsTap;
  final void Function()? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName!),
            accountEmail: Text(accountEmail!),
            currentAccountPicture: CircleAvatar(
              child: userProfile,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'), //TRANSLATE
            onTap: onProfileTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(forDoctorDrawer
                ? 'On-Progress Consultation'
                : 'Current Consultation'), //TRANSLATE - KINING IKADUHA LANG I
            onTap: onCurrentConsultTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Consultation History'), //TRANSLATE
            onTap: onConsultHisoryTap,
          ),
          if (!forDoctorDrawer) const Divider(),
          if (!forDoctorDrawer)
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title: const Text('Medical Assistance History'), //TRANSLATE
              onTap: onMedicalHistoryTap,
            ),
          if (!forDoctorDrawer) const Divider(),
          if (!forDoctorDrawer)
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'), //TRANSLATE
              onTap: onSettingsTap,
            ),
          const Divider(),
          Expanded(
            child: Align(
              alignment: forDoctorDrawer
                  ? Alignment.topCenter
                  : FractionalOffset.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'), //TRANSLATE
                onTap: onLogoutTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
