import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/services/adminService.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/sortButton.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/placeOrderButton.dart';
import 'package:grtabstore/ui/widgets/Shared/textForm.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: width * 0.8,
        padding: EdgeInsets.all(height * 0.03),
        decoration: BoxDecoration(
          color: primaryBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: height * 0.005),
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    color: textPrimary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Admin Login',
                    fontSize: width * 0.05,
                    color: textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            TextForm(
              controller: _usernameController,
              label: 'Email',
              icon: Icon(Icons.email),
            ),
            SizedBox(height: height * 0.01),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              padding: EdgeInsets.only(
                right: width * 0.02,
                top: height * 0.007,
                bottom: height * 0.005,
                left: width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: textPrimary, width: 1.5),
              ),
              height: height * 0.045,
              child: TextField(
                style: GoogleFonts.abel(
                  fontSize: width * 0.034,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                obscureText: !isPasswordVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: textSecondary,
                      size: width * 0.05,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: FilterSortButton(
                    icon: Icon(
                      Icons.close,
                      color: textOnDark,
                      size: width * 0.05,
                    ),
                    function: () {
                      Navigator.pop(context);
                    },
                    label: 'Cancel',
                    size: width * 0.15,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FilterSortButton(
                    icon: Icon(
                      Icons.login,
                      color: textOnDark,
                      size: width * 0.05,
                    ),
                    function: _handleLogin,
                    label: 'Login',
                    size: width * 0.15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    // Add your login logic here
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool loginSuccess = await AdminService().login(username, password);

    if (loginSuccess) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('valid credentials'),
          backgroundColor: Colors.green,
        ),
      ); // Return true on successful login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Helper function to show the modal
void showLoginModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const LoginModal(),
  ).then((result) {
    if (result == true) {
      // Login was successful
      print('Admin logged in successfully');
    }
  });
}
