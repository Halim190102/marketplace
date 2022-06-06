import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:marketplace/models/model.dart';
import 'package:provider/provider.dart';

class Alamat extends StatefulWidget {
  const Alamat({
    Key? key,
    this.profil,
    required this.uid,
  }) : super(key: key);
  final Profil? profil;
  final String uid;

  @override
  State<Alamat> createState() => _AlamatState();
}

class _AlamatState extends State<Alamat> {
  final _key = GlobalKey<FormState>();
  final _alamatController = TextEditingController();
  final _nomorController = TextEditingController();

  bool submit = true;

  @override
  void dispose() {
    super.dispose();
    _nomorController.dispose();
    _alamatController.dispose();
  }

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.profil != null) {
      _alamatController.text = widget.profil!.tgl.toString();
      _nomorController.text = widget.profil!.nomor.toString();
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textField(
                  controller: _nomorController,
                  lable: 'Nomor Telepon',
                  valid: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Nomor Telepon';
                    } else if (value.length < 6) {
                      return 'Masukkan minimal 8 Characters';
                    }
                    return null;
                  },
                  onChange: (e) {
                    setState(() {
                      !submit;
                    });
                    return null;
                  },
                  boolean: false,
                  submit: submit
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  format: [FilteringTextInputFormatter.digitsOnly],
                  type: TextInputType.number,
                ),
                textField(
                  controller: _alamatController,
                  lable: 'Alamat',
                  valid: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan alamat';
                    }
                    return null;
                  },
                  onChange: (e) {
                    setState(() {
                      !submit;
                    });
                    return null;
                  },
                  boolean: false,
                  submit: submit
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String nomor = _nomorController.text;
                    String alamat = _alamatController.text;
                    final data =
                        Provider.of<DataProfil>(context, listen: false);
                    if (_key.currentState!.validate()) {
                      if (!_isUpdate) {
                        await data.addProfil(widget.uid, nomor, alamat);
                      } else {
                        final idData = data.dataProfil.firstWhere(
                            (element) => element.id == widget.profil!.id);
                        await data.editProfil(
                          idData.id.toString(),
                          widget.uid,
                          nomor,
                          alamat,
                        );
                      }
                      if (!mounted) return;
                      Navigator.pop(context, 'refresh');
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
