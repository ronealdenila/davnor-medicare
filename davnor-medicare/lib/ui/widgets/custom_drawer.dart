import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    required this.accountName,
    required this.accountEmail,
    required this.userProfile,
    required this.onProfileTap,
    required this.onCurrentConsultTap,
    required this.onConsultHisoryTap,
    required this.onMedicalHistoryTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  final String? accountName;
  final String? accountEmail;
  final Widget? userProfile;
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
            title: const Text('Profile'),
            onTap: onProfileTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Current Consultation'),
            onTap: onCurrentConsultTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Consultation History'),
            onTap: onConsultHisoryTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.document_scanner),
            title: const Text('Medical Assistance History'),
            onTap: onMedicalHistoryTap,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: onSettingsTap,
          ),
          const Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: onLogoutTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
