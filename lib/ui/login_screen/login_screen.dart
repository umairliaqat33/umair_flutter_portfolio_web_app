import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_bloc.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_event.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_state.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/password_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PortfolioAppTheme.primary,
      appBar: AppBar(
        title: Text(
          "Login",
        ),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Center(
              child: Container(
                width: context.width * 0.8,
                height: context.height,
                padding: AppSizes.appPadding(context),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.width * 0.03,
                      ),
                    ),
                    SizedBox(
                      height: context.width * 0.03,
                    ),
                    SizedBox(
                      width: context.width * 0.5,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _emailController,
                            label: AppStrings.email,
                            hintText: AppStrings.enterValue(
                                AppStrings.email.toLowerCase()),
                            asteriskRequired: true,
                            validator: (value) =>
                                ValidatorUtils.emailValidator(value),
                          ),
                          SizedBox(
                            height: context.width * 0.01,
                          ),
                          PasswordTextField(
                            controller: _passwordController,
                          ),
                          SizedBox(
                            height: context.width * 0.03,
                          ),
                          context.watch<LoginBloc>().state.isLoading
                              ? CircularProgressIndicator()
                              : NormalButton(
                                  label: "Login",
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                            LoginButtonPressed(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              context: context,
                                            ),
                                          );
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
