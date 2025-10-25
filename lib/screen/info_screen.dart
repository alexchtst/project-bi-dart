import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // Fungsi untuk parsing teks dan membuat bagian tebal dari *...*
  List<TextSpan> parseBoldText(
    String text,
    TextStyle baseStyle,
    TextStyle boldStyle,
  ) {
    final regex = RegExp(r'\*(.*?)\*');
    final spans = <TextSpan>[];
    int start = 0;

    for (final match in regex.allMatches(text)) {
      // Tambahkan teks sebelum *
      if (match.start > start) {
        spans.add(
          TextSpan(text: text.substring(start, match.start), style: baseStyle),
        );
      }
      // Tambahkan teks di antara *...*
      spans.add(TextSpan(text: match.group(1), style: boldStyle));
      start = match.end;
    }

    // Tambahkan sisa teks setelah match terakhir
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: baseStyle));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsive font sizes
    final titleSize = width * 0.05;
    final subtitleSize = width * 0.035;
    final bodySize = width * 0.025;

    final baseStyle = TextStyle(
      fontFamily: 'Baloo',
      fontSize: bodySize,
      color: Colors.white,
      height: 1.4,
    );

    final boldStyle = TextStyle(
      fontFamily: 'Baloo',
      fontSize: bodySize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.4,
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: width * 0.04,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/playbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tutorial Penggunaan Aplikasi SYNDO',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                Text(
                  'Homepage',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Pengguna akan disambut oleh tampilan awal aplikasi SYNDO. '
                      'Setelah masuk, pengguna dapat memilih menu utama *Play Mode* atau mencoba fitur lain terlebih dahulu seperti '
                      '*Chatbot ai* dan *Shop*. Di laman ini, pengguna juga bisa menghidup '
                      'atau mematikan musik serta dapat membaca tutorial penggunaan aplikasi.',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                Text(
                  'Shop',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Fitur *Shop* pada aplikasi *SYNDO* berfungsi sebagai tempat bagi pengguna '
                      'untuk membeli koin yang menjadi mata uang utama di dalam permainan. '
                      'Di sini pengguna dapat membeli atau memilih karakter-karakter menarik '
                      'yang diinginkan dan menampilkannya di bagian photomode.',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                Text(
                  'Chatbot AI',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Fitur *Chatbot AI* berfungsi sebagai asisten virtual. Pengguna dapat '
                      'berinteraksi dengan chatbot untuk mempelajari kosakata baru, '
                      'mendapatkan petunjuk, atau melakukan latihan isyarat tambahan. '
                      'Chatbot juga memberikan respons secara interaktif terhadap setiap '
                      'masukan pengguna.',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                Text(
                  'Study Mode',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Dalam *Study Mode*, pengguna dapat memilih apakah akan fokus ke dalam fitur '
                      '*Memorization* yang bertujuan untuk mengingat materi bahasa isyarat yang ada '
                      'melalui kartu dan video atau masuk ke *Evaluation* yang bertujuan untuk '
                      'mengevaluasi hasil pembelajaran melalui *Flashcard*, *Isi Bagian Kosong*, '
                      '*Scanner*, dan *Gesture Recognition*. Di dalam fitur *Flashcard* dan *Isi Bagian Kosong*, '
                      'pengguna dapat mendapatkan koin sebagai reward menyelesaikan level.',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                // ===== Story Mode =====
                Text(
                  'Story Mode',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Dalam *Story Mode*, pembelajaran dikemas melalui cerita interaktif. '
                      'Karakter utama akan mengajak pengguna menjawab pertanyaan seputar kosakata '
                      'BISINDO yang muncul dalam dialog cerita. Di fitur ini juga terdapat unsur '
                      'budaya-budaya lokal sebagai latar tempat pembelajaran.',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
          
                // ===== Information =====
                Text(
                  'Information',
                  style: TextStyle(
                    fontFamily: 'Baloo',
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: width * 0.015),
                RichText(
                  text: TextSpan(
                    children: parseBoldText(
                      'Apabila ada kendala dalam penggunaan aplikasi atau pertanyaan lebih lanjut, '
                      'dapat menghubungi email *syndo.eduapp@gmai.com*',
                      baseStyle,
                      boldStyle,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
