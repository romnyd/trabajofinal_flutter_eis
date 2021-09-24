class LeyendasInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;

  LeyendasInfo(
    this.position, {
    required this.name,
    required this.iconImage,
    required this.description,
  });
}

List<LeyendasInfo> leyendas = [
  LeyendasInfo(
    1,
    name: 'leyenda1',
    iconImage: 'assets/mobile.png',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
  ),
  LeyendasInfo(
    2,
    name: 'leyenda1',
    iconImage: 'assets/mobile.png',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
  ),
  LeyendasInfo(
    3,
    name: 'leyenda1',
    iconImage: 'assets/mobile.png',
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
  ),
];
