import 'package:syndo/utils/data.dart';

String processInputQr(String input) {
  final lower = input.toLowerCase();
  final baseUrl =
      'https://media-api.grayhill-39d1a131.southeastasia.azurecontainerapps.io/file';
  final extension = lower.contains('vidio') ? 'mov' : 'png';
  final extendedName = _addExtension(input, extension);
  return '$baseUrl/$extendedName';
}

String _addExtension(String name, String extension) {
  final dotIndex = name.lastIndexOf('.');
  if (dotIndex != -1) {
    return name.substring(0, dotIndex + 1) + extension;
  } else {
    return '$name.$extension';
  }
}

String helperGetImageStudyPath(String code) {
  switch (code) {
    case 'BERWISATA JAKARTA':
      return 'assets/images/bg-berwisata-jakarta.png';
    case 'MONKEY FOREST':
      return 'assets/images/bg-monkey-forest.png';
    case 'MUSEUM':
      return 'assets/images/bg-museum.png';
    case 'PANTAI':
      return 'assets/images/bg-pantai.png';
    case 'PASAR':
      return 'assets/images/bg-pasar.png';
    case 'TAMAN':
      return 'assets/images/bg-taman.png';
    case 'WARUNG SATE':
      return 'assets/images/bg-warung-sate.png';
    case 'ZOO':
      return 'assets/images/bg-zoo.png';
    default:
      return 'assets/images/bg-pasar.png';
  }
}

List<Map<String, dynamic>> helperGetStrudyData(String name){
   switch (name) {
    case 'BERWISATA JAKARTA':
      return storyJakartaScenes;
    case 'MONKEY FOREST':
      return storyMonkeyScenes;
    case 'MUSEUM':
      return storyMuseumScenes;
    case 'PANTAI':
      return storyPantaiScenes;
    case 'PASAR':
      return storyPasarScenes;
    case 'TAMAN':
      return storyTamanScenes;
    case 'WARUNG SATE':
      return storyWarungScenes;
    case 'ZOO':
      return storyKebunBinatangScenes;
    default:
      return storyBuahScenes;
  }
}