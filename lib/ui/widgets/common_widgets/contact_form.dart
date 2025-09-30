import 'package:flutter/material.dart';

import 'package:umair_liaqat/repositories/user_repository.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/custom_textfield.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    UserRepository userRepository = UserRepository();
    await userRepository.contactForm(
      email: emailController.text,
      name: nameController.text,
      message: subjectController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Fill it out:", style: textTheme.titleMedium),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Your Name',
            controller: nameController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your name'
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Email',
            controller: emailController,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter email' : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Subject & Description',
            controller: subjectController,
            inputAction: TextInputAction.newline,
            maxLines: 5,
            textInputType: TextInputType.multiline,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter subject' : null,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: OutlinedButton(
              onPressed: () async => _submitForm(),
              style: OutlinedButton.styleFrom(
                backgroundColor: PortfolioAppTheme.nameColor,
                side: const BorderSide(color: PortfolioAppTheme.nameColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(
                'Submit',
                style: textTheme.titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
