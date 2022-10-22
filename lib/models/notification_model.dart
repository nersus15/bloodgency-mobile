class NotificationModel {
  NotificationModel({
    required this.id,
    required this.pesan,
    required this.jenis,
    required this.user,
    required this.role,
    required this.link,
    required this.mobile_act,
    required this.dibuat,
    required this.dibaca,
    required this.pembuat,
  });

  final String id, pesan, jenis, dibuat, pembuat;

  final String? role, link, mobile_act, dibaca, user;

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'],
      pesan: data['pesan'],
      jenis: data['jenis'],
      user: data['user'],
      role: data['role'],
      link: data['link'],
      mobile_act: data['mobile_act'],
      dibuat: data['dibuat'],
      dibaca: data['dibaca'],
      pembuat: data['pembuat'],
    );
  }
}
