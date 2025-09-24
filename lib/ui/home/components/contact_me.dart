import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/ui/login_screen/login_screen.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/contact_form.dart';
import 'package:universal_html/html.dart' as html;

class ContactMe extends StatefulWidget {
  final UserModel? userModel;
  const ContactMe({
    super.key,
    this.userModel,
  });

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile =
            constraints.maxWidth < 600; // Adjust layout based on screen width

        return Padding(
          padding: AppSizes.appPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Connect!",
                style: textTheme.displaySmall!.copyWith(
                  color: PortfolioAppTheme.nameColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.height * 0.05),
              Container(
                width: context.width * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff36454F),
                ),
                child: isMobile
                    ? _buildColumnLayout(textTheme) // Mobile view
                    : _buildRowLayout(textTheme), // Desktop view
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRowLayout(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: _buildInfoSection(textTheme)),
        const Expanded(child: ContactForm()),
      ],
    );
  }

  Widget _buildColumnLayout(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildInfoSection(textTheme),
        const SizedBox(height: 20),
        const Divider(color: Colors.white),
        const SizedBox(height: 20),
        const ContactForm(),
      ],
    );
  }

  Widget _buildInfoSection(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Let's make something awesome together!",
          style: textTheme.titleMedium!.copyWith(
            color: PortfolioAppTheme.nameColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "I'm just a click away.",
          style: textTheme.titleSmall?.copyWith(color: PortfolioAppTheme.white),
        ),
        const SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
              onPressed: () => gotoUrl(
                  widget.userModel?.phoneNumber ?? AppConstants.whatsapp),
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.linkedin,
                  color: PortfolioAppTheme.blue),
              onPressed: () =>
                  gotoUrl(widget.userModel?.linkedIn ?? AppConstants.linkedIn),
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.github, color: Colors.black),
              onPressed: () =>
                  gotoUrl(widget.userModel?.github ?? AppConstants.github),
            ),
            ElevatedButton.icon(
              label: Text(
                "Download CV",
                style: textTheme.titleMedium,
              ),
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.download, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              onPressed: () {
                html.window.open(AppConstants.cv, "pdf");
              },
            ),
            ElevatedButton.icon(
              label: Text(
                Strings.login,
                style: textTheme.titleMedium,
              ),
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.rightToBracket,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildFormSection(TextTheme textTheme) {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         Text("Fill it out:", style: textTheme.titleMedium),
  //         SizedBox(height: 10),
  //         CustomTextField(
  //           hintText: 'Your Name',
  //           controller: nameController,
  //           validator: (value) => value == null || value.isEmpty
  //               ? 'Please enter your name'
  //               : null,
  //         ),
  //         SizedBox(height: 10),
  //         CustomTextField(
  //           hintText: 'Email',
  //           controller: emailController,
  //           validator: (value) =>
  //               value == null || value.isEmpty ? 'Please enter email' : null,
  //         ),
  //         SizedBox(height: 10),
  //         CustomTextField(
  //           hintText: 'Subject & Description',
  //           controller: subjectController,
  //           maxLines: 4,
  //           validator: (value) =>
  //               value == null || value.isEmpty ? 'Please enter subject' : null,
  //         ),
  //         SizedBox(height: 10),
  //         SizedBox(
  //           width: 200,
  //           child: OutlinedButton(
  //             onPressed: () {},
  //             style: OutlinedButton.styleFrom(
  //               backgroundColor: PortfolioAppTheme.nameColor,
  //               side: const BorderSide(color: PortfolioAppTheme.nameColor),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(4)),
  //             ),
  //             child: Text(
  //               'Submit',
  //               style: textTheme.titleSmall!
  //                   .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void gotoUrl(String platform) {
    html.window.open(platform, '_blank');
  }
}
