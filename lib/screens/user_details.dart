import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/services/preference_manager.dart';
import 'package:tasks/core/widgets/custom_text_form_field.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.userName, required this.quote});

  @override
  State<UserDetails> createState() => _UserDetailsState();
  final String userName;

  final String? quote;
}

class _UserDetailsState extends State<UserDetails> {
  late final TextEditingController nameController;

  late final TextEditingController quoteController;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
    quoteController = TextEditingController(text: widget.quote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        iconTheme: Theme.of(context).iconTheme,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                title: "Name",
                controller: nameController,
                maxLines: 1,
                hint: "Name",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                title: "quote",
                controller: quoteController,
                maxLines: 3,
                hint: "quote",
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    final pref = await SharedPreferences.getInstance();
                    await PreferenceManager().setString(
                      'username',
                      nameController.text.trim(),
                    );
                    await PreferenceManager().setString(
                      'quotename',
                      quoteController.text.trim(),
                    );

                    Navigator.pop(context, true);
                  }
                },
                child: Text("Save", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
