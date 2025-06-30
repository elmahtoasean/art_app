import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:art_app/art_details.dart';
import 'constant.dart';

class CurvedClipper extends CustomClipper<Path> {
  final double curveHeight;

  CurvedClipper(this.curveHeight);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - curveHeight * 2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - curveHeight * 2,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseAppBarHeight = screenHeight * 0.2;
    final curveHeight = baseAppBarHeight * 0.5;
    final totalHeight = baseAppBarHeight + curveHeight;

    final fontSize = screenWidth * 0.04;
    final spacing = 12.0;
    final iconSize = screenWidth * 0.10;
    final cardMargin = 8.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, totalHeight),
        child: ClipPath(
          clipper: CurvedClipper(curveHeight),
          child: Container(
            width: screenWidth,
            height: totalHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 175, 100, 128),
                  Color.fromARGB(255, 195, 206, 229)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Art Chronicle",
                    style: GoogleFonts.allura(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 248, 246),
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                            blurRadius: 30,
                            color: Color.fromARGB(255, 190, 100, 220)
                                .withOpacity(0.8),
                            offset: Offset(0, 0)),
                        Shadow(
                            blurRadius: 45,
                            color: Colors.black
                                .withOpacity(1),
                            offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
          ),
          itemCount: artData.length,
          itemBuilder: (context, index) {
            final entry = artData.entries.elementAt(index);
            final category = entry.key;
            final artworks = entry.value;
            final previewImage = 'assets/' + (artworks[0]['image'] ?? "");
            final description = "${artworks.length} artworks";

            return _buildCard(
              context,
              category,
              previewImage,
              description,
              iconSize,
              cardMargin,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String name,
    String image,
    String description,
    double iconSize,
    double margin,
  ) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtDetails(
              name: name,
              image: image,
              description: description,
              artworks: artData[name]!,
            ),
          ),
        );
      },
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        margin: EdgeInsets.all(margin),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 162, 93, 118),
                    Color.fromARGB(255, 170, 180, 200)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
