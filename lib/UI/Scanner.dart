import 'dart:io'; // Untuk menangani file gambar
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar dari galeri atau kamera
import 'package:tastygo/Constant/Colors.dart';
import 'package:tastygo/Route.dart';
import 'package:tflite_v2/tflite_v2.dart'; // TensorFlow Lite

class Scanner extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Scanner({Key? key, required this.cameras}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with SingleTickerProviderStateMixin {
  File? _selectedImage; // File untuk gambar yang dipilih dari galeri atau kamera
  CameraController? cameraController; // Untuk real-time scanner
  var _recognitions = [];
  String result = '';
  bool isDetecting = false;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    loadModel();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabChange); // Tambahkan listener saat ganti tab
    initializeCamera(); // Inisialisasi kamera untuk real-time scanner
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/tensorflow/model_unquant.tflite", // Path model TFLite
        labels: "assets/tensorflow/labels.txt", // Path label TFLite
      );
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  // Inisialisasi kamera untuk real-time scanner
  void initializeCamera() {
    cameraController = CameraController(
      widget.cameras[0], // Gunakan kamera belakang
      ResolutionPreset.medium,
    );
    cameraController!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});

      cameraController!.startImageStream((CameraImage img) {
        if (!isDetecting && _tabController!.index == 0) { // Hanya deteksi di tab real-time scanner
          isDetecting = true;
          detectImageFromStream(img);
        }
      });
    });
  }

  // Deteksi gambar dari stream kamera (real-time)
  Future<void> detectImageFromStream(CameraImage image) async {
    try {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _recognitions = recognitions ?? [];
        result = recognitions?.isNotEmpty == true ? recognitions.toString() : "No object detected";
      });
    } catch (e) {
      print("Error detecting image from stream: $e");
    } finally {
      isDetecting = false;
    }
  }

  // Deteksi gambar dari file yang dipilih dari galeri atau kamera
  Future<void> detectImageFromFile(File imageFile) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: imageFile.path, // Path gambar
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _recognitions = recognitions ?? [];
        result = recognitions?.isNotEmpty == true ? recognitions.toString() : "No object detected";
      });

      if (recognitions != null && recognitions.isNotEmpty) {
        for (var recog in recognitions) {
          double confidence = recog["confidence"] ?? 0.0;
          String label = recog["label"] ?? 'Unknown';
          if (confidence > 0.6) {
            await _showMessageDialog(label, confidence); // Menampilkan dialog dengan hasil deteksi
            break;
          }
        }
      }
    } catch (e) {
      print("Error detecting image from file: $e");
    }
  }

  Future<void> _showMessageDialog(String label, double confidence) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deteksi Item"),
          content: Text("Label: $label\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                toDetail(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path); // Simpan gambar yang dipilih
      setState(() {
        result = "Gambar dari galeri dipilih.";
      });
      await detectImageFromFile(_selectedImage!); // Proses gambar yang dipilih
    }
  }

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path); // Simpan gambar yang diambil dari kamera
      setState(() {
        result = "Gambar dari kamera dipilih.";
      });
      await detectImageFromFile(_selectedImage!); // Proses gambar yang diambil
    }
  }

  void _handleTabChange() {
    if (_tabController!.index == 1) {
      // Jika pindah ke tab "Take Foto", hentikan stream kamera sementara
      cameraController?.stopImageStream();
    } else {
      // Jika kembali ke tab "Real-time Scanner", mulai kembali stream kamera
      if (cameraController != null && cameraController!.value.isInitialized) {
        cameraController!.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
            detectImageFromStream(img);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _tabController?.removeListener(_handleTabChange);
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColors(),
        iconTheme: const IconThemeData(
          color: Colors.white, // Mengubah warna tombol back menjadi putih
        ),
        title: const Text('TastyGo Scanner', style: TextStyle(color: Colors.white)),
        actions: [
          // Ikon untuk mengambil gambar dari galeri
          IconButton(
            icon: const Icon(Icons.photo_library, color: Colors.white),
            onPressed: pickImageFromGallery, // Pilih gambar dari galeri
          ),
          // Ikon untuk mengambil gambar dari kamera
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: pickImageFromCamera, // Ambil gambar dari kamera
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Gaya teks saat dipilih
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold), // Gaya teks saat tidak dipilih
          labelColor: Colors.blue, // Warna teks saat dipilih
          unselectedLabelColor: Colors.white, // Warna teks saat tidak dipilih
          tabs: const [
            Tab(text: "Real-time Scanner"),
            Tab(text: "Take Foto"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          // Tab 1: Real-time Scanner
          _buildRealTimeScanner(),

          // Tab 2: Take Foto
          Stack(
            children: <Widget>[
              _selectedImage == null
                  ? const Center(child: Text('Silakan pilih gambar.')) // Jika belum ada gambar yang dipilih
                  : Image.file(_selectedImage!, fit: BoxFit.cover, width: size.width, height: size.height), // Tampilkan gambar yang dipilih
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _recognitions.map((recog) {
                      String className = recog["label"] ?? 'Unknown';
                      double confidence = recog["confidence"] ?? 0.0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                className.substring(2), // Tampilkan label objek
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: LinearProgressIndicator(
                                value: confidence, // Tampilkan nilai confidence
                                backgroundColor: Colors.grey,
                                color: Colors.blue,
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${(confidence * 100).toStringAsFixed(0)}%", // Tampilkan confidence dalam persentase
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk Tab Real-time Scanner
  Widget _buildRealTimeScanner() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: <Widget>[
        CameraPreview(cameraController!),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _recognitions.map((recog) {
                String className = recog["label"] ?? 'Unknown';
                double confidence = recog["confidence"] ?? 0.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          className.substring(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: LinearProgressIndicator(
                          value: confidence,
                          backgroundColor: Colors.grey,
                          color: Colors.blue,
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${(confidence * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
