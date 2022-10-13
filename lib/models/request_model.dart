class DonationRequestModel {
  DonationRequestModel(
      {required this.pasien,
      required this.lokasi,
      required this.waktu,
      required this.darah,
      required this.terkumpul,
      required this.total});

  final String pasien, lokasi, waktu, darah;
  final int total, terkumpul;

  factory DonationRequestModel.fromMap(Map<String, dynamic> request) {
    return DonationRequestModel(
        pasien: request["pasien"],
        lokasi: request["lokasi"],
        waktu: request["waktu"],
        darah: request["darah"],
        terkumpul: request["terkumpul"],
        total: request["total"]);
  }
}
