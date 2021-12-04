import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

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
            title: Text('menu1'.tr),
            onTap: onProfileTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(forDoctorDrawer
                ? 'On-Progress Consultation'
                : 'menu2'.tr),
            onTap: onCurrentConsultTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text('menu3'.tr), 
            onTap: onConsultHisoryTap,
          ),
          if (!forDoctorDrawer) const Divider(),
          if (!forDoctorDrawer)
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title:  Text('menu4'.tr),
              onTap: onMedicalHistoryTap,
            ),
          if (!forDoctorDrawer) const Divider(),
          if (!forDoctorDrawer)
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title:  Text('setting'.tr),
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
                title: Text('menu5'.tr),
                onTap: onLogoutTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
