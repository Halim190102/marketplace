import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:marketplace/Views/Home%20Pages/home.dart';
import 'package:marketplace/Views/Login%20Pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible = true;
  bool submit1 = true;
  bool submit2 = true;
  bool isloading = false;

  iniInitial() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHome(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      iniInitial();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      const CircleAvatar(
                        radius: 90,
                        backgroundImage:
                            AssetImage('assets/images/milenial.png'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
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
                              // const SizedBox(height: 20),
                              // const Text(
                              //   'Login',
                              //   style: TextStyle(
                              //     color: Colors.black54,
                              //     fontSize: 50,
                              //     fontWeight: FontWeight.w700,
                              //   ),
                              // ),
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
                                controller: _passwordController,
                                lable: 'Password',
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password cannot be null';
                                  }
                                  return null;
                                },
                                boolean: _passwordVisible,
                                submit: submit2
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                onChange: (e) {
                                  setState(() {
                                    !submit2;
                                  });
                                  return null;
                                },
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              InkWell(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
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
                                  String email = _emailController.text;
                                  String pass = _passwordController.text;
                                  if (_key.currentState!.validate()) {
                                    setState(() {
                                      isloading = true;
                                    });
                                    try {
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: pass);
                                      if (!mounted) {
                                        return setState(() {
                                          isloading = false;
                                        });
                                      }
                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MyHome(),
                                        ),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title:
                                              const Text("Ops! Login Failed"),
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
                                  const Text('Belum punya akun ?'),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Daftar',
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
                ),
              ],
            ),
    );
  }
}
