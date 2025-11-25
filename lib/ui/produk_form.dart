import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';

const Color primaryColor = Color(0xFFABE0F0);

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({super.key, this.produk});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
	final _formKey = GlobalKey<FormState>();
	bool _isLoading = false;
	String judul = "Tambah Produk alyaaa";
	String tombolSubmit = "Simpan";
	final _kodeProdukTextboxController = TextEditingController();
	final _namaProdukTextboxController = TextEditingController();
	final _hargaProdukTextboxController = TextEditingController();

	@override
	void initState() {
		super.initState();
		isUpdate();
	}

	void isUpdate() {
		if (widget.produk != null) {
			setState(() {
				judul = "Ubah Produk alyaaa";
				tombolSubmit = "Ubah";
				_kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
				_namaProdukTextboxController.text = widget.produk!.namaProduk!;
				_hargaProdukTextboxController.text = widget.produk!.hargaProduk.toString();
			});
		} else {
			judul = "Tambah Produk alyaaa";
			tombolSubmit = "Simpan";
		}
	}

	@override
	void dispose() {
		_kodeProdukTextboxController.dispose();
		_namaProdukTextboxController.dispose();
		_hargaProdukTextboxController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(judul), backgroundColor: primaryColor),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.all(8.0),
					child: Form(
						key: _formKey,
						child: Column(
							children: [
								_kodeProdukTextField(),
								_namaProdukTextField(),
								_hargaProdukTextField(),
								_buttonSubmit()
							],
						),
					),
				),
			),
		);
	}

	// Membuat Textbox Kode Produk
	Widget _kodeProdukTextField() {
		return TextFormField(
			decoration: const InputDecoration(labelText: "Kode Produk"),
			keyboardType: TextInputType.text,
			controller: _kodeProdukTextboxController,
			validator: (value) {
				if (value == null || value.isEmpty) {
					return "Kode Produk harus diisi";
				}
				return null;
			},
		);
	}

	// Membuat Textbox Nama Produk
	Widget _namaProdukTextField() {
		return TextFormField(
			decoration: const InputDecoration(labelText: "Nama Produk"),
			keyboardType: TextInputType.text,
			controller: _namaProdukTextboxController,
			validator: (value) {
				if (value == null || value.isEmpty) {
					return "Nama Produk harus diisi";
				}
				return null;
			},
		);
	}

	// Membuat Textbox Harga Produk
	Widget _hargaProdukTextField() {
		return TextFormField(
			decoration: const InputDecoration(labelText: "Harga"),
			keyboardType: TextInputType.number,
			controller: _hargaProdukTextboxController,
			validator: (value) {
				if (value == null || value.isEmpty) {
					return "Harga harus diisi";
				}
				return null;
			},
		);
	}

	// Membuat Tombol Simpan/Ubah
	Widget _buttonSubmit() {
		return SizedBox(
			width: double.infinity,
			height: 48,
			child: ElevatedButton(
				style: ElevatedButton.styleFrom(
					backgroundColor: primaryColor,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
				),
				onPressed: () async {
					if (_isLoading) return;
					final validate = _formKey.currentState?.validate() ?? false;
					if (!validate) return;
					setState(() {
						_isLoading = true;
					});

					// simulate submit / network call
					await Future.delayed(const Duration(milliseconds: 500));

					setState(() {
						_isLoading = false;
					});

					// TODO: submit data
				},
				child: _isLoading
						? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
						: Text(tombolSubmit),
			),
		);
	}

}