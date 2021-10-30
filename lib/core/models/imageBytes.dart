import 'dart:convert';

List<ImagesBytes> imagesBytesFromJson(String str) => List<ImagesBytes>.from(
    json.decode(str).map((x) => ImagesBytes.fromJson(x)));

String imagesBytesToJson(List<ImagesBytes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImagesBytes {
  ImagesBytes({
    required this.bytes,
  });

  List<int> bytes;

  factory ImagesBytes.fromJson(Map<String, dynamic> json) => ImagesBytes(
        bytes: List<int>.from(json["bytes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bytes": List<dynamic>.from(bytes.map((x) => x)),
      };
}
