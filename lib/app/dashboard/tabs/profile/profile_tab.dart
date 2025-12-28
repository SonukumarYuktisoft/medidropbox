import 'package:medidropbox/app/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:medidropbox/core/helpers/app_dialog/log_out_dialog.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

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

        Expanded(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) =>
                previous.profileStatus != current.profileStatus,
            builder: (context, state) {
              if (state.profileStatus == ApiStatus.loading) {
                return DataLoading();
              }
              if (state.profileStatus == ApiStatus.error) {
                return RefreshView(
                  title: state.mess,
                  onPressed: () =>
                      context.read<ProfileBloc>().add(OnGetProfile()),
                );
              }
              if (state.profileStatus == ApiStatus.success) {
                if (state.profileData == null) {
                  return DataNotFound(title: state.mess);
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              "${state.profileData!.profileImageUrl}"
                                  .toCircularImage(size: 80),

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
                              children: [
                                Text(
                                  "${state.profileData!.fullName}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${state.profileData!.email}",

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
                              AppNavigators.pushNamed(
                                AppRoutesName.editprofileView,
                              );
                            },
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      _profileTile(context,
                        icon: Icons.favorite_border,
                        title: "Favourites",
                      ),
                      _profileTile(context,
                        icon: Icons.download_outlined,
                        title: "Downloads",
                      ),
                      _profileTile(context,icon: Icons.language, title: "Language"),
                      _profileTile(context,
                        icon: Icons.location_on_outlined,
                        title: "Location",
                      ),
                      _profileTile(context,
                        icon: Icons.subscriptions_outlined,
                        title: "Subscription",
                      ),
                      _profileTile(context,
                        icon: Icons.delete_outline,
                        title: "Clear cache",
                      ),
                      _profileTile(context,icon: Icons.history, title: "Clear history"),
                      _profileTile(context,
                        icon: Icons.logout,
                        title: "Log out",
                        isLogout: true,
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _profileTile(
    BuildContext context,
    {
    required IconData icon,
    required String title,
    bool isLogout = false,
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
      onTap: () {
        if (isLogout) {
          showLogoutDialog(context);
          //  LogOutStorage().logOut();
        }
      },
    );
  }
}
