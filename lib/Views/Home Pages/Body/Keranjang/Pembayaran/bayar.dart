import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:provider/provider.dart';

class Bayar extends StatefulWidget {
  const Bayar(
      {Key? key,
      required this.uid,
      required this.laptop,
      required this.lokasi,
      required this.image,
      required this.harga,
      required this.jumlah,
      required this.id,
      required this.list})
      : super(key: key);
  final ShoppingCart list;
  final String id, uid, laptop, lokasi, image;
  final int harga, jumlah;

  @override
  State<Bayar> createState() => _BayarState();
}

class _BayarState extends State<Bayar> {
  final user = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  Widget build(BuildContext context) {
    final dataProfil = Provider.of<DataProfil>(context, listen: false);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 7.5,
                  ),
                  const Text(
                    'Transfer Bank',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final buy = Provider.of<BuyCart>(context, listen: false);
                      if (dataProfil.dataProfil[0].tgl.toString().isEmpty ||
                          dataProfil.dataProfil[0].nomor.toString().isEmpty) {
                        Navigator.pop(context, 'refresh');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ops! Ada Yang Salah'),
                            content: const Text(
                                'Nomor Telepon dan Alamat tidak boleh Kosong'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await buy
                            .addData2(
                          widget.uid,
                          user,
                          widget.laptop,
                          widget.harga,
                          dataProfil.dataProfil[0].tgl.toString(),
                          widget.image,
                          widget.jumlah,
                          dataProfil.dataProfil[0].nomor.toString(),
                          'Bank Mandiri',
                        )
                            .then(
                          (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian berhasil"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian GAGAL !!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                        await widget.list.deleteData1(widget.id, widget.uid);
                        if (!mounted) return;
                        Navigator.pop(context, 'refresh');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Bank Mandiri',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final buy = Provider.of<BuyCart>(context, listen: false);
                      if (dataProfil.dataProfil[0].tgl.toString().isEmpty ||
                          dataProfil.dataProfil[0].nomor.toString().isEmpty) {
                        Navigator.pop(context, 'refresh');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ops! Ada Yang Salah'),
                            content: const Text(
                                'Nomor Telepon dan Alamat tidak boleh Kosong'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await buy
                            .addData2(
                          widget.uid,
                          user,
                          widget.laptop,
                          widget.harga,
                          dataProfil.dataProfil[0].tgl.toString(),
                          widget.image,
                          widget.jumlah,
                          dataProfil.dataProfil[0].nomor.toString(),
                          'Bank BRI',
                        )
                            .then(
                          (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian berhasil"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian GAGAL !!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                        await widget.list.deleteData1(widget.id, widget.uid);
                        if (!mounted) return;
                        Navigator.pop(context, 'refresh');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Bank BRI',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final buy = Provider.of<BuyCart>(context, listen: false);
                      if (dataProfil.dataProfil[0].tgl.toString().isEmpty ||
                          dataProfil.dataProfil[0].nomor.toString().isEmpty) {
                        Navigator.pop(context, 'refresh');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ops! Ada Yang Salah'),
                            content: const Text(
                                'Nomor Telepon dan Alamat tidak boleh Kosong'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await buy
                            .addData2(
                          widget.uid,
                          user,
                          widget.laptop,
                          widget.harga,
                          dataProfil.dataProfil[0].tgl.toString(),
                          widget.image,
                          widget.jumlah,
                          dataProfil.dataProfil[0].nomor.toString(),
                          'Bank BCA',
                        )
                            .then(
                          (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian berhasil"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian GAGAL !!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                        await widget.list.deleteData1(widget.id, widget.uid);
                        if (!mounted) return;
                        Navigator.pop(context, 'refresh');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Bank BCA',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Dompet Digital',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final buy = Provider.of<BuyCart>(context, listen: false);
                      if (dataProfil.dataProfil[0].tgl.toString().isEmpty ||
                          dataProfil.dataProfil[0].nomor.toString().isEmpty) {
                        Navigator.pop(context, 'refresh');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ops! Ada Yang Salah'),
                            content: const Text(
                                'Nomor Telepon dan Alamat tidak boleh Kosong'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await buy
                            .addData2(
                          widget.uid,
                          user,
                          widget.laptop,
                          widget.harga,
                          dataProfil.dataProfil[0].tgl.toString(),
                          widget.image,
                          widget.jumlah,
                          dataProfil.dataProfil[0].nomor.toString(),
                          'Dana',
                        )
                            .then(
                          (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian berhasil"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian GAGAL !!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                        await widget.list.deleteData1(widget.id, widget.uid);
                        if (!mounted) return;
                        Navigator.pop(context, 'refresh');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemesColor().purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Dana',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final buy = Provider.of<BuyCart>(context, listen: false);
                      if (dataProfil.dataProfil[0].tgl.toString().isEmpty ||
                          dataProfil.dataProfil[0].nomor.toString().isEmpty) {
                        Navigator.pop(context, 'refresh');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Ops! Ada Yang Salah'),
                            content: const Text(
                                'Nomor Telepon dan Alamat tidak boleh Kosong'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Okay'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await buy
                            .addData2(
                          widget.uid,
                          user,
                          widget.laptop,
                          widget.harga,
                          dataProfil.dataProfil[0].tgl.toString(),
                          widget.image,
                          widget.jumlah,
                          dataProfil.dataProfil[0].nomor.toString(),
                          'OVO',
                        )
                            .then(
                          (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian berhasil"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ).catchError(
                          (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pembelian GAGAL !!!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                        await widget.list.deleteData1(widget.id, widget.uid);
                        if (!mounted) return;
                        Navigator.pop(context, 'refresh');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemesColor().purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'OVO',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
