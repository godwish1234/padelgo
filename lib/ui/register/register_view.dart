import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/components/my_button.dart';
import 'package:padelgo/components/my_text_field.dart';
import 'package:padelgo/ui/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with TickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String _errorMessage = "";
  bool _isFormValid = false;
  bool _agreeToTerms = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    nameController.addListener(_checkFieldsNotEmpty);
    emailController.addListener(_checkFieldsNotEmpty);
    phoneController.addListener(_checkFieldsNotEmpty);
    passwordController.addListener(_checkFieldsNotEmpty);
    confirmPasswordController.addListener(_checkFieldsNotEmpty);

    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _checkFieldsNotEmpty() {
    setState(() {
      _isFormValid = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          _agreeToTerms;
    });
  }

  bool _validateEmailFormat(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  void _handleRegister(RegisterViewModel vm) {
    if (!nameController.text.isNotEmpty ||
        !emailController.text.isNotEmpty ||
        !phoneController.text.isNotEmpty ||
        !passwordController.text.isNotEmpty ||
        !confirmPasswordController.text.isNotEmpty) {
      setState(() {
        _errorMessage = "All fields are required";
      });
      return;
    }

    if (!_validateEmailFormat(emailController.text)) {
      setState(() {
        _errorMessage = "Invalid email format";
      });
      return;
    }

    if (!_validatePassword(passwordController.text)) {
      setState(() {
        _errorMessage = "Password must be at least 6 characters";
      });
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match";
      });
      return;
    }

    if (!_agreeToTerms) {
      setState(() {
        _errorMessage = "Please agree to terms and conditions";
      });
      return;
    }

    vm.register(
      context,
      nameController.text,
      emailController.text,
      phoneController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = HexColor("#1E88E5");
    final backgroundColor =
        isDarkMode ? HexColor("#0A0A0A") : HexColor("#FAFAFA");
    final cardColor = isDarkMode ? HexColor("#1A1A1A") : Colors.white;
    final textColor = isDarkMode ? Colors.white : HexColor("#212121");
    final hintColor = isDarkMode ? HexColor("#BBBBBB") : HexColor("#757575");

    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(this),
      onViewModelReady: (vm) => vm.initialize(),
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.8),
                      HexColor("#0D47A1"),
                    ],
                  ),
                ),
              ),

              // Decorative circles
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Header with back button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Create Account",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Registration form card
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(
                                size.width * 0.08,
                                size.height * 0.04,
                                size.width * 0.08,
                                size.height * 0.04,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Join CourtSide",
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Start booking courts in seconds",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: hintColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 28),

                                  // Full Name field
                                  MyTextField(
                                    controller: nameController,
                                    hintText: 'Full Name',
                                    obscureText: false,
                                    prefixIcon:
                                        const Icon(Icons.person_outline),
                                    onChanged: () {
                                      if (_errorMessage.isNotEmpty) {
                                        setState(() {
                                          _errorMessage = "";
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Email field
                                  MyTextField(
                                    controller: emailController,
                                    hintText: 'Email Address',
                                    obscureText: false,
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    onChanged: () {
                                      if (_errorMessage.isNotEmpty) {
                                        setState(() {
                                          _errorMessage = "";
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Phone field
                                  MyTextField(
                                    controller: phoneController,
                                    hintText: 'Phone Number',
                                    obscureText: false,
                                    prefixIcon:
                                        const Icon(Icons.phone_outlined),
                                    onChanged: () {
                                      if (_errorMessage.isNotEmpty) {
                                        setState(() {
                                          _errorMessage = "";
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Password field
                                  MyTextField(
                                    controller: passwordController,
                                    hintText: "Password (min. 6 characters)",
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
                                    onChanged: () {
                                      if (_errorMessage.isNotEmpty) {
                                        setState(() {
                                          _errorMessage = "";
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Confirm Password field
                                  MyTextField(
                                    controller: confirmPasswordController,
                                    hintText: "Confirm Password",
                                    obscureText: !_confirmPasswordVisible,
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _confirmPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: hintColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _confirmPasswordVisible =
                                              !_confirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    onChanged: () {
                                      if (_errorMessage.isNotEmpty) {
                                        setState(() {
                                          _errorMessage = "";
                                        });
                                      }
                                    },
                                  ),

                                  // Error message
                                  if (_errorMessage.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 4),
                                      child: Text(
                                        _errorMessage,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 16),

                                  // Terms and conditions checkbox
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: _agreeToTerms,
                                          activeColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              _agreeToTerms = value ?? false;
                                              _checkFieldsNotEmpty();
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "I agree to the ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: hintColor,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // TODO: Show terms
                                              },
                                              child: Text(
                                                "Terms & Conditions",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              " and ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: hintColor,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // TODO: Show privacy policy
                                              },
                                              child: Text(
                                                "Privacy Policy",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  // Register button
                                  MyButton(
                                    onPressed: () => _handleRegister(vm),
                                    buttonText: "Create Account",
                                    isLoading: vm.isBusy,
                                    isEnabled: _isFormValid,
                                  ),

                                  const SizedBox(height: 24),

                                  // Divider
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                              color:
                                                  hintColor.withOpacity(0.3))),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          "or sign up with",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: hintColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Divider(
                                              color:
                                                  hintColor.withOpacity(0.3))),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  // Social signup buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildSocialButton(
                                        onTap: () =>
                                            vm.signUpWithGoogle(context),
                                        icon: 'icons/google_icon.png',
                                        isDarkMode: isDarkMode,
                                      ),
                                      const SizedBox(width: 20),
                                      _buildSocialButton(
                                        onTap: () =>
                                            vm.signUpWithFacebook(context),
                                        icon: 'icons/facebook_icon.png',
                                        isDarkMode: isDarkMode,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  // Sign in option
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account? ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: hintColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          "Sign In",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required Function() onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDarkMode ? HexColor("#252525") : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? HexColor("#353535") : HexColor("#E0E0E0"),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Image.asset(
          icon,
          height: 26,
          width: 26,
        ),
      ),
    );
  }
}
