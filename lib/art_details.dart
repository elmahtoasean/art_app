import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artwork_view.dart'; // 👈 New page you’ll create
// You can move this to constant.dart if reused
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

class ArtDetails extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final List<Map<String, String>> artworks;

  const ArtDetails({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.artworks,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final baseAppBarHeight = screenHeight * 0.2;
    final curveHeight = baseAppBarHeight * 0.5;
    final totalHeight = baseAppBarHeight + curveHeight;

    final fontSize = screenWidth * 0.04;

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
                    name,
                    style: GoogleFonts.allura(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          blurRadius: 30,
                          color:
                              const Color.fromARGB(255, 190, 100, 220).withOpacity(0.8),
                          offset: const Offset(0, 0),
                        ),
                        const Shadow(
                          blurRadius: 45,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
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
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: artworks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final art = artworks[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtworkView(
                      title: art['title'] ?? '',
                      artist: art['artist'] ?? '',
                      year: art['year'] ?? '',
                      description: art['description'] ?? '',
                      imagePath: 'assets/${art['image'] ?? ''}',
                      artworkDetails: art['artworkDetails'] ?? '',
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/${art['image'] ?? ''}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image,
                              size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 162, 93, 118),
                            Color.fromARGB(255, 170, 180, 200),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            art['title'] ?? '',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '${art['artist']} (${art['year']})',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            art['description'] ?? '',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
