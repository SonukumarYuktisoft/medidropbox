class BookAppointmentModel {
  final String docId;
  final String hosId;
  final String docFees;

  BookAppointmentModel({
    required this.docId,
    required this.hosId,
    required this.docFees,
  });

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "hosId": hosId,
        "docFees": docFees,
      };

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentModel(
      docId: json["docId"],
      hosId: json["hosId"],
      docFees: json["docFees"],
    );
  }
}
