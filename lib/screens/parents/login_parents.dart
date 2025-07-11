import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/home_page.dart';
import 'package:virtual_animal/screens/parents/page_parents.dart'; // HomePage import edildi
import 'package:virtual_animal/screens/parents/register_parents.dart';
import 'package:virtual_animal/database/parent_data.dart';

class LoginParents extends StatefulWidget {
  const LoginParents({super.key});

  @override
  State<LoginParents> createState() => _LoginParentsState();
}

class _LoginParentsState extends State<LoginParents> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController2 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Ebeveyn bilgilerini kontrol et
      if (await ParentData.validateParent(_emailController2.text, _passwordController2.text)) {
        // Giriş başarılıysa PageParents'e yönlendirme
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PageParents()),
          );
        }
      } else {
        // Hata mesajı göster
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email veya şifre hatalı!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 153, 105),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Giriş Yap",
                style: TextStyle(
                  color: Color.fromARGB(255, 119, 48, 10),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Email", controller: _emailController2, isEmail: true),
                    _buildTextField("Parola", controller: _passwordController2, isPassword: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.7,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 250, 102, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Giriş",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterParents()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 250, 102, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Hesabın yok mu? Üye Ol",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, {bool isPassword = false, bool isEmail = false, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hintText alanı boş bırakılamaz";
          }
          if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
            return "Geçerli bir email adresi giriniz";
          }
          if (isPassword && value.length < 6) {
            return "Parola en az 6 karakter olmalıdır";
          }
          return null;
        },
      ),
    );
  }
}
