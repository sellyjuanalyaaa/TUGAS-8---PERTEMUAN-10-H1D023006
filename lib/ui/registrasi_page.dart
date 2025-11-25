import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  static const Color _primaryColor = Color(0xFFABE0F0);
	final _formKey = GlobalKey<FormState>();
	bool _isLoading = false;
	final _namaTextboxController = TextEditingController();
	final _emailTextboxController = TextEditingController();
	final _passwordTextboxController = TextEditingController();

	@override
	void dispose() {
		_namaTextboxController.dispose();
		_emailTextboxController.dispose();
		_passwordTextboxController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[50],
			appBar: AppBar(
				title: const Text("Registrasi alyaaa"),
				centerTitle: true,
				elevation: 1,
				backgroundColor: _primaryColor,
			),
			body: Center(
				child: SingleChildScrollView(
					padding: const EdgeInsets.all(16.0),
					child: ConstrainedBox(
						constraints: const BoxConstraints(maxWidth: 600),
						child: Card(
							elevation: 4,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
							child: Padding(
								padding: const EdgeInsets.all(20.0),
								child: Form(
									key: _formKey,
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											Text(
												"Buat Akun",
												style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
												),
											sizedBoxHeight(8),
											_namaTextField(),
											sizedBoxHeight(12),
											_emailTextField(),
											sizedBoxHeight(12),
											_passwordTextField(),
											sizedBoxHeight(12),
											_passwordKonfirmasiTextField(),
											sizedBoxHeight(18),
											_buttonRegistrasi(),
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

	// Membuat Textbox Nama
	Widget _namaTextField() {
		return TextFormField(
			controller: _namaTextboxController,
			keyboardType: TextInputType.name,
			decoration: const InputDecoration(
				labelText: "Nama",
				prefixIcon: Icon(Icons.person),
				border: OutlineInputBorder(),
			),
			validator: (value) {
				if (value == null || value.trim().length < 3) {
					return "Nama harus diisi minimal 3 karakter";
				}
				return null;
			},
		);
	}

	// Membuat Textbox email
	Widget _emailTextField() {
		return TextFormField(
			controller: _emailTextboxController,
			keyboardType: TextInputType.emailAddress,
			decoration: const InputDecoration(
				labelText: "Email",
				prefixIcon: Icon(Icons.email),
				border: OutlineInputBorder(),
			),
			validator: (value) {
				if (value == null || value.isEmpty) return 'Email harus diisi';
				final pattern = r'^[\w\-.]+@([\w\-]+\.)+[A-Za-z]{2,}$';
				final regex = RegExp(pattern, caseSensitive: false);
				if (!regex.hasMatch(value)) return "Email tidak valid";
				return null;
			},
		);
	}

	// Membuat Textbox password
	Widget _passwordTextField() {
		return TextFormField(
			controller: _passwordTextboxController,
			obscureText: true,
			decoration: const InputDecoration(
				labelText: "Password",
				prefixIcon: Icon(Icons.lock),
				border: OutlineInputBorder(),
			),
			validator: (value) {
				if (value == null || value.length < 6) {
					return "Password harus diisi minimal 6 karakter";
				}
				return null;
			},
		);
	}

	// membuat textbox Konfirmasi Password
	Widget _passwordKonfirmasiTextField() {
		return TextFormField(
			obscureText: true,
			decoration: const InputDecoration(
				labelText: "Konfirmasi Password",
				prefixIcon: Icon(Icons.lock_outline),
				border: OutlineInputBorder(),
			),
			validator: (value) {
				if (value != _passwordTextboxController.text) {
					return "Konfirmasi Password tidak sama";
				}
				return null;
			},
		);
	}

	// Membuat Tombol Registrasi
	Widget _buttonRegistrasi() {
		return SizedBox(
			width: double.infinity,
			height: 48,
					child: ElevatedButton(
						style: ElevatedButton.styleFrom(
							backgroundColor: _primaryColor,
							foregroundColor: Colors.black,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
						),
						child: _isLoading
							? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
							: const Text("Registrasi"),
						onPressed: () async {
					if (_isLoading) return;
					setState(() {
						_isLoading = true;
					});

					final validate = _formKey.currentState?.validate() ?? false;

					// simulate async operation; replace with real registration call
					await Future.delayed(const Duration(milliseconds: 500));

					setState(() {
						_isLoading = false;
					});

					if (validate) {
						// TODO: add registration logic
					}
				},
			),
		);
	}

	// small helper to create vertical spacing widget consistently
	Widget sizedBoxHeight(double h) => SizedBox(height: h);
}
