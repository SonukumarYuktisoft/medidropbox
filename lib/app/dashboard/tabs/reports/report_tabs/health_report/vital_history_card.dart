
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medidropbox/app/dashboard/tabs/reports/dialog/create_vital_dialog.dart';
import 'package:medidropbox/app/models/health_profile/vital_history_model.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';

class VitalHistoryCard extends StatelessWidget {
  final VitalHistoryModel vitalHistory;

  const VitalHistoryCard({
  super.key,
    required this.vitalHistory,
  }) ;

  String _formatDate(DateTime? date) {
    try {
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date!);
    } catch (e) {
      return date.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Time Header
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatDate(vitalHistory.recordedAt),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              
                Icon(Icons.edit_document).asIconButton(
                  tooltip: 'edit vital',
                  onPressed: (){
                  showCreateVitalsDialog(context,vital: vitalHistory);
                })
              
              ],
            ),
            
            SizedBox(height: 16),
            
            // Vitals Grid
            Row(
              children: [
                // Blood Pressure
                Expanded(
                  child: _VitalItem(
                    icon: Icons.favorite,
                    iconColor: Colors.red,
                    label: 'Blood Pressure',
                    value: vitalHistory.bloodPressureDisplay.toString(),
                    unit: 'mmHg',
                  ),
                ),
                SizedBox(width: 12),
                // Blood Glucose
                Expanded(
                  child: _VitalItem(
                    icon: Icons.water_drop,
                    iconColor: Colors.blue,
                    label: 'Blood Glucose',
                    value: vitalHistory.bloodGlucoseMgdl.toStringAsFixed(1),
                    unit: 'mg/dL',
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12),
            
            // Weight
            _VitalItem(
              icon: Icons.monitor_weight,
              iconColor: Colors.green,
              label: 'Weight',
              value: vitalHistory.weightKg.toStringAsFixed(1),
              unit: 'kg',
            ),
            
            // Notes Section
            if (vitalHistory.notes!=null&&vitalHistory.notes!.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vitalHistory.notes.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VitalItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String unit;

  const _VitalItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: iconColor,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
