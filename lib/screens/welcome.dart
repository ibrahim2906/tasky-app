import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/core/services/preference_manager.dart';
import 'package:tasks/core/widgets/custom_text_form_field.dart';
import 'package:tasks/screens/main_screen.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 8),
                    Image(image: AssetImage('assets/images/hand.png')),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 40),
                Image.asset("assets/images/person.png"),
                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomTextFormField(
                    title: "Full Name",
                    controller: controller,
                    maxLines: 1,
                    hint: "e.g. Ibrahim Mohamed",
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? false) {
                        return "Enter Your Name";
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                //===============elevated button-----------------
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await PreferenceManager().setString(
                        'username',
                        controller.text.trim(),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const MainScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Enter Your Name"),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          showCloseIcon: true,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.backgroundColor?.resolve({}),
                    foregroundColor: Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                    fixedSize: Size(MediaQuery.of(context).size.width * .9, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
