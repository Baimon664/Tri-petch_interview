import 'dart:convert';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {
  static String route = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _hospital = [];
  bool _isLoading = true;

  void _getHospital() {
    var url = Uri.parse('https://tripetch-zombie.herokuapp.com/hospitals');
    http.get(url).then((res) {
      var decodedResponse =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
        _hospital = decodedResponse['hospitals'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHospital();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Text(
            "Hospitals",
            style: TextStyle(fontSize: 24),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemBuilder: (ctx, idx) => Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Icon(Icons.medical_services),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _hospital[idx]['name'],
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: _hospital.length,
                ),
              ),
      ),
    );
  }
}
