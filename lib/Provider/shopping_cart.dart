import 'package:flutter/material.dart';
import 'package:marketplace/models/model.dart';
import 'package:dio/dio.dart';

class ShoppingCart with ChangeNotifier {
  final _allDataShopping = <Model2>[];
  final urls = 'https://tugas-uas-c9e8d-default-rtdb.firebaseio.com/';

  List<Model2> get allDataShopping => _allDataShopping;
  int get jumlahShop => _allDataShopping.length;

  // Model2 selectById(String laptop) =>
  //     _allDataShopping.firstWhere((element) => element.laptop == laptop);

  addData1(String uid, String laptop, int harga, String lokasi, String image,
      int jumlah) async {
    try {
      final response = await Dio().post(
        '$urls$uid/keranjang.json',
        data: {
          'laptop': laptop,
          'harga': harga,
          'lokasi': lokasi,
          'image': image,
          'jumlah': jumlah,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allDataShopping.add(
          Model2(
            response.data['name'].toString(),
            laptop,
            harga,
            lokasi,
            image,
            jumlah,
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

  editData1(String id, String uid, String laptop, int harga, int jumlah) async {
    try {
      final response = await Dio().patch(
        '$urls$uid/keranjang/$id.json',
        data: {
          'laptop': laptop,
          'harga': harga,
          'jumlah': jumlah,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Model2 selectModel2 =
            _allDataShopping.firstWhere((element) => element.laptop == laptop);
        selectModel2.laptop = laptop;
        selectModel2.harga = harga;
        selectModel2.jumlah = jumlah;
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  deleteData1(String id, String uid) async {
    try {
      final response = await Dio().delete('$urls$uid/keranjang/$id.json');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allDataShopping.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future initialData1(String uid) async {
    final dataRes = await Dio().get('$urls$uid/keranjang.json');
    final dataResponse = dataRes.data;
    if (dataResponse != null) {
      dataResponse.forEach(
        (key, value) {
          _allDataShopping.add(
            Model2(
              key,
              value['laptop'],
              value['harga'],
              value['lokasi'],
              value['image'],
              value['jumlah'],
            ),
          );
        },
      );
      notifyListeners();
    }
  }
}
