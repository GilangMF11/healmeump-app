
import 'package:healmeumpapp/features/auth/domain/entities/login_entities.dart';

class LoginModel {
  final List<DataUser> dataUser; // Tetap list karena JSON `response` adalah array.
  final List<Jabatan> jabatan;
  final Query query; // Diubah menjadi objek tunggal.
  final MetaData metaData; // Diubah menjadi objek tunggal.

  LoginModel({
    required this.dataUser,
    required this.jabatan,
    required this.query,
    required this.metaData,
  });

  LoginEntities toEntity() {
    return LoginEntities(
      dataUser: dataUser,
      jabatan: jabatan,
      query: query,
      metaData: metaData,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      dataUser: json['response'] == null
          ? []
          : List<DataUser>.from(json['response'].map((x) => DataUser.fromJson(x))),
      jabatan: json['jabatan'] == null
          ? []
          : List<Jabatan>.from(json['jabatan'].map((x) => Jabatan.fromJson(x))),
      query: Query.fromJson(json['query']),
      metaData: MetaData.fromJson(json['metaData']),
    );
  }
}

class DataUser {
  final String pegawaiId;
  final String namaPegawai;
  final String idSubUnitKerja;
  final String nip;
  final String jenisPegawai;
  final String prodi;
  final String jabatan;
  final String nidn;
  final String idIjazah;
  final String idJab;
  final String ijazah;
  final String struktural;
  final String pangkat;
  final String alamatRumah;
  final String hp;
  final String email;
  final String subUnitKerja;
  final String idDosenSister;
  final String gaji;
  final String dosenPa;
  final String nopen;
  final String idSinta;
  final String foto;

  DataUser({
    required this.pegawaiId,
    required this.namaPegawai,
    required this.idSubUnitKerja,
    required this.nip,
    required this.jenisPegawai,
    required this.prodi,
    required this.jabatan,
    required this.nidn,
    required this.idIjazah,
    required this.idJab,
    required this.ijazah,
    required this.struktural,
    required this.pangkat,
    required this.alamatRumah,
    required this.hp,
    required this.email,
    required this.subUnitKerja,
    required this.idDosenSister,
    required this.gaji,
    required this.dosenPa,
    required this.nopen,
    required this.idSinta,
    required this.foto,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      pegawaiId: json['pegawai_id'],
      namaPegawai: json['nama_pegawai'],
      idSubUnitKerja: json['id_sub_unit_kerja'],
      nip: json['NIP'],
      jenisPegawai: json['jenis_pegawai'],
      prodi: json['prodi'],
      jabatan: json['jab'],
      nidn: json['nidn'],
      idIjazah: json['id_ijazah'],
      idJab: json['id_jab'],
      ijazah: json['ijazah'],
      struktural: json['struktural'],
      pangkat: json['pangkat'],
      alamatRumah: json['alamat_rumah'],
      hp: json['hp'],
      email: json['email'],
      subUnitKerja: json['sub_unit_kerja'],
      idDosenSister: json['id_dosen_sister'],
      gaji: json['gaji'],
      dosenPa: json['dosen_pa'] ?? "",
      nopen: json['nopen'] ?? "",
      idSinta: json['id_sinta'],
      foto: json['foto'],
    );
  }
}

class Jabatan {
  final String struktural;
  final String idUnitKerja;
  final String statusEselon;

  Jabatan({
    required this.struktural,
    required this.idUnitKerja,
    required this.statusEselon,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      struktural: json['struktural'],
      idUnitKerja: json['id_unit_kerja'],
      statusEselon: json['status_eselon'],
    );
  }
}

class Query {
  final String message;
  final String code;

  Query({
    required this.message,
    required this.code,
  });

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      message: json['message'],
      code: json['code'],
    );
  }
}

class MetaData {
  final String message;
  final String code;

  MetaData({
    required this.message,
    required this.code,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      message: json['message'] ?? '',
      code: json['code'],
    );
  }
}
