import 'package:medidropbox/app/dashboard/tabs/reports/dialog/update_health_profile.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/bmi_report_tab.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/health_record_tab.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HealthProfileCard extends StatelessWidget {
  final bool isNavigate;
  const HealthProfileCard({super.key, this.isNavigate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          HealthProfileData(), 
          BmiReportData(),
          LatestVitalData()],
      ),
    );
  }
}

class HealthProfileData extends StatelessWidget {
  const HealthProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthProfileBloc, HealthProfileState>(
      buildWhen: (previous, current) =>
          previous.getHealthProfileStatus != current.getHealthProfileStatus,
      builder: (context, state) {
        if (state.getHealthProfileStatus == ApiStatus.loading) {
          return BoxShimmer(height: 250).paddingHorizontal(15).paddingTop(15);
        }
        if (state.getHealthProfileStatus == ApiStatus.success) {
          final data = state.getHealthProfileData;
          if (data == null) return const SizedBox();

          final age = _calculateAge(data.dateOfBirth);
          final bloodGroup = _formatBloodGroup(data.bloodGroup);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Health Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () {
                   showUpdateHealthProfileDialog(context);
                    },
                    child:Row(
                      children: [
                        "Update".toHeadingText(color: Colors.white),
                        5.widthBox,
                        Icon(Icons.edit,color: Colors.white,shadows: toIconShadow()),
                      ],
                    )
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Quick Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickStat(
                    icon: Icons.height,
                    label: 'Height',
                    value: '${data.heightCm?.toStringAsFixed(0) ?? '-'} cm',
                    onTap: () {},
                  ),
                  Container(width: 1, height: 40, color: Colors.white30),
                  _buildQuickStat(
                    icon: Icons.person,
                    label: 'Gender',
                    value: data.gender == 'MALE' ? 'Male' : 'Female',
                    onTap: () {},
                  ),
                  Container(width: 1, height: 40, color: Colors.white30),
                  _buildQuickStat(
                    icon: Icons.water_drop,
                    label: 'Blood',
                    value: bloodGroup,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Age Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Age',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    '$age years',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(15);
        }
        return _buildEmptyState(context);
      },
    );
  }

 


  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_add, size: 60, color: Colors.blue[400]),
          ),
          Text(
            'No Health Profile Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
             showUpdateHealthProfileDialog(context);
            },
            icon: const Icon(Icons.upload_file, size: 22),
            label: const Text('Update Health Profile', style: TextStyle(fontSize: 15)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        const SizedBox(height: 24),

        ],
      ),
    );
  }

  /// Quick Stat Widget
  Widget _buildQuickStat({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  /// Helpers
  String _formatBloodGroup(String? value) {
    switch (value) {
      case 'A_POSITIVE':
        return 'A+';
      case 'A_NEGATIVE':
        return 'A-';
      case 'B_POSITIVE':
        return 'B+';
      case 'B_NEGATIVE':
        return 'B-';
      case 'O_POSITIVE':
        return 'O+';
      case 'O_NEGATIVE':
        return 'O-';
      case 'AB_POSITIVE':
        return 'AB+';
      case 'AB_NEGATIVE':
        return 'AB-';
      default:
        return '-';
    }
  }

  int _calculateAge(DateTime? dob) {
    if (dob == null) return 0;
    final today = DateTime.now();
    int age = today.year - dob.year;

    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }
}
class BmiReportData extends StatelessWidget {
  const BmiReportData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthProfileBloc, HealthProfileState>(
      buildWhen: (previous, current) => previous.bmiStatus != current.bmiStatus,
      builder: (context, state) {
        if (state.bmiStatus == ApiStatus.loading) {
          return BoxShimmer(height: 100).paddingHorizontal(10).paddingTop(15);
        }
        if (state.bmiStatus == ApiStatus.success) {
          var data = state.bmiData;
          if (data == null) {
            return SizedBox();
          }
          final bmi = double.parse(data.bmi.toString());
          final category = data.bmiCategory.toString();

          Color getCategoryColor() {
            switch (category.toLowerCase()) {
              case 'underweight':
                return Colors.blue;
              case 'normal':
              case 'overweight':
                return Colors.orange; // Boss chahta hai orange
              case 'obese':
                return Colors.red;
              default:
                return Colors.orange; // Default bhi orange
            }
          }

          return Stack(
            children: [
              Positioned(
                bottom: 15.0,
                right: 20.0,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 14,
                  shadows: toIconShadow(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: getCategoryColor().withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.orange, // Consistently orange border
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your BMI Daily Score',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange, // Orange badge
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          bmi.toStringAsFixed(1), // 24.6 dikhega
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.orange, // Orange BMI number
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'kg/m²',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // White unit text
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ).onTap(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BmiReportTab()),
            );
          });
        }

        return SizedBox();
      },
    );
  }
}
class LatestVitalData extends StatelessWidget {
  const LatestVitalData({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthProfileBloc, HealthProfileState>(
      buildWhen: (previous, current) =>
          previous.latestVitalStatus != current.latestVitalStatus,
      builder: (context, state) {
        if (state.latestVitalStatus == ApiStatus.loading) {
          return BoxShimmer(height: 100).paddingAll(10);
        }

        if (state.latestVitalStatus == ApiStatus.success) {
          var data = state.latestVitalData;
          if (data == null) {
            return DataNotFound();
          }
          Color getBMIColor() {
            if (data.bmiCategory == 'Normal') return Color(0xFF4ade80);
            if (data.bmiCategory == 'Overweight') return Color(0xFFfbbf24);
            if (data.bmiCategory == 'Obese') return Color(0xFFf87171);
            return Color(0xFF60a5fa);
          }

          return Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: getBMIColor().withAlpha(20),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4facfe).withAlpha(50),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              border: Border.all(color:  getBMIColor().withAlpha(20))
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Body Mass Index',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data.bmi != null
                                  ? data.bmi.toStringAsFixed(1)
                                  : '--',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'kg/m²',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: getBMIColor(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data.bmiCategory ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 14,
                      shadows: toIconShadow(),
                    ),
                  ],
                ),
              ],
            ),
          ).onTap(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HealthRecordTab()),
            );
          });
        }
        return SizedBox();
      },
    );
  }
}
