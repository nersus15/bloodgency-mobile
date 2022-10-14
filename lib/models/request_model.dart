class DonationRequestModel {
  DonationRequestModel(
      {required this.pasien,
      required this.lokasi,
      required this.waktu,
      required this.darah,
      required this.terkumpul,
      required this.koordinat,
      required this.total});

  final String pasien, lokasi, waktu, darah, koordinat;
  final int total, terkumpul;

  factory DonationRequestModel.fromMap(Map<String, dynamic> request) {
    return DonationRequestModel(
        koordinat: request['koordinat'],
        pasien: request["pasien"],
        lokasi: request["lokasi"],
        waktu: request["waktu"],
        darah: request["darah"],
        terkumpul: request["terkumpul"],
        total: request["total"]);
  }
}
