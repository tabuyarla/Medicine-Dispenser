import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.red[300],
          child: ListView(children: [
            DrawerHeader(
                child: ListView(
              children: [
                Image.asset(
                  'lib/images/medicine.png',
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Medicine Dispenser",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lumanosimo(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              iconColor: Colors.white,
              textColor: Colors.white,
              horizontalTitleGap: 10,
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/details');
              },
              leading: const Icon(Icons.details),
              title: const Text("Patient Details"),
              iconColor: Colors.white,
              textColor: Colors.white,
              horizontalTitleGap: 10,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About us"),
              iconColor: Colors.white,
              textColor: Colors.white,
              horizontalTitleGap: 10,
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            )
          ]),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.red[300],
          title: const Text(
            'Medicine Dispenser',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red.shade100,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("A Project on"),
              Text(
                "Medical Dispenser",
                style:
                    GoogleFonts.mali(fontSize: 24, color: Colors.red.shade400),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("Team Details"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "M. LAYA SRI",
                style: GoogleFonts.mali(fontSize: 22, color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "L. DHARANI",
                style: GoogleFonts.mali(fontSize: 22, color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "V.RESHMI SAI",
                style: GoogleFonts.mali(fontSize: 22, color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "P. MANJULA",
                style: GoogleFonts.mali(fontSize: 22, color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Gayatri vidya parishad college of engineering for women",
                style: GoogleFonts.mali(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
