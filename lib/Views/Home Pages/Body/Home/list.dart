import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:provider/provider.dart';

class CardPages extends StatefulWidget {
  const CardPages({
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
  State<CardPages> createState() => _CardPagesState();
}

class _CardPagesState extends State<CardPages> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.23),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(widget.image),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.laptop,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp. ${widget.harga}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.lokasi,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: ThemesColor().primaryBar,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('Masukkan Ke keranjang'),
                            onTap: () async {
                              final data = Provider.of<ShoppingCart>(context,
                                  listen: false);
                              if ((data.allDataShopping.where((element) =>
                                  element.laptop == widget.laptop)).isEmpty) {
                                await data
                                    .addData1(
                                  widget.uid,
                                  widget.laptop,
                                  widget.harga,
                                  widget.lokasi,
                                  widget.image,
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
                                        content: Text(
                                            "Tidak dapat menambah Data !!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                );
                                if (!mounted) return;
                                Navigator.pop(context);
                              } else {
                                final dataShopList = data.allDataShopping
                                    .firstWhere((element) =>
                                        element.laptop == widget.laptop);
                                data
                                    .editData1(
                                  dataShopList.id!,
                                  widget.uid,
                                  widget.laptop,
                                  widget.harga,
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
                                        content: Text(
                                            "Tidak dapat menambah Data !!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                );
                                if (!mounted) return;
                                Navigator.pop(context);
                              }
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.more_horiz,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// }
