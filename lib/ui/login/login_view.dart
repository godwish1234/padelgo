import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/components/my_button.dart';
import 'package:padelgo/components/my_text_field.dart';
import 'package:padelgo/ui/login/login_view_model.dart';
import 'package:padelgo/ui/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible = false;
  String _errorMessage = "";
  bool _isFormValid = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    emailController.addListener(_checkFieldsNotEmpty);
    passwordController.addListener(_checkFieldsNotEmpty);

    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    emailController.removeListener(_checkFieldsNotEmpty);
    passwordController.removeListener(_checkFieldsNotEmpty);
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _checkFieldsNotEmpty() {
    setState(() {
      _isFormValid =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  bool _validateEmailFormat(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isValid = emailRegex.hasMatch(email);

    if (!isValid) {
      setState(() {
        _errorMessage = "Invalid email format";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }

    return isValid;
  }

  void _handleLogin(LoginViewModel vm) {
    if (!emailController.text.isNotEmpty ||
        !passwordController.text.isNotEmpty) {
      setState(() {
        _errorMessage = "Email and password cannot be empty";
      });
      return;
    }

    if (!_validateEmailFormat(emailController.text)) {
      return;
    }

    vm.signIn(context, emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Padel theme colors - green and blue
    final padelGreen = HexColor("#00C853");
    final padelBlue = HexColor("#0091EA");
    final backgroundColor =
        isDarkMode ? HexColor("#0A0E1A") : HexColor("#F0F4F8");
    final cardColor = isDarkMode ? HexColor("#1A1F2E") : Colors.white;
    final textColor = isDarkMode ? Colors.white : HexColor("#1A1F2E");
    final hintColor = isDarkMode ? HexColor("#B0B8C1") : HexColor("#6B7280");

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(this),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: _buildLoginForm(
                      vm,
                      cardColor,
                      textColor,
                      hintColor,
                      padelGreen,
                      isDarkMode,
                      size,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildLoginForm(
    LoginViewModel vm,
    Color cardColor,
    Color textColor,
    Color hintColor,
    Color primaryColor,
    bool isDarkMode,
    Size size,
  ) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              "Welcome Back",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Sign in to continue playing",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: hintColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),

            // Email field
            MyTextField(
              controller: emailController,
              hintText: 'Email address',
              obscureText: false,
              prefixIcon: const Icon(Icons.email_outlined),
              onChanged: () {
                if (_errorMessage.isNotEmpty) {
                  setState(() {
                    _errorMessage = "";
                  });
                }
              },
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  _errorMessage,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Password field
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: !_passwordVisible,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: hintColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Forgot password functionality
                },
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Sign in button
            MyButton(
              onPressed: () => _handleLogin(vm),
              buttonText: "Sign In",
              isLoading: vm.isBusy,
              isEnabled: _isFormValid,
            ),

            const SizedBox(height: 32),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: hintColor.withOpacity(0.3))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "or",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: hintColor,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: hintColor.withOpacity(0.3))),
              ],
            ),

            const SizedBox(height: 32),

            // Social login buttons
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    onTap: () => vm.signInWithGoogle(context),
                    icon: 'icons/google_icon.png',
                    label: 'Google',
                    isDarkMode: isDarkMode,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSocialButton(
                    onTap: () => vm.signInWithFacebook(context),
                    icon: 'icons/facebook_icon.png',
                    label: 'Facebook',
                    isDarkMode: isDarkMode,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New to PadelGo? ",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: hintColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ),
                    );
                  },
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required Function() onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDarkMode ? HexColor("#252D3F") : HexColor("#F9FAFB"),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? HexColor("#3A4256") : HexColor("#E5E7EB"),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 20,
              width: 20,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  icon.contains('google') ? Icons.g_mobiledata : Icons.facebook,
                  size: 20,
                  color: isDarkMode ? Colors.white70 : Colors.grey[700],
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : HexColor("#374151"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
