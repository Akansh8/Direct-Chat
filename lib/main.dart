import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:directchat/mystyles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "Direct Chat",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _code;
  TextEditingController _numberController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _code = "91";
  }

  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("Can't Open Whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade700,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Text(
                "Select Region :",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: CountryCodePicker(
                    searchStyle: TextStyle(color: Colors.grey.shade100),
                    dialogBackgroundColor: Colors.blueGrey.shade700,
                    dialogTextStyle: TextStyle(
                      color: Colors.grey.shade100,
                    ),
                    initialSelection: 'IN',
                    showCountryOnly: false,
                    favorite: ['+91', 'IN'],
                    enabled: true,
                    onChanged: (CountryCode countryCode) {
                      setState(() {
                        _code = countryCode.dialCode.toString();
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.grey.shade100),
                  autofocus: true,
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    labelText: "Enter 10 digit phone number",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(color: Colors.black54),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  controller: _numberController,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //message feild
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
                child: Center(
                  child: TextField(
                    style: TextStyle(color: Colors.grey.shade100),
                    cursorColor: Colors.black54,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 100,
                    decoration: InputDecoration(
                      labelText: "Enter a Message",
                      focusColor: Colors.black54,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.black54),
                      ),
                    ),
                    controller: _messageController,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black54),
                    onPressed: () {
                      launchWhatsapp(
                          number: "+$_code${_numberController.text.toString()}",
                          message: _messageController.text);
                    },
                    child: myText(text: "Send Message"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
