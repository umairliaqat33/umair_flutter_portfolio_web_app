import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/ui/widgets/common_widgtes/custom_textfield.dart';

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

    final formData = {
      'name': nameController.text,
      'email': emailController.text,
      'subject': subjectController.text,
      'timestamp': Timestamp.now().toString(),
    };

    try {
      // Save to Firebase Firestore
      // await FirebaseFirestore.instance.collection('contact_form').add(formData);

      // Send email notification
      await sendEmail(
        formData,
      ); // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your response has been recorded!"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form fields
      nameController.clear();
      emailController.clear();
      subjectController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error submitting form: $e"),
          backgroundColor: Colors.red,
        ),
      );
      log(e.toString());
    }
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
            maxLines: 4,
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

Future<void> sendEmail(var data) async {
  final url = Uri.parse('https://formspree.io/f/xrgwqbnz');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    log("Email sent successfully!");
  } else {
    log("Failed to send email: ${response.body}");
  }
}
