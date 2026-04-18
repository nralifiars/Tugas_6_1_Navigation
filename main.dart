import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APB - NurAlifiaRustan',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HalamanDaftar(judul: 'APB'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key, required this.judul});
  final String judul;

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  List<Map<String, dynamic>> daftarTeknologi = [
    {
      'judul': 'Native App',
      'platform': 'Android, iOS',
      'bahasa': 'Java, Kotlin, Swift, C#',
      'warna': Colors.deepPurple,
    },
    {
      'judul': 'Hybrid App',
      'platform': 'Android, iOS, Web',
      'bahasa': 'Javascript, Dart',
      'warna': Colors.teal,
    },
  ];

  final inputJudul = TextEditingController();
  final inputPlatform = TextEditingController();
  final inputBahasa = TextEditingController();

  final List<String> pilihanWarna = ['Biru', 'Hijau', 'Oranye'];
  List<DropdownMenuItem<String>> opsiDropdown = [];
  String? warnaYangDipilih;

  @override
  void initState() {
    super.initState();
    for (String w in pilihanWarna) {
      opsiDropdown.add(DropdownMenuItem(value: w, child: Text(w)));
    }
  }

  Color _resolveColor(String? nama) {
    switch (nama) {
      case 'Biru':
        return Colors.blue;
      case 'Hijau':
        return Colors.green;
      case 'Oranye':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _tampilkanDetailItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Teknologi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              daftarTeknologi[index]['judul'],
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text('Platform: ${daftarTeknologi[index]['platform']}',
                style: const TextStyle(fontSize: 16)),
            Text('Bahasa: ${daftarTeknologi[index]['bahasa']}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _tampilkanFormTambah() {
    final formKey = GlobalKey<FormState>();
    inputJudul.clear();
    inputPlatform.clear();
    inputBahasa.clear();
    warnaYangDipilih = null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Teknologi'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: inputJudul,
                  decoration: const InputDecoration(labelText: 'Nama Teknologi'),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: inputPlatform,
                  decoration: const InputDecoration(labelText: 'Platform'),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Tidak boleh kosong' : null,
                ),
                TextFormField(
                  controller: inputBahasa,
                  decoration: const InputDecoration(labelText: 'Bahasa Pemrograman'),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Tidak boleh kosong' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  items: opsiDropdown,
                  hint: const Text('Pilih Warna'),
                  onChanged: (val) {
                    warnaYangDipilih = val;
                  },
                  validator: (val) =>
                      val == null ? 'Pilih warna terlebih dahulu' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  daftarTeknologi.add({
                    'judul': inputJudul.text,
                    'platform': inputPlatform.text,
                    'bahasa': inputBahasa.text,
                    'warna': _resolveColor(warnaYangDipilih),
                  });
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.judul),
        backgroundColor: const Color(0xFF4839EB),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: daftarTeknologi.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: InkWell(
              onTap: () => _tampilkanDetailItem(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: daftarTeknologi[index]['warna'],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            daftarTeknologi[index]['judul'],
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            daftarTeknologi[index]['platform'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            daftarTeknologi[index]['bahasa'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tampilkanFormTambah,
        backgroundColor: const Color(0xFF4839EB),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}