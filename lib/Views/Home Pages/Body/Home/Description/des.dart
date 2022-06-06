import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Home/Description/des_buy.dart';
import 'package:provider/provider.dart';

class Descrip extends StatelessWidget {
  const Descrip({
    Key? key,
    required this.image,
    required this.laptop,
    required this.harga,
    required this.lokasi,
    required this.uid,
  }) : super(key: key);
  final String uid, image, laptop, lokasi;
  final int harga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    laptop,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    'Rp. $harga',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    lokasi,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 8,
                  //     vertical: 10,
                  //   ),
                  //   height: MediaQuery.of(context).size.height * 0.6,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: ThemesColor().primaryBody),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (_) => DesBuy(
                    uid: uid,
                    image: image,
                    laptop: laptop,
                    harga: harga,
                  ),
                );
              },
              child: const Text('Beli'),
            ),
          ),
          Expanded(
            child: ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(primary: ThemesColor().primaryBody),
              onPressed: () async {
                final data = Provider.of<ShoppingCart>(context, listen: false);
                if ((data.allDataShopping
                    .where((element) => element.laptop == laptop)).isEmpty) {
                  await data
                      .addData1(
                    uid,
                    laptop,
                    harga,
                    lokasi,
                    image,
                    1,
                  )
                      .then(
                    (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Berhasil ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ).catchError(
                    (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tidak dapat menambah Data !!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                } else {
                  final dataShopList = data.allDataShopping
                      .firstWhere((element) => element.laptop == laptop);
                  await data
                      .editData1(
                    dataShopList.id!,
                    uid,
                    laptop,
                    harga,
                    dataShopList.jumlah! + 1,
                  )
                      .then(
                    (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Berhasil ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ).catchError(
                    (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tidak dapat menambah Data !!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Keranjang'),
            ),
          ),
        ],
      ),
    );
  }
}
