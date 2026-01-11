// To parse this JSON data, do
//
//     final latestVitalModel = latestVitalModelFromJson(jsonString);

import 'dart:convert';

LatestVitalModel latestVitalModelFromJson(String str) => LatestVitalModel.fromJson(json.decode(str));

String latestVitalModelToJson(LatestVitalModel data) => json.encode(data.toJson());

class LatestVitalModel {
    dynamic latestWeight;
    DateTime? latestWeightDate;
    dynamic latestBloodGlucose;
    DateTime? latestBloodGlucoseDate;
    dynamic latestBloodPressureSystolic;
    dynamic latestBloodPressureDiastolic;
    String? latestBloodPressureDisplay;
    DateTime? latestBloodPressureDate;
    dynamic bmi;
    String? bmiCategory;
    String? bmiQuote;
    String? disclaimer;

    LatestVitalModel({
        this.latestWeight,
        this.latestWeightDate,
        this.latestBloodGlucose,
        this.latestBloodGlucoseDate,
        this.latestBloodPressureSystolic,
        this.latestBloodPressureDiastolic,
        this.latestBloodPressureDisplay,
        this.latestBloodPressureDate,
        this.bmi,
        this.bmiCategory,
        this.bmiQuote,
        this.disclaimer,
    });

    factory LatestVitalModel.fromJson(Map<String, dynamic> json) => LatestVitalModel(
        latestWeight: json["latestWeight"]?.toDouble(),
        latestWeightDate: json["latestWeightDate"] == null ? null : DateTime.parse(json["latestWeightDate"]),
        latestBloodGlucose: json["latestBloodGlucose"],
        latestBloodGlucoseDate: json["latestBloodGlucoseDate"] == null ? null : DateTime.parse(json["latestBloodGlucoseDate"]),
        latestBloodPressureSystolic: json["latestBloodPressureSystolic"],
        latestBloodPressureDiastolic: json["latestBloodPressureDiastolic"],
        latestBloodPressureDisplay: json["latestBloodPressureDisplay"],
        latestBloodPressureDate: json["latestBloodPressureDate"] == null ? null : DateTime.parse(json["latestBloodPressureDate"]),
        bmi: json["bmi"]?.toDouble(),
        bmiCategory: json["bmiCategory"],
        bmiQuote: json["bmiQuote"],
        disclaimer: json["disclaimer"],
    );

    Map<String, dynamic> toJson() => {
        "latestWeight": latestWeight,
        "latestWeightDate": latestWeightDate?.toIso8601String(),
        "latestBloodGlucose": latestBloodGlucose,
        "latestBloodGlucoseDate": latestBloodGlucoseDate?.toIso8601String(),
        "latestBloodPressureSystolic": latestBloodPressureSystolic,
        "latestBloodPressureDiastolic": latestBloodPressureDiastolic,
        "latestBloodPressureDisplay": latestBloodPressureDisplay,
        "latestBloodPressureDate": latestBloodPressureDate?.toIso8601String(),
        "bmi": bmi,
        "bmiCategory": bmiCategory,
        "bmiQuote": bmiQuote,
        "disclaimer": disclaimer,
    };
}
