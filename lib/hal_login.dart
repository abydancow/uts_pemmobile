import 'package:flutter/material.dart';
import 'package:uts_pemmobile/home.dart';
import 'package:uts_pemmobile/hal_register.dart';

class HalLogin extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _HalLoginState createState() => new _HalLoginState();
}

class _HalLoginState extends State<HalLogin> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('lib/images/udb.png'),
      ),
    );

    final nimField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'NIM', 
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Color.fromARGB(255, 71, 169, 138),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
          color: const Color.fromARGB(255, 64, 255, 112),
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final daftarAkun = TextButton(
      child: Text(
        'Belum memiliki akun? daftar',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HalRegister()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            nimField, // Menggunakan nimField yang telah diubah
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            daftarAkun
          ],
        ),
      ),
    );
  }
}
