import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Views/Home%20Pages/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordControllerConfirm = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  bool submit1 = true;
  bool submit2 = true;
  bool submit3 = true;
  bool submit4 = true;
  bool isloading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  color: ThemesColor().rawblue,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 120,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 25),
                        textField(
                          controller: _nameController,
                          lable: 'Name',
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                          onChange: (e) {
                            setState(() {
                              !submit1;
                            });
                            return null;
                          },
                          boolean: false,
                          submit: submit1
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                        ),
                        textField(
                          controller: _emailController,
                          lable: 'Email',
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Enter some Email';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Masukkan format yang sesuai';
                            }
                            return null;
                          },
                          onChange: (e) {
                            setState(() {
                              !submit2;
                            });
                            return null;
                          },
                          boolean: false,
                          submit: submit2
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                        ),
                        textField(
                          controller: _passwordController,
                          lable: 'Password',
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be null';
                            } else if (value.length < 6) {
                              return 'Enter at least 8 Characters';
                            }
                            return null;
                          },
                          boolean: _passwordVisible1,
                          submit: submit3
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          onChange: (e) {
                            setState(() {
                              !submit3;
                            });
                            return null;
                          },
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible1 = !_passwordVisible1;
                              });
                            },
                            icon: Icon(
                              _passwordVisible1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        textField(
                          controller: _passwordControllerConfirm,
                          lable: 'Confirm Password',
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be null';
                            } else if (value.length < 6) {
                              return 'Enter at least 8 Characters';
                            } else if (value != _passwordController.text) {
                              return 'Password must be the same';
                            }
                            return null;
                          },
                          boolean: _passwordVisible2,
                          submit: submit4
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          onChange: (e) {
                            setState(() {
                              !submit4;
                            });
                            return null;
                          },
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
                              });
                            },
                            icon: Icon(
                              _passwordVisible2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ThemesColor().rawblue,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () async {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String pass = _passwordControllerConfirm.text;
                            User? user;
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              try {
                                UserCredential userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: pass);
                                user = userCredential.user;
                                await user!.updateDisplayName(name);
                                await user.reload();
                                if (!mounted) {
                                  return setState(() {
                                    isloading = false;
                                  });
                                }
                                // final userid = user.uid;
                                // final profile = Provider.of<DataProfil>(context,
                                //     listen: false);
                                // await profile.addProfil(userid, name, pass);
                                // if (!mounted) return;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHome(),
                                  ),
                                  (route) => false,
                                );
                              } on FirebaseAuthException catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Ops! Login Failed"),
                                    content: Text('${e.message}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Okay'),
                                      )
                                    ],
                                  ),
                                );
                                setState(() {
                                  isloading = false;
                                });
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sudah punya akun ?'),
                            const SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: ThemesColor().purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
