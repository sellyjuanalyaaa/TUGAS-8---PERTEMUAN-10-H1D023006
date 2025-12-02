import 'package:flutter/material.dart';
import 'package:tokokita/bloc/login_bloc.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';
import 'package:tokokita/helpers/app_theme.dart';
class LoginPage extends StatefulWidget {
const LoginPage({Key? key}) : super(key: key);
@override
_LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

final _formKey = GlobalKey<FormState>();
bool _isLoading = false;
final _emailTextboxController = TextEditingController();
final _passwordTextboxController = TextEditingController();
@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
	title: const Text('Login Alyaaa'),
	backgroundColor: AppTheme.primaryColor,
	),
body: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(8.0),
				child: Form(
						key: _formKey,
						child: Center(
							child: Card(
								color: AppTheme.cardBackground,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
								elevation: 2,
								child: Padding(
									padding: const EdgeInsets.all(16.0),
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											Text('Masuk', style: Theme.of(context).textTheme.titleLarge),
											const SizedBox(height: 12),
											_emailTextField(),
											const SizedBox(height: 12),
											_passwordTextField(),
											const SizedBox(height: 20),
											_buttonLogin(),
											const SizedBox(height: 12),
											_menuRegistrasi()
										],
									),
								),
							),
						),
					),
),
),
);
}
//Membuat Textbox email
Widget _emailTextField() {
	return TextFormField(
	decoration: AppTheme.inputDecoration(label: "Email", prefixIcon: Icons.email),
keyboardType: TextInputType.emailAddress,
controller: _emailTextboxController,
validator: (value) {
//validasi harus diisi
if (value!.isEmpty) {
return 'Email harus diisi';

}
return null;
},
);
}
//Membuat Textbox password
Widget _passwordTextField() {
	return TextFormField(
	decoration: AppTheme.inputDecoration(label: "Password", prefixIcon: Icons.lock),
keyboardType: TextInputType.text,
obscureText: true,
controller: _passwordTextboxController,
validator: (value) {
//jika karakter yang dimasukkan kurang dari 6 karakter
if (value!.isEmpty) {
return "Password harus diisi";
}
return null;
},
);
}
//Membuat Tombol Login
Widget _buttonLogin() {
	return SizedBox(
		width: double.infinity,
		child: ElevatedButton(
			style: AppTheme.elevatedButtonStyle(),
			onPressed: _isLoading
					? null
					: () {
							var validate = _formKey.currentState!.validate();
							if (validate) {
								if (!_isLoading) _submit();
							}
						},
			child: _isLoading
					? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
					: const Text("Login", style: TextStyle(color: Colors.black)),
		),
	);
}
void _submit() {
_formKey.currentState!.save();
setState(() {
_isLoading = true;
});
LoginBloc.login(

email: _emailTextboxController.text,
password: _passwordTextboxController.text)
.then((value) async {
if (value.code == 200) {
await UserInfo().setToken(value.token.toString());
await UserInfo().setUserID(int.parse(value.userID.toString()));
Navigator.pushReplacement(context,
MaterialPageRoute(builder: (context) => const ProdukPage()));
} else {
showDialog(
context: context,
barrierDismissible: false,
builder: (BuildContext context) => const WarningDialog(
description: "Login gagal, silahkan coba lagi",
));

}
}, onError: (error) {
print(error);
showDialog(
context: context,
barrierDismissible: false,
builder: (BuildContext context) => const WarningDialog(
description: "Login gagal, silahkan coba lagi",
));

});
setState(() {
_isLoading = false;
});
}
// Membuat menu untuk membuka halaman registrasi
Widget _menuRegistrasi() {
	return SizedBox(
		width: double.infinity,
		child: OutlinedButton(
			style: OutlinedButton.styleFrom(
				backgroundColor: Colors.white.withOpacity(0.5),
				side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.5)),
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
				padding: const EdgeInsets.symmetric(vertical: 12),
			),
			onPressed: () {
				Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrasiPage()));
			},
			child: const Text(
				'Registrasi',
				style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
			),
		),
	);
}
}