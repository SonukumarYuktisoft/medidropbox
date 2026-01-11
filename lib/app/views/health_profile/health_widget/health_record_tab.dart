import 'package:medidropbox/app/models/health_profile/latest_vital_model.dart' show LatestVitalModel;
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:intl/intl.dart';

class HealthRecordTab extends StatelessWidget {
  const HealthRecordTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Latest Vital",titleColor: Colors.white,leadColor: Colors.white,),
      body: BlocBuilder<HealthProfileBloc, HealthProfileState>(
        buildWhen: (previous, current) => previous.latestVitalStatus != current.latestVitalStatus,
        builder: (context, state) {
          if (state.latestVitalStatus == ApiStatus.loading) {
            return DataLoading();
          }
          if (state.latestVitalStatus == ApiStatus.error) {
            return RefreshView(
              onPressed: () => context.read<HealthProfileBloc>().add((OnGetLatestVitalApi())),
            );
          }
          if (state.latestVitalStatus == ApiStatus.success) {
            var data = state.latestVitalData;
            if (data == null) {
              return DataNotFound();
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // BMI Card - Featured Card
                  _buildBMICard(data),
                  SizedBox(height: 16),
                  
                  // Vitals Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildVitalCard(
                          title: 'Weight',
                          value: data.latestWeight != null ? '${data.latestWeight} kg' : '--',
                          date: data.latestWeightDate,
                          icon: Icons.monitor_weight_outlined,
                          gradient: [Color(0xFF667eea), Color(0xFF764ba2)],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildVitalCard(
                          title: 'Blood Glucose',
                          value: data.latestBloodGlucose != null ? '${data.latestBloodGlucose} mg/dL' : '--',
                          date: data.latestBloodGlucoseDate,
                          icon: Icons.water_drop_outlined,
                          gradient: [Color(0xFFf093fb), Color(0xFFF5576C)],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  
                  // Blood Pressure Card - Full Width
                  _buildBloodPressureCard(data),
                  
                  // Disclaimer
                  if (data.disclaimer != null) ...[
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, size: 20, color: Colors.amber.shade700),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data.disclaimer!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.amber.shade900,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildBMICard(LatestVitalModel data) {
    Color getBMIColor() {
      if (data.bmiCategory == 'Normal') return Color(0xFF4ade80);
      if (data.bmiCategory == 'Overweight') return Color(0xFFfbbf24);
      if (data.bmiCategory == 'Obese') return Color(0xFFf87171);
      return Color(0xFF60a5fa);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4facfe).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
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
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data.bmi != null ? data.bmi.toStringAsFixed(1) : '--',
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
                  color: Colors.white.withOpacity(0.2),
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
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          if (data.bmiQuote != null) ...[
            SizedBox(height: 12),
            Text(
              data.bmiQuote!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVitalCard({
    required String title,
    required String value,
    required DateTime? date,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (date != null) ...[
            SizedBox(height: 8),
            Text(
              DateFormat('MMM dd, yyyy').format(date),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBloodPressureCard(LatestVitalModel data) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFfa709a), Color(0xFFfee140)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFfa709a).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.favorite, color: Colors.white, size: 32),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blood Pressure',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  data.latestBloodPressureDisplay ?? '--/--',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (data.latestBloodPressureDate != null) ...[
                  SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(data.latestBloodPressureDate!),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              _buildBPLabel('SYS', data.latestBloodPressureSystolic?.toString() ?? '--'),
              SizedBox(height: 8),
              _buildBPLabel('DIA', data.latestBloodPressureDiastolic?.toString() ?? '--'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBPLabel(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}