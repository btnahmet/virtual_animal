import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/login.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Register(), // Home yerine Register kullanıldı
    );
  }
}

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("İsim: ${_nameController.text}");
      print("Email: ${_emailController.text}");
      print("Şifre: ${_passwordController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(190, 252, 249, 249),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: screenHeight * 0.069,
            child: Image.asset(
              'assets/images/cat.png',
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.69,
              decoration: BoxDecoration(
                color: Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Üye ol",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField("İsim", controller: _nameController),
                          _buildTextField("Email",
                              controller: _emailController, isEmail: true),
                          _buildTextField("Şifre",
                              controller: _passwordController,
                              isPassword: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.15, vertical: 12),
                        ),
                        child: const Text(
                          "Kaydol",
                          style:
                              TextStyle(color: Color(0xFFB65C2C), fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Login()), // Login ekranına yönlendirme
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Zaten hesabınız var mı? ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Giriş Yap",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText,
      {bool isPassword = false,
      bool isEmail = false,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hintText alanı boş bırakılamaz";
          }
          if (isEmail &&
              !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
            return "Geçerli bir email adresi giriniz";
          }
          if (isPassword && value.length < 6) {
            return "Şifre en az 6 karakter olmalıdır";
          }
          return null;
        },
      ),
    );
  }
}
