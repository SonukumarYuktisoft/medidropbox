import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        60.heightBox,
        Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),

        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      "https://i.pravatar.cc/150?img=3".toCircularImage(
                        size: 80,
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Charlotte King",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "@johnkinggraphics",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffE84C3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {
                      AppNavigators.pushNamed(AppRoutesName.editprofileView);
                    },
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              _profileTile(icon: Icons.favorite_border, title: "Favourites"),
              _profileTile(icon: Icons.download_outlined, title: "Downloads"),
              _profileTile(icon: Icons.language, title: "Language"),
              _profileTile(icon: Icons.location_on_outlined, title: "Location"),
              _profileTile(
                icon: Icons.subscriptions_outlined,
                title: "Subscription",
              ),
              _profileTile(icon: Icons.delete_outline, title: "Clear cache"),
              _profileTile(icon: Icons.history, title: "Clear history"),
              _profileTile(
                icon: Icons.logout,
                title: "Log out",
                isLogout: true,
                onTap: () async {
                  await SharedPreferencesHelper.clearAllUserData();
                  AppNavigators.pushReplacementNamed(AppRoutesName.loginView);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    bool isLogout = false,
    void Function()? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
