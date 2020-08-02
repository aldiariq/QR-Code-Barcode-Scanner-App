import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String barcode = "QR Code / Barcode Tidak Terdeteksi";

  Future scanbarcode() async {
    try {
      String tempbarcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = tempbarcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = "Mohon Beri Akses Kamera";
        });
      } else {
        setState(() {
          this.barcode = "Gagal Menjalankan Fungsi";
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = "Proses Scanning Dibatalkan";
      });
    } catch (e) {
      setState(() {
        this.barcode = e;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  tampilDialog(String pesan) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text('Keterangan'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text(pesan)],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  bukaUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      tampilDialog("Pastikan Hasil Scanning Berupa URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text("Halaman Scanning"),
          elevation: .1,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                          aspectRatio: 18.0 / 13.0,
                          child: Image.asset(
                            'images/scanlogo.png',
                            height: 100,
                            width: 100,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Mulai Proses Scanning",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  scanbarcode();
                },
              ),
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(barcode,
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.content_copy,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    color: Color.fromRGBO(68, 153, 213, 1.0),
                    shape: CircleBorder(),
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: barcode));
                      tampilDialog("Hasil Scanning Berhasil Disalin");
                    },
                  ),
                  FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.open_in_browser,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    color: Color.fromRGBO(68, 153, 213, 1.0),
                    shape: CircleBorder(),
                    onPressed: () {
                      bukaUrl(barcode);
                    },
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
