  import 'package:flutter/material.dart';
  import 'package:compsec/dbhelper.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  // import 'package:nomem/passwordGen.dart';
  import 'package:flutter/services.dart';
  import 'package:compsec/backup.dart';
  // import 'package:compsec/backup.dart';
  class Store extends StatefulWidget {

  @override
  State<Store> createState() => _StoreState();
  }

  class _StoreState extends State<Store> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? selectedOption;

  @override
  void dispose() {
  usernameController.dispose();
  passwordController.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color.fromRGBO(255, 251, 250, 1),
  appBar: AppBar(
  title: const Text(
  "Store new Password",
  // style: TextStyle(textAlign: TextAlign.center),
  style: TextStyle(color: Colors.white),
  ),
  centerTitle: true,
  backgroundColor: const Color.fromRGBO(59, 85, 171, 1.0),
  foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
  // shadowColor: const Color.fromRGBO(255, 255, 255, 1),

  ),
  body:SingleChildScrollView(
  child: Form(
  key: _formKey,
  child: Padding(
  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Padding(
  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
  child: Autocomplete<String>(
  optionsBuilder: (TextEditingValue textEditingValue) {
  return [
  "Google",
  "Facebook",
  "Twitter",
  "SBI",
  "Instagram",
  "LinkedIn",
  "Eduserver",
  "HDFC",
  "ICICI",
  "Aternos",
  ].where((option) => option.toLowerCase().startsWith(textEditingValue.text.toLowerCase())).toList();
  },
  onSelected: (String selectedOption) {
  setState(() {
  // Update the selected option when the user selects an option
  this.selectedOption = selectedOption;
  });
  },
  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
  return TextFormField(
  controller: textEditingController,
  focusNode: focusNode,
  onChanged: (String value){
  setState(() {
  // Update the selected option as the user types
  selectedOption = value;
  });
  },
  decoration: InputDecoration(
  labelText: 'Domain',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: "Google",
  hintStyle: TextStyle(color: Colors.grey[350]),
  border: OutlineInputBorder(
  borderSide: const BorderSide(
  color: Colors.black,
  ),
  borderRadius: BorderRadius.circular(15),
  ),
  ),
  validator: (String? value) {
  if (value == null || value.isEmpty) {
  return 'Domain is a required field';
  }
  return null;
  },
  onFieldSubmitted: (_) => onFieldSubmitted(),
  );
  },
    optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
      // Build the dropdown options from the generated list of autocomplete options
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: SizedBox(
            height: 200.0,
            width: 293.0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index);
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    onSelected(option);
                  },
                );
              },
            ),
          ),
        ),
      );
    },
  ),
  ),
  const Text(
  "e.g. 'Facebook', 'Twitter' ,etc. No need to enter complete URL.",
  style: TextStyle(
  fontSize: 11,
  color: Color(0xFF938F99),
  ),
  textAlign: TextAlign.justify,
  ),
  const SizedBox(height: 16),
  //Username
  Padding(
  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
  child: TextFormField(
      decoration: InputDecoration(
        labelText: "Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: "example@abc.com",
        hintStyle: TextStyle(color: Colors.grey[350]),
        errorMaxLines: 2,
      ),
      validator: (value) {
        if (value == '') {
          return 'Username is a required field';
        }
        return null;
      },
      controller: usernameController)),
  const Text(
  "The unique login ID for your account.",
  style: TextStyle(
  fontSize: 11,
  color: Color(0xFF938F99),
  ),
  textAlign: TextAlign.justify,
  ),
  const SizedBox(height: 16),
  //password
  Padding(
  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
  child: TextFormField(
      obscureText: _obscureText,//This argument gives us the power to hide the data entered in the input field. The default of this is false, which makes it visible to us. If we make this true, the actual text will be invisible.
      // obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,//the label text effect,whether it will appear or disappear
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: "eg. ab765418",
        hintStyle: TextStyle(color: Colors.grey[350]),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == '') {
          return 'Password is a required field';
        }
        return null;
      },
      controller: passwordController)),
  const Text(
  ' Preferably contains at least 8 characters.',
  style: TextStyle(
  fontSize: 12,
  color: Color(0xFF938F99),
  ),
  textAlign: TextAlign.center,
  ),
  const SizedBox(height: 24),


  SizedBox(
  width: 180,

  // submit button
  child: ElevatedButton(
  onPressed: () {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!(_formKey.currentState!.validate())) {
      return;
    }

    if (selectedOption == null) {return;}
    final domain = selectedOption!.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    //check if account is created
    if (DBHelper().createAccount(domain, username,
        password)) {
      passwordController.clear();
      usernameController.clear();
    } else {
      Fluttertoast.showToast(
          msg: 'This account already exists',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: const Color.fromRGBO(255, 255, 245, 1),
            ),
          ),
          child: AlertDialog(
            title: const Text(
              'The account details have been stored.',
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  //close button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //export
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: ThemeData(
                              dialogTheme: DialogTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: const Color.fromRGBO(255, 255, 245, 1),
                              ),
                            ),
                            child: AlertDialog(
                              title: const Text('Export recommended'),
                              content: const Text(
                                'A new account have been added. Would you like to export the accounts onto your system?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    var msg = '';
                                    Navigator.of(context).pop();
                                    if (await Export().export()) {
                                      msg = 'Data file exported to Download folder successfully';
                                    } else {
                                      msg = "Data wasn't exported as Download folder couldn't be opened";
                                    }
                                    Fluttertoast.
                                    showToast(
                                      msg: msg,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
  style: ElevatedButton.styleFrom(
    primary: const Color.fromRGBO(232, 222, 248, 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
    ),
  ),
  child: const Text(
    'Store Password',
    style: TextStyle(
      color: Color(0xFF4A4458),
    ),
  ),
  ),
  ),
  ],
  ),
  )
  ),
  ),
  );
  }
  }
