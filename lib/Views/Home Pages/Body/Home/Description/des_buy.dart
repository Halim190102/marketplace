import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:provider/provider.dart';

class DesBuy extends StatefulWidget {
  const DesBuy(
      {Key? key,
      required this.uid,
      required this.image,
      required this.laptop,
      required this.harga})
      : super(key: key);
  final String uid, image, laptop;
  final int harga;
  @override
  State<DesBuy> createState() => _DesBuyState();
}

class _DesBuyState extends State<DesBuy> {
  final user = FirebaseAuth.instance.currentUser!.displayName.toString();

  int jumlah = 1;
  @override
  Widget build(BuildContext context) {
    final dataProfil = Provider.of<DataProfil>(context, listen: false);
    final hargaTotal = (widget.harga) * jumlah;
    return Container(
      padding: const EdgeInsets.all(9),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.23),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset(
                        widget.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (jumlah > 1) {
                              setState(() {
                                jumlah--;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 17,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          jumlah.toString(),
                          style:
                              const TextStyle(fontSize: 17, color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (jumlah < 10) {
                              setState(() {
                                jumlah++;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.add,
                            size: 17,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    'Harga Total : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Rp. $hargaTotal'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Metode Pembayaran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    const Text(
                                      'Transfer Bank',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final buy = Provider.of<BuyCart>(
                                            context,
                                            listen: false);
                                        if (dataProfil.dataProfil[0].tgl
                                                .toString()
                                                .isEmpty ||
                                            dataProfil.dataProfil[0].nomor
                                                .toString()
                                                .isEmpty) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'Ops! Ada Yang Salah'),
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
                                                  dataProfil.dataProfil[0].tgl
                                                      .toString(),
                                                  widget.image,
                                                  jumlah,
                                                  dataProfil.dataProfil[0].nomor
                                                      .toString(),
                                                  'Bank Mandiri')
                                              .then(
                                            (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian berhasil"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          ).catchError(
                                            (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian GAGAL !!!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          );
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'Bank Mandiri',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final buy = Provider.of<BuyCart>(
                                            context,
                                            listen: false);
                                        if (dataProfil.dataProfil[0].tgl
                                                .toString()
                                                .isEmpty ||
                                            dataProfil.dataProfil[0].nomor
                                                .toString()
                                                .isEmpty) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'Ops! Ada Yang Salah'),
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
                                                  dataProfil.dataProfil[0].tgl
                                                      .toString(),
                                                  widget.image,
                                                  jumlah,
                                                  dataProfil.dataProfil[0].nomor
                                                      .toString(),
                                                  'Bank BRI')
                                              .then(
                                            (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian berhasil"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          ).catchError(
                                            (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian GAGAL !!!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          );
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'Bank BRI',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final buy = Provider.of<BuyCart>(
                                            context,
                                            listen: false);
                                        if (dataProfil.dataProfil[0].tgl
                                                .toString()
                                                .isEmpty ||
                                            dataProfil.dataProfil[0].nomor
                                                .toString()
                                                .isEmpty) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'Ops! Ada Yang Salah'),
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
                                                  dataProfil.dataProfil[0].tgl
                                                      .toString(),
                                                  widget.image,
                                                  jumlah,
                                                  dataProfil.dataProfil[0].nomor
                                                      .toString(),
                                                  'Bank BCA')
                                              .then(
                                            (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian berhasil"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          ).catchError(
                                            (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian GAGAL !!!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          );
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'Bank BCA',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Dompet Digital',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final buy = Provider.of<BuyCart>(
                                            context,
                                            listen: false);
                                        if (dataProfil.dataProfil[0].tgl
                                                .toString()
                                                .isEmpty ||
                                            dataProfil.dataProfil[0].nomor
                                                .toString()
                                                .isEmpty) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'Ops! Ada Yang Salah'),
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
                                                  dataProfil.dataProfil[0].tgl
                                                      .toString(),
                                                  widget.image,
                                                  jumlah,
                                                  dataProfil.dataProfil[0].nomor
                                                      .toString(),
                                                  'Dana')
                                              .then(
                                            (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian berhasil"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          ).catchError(
                                            (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian GAGAL !!!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          );
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ThemesColor().purple,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'Dana',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final buy = Provider.of<BuyCart>(
                                            context,
                                            listen: false);
                                        if (dataProfil.dataProfil[0].tgl
                                                .toString()
                                                .isEmpty ||
                                            dataProfil.dataProfil[0].nomor
                                                .toString()
                                                .isEmpty) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  'Ops! Ada Yang Salah'),
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
                                          // if (!mounted) return;
                                          // Navigator.pop(context);
                                        } else {
                                          await buy
                                              .addData2(
                                                  widget.uid,
                                                  user,
                                                  widget.laptop,
                                                  widget.harga,
                                                  dataProfil.dataProfil[0].tgl
                                                      .toString(),
                                                  widget.image,
                                                  jumlah,
                                                  dataProfil.dataProfil[0].nomor
                                                      .toString(),
                                                  'OVO')
                                              .then(
                                            (response) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian berhasil"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          ).catchError(
                                            (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Pembelian GAGAL !!!"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                          );
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ThemesColor().purple,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'OVO',
                                            style:
                                                TextStyle(color: Colors.white),
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
                      ),
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text('Beli'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
