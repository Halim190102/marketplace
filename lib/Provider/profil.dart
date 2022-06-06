import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/models/model.dart';

class DataProfil with ChangeNotifier {
  final _dataProfil = <Profil>[];
  final urls = 'https://tugas-uas-c9e8d-default-rtdb.firebaseio.com/';

  List<Profil> get dataProfil => _dataProfil;
  int get countProfil => _dataProfil.length;

  addProfil(String uid, String nomor, String tgl) async {
    try {
      final response = await Dio().post(
        '$urls$uid/profil.json',
        data: {
          'nomor': nomor,
          'tgl': tgl,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _dataProfil.add(
          Profil(
            response.data['name'].toString(),
            nomor,
            tgl,
          ),
        );
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  editProfil(String id, String uid, String nomor, String tgl) async {
    try {
      final response = await Dio().patch(
        '$urls$uid/profil/$id.json',
        data: {
          'nomor': nomor,
          'tgl': tgl,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Profil selectProfil =
            _dataProfil.firstWhere((element) => element.id == id);
        selectProfil.nomor = nomor;
        selectProfil.tgl = tgl;
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future initialProfil(String uid) async {
    final dataRes = await Dio().get('$urls$uid/profil.json');
    final dataResponse = dataRes.data;
    if (dataResponse != null) {
      dataResponse.forEach(
        (key, value) {
          _dataProfil.add(
            Profil(
              key,
              value['nomor'],
              value['tgl'],
            ),
          );
        },
      );
      notifyListeners();
    }
  }
}
