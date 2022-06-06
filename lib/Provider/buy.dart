import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/models/model.dart';
import 'package:intl/intl.dart';

class BuyCart with ChangeNotifier {
  final _allDataBuy = <Model3>[];
  final urls = 'https://tugas-uas-c9e8d-default-rtdb.firebaseio.com/';

  List<Model3> get allDataBuy => _allDataBuy;
  int get jumlahBuy => _allDataBuy.length;

  addData2(String uid, String nama, String laptop, int harga, String lokasi,
      String image, int jumlah, String nomor, String metode) async {
    DateTime dateTimeNow = DateTime.now();
    try {
      final response = await Dio().post(
        '$urls$uid/beli.json',
        data: {
          'nama': nama,
          'laptop': laptop,
          'harga': harga,
          'lokasi': lokasi,
          'image': image,
          'jumlah': jumlah,
          'nomor': nomor,
          'metode': metode,
          'createdAt': DateFormat("d MMMM yyyy").format(dateTimeNow),
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allDataBuy.add(
          Model3(
            response.data['name'].toString(),
            nama,
            laptop,
            harga,
            lokasi,
            image,
            jumlah,
            nomor,
            metode,
            DateFormat("d MMMM yyyy").format(dateTimeNow),
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

  deleteData2(String id, String uid) async {
    try {
      final response = await Dio().delete('$urls$uid/beli/$id.json');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allDataBuy.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future initialData2(String uid) async {
    final dataRes = await Dio().get('$urls$uid/beli.json');
    final dataResponse = dataRes.data;
    if (dataResponse != null) {
      dataResponse.forEach(
        (key, value) {
          _allDataBuy.add(
            Model3(
              key,
              value['nama'],
              value['laptop'],
              value['harga'],
              value['lokasi'],
              value['image'],
              value['jumlah'],
              value['nomor'],
              value['metode'],
              value['createdAt'],
            ),
          );
        },
      );
      notifyListeners();
    }
  }
}
