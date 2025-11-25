import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

const Color primaryColor = Color(0xFFABE0F0);

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
	Produk? produk;
	ProdukDetail({Key? key, this.produk}) : super(key: key);

	@override
	State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Detail Produk alyaaa'),
				backgroundColor: primaryColor,
			),
			body: Center(
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						Text(
							"Kode : ${widget.produk!.kodeProduk}",
							style: const TextStyle(fontSize: 20.0),
						),
						const SizedBox(height: 8),
						Text(
							"Nama : ${widget.produk!.namaProduk}",
							style: const TextStyle(fontSize: 18.0),
						),
						const SizedBox(height: 8),
						Text(
							"Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
							style: const TextStyle(fontSize: 18.0),
						),
						const SizedBox(height: 16),
						_tombolHapusEdit(),
					],
				),
			),
		);
	}

	Widget _tombolHapusEdit() {
		return Row(
			mainAxisSize: MainAxisSize.min,
			children: [
				// Tombol Edit
				OutlinedButton(
					style: OutlinedButton.styleFrom(
						foregroundColor: primaryColor,
						side: const BorderSide(color: primaryColor),
					),
					child: const Text("EDIT"),
					onPressed: () {
						Navigator.push(
							context,
							MaterialPageRoute(
								builder: (context) => ProdukForm(
									produk: widget.produk!,
								),
							),
						);
					},
				),
				const SizedBox(width: 8),
				// Tombol Hapus
				ElevatedButton(
					style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
					child: const Text("DELETE"),
					onPressed: () => confirmHapus(),
				),
			],
		);
	}

	void confirmHapus() {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				content: const Text("Yakin ingin menghapus data ini?"),
				actions: [
					TextButton(
						child: const Text('Ya'),
						onPressed: () {
							// TODO: panggil API hapus di sini
							Navigator.pop(context); // tutup dialog
							Navigator.pop(context); // kembali ke daftar produk
							ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produk dihapus')));
						},
					),
					TextButton(
						child: const Text('Batal'),
						onPressed: () => Navigator.pop(context),
					),
				],
			),
		);
	}
}