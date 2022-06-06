import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Riwayat/Invoice/invoice.dart';
import 'package:provider/provider.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({Key? key}) : super(key: key);

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final datas = Provider.of<BuyCart>(context, listen: false);

    bool messege = true;
    // return const SafeArea(child: Text('hallo'));
    return SafeArea(
      child: ListView.builder(
        itemCount: datas.jumlahBuy,
        itemBuilder: (ctx, i) {
          final data = datas.allDataBuy[i];
          final id = data.id.toString();
          final date = data.createdAt.toString();
          final nama = data.nama.toString();
          final laptop = data.laptop.toString();
          final lokasi = data.lokasi.toString();
          final harga = data.harga as int;
          final image = data.image.toString();
          final jumlah = data.jumlah as int;
          final metode = data.metode.toString();
          final nomor = data.nomor.toString();
          final hargaTotal = ((data.harga as int) * (data.jumlah as int));
          return InkWell(
            onLongPress: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('Kamu Yakin ingin menghapusnya ?'),
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
                        await datas.deleteData2(
                          id,
                          uid,
                        );
                        if (!mounted) return;
                        Navigator.pop(
                          context,
                        );
                        setState(() {
                          messege = true;
                        });
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
              if (!mounted) return;
              messege == true
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Berhasil dihapus"),
                        duration: Duration(milliseconds: 500),
                      ),
                    )
                  : null;
            },
            child: Card(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.redAccent,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.23),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.asset(image),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  laptop,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$jumlah x Rp. $harga',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                            // SizedBox(
                            //   width: 150,
                            //   child: ListTile(
                            //     title: Text(
                            //       laptop,
                            //     ),
                            //     subtitle: Text(
                            // '$jumlah x Rp. $harga',
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1.4,
                          color: Colors.black54,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Total'),
                                Text(
                                  'Rp. $hargaTotal',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 22,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.info_outline_rounded,
                                  size: 18,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Invoice(
                                        nama: nama,
                                        tanggal: date,
                                        nomor: nomor,
                                        metode: metode,
                                        alamat: lokasi,
                                        laptop: laptop,
                                        jumlah: jumlah,
                                        harga: harga,
                                        hargaTotal: hargaTotal,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
