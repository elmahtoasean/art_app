import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtworkView extends StatelessWidget {
  final String title;
  final String artist;
  final String year;
  final String description;
  final String imagePath;
  final String artworkDetails;

  const ArtworkView({
    super.key,
    required this.title,
    required this.artist,
    required this.year,
    required this.description,
    required this.imagePath,
    required this.artworkDetails,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 100, 128),
        title: Text(
          title,
          style: GoogleFonts.allura(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  height: screenHeight * 0.4,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: screenHeight * 0.4,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$artist ($year)',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  artworkDetails,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(fontSize: 16, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}