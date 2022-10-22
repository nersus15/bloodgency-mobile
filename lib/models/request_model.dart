class DonationRequestModel {
  DonationRequestModel({
    required this.pasien,
    required this.lokasi,
    required this.waktu,
    required this.darah,
    required this.terkumpul,
    required this.koordinat,
    required this.total,
    required this.user,
    required this.id,
  });

  final String pasien, id, lokasi, waktu, darah, koordinat, user;
  final int total, terkumpul;

  factory DonationRequestModel.fromMap(Map<String, dynamic> request) {
    return DonationRequestModel(
        koordinat: request['koordinat'],
        pasien: request["pasien"],
        lokasi: request["lokasi"],
        waktu: request["waktu"],
        darah: request["darah"],
        terkumpul: request["terkumpul"],
        total: request["total"],
        id: request["id"],
        user: request["user"]);
  }
}
