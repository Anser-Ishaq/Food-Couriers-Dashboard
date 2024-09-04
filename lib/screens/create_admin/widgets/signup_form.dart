import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_dashboard/constants/routes/routes.dart';
import 'package:food_couriers_dashboard/models/user_model.dart';
import 'package:food_couriers_dashboard/provider/auth_provider.dart';
import 'package:food_couriers_dashboard/provider/userdata_provider.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/custom_signup_button.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/custom_text_field.dart';
import 'package:food_couriers_dashboard/screens/create_admin/widgets/space.dart';
import 'package:food_couriers_dashboard/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  late AuthProvider _authProvider;
  late UserdataProvider _userDataProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _userDataProvider = Provider.of<UserdataProvider>(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              title: 'Name',
              textEditingController: _nameController,
              obscureText: false,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const Space(),
            const Space(),
            CustomTextField(
              title: 'Email',
              textEditingController: _emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const Space(),
            const Space(),
            CustomTextField(
              title: 'Password',
              textEditingController: _passwordController,
              obscureText: _isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              isIcon: true,
              onTap: () => setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              }),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your password';
                }
                if (value.trim().length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
                if (!passwordRegex.hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
                }
                return null;
              },
            ),
            const Space(),
            const Space(),
            CustomTextField(
              title: 'Confirm Password',
              textEditingController: _confirmPasswordController,
              obscureText: _isConfirmPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              isIcon: true,
              onTap: () => setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              }),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please confirm your password';
                }
                if (value.trim() != _passwordController.text.trim()) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const Space(),
            const Space(),
            CustomSignupButton(
              buttonText: 'Create',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _createAccount();
                }
              },
            ),
            const Space(),
            const Space(),
          ],
        ),
      ),
    );
  }

  void _createAccount() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }
    _authProvider.signUp(email, password).then((_) {
      if (_authProvider.user != null) {
        _userDataProvider.createUser(
          UserModel(
            uid: _authProvider.user!.uid,
            name: name,
            email: email,
            role: 'Admin',
            createAt: Timestamp.now(),
            status: 'Inactive',
          ),
        );
        _authProvider.signOut();
        context.goNamed(Routes.home);
      }
    });
  }
}
