import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  const Invoice({
    Key? key,
    required this.nama,
    required this.tanggal,
    required this.nomor,
    required this.metode,
    required this.alamat,
    required this.laptop,
    required this.jumlah,
    required this.harga,
    required this.hargaTotal,
  }) : super(key: key);
  final String nama, tanggal, nomor, metode, alamat, laptop;
  final int jumlah, harga, hargaTotal;

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Invoice Pembelian'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pembeli',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tanggal Pembelian',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Nomor Telepon',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Alamat Pembeli',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ': ${widget.nama}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ': ${widget.tanggal}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ': ${widget.nomor}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ': ${widget.metode}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ': ${widget.alamat}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.4,
                  color: Colors.black54,
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Info Produk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.laptop,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jumlah',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.jumlah.toString()),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Harga Satuan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Rp. ${widget.harga}'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Harga',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Rp. ${widget.hargaTotal}'),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
