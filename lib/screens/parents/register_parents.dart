import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/parents/login_parents.dart';
import 'package:virtual_animal/database/parent_data.dart';

class RegisterParents extends StatefulWidget {
  const RegisterParents({super.key});

  @override
  State<RegisterParents> createState() => _RegisterParentsState();
}

class _RegisterParentsState extends State<RegisterParents> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Ebeveyn bilgilerini kaydet
      ParentData.saveParentData(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );
      
      // Login sayfasına yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginParents()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 153, 105),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Üye Ol",
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
                      _buildTextField("İsim", controller: _nameController),
                      _buildTextField("Email", controller: _emailController, isEmail: true),
                      _buildTextField("Şifre", controller: _passwordController, isPassword: true),
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
                      "Kaydol",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginParents()),
                    );
                  },
                  child: const Text(
                    "Zaten hesabın var mı? Giriş Yap",
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 50, 10),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
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
            return "Şifre en az 6 karakter olmalıdır";
          }
          return null;
        },
      ),
    );
  }
} 