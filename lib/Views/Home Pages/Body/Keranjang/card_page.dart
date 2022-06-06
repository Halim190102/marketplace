import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Keranjang/Pembayaran/bayar.dart';
import 'package:provider/provider.dart';

class CardPageList extends StatefulWidget {
  const CardPageList({
    Key? key,
  }) : super(key: key);

  @override
  State<CardPageList> createState() => _CardPageListState();
}

class _CardPageListState extends State<CardPageList> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int hargaTotal = 0;

  bool messege = true;
  bool delete = false;

  bool value = false;

  void changeData() {
    setState(() {
      value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ShoppingCart>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Keranjang'),
        elevation: 0,
      ),
      backgroundColor: ThemesColor().primaryBody,
      body: list.allDataShopping.isEmpty
          ? const Center(
              child: Text(
                'Kosong',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: list.jumlahShop,
                  itemBuilder: (context, index) {
                    final listKeranjang = list.allDataShopping[index];
                    int jumlah = listKeranjang.jumlah as int;
                    int harga = listKeranjang.harga as int;
                    final id = listKeranjang.id.toString();
                    final laptop = listKeranjang.laptop.toString();
                    final lokasi = listKeranjang.lokasi.toString();
                    final image = listKeranjang.image.toString();
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lokasi,
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.23),
                                          child: SizedBox(
                                            width: 90,
                                            height: 90,
                                            child: Image.asset(
                                              listKeranjang.image.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          laptop,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        const SizedBox(height: 8),
                                        Text('Rp. $harga'),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      primary: Colors.green),
                                  onPressed: () async {
                                    String refresh = await showDialog(
                                      context: context,
                                      builder: (_) => Bayar(
                                        list: list,
                                        uid: uid,
                                        laptop: laptop,
                                        lokasi: lokasi,
                                        image: image,
                                        harga: harga,
                                        jumlah: jumlah,
                                        id: id,
                                      ),
                                    );
                                    if (refresh == 'refresh') {
                                      changeData();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.monetization_on,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Harga Total : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Rp. ${(harga * jumlah)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      alignment: Alignment.bottomRight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              final dataShopList = list
                                                  .allDataShopping
                                                  .firstWhere((element) =>
                                                      element.laptop ==
                                                      listKeranjang.laptop);
                                              if ((listKeranjang.jumlah
                                                      as int) >
                                                  1) {
                                                await list.editData1(
                                                    dataShopList.id!,
                                                    uid,
                                                    listKeranjang.laptop
                                                        .toString(),
                                                    listKeranjang.harga as int,
                                                    (listKeranjang.jumlah
                                                            as int) -
                                                        1);
                                                setState(() {
                                                  jumlah = listKeranjang.jumlah
                                                      as int;
                                                });
                                              }
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            jumlah.toString(),
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final dataShopList = list
                                                  .allDataShopping
                                                  .firstWhere((element) =>
                                                      element.laptop ==
                                                      listKeranjang.laptop);
                                              if ((listKeranjang.jumlah
                                                      as int) <
                                                  10) {
                                                await list.editData1(
                                                    dataShopList.id!,
                                                    uid,
                                                    listKeranjang.laptop
                                                        .toString(),
                                                    listKeranjang.harga as int,
                                                    (listKeranjang.jumlah
                                                            as int) +
                                                        1);
                                                setState(() {
                                                  jumlah = listKeranjang.jumlah
                                                      as int;
                                                });
                                              }
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text(
                                          'Kamu Yakin ingin menghapusnya ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              messege = false;
                                            });
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await list.deleteData1(
                                              id,
                                              uid,
                                            );
                                            setState(() {
                                              messege = true;
                                            });
                                            if (!mounted) {
                                              return;
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (!mounted) return;
                                  messege == true
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text("Berhasil dihapus"),
                                            duration:
                                                Duration(milliseconds: 500),
                                          ),
                                        )
                                      : null;
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
