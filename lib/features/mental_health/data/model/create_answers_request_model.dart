class CreateAnswersRequestModel {
  final String questionnaireCode;
  final String userId;
  final UserData userData;

  CreateAnswersRequestModel({
    required this.questionnaireCode,
    required this.userId,
    required this.userData,
  });

  Map<String, dynamic> toJson() => {
        "questionnaireCode": questionnaireCode,
        "userId": userId,
        "userData": userData.toJson(),
      };
}

class UserData {
  final String namaPegawai;
  final String nip;
  final String jenisPegawai;
  final String prodi;
  final String email;
  final String hp;

  UserData({
    required this.namaPegawai,
    required this.nip,
    required this.jenisPegawai,
    required this.prodi,
    required this.email,
    required this.hp,
  });

  Map<String, dynamic> toJson() => {
        "nama_pegawai": namaPegawai,
        "NIP": nip,
        "jenis_pegawai": jenisPegawai,
        "prodi": prodi,
        "email": email,
        "hp": hp,
      };
}
