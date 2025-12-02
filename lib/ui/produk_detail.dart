import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';
import 'package:tokokita/helpers/app_theme.dart';
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
				title: const Text('Detail Produk Alyaaa'),
				backgroundColor: AppTheme.primaryColor,
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
								ElevatedButton(
									style: AppTheme.elevatedButtonStyle(),
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
									style: AppTheme.elevatedButtonStyle(bg: Colors.red),
									child: const Text("DELETE"),
									onPressed: () => confirmHapus(),
								),
			],
		);
	}

	Future<void> confirmHapus() async {
		final confirmed = await showDialog<bool>(
			context: context,
			builder: (context) => AlertDialog(
				content: const Text("Yakin ingin menghapus data ini?"),
				actions: [
										// tombol hapus (jelas/berwarna)
										ElevatedButton(
											style: ElevatedButton.styleFrom(
												backgroundColor: Colors.red,
												foregroundColor: Colors.white,
												elevation: 0,
											),
											child: const Text("Ya"),
											onPressed: () async {
												Navigator.of(context).pop(true);
											},
										),
										const SizedBox(width: 8),
																				// tombol batal (lebih terlihat): white filled with colored border
																				ElevatedButton(
																					style: ElevatedButton.styleFrom(
																						backgroundColor: Colors.white,
																						foregroundColor: Colors.black,
																						elevation: 0,
																						side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.9)),
																					),
																					child: const Text("Batal"),
																					onPressed: () => Navigator.pop(context, false),
																				)
				],
			),
		);

		if (confirmed != true) return;

		try {
			final deleted = await ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!));
			if (deleted) {
				if (!mounted) return;
				await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProdukPage()));
			} else {
				if (!mounted) return;
				await showDialog(
					context: context,
					builder: (BuildContext context) => const WarningDialog(
						description: "Hapus gagal, silahkan coba lagi",
					),
				);
			}
		} catch (error) {
			if (!mounted) return;
			await showDialog(
				context: context,
				builder: (BuildContext context) => const WarningDialog(
					description: "Hapus gagal, silahkan coba lagi",
				),
			);
		}
	}
}