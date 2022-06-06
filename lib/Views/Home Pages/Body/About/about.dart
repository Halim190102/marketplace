import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Reusable%20Widget/setting_item.dart';
import 'package:marketplace/Component/Theme/color.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:marketplace/Views/Home%20Pages/Body/About/Form/alamat.dart';
import 'package:marketplace/Views/Login%20Pages/login.dart';
import 'package:provider/provider.dart';

class Abouts extends StatefulWidget {
  const Abouts({Key? key}) : super(key: key);

  @override
  State<Abouts> createState() => _AboutsState();
}

class _AboutsState extends State<Abouts> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  String button = 'Tambah Nomor Telephone dan Alamat';
  String nomor = 'Atur Nomor Ponsel';
  String lokasi = 'Atur Lokasi';

  bool value = false;

  void changeData() {
    setState(() {
      value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProfil = Provider.of<DataProfil>(context, listen: false);
    final data1 = Provider.of<ShoppingCart>(context).allDataShopping;
    final data2 = Provider.of<BuyCart>(context).allDataBuy;
    if (dataProfil.dataProfil.isNotEmpty) {
      setState(() {
        button = 'Edit Nomor Telephone dan Alamat';
        nomor = dataProfil.dataProfil[0].nomor.toString();
        lokasi = dataProfil.dataProfil[0].tgl.toString();
      });
    }
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  user.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  email.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SettingItem(
              title: button,
              leadingIcon: Icons.settings,
              leadingIconColor: Colors.grey,
              onTap: () async {
                if (dataProfil.dataProfil.isEmpty) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => Alamat(uid: uid),
                  //   ),
                  // );

                  String refresh = await showDialog(
                    context: context,
                    builder: (_) => Alamat(
                      uid: uid,
                    ),
                  );
                  if (refresh == 'refresh') {
                    changeData();
                  }
                } else {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) =>
                  //         Alamat(profil: dataProfil.dataProfil[0], uid: uid),
                  //   ),
                  // );
                  String refresh = await showDialog(
                    context: context,
                    builder: (_) => Alamat(
                      profil: dataProfil.dataProfil[0],
                      uid: uid,
                    ),
                  );
                  if (refresh == 'refresh') {
                    changeData();
                  }
                }
              },
            ),
            const SizedBox(height: 10),
            SettingItem(
                title: nomor,
                leadingIcon: Icons.phone,
                leadingIconColor: blue,
                onTap: () {}),
            const SizedBox(height: 10),
            SettingItem(
                title: lokasi,
                leadingIcon: Icons.map,
                leadingIconColor: green,
                onTap: () {}),
            const SizedBox(height: 10),
            SettingItem(
              title: "Keluar",
              leadingIcon: Icons.logout_outlined,
              leadingIconColor: Colors.grey.shade400,
              onTap: () async {
                dataProfil.dataProfil.clear();
                data1.clear();
                data2.clear();
                await _signOut();
                if (!mounted) return;
                if (_firebaseAuth.currentUser == null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
