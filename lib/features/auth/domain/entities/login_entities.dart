import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/auth/data/model/model_login.dart';

class LoginEntities extends Equatable {
  final List<DataUser> dataUser; // Tetap list karena "response" adalah array
  final Query query; // Diubah menjadi objek tunggal
  final MetaData metaData; // Diubah menjadi objek tunggal
  final List<Jabatan> jabatan; // Tetap list karena "jabatan" adalah array

  const LoginEntities({
    this.dataUser = const [],
    required this.query, // Wajib diisi karena tidak ada default dalam JSON
    required this.metaData, // Wajib diisi karena tidak ada default dalam JSON
    this.jabatan = const [],
  });

  // Helper untuk mengecek apakah data kosong
  bool get isEmpty => dataUser.isEmpty && jabatan.isEmpty;

  @override
  List<Object?> get props => [dataUser, query, metaData, jabatan];
}
