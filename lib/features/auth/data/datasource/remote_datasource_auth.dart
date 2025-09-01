import 'dart:convert';

import 'package:healmeumpapp/core/service/service_api_ump.dart';
import 'package:healmeumpapp/features/auth/data/model/model_login.dart';
import 'package:healmeumpapp/global/constant/api_url.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';


abstract class AuthRemoteDataSource {
  Future<LoginModel> postLogin(Map<String, dynamic> dataBody);
}

class AuthImpRemoteDataSource implements AuthRemoteDataSource {
  final dio = ServiceApiDioUmp();

  @override
  Future<LoginModel> postLogin(Map<String, dynamic> dataBody) async {
    try {
      final response = await dio.postCall(ApiUrl.login, dataBody);
      print("Tipe response.data: ${response.data.runtimeType}");
      print("response data source: ${response.data}");

      // Pastikan data terkonversi ke Map<String, dynamic>
      final responseData = response.data is String
          ? jsonDecode(response.data) as Map<String, dynamic>
          : response.data;

      // Parsing response ke LoginModel
      LoginModel result = LoginModel.fromJson(responseData);

      print('Kode pada data source: ${result.metaData.code}');

      if (result.metaData.code == "200") {
        DataUser dataUser = result.dataUser[0];
        LocalDataSource().saveName(dataUser.namaPegawai);
        LocalDataSource().saveStudyProgram(dataUser.prodi);
        LocalDataSource().savePhoneNumber(dataUser.hp);
        LocalDataSource().saveUsername(dataUser.nip);
        LocalDataSource().saveFaculty(dataUser.subUnitKerja);
        LocalDataSource().savePhoneNumber(dataUser.hp);
        print('Data User\n${dataUser.namaPegawai}\n${dataUser.prodi}\n${dataUser.hp}');
      } else {
        print('Login gagal. Tidak ada data yang tersimpan!');
      }
      return result;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
