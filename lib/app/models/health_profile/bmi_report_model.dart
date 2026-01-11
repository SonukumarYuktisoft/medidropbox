// To parse this JSON data, do
//
//     final bmiReportModel = bmiReportModelFromJson(jsonString);

import 'dart:convert';

BmiReportModel bmiReportModelFromJson(String str) => BmiReportModel.fromJson(json.decode(str));

String bmiReportModelToJson(BmiReportModel data) => json.encode(data.toJson());

class BmiReportModel {
    dynamic bmi;
    String? bmiCategory;
    String? bmiDescription;
    String? inspirationalQuote;
    dynamic heightCm;
   dynamic weightKg;
    DateTime? weightRecordedAt;
    String? healthRecommendation;
    String? disclaimer;

    BmiReportModel({
        this.bmi,
        this.bmiCategory,
        this.bmiDescription,
        this.inspirationalQuote,
        this.heightCm,
        this.weightKg,
        this.weightRecordedAt,
        this.healthRecommendation,
        this.disclaimer,
    });

    factory BmiReportModel.fromJson(Map<String, dynamic> json) => BmiReportModel(
        bmi: json["bmi"]?.toDouble(),
        bmiCategory: json["bmiCategory"],
        bmiDescription: json["bmiDescription"],
        inspirationalQuote: json["inspirationalQuote"],
        heightCm: json["heightCm"],
        weightKg: json["weightKg"]?.toDouble(),
        weightRecordedAt: json["weightRecordedAt"] == null ? null : DateTime.parse(json["weightRecordedAt"]),
        healthRecommendation: json["healthRecommendation"],
        disclaimer: json["disclaimer"],
    );

    Map<String, dynamic> toJson() => {
        "bmi": bmi,
        "bmiCategory": bmiCategory,
        "bmiDescription": bmiDescription,
        "inspirationalQuote": inspirationalQuote,
        "heightCm": heightCm,
        "weightKg": weightKg,
        "weightRecordedAt": weightRecordedAt?.toIso8601String(),
        "healthRecommendation": healthRecommendation,
        "disclaimer": disclaimer,
    };
}
